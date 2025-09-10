package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.Category;
import vn.iotstar.model.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * Category Controller - Servlet handling category CRUD operations
 * URL Pattern: /admin/category/list
 */
@WebServlet(urlPatterns = "/admin/category/list")
public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private CategoryService categoryService = new CategoryServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding for Vietnamese characters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Check if user is logged in and has admin/manager role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("account");
        if (currentUser.getRoleid() != 1 && currentUser.getRoleid() != 2) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Check if this is an edit request
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(idParam);
                Category category = categoryService.findById(categoryId);
                
                if (category != null) {
                    request.setAttribute("category", category);
                    request.setAttribute("isEdit", true);
                }
            } catch (NumberFormatException e) {
                // Invalid ID format, ignore
            }
        }
        
        // Get all categories for display
        List<Category> categories = categoryService.findAll();
        request.setAttribute("categories", categories);
        
        // Forward to category list page
        request.getRequestDispatcher("/views/admin/category-list.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding for Vietnamese characters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Check if user is logged in and has admin/manager role
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("account");
        if (currentUser.getRoleid() != 1 && currentUser.getRoleid() != 2) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Get form parameters
        String cateIdParam = request.getParameter("cateId");
        String cateName = request.getParameter("cateName");
        String icons = request.getParameter("icons");
        
        String alertMsg = "";
        boolean isSuccess = false;
        
        // Validate input
        if (cateName == null || cateName.trim().isEmpty()) {
            alertMsg = "Tên danh mục không được để trống!";
        } else {
            try {
                if (cateIdParam != null && !cateIdParam.trim().isEmpty()) {
                    // Update existing category
                    int cateId = Integer.parseInt(cateIdParam);
                    Category category = new Category(cateId, cateName.trim(), icons, currentUser.getId());
                    
                    isSuccess = categoryService.update(category);
                    alertMsg = isSuccess ? "Cập nhật danh mục thành công!" : "Cập nhật danh mục thất bại!";
                    
                } else {
                    // Create new category
                    Category category = new Category(cateName.trim(), icons, currentUser.getId());
                    
                    isSuccess = categoryService.create(category);
                    alertMsg = isSuccess ? "Thêm danh mục thành công!" : "Thêm danh mục thất bại!";
                }
                
            } catch (NumberFormatException e) {
                alertMsg = "ID danh mục không hợp lệ!";
            } catch (Exception e) {
                alertMsg = "Có lỗi xảy ra: " + e.getMessage();
            }
        }
        
        // Set alert message
        if (isSuccess) {
            session.setAttribute("successMsg", alertMsg);
        } else {
            session.setAttribute("alertMsg", alertMsg);
        }
        
        // Redirect to avoid form resubmission
        response.sendRedirect(request.getContextPath() + "/admin/category/list");
    }
}