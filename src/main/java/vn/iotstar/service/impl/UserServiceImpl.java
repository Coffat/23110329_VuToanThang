package vn.iotstar.service.impl;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;

import java.util.Date;

/**
 * User Service Implementation
 * Implements UserService interface with business logic
 */
public class UserServiceImpl implements UserService {
    
    private UserDao userDao = new UserDaoImpl();
    
    @Override
    public User login(String username, String password) {
        User user = this.get(username);
        
        if (user != null && password.equals(user.getPassword())) {
            return user;
        }
        
        return null;
    }
    
    @Override
    public User get(String username) {
        return userDao.get(username);
    }
    
    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        // Check if username already exists
        if (checkExistUsername(username)) {
            return false;
        }
        
        try {
            // Create new user with default role (5) and current date
            User user = new User(
                email,
                username,
                fullname,
                password,
                null, // avatar - can be null initially
                5,    // roleid = 5 (default user role)
                phone,
                new Date() // current date
            );
            
            userDao.insert(user);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean checkExistEmail(String email) {
        return userDao.checkExistEmail(email);
    }
    
    @Override
    public boolean checkExistUsername(String username) {
        return userDao.checkExistUsername(username);
    }
    
    @Override
    public boolean checkExistPhone(String phone) {
        return userDao.checkExistPhone(phone);
    }
    
    @Override
    public boolean resetPasswordByEmail(String email, String newPassword) {
        try {
            // Kiểm tra user có tồn tại không
            User user = userDao.getUserByEmail(email);
            if (user == null) {
                return false;
            }
            
            // Cập nhật mật khẩu mới
            boolean passwordUpdated = userDao.updatePassword(email, newPassword);
            
            if (passwordUpdated) {
                System.out.println("Password reset successfully for: " + email + " -> New password: " + newPassword);
                return true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return false;
    }
}
