package vn.iotstar.service;

import vn.iotstar.model.Category;
import java.util.List;

/**
 * Category Service Interface
 * Defines business logic methods for category operations
 */
public interface CategoryService {
    
    /**
     * Create new category
     * @param category Category object to create
     * @return true if creation successful, false otherwise
     */
    boolean create(Category category);
    
    /**
     * Get all categories
     * @return List of all categories
     */
    List<Category> findAll();
    
    /**
     * Find category by ID
     * @param id Category ID
     * @return Category object if found, null otherwise
     */
    Category findById(int id);
    
    /**
     * Update existing category
     * @param category Category object with updated information
     * @return true if update successful, false otherwise
     */
    boolean update(Category category);
    
    /**
     * Delete category by ID
     * @param id Category ID to delete
     * @return true if deletion successful, false otherwise
     */
    boolean delete(int id);
    
    /**
     * Find categories by user ID
     * @param userId User ID
     * @return List of categories belonging to the user
     */
    List<Category> findByUserId(int userId);
}