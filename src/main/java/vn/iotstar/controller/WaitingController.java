package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;

import java.io.IOException;

/**
 * Waiting Controller - Servlet handling user role-based redirection
 * URL Pattern: /waiting
 */
@WebServlet(urlPatterns = "/waiting")
public class WaitingController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Get user from session
        User user = (User) session.getAttribute("account");
        
        // Redirect based on user role
        String contextPath = request.getContextPath();
        
        switch (user.getRoleId()) {
            case 1:
                // Admin role
                response.sendRedirect(contextPath + "/admin/home");
                break;
            case 2:
                // Manager role
                response.sendRedirect(contextPath + "/manager/home");
                break;
            default:
                // Regular user or other roles
                response.sendRedirect(contextPath + "/home");
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
