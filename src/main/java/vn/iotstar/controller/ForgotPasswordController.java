package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

import java.io.IOException;
import java.util.Random;

/**
 * Forgot Password Controller - Servlet handling forgot password requests
 * URL Pattern: /forgot-password
 */
@WebServlet(urlPatterns = "/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserService userService = new UserServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Forward to forgot password page
        request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding for Vietnamese characters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Get email parameter
        String email = request.getParameter("email");
        String alertMsg = "";
        
        // Validate input
        if (email == null || email.trim().isEmpty()) {
            alertMsg = "Vui lòng nhập địa chỉ email!";
            request.setAttribute("alert", alertMsg);
            request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Validate email format
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (!email.matches(emailRegex)) {
            alertMsg = "Định dạng email không hợp lệ!";
            request.setAttribute("alert", alertMsg);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
            return;
        }
        
        // Tạo mật khẩu mới ngay lập tức
        String newPassword = generateNewPassword();
        boolean passwordReset = userService.resetPasswordByEmail(email.trim(), newPassword);
        
        if (passwordReset) {
            // Thành công - hiển thị mật khẩu mới
            String successMsg = "Mật khẩu mới của bạn là: " + newPassword + ". Vui lòng đăng nhập và đổi mật khẩu!";
            request.setAttribute("success", successMsg);
            request.setAttribute("newPassword", newPassword);
            request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
        } else {
            // Email không tồn tại
            alertMsg = "Email không tồn tại trong hệ thống!";
            request.setAttribute("alert", alertMsg);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/views/forgot-password.jsp").forward(request, response);
        }
    }
    
    /**
     * Tạo mật khẩu mới ngẫu nhiên
     * @return Mật khẩu mới 6 ký tự
     */
    private String generateNewPassword() {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder newPassword = new StringBuilder();
        
        for (int i = 0; i < 6; i++) {
            newPassword.append(chars.charAt(random.nextInt(chars.length())));
        }
        
        return newPassword.toString();
    }
}
