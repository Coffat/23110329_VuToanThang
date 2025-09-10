package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

import java.io.IOException;

/**
 * Category Delete Controller - Servlet handling category deletion
 * URL Pattern: /admin/category/delete
 */
@WebServlet(urlPatterns = "/admin/category/delete")
public class CategoryDeleteController extends HttpServlet {
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
        
        // Get category ID from parameter
        String idParam = request.getParameter("id");
        String alertMsg = "";
        boolean isSuccess = false;
        
        if (idParam == null || idParam.trim().isEmpty()) {
            alertMsg = "ID danh mục không hợp lệ!";
        } else {
            try {
                int categoryId = Integer.parseInt(idParam);
                
                // Attempt to delete category
                isSuccess = categoryService.delete(categoryId);
                alertMsg = isSuccess ? "Xóa danh mục thành công!" : "Xóa danh mục thất bại!";
                
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
        
        // Redirect back to category list
        response.sendRedirect(request.getContextPath() + "/admin/category/list");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect POST requests to GET
        doGet(request, response);
    }
}