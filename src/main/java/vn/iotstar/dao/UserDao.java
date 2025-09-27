package vn.iotstar.dao;

import vn.iotstar.model.User;

/**
 * User Data Access Object Interface
 * Defines methods for user data operations
 */
public interface UserDao {
    
    /**
     * Get user by username
     * @param username Username to search for
     * @return User object if found, null otherwise
     */
    User get(String username);
    
    /**
     * Insert new user into database
     * @param user User object to insert
     */
    void insert(User user);
    
    /**
     * Check if email already exists in database
     * @param email Email to check
     * @return true if email exists, false otherwise
     */
    boolean checkExistEmail(String email);
    
    /**
     * Check if username already exists in database
     * @param username Username to check
     * @return true if username exists, false otherwise
     */
    boolean checkExistUsername(String username);
    
    /**
     * Check if phone number already exists in database
     * @param phone Phone number to check
     * @return true if phone exists, false otherwise
     */
    boolean checkExistPhone(String phone);
    
    /**
     * Get user by email
     * @param email Email to search for
     * @return User object if found, null otherwise
     */
    User getUserByEmail(String email);
    
    /**
     * Update user password
     * @param email User email
     * @param newPassword New password
     * @return true if update successful, false otherwise
     */
    boolean updatePassword(String email, String newPassword);
    
    /**
     * Get user by ID
     * @param id User ID
     * @return User object if found, null otherwise
     */
    User getUserById(int id);
    
    /**
     * Update user profile information
     * @param user User object with updated information
     * @return true if update successful, false otherwise
     */
    boolean updateProfile(User user);
    
    /**
     * Update user avatar
     * @param userId User ID
     * @param avatarPath Path to avatar image
     * @return true if update successful, false otherwise
     */
    boolean updateAvatar(int userId, String avatarPath);
}
