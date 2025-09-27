package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

/**
 * Profile Controller - Handles user profile operations
 * Supports profile viewing and updating with file upload
 */
@WebServlet(urlPatterns = {"/profile", "/profile/update"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserDao userDao = new UserDaoImpl();
    
    // Upload directory configuration
    private static final String UPLOAD_DIR = "uploads";
    private static final String AVATAR_DIR = "avatars";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get fresh user data from database
        User user = userDao.getUserById(currentUser.getId());
        if (user != null) {
            request.setAttribute("user", user);
            session.setAttribute("account", user); // Update session
        }
        
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        if ("/profile/update".equals(action)) {
            updateProfile(request, response, currentUser);
        } else {
            doGet(request, response);
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws ServletException, IOException {
        
        try {
            // Get form data
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            
            // Validate input
            if (fullName == null || fullName.trim().isEmpty()) {
                request.setAttribute("error", "Họ và tên không được để trống!");
                doGet(request, response);
                return;
            }
            
            // Update user object
            currentUser.setFullName(fullName.trim());
            currentUser.setPhone(phone != null ? phone.trim() : "");
            
            // Handle avatar upload
            Part avatarPart = request.getPart("avatar");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String avatarPath = uploadAvatar(avatarPart, currentUser.getId());
                if (avatarPath != null) {
                    currentUser.setAvatar(avatarPath);
                    // Update avatar in database
                    userDao.updateAvatar(currentUser.getId(), avatarPath);
                }
            }
            
            // Update profile in database
            boolean success = userDao.updateProfile(currentUser);
            
            if (success) {
                // Update session
                HttpSession session = request.getSession();
                session.setAttribute("account", currentUser);
                
                request.setAttribute("success", "Cập nhật hồ sơ thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật hồ sơ!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        doGet(request, response);
    }
    
    private String uploadAvatar(Part filePart, int userId) throws IOException {
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Validate file type
        if (!isValidImageFile(fileName)) {
            return null;
        }
        
        // Create upload directory if not exists
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR + File.separator + AVATAR_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        // Generate unique filename
        String fileExtension = getFileExtension(fileName);
        String newFileName = "avatar_" + userId + "_" + System.currentTimeMillis() + "." + fileExtension;
        
        // Save file
        String filePath = uploadPath + File.separator + newFileName;
        filePart.write(filePath);
        
        // Return relative path for database storage
        return UPLOAD_DIR + "/" + AVATAR_DIR + "/" + newFileName;
    }
    
    private boolean isValidImageFile(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return false;
        }
        
        String extension = getFileExtension(fileName).toLowerCase();
        return extension.equals("jpg") || extension.equals("jpeg") || 
               extension.equals("png") || extension.equals("gif") || 
               extension.equals("bmp") || extension.equals("webp");
    }
    
    private String getFileExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return "";
        }
        
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex == -1) {
            return "";
        }
        
        return fileName.substring(lastDotIndex + 1);
    }
}
