package vn.iotstar.service;

import vn.iotstar.model.User;

/**
 * User Service Interface
 * Defines business logic methods for user operations
 */
public interface UserService {
    
    /**
     * Authenticate user login
     * @param username Username
     * @param password Password
     * @return User object if login successful, null otherwise
     */
    User login(String username, String password);
    
    /**
     * Get user by username
     * @param username Username to search for
     * @return User object if found, null otherwise
     */
    User get(String username);
    
    /**
     * Register new user
     * @param username Username
     * @param password Password
     * @param email Email
     * @param fullname Full name
     * @param phone Phone number
     * @return true if registration successful, false otherwise
     */
    boolean register(String username, String password, String email, String fullname, String phone);
    
    /**
     * Check if email already exists
     * @param email Email to check
     * @return true if email exists, false otherwise
     */
    boolean checkExistEmail(String email);
    
    /**
     * Check if username already exists
     * @param username Username to check
     * @return true if username exists, false otherwise
     */
    boolean checkExistUsername(String username);
    
    /**
     * Check if phone number already exists
     * @param phone Phone number to check
     * @return true if phone exists, false otherwise
     */
    boolean checkExistPhone(String phone);
    
    /**
     * Reset password by email (simplified version)
     * @param email User email
     * @param newPassword New password
     * @return true if reset successful, false otherwise
     */
    boolean resetPasswordByEmail(String email, String newPassword);
}
