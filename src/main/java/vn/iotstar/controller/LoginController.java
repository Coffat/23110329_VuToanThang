package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

import java.io.IOException;

/**
 * Login Controller - Servlet handling user login
 * URL Pattern: /login
 */
@WebServlet(urlPatterns = "/login")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserService userService = new UserServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is already logged in via session
        if (session != null && session.getAttribute("account") != null) {
            response.sendRedirect(request.getContextPath() + "/waiting");
            return;
        }
        
        // Check if user has remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    String username = cookie.getValue();
                    User user = userService.get(username);
                    if (user != null) {
                        // Create session for remembered user
                        session = request.getSession(true);
                        session.setAttribute("account", user);
                        response.sendRedirect(request.getContextPath() + "/waiting");
                        return;
                    }
                }
            }
        }
        
        // Check for reset password success message
        if (session != null && session.getAttribute("resetSuccess") != null) {
            request.setAttribute("message", session.getAttribute("resetSuccess"));
            session.removeAttribute("resetSuccess");
        }
        
        // Forward to login page
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set encoding for Vietnamese characters
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        String alertMsg = "";
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            alertMsg = "Tài khoản và mật khẩu không được để trống!";
            request.setAttribute("alert", alertMsg);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }
        
        // Attempt login
        User user = userService.login(username.trim(), password);
        
        if (user != null) {
            // Login successful
            HttpSession session = request.getSession(true);
            session.setAttribute("account", user);
            
            // Handle remember me
            if ("on".equals(remember)) {
                Cookie usernameCookie = new Cookie("username", username);
                usernameCookie.setMaxAge(30 * 24 * 60 * 60); // 30 days
                usernameCookie.setPath("/");
                response.addCookie(usernameCookie);
            }
            
            response.sendRedirect(request.getContextPath() + "/waiting");
        } else {
            // Login failed
            alertMsg = "Tài khoản hoặc mật khẩu không đúng!";
            request.setAttribute("alert", alertMsg);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
