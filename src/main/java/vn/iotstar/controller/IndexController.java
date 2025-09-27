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
 * Index Controller - Servlet handling index requests
 * URL Pattern: /index
 */
@WebServlet(urlPatterns = "/index")
public class IndexController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is already logged in
        if (session != null && session.getAttribute("account") != null) {
            User user = (User) session.getAttribute("account");
            
            // Redirect based on user role
            switch (user.getRoleId()) {
                case 1: // Admin
                    response.sendRedirect(request.getContextPath() + "/admin/home");
                    break;
                case 2: // Manager
                    response.sendRedirect(request.getContextPath() + "/manager/home");
                    break;
                default: // Regular user
                    response.sendRedirect(request.getContextPath() + "/home");
                    break;
            }
        } else {
            // User not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
