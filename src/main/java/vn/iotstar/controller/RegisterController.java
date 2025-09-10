package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;

import java.io.IOException;

/**
 * Register Controller - Servlet handling user registration
 * URL Pattern: /register
 */
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserService userService = new UserServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Forward to register page
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
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
        String email = request.getParameter("email");
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        
        String alertMsg = "";
        
        // Basic validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            fullname == null || fullname.trim().isEmpty()) {
            
            alertMsg = "Vui lòng điền đầy đủ thông tin bắt buộc!";
            request.setAttribute("alert", alertMsg);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Trim input values
        username = username.trim();
        password = password.trim();
        email = email.trim();
        fullname = fullname.trim();
        phone = (phone != null) ? phone.trim() : "";
        
        // Validation 1: Check if email already exists
        if (userService.checkExistEmail(email)) {
            alertMsg = "Email đã tồn tại!";
            request.setAttribute("alert", alertMsg);
            request.setAttribute("username", username);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Validation 2: Check if username already exists
        if (userService.checkExistUsername(username)) {
            alertMsg = "Tài khoản đã tồn tại!";
            request.setAttribute("alert", alertMsg);
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Optional: Check if phone already exists (if phone is provided)
        if (!phone.isEmpty() && userService.checkExistPhone(phone)) {
            alertMsg = "Số điện thoại đã tồn tại!";
            request.setAttribute("alert", alertMsg);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullname);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        // Attempt registration
        boolean isSuccess = userService.register(username, password, email, fullname, phone);
        
        if (isSuccess) {
            // Registration successful - redirect to login page
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            // Registration failed - system error
            alertMsg = "System error!";
            request.setAttribute("alert", alertMsg);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("fullname", fullname);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
