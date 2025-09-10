package vn.iotstar.model;

import java.io.Serializable;

/**
 * Category Model - JavaBean representing Category entity
 * Implements Serializable for session storage
 */
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int cateId;
    private String cateName;
    private String icons;
    private int userId;
    
    // Reference to User object for easier access
    private User user;
    
    // Default constructor
    public Category() {
    }
    
    // Constructor with all fields
    public Category(int cateId, String cateName, String icons, int userId) {
        this.cateId = cateId;
        this.cateName = cateName;
        this.icons = icons;
        this.userId = userId;
    }
    
    // Constructor without cateId (for new category creation)
    public Category(String cateName, String icons, int userId) {
        this.cateName = cateName;
        this.icons = icons;
        this.userId = userId;
    }
    
    // Getters and Setters
    public int getCateId() {
        return cateId;
    }
    
    public void setCateId(int cateId) {
        this.cateId = cateId;
    }
    
    public String getCateName() {
        return cateName;
    }
    
    public void setCateName(String cateName) {
        this.cateName = cateName;
    }
    
    public String getIcons() {
        return icons;
    }
    
    public void setIcons(String icons) {
        this.icons = icons;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
        if (user != null) {
            this.userId = user.getId();
        }
    }
    
    @Override
    public String toString() {
        return "Category{" +
                "cateId=" + cateId +
                ", cateName='" + cateName + '\'' +
                ", icons='" + icons + '\'' +
                ", userId=" + userId +
                '}';
    }
}