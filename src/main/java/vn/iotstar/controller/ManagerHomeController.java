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
 * Manager Home Controller - Servlet handling manager home page
 * URL Pattern: /manager/home
 */
@WebServlet(urlPatterns = "/manager/home")
public class ManagerHomeController extends HttpServlet {
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
        
        // Check if user has manager role
        if (user.getRoleId() != 2) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        request.setAttribute("user", user);
        request.setAttribute("pageTitle", "Manager Dashboard");
        
        // Forward to manager home page
        request.getRequestDispatcher("/views/manager-home.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
