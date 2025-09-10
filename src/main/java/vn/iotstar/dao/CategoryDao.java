package vn.iotstar.dao;

import vn.iotstar.model.Category;
import java.util.List;

/**
 * Category Data Access Object Interface
 * Defines methods for category data operations
 */
public interface CategoryDao {
    
    /**
     * Insert new category into database
     * @param category Category object to insert
     */
    void insert(Category category);
    
    /**
     * Get all categories from database
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
     */
    void update(Category category);
    
    /**
     * Delete category by ID
     * @param id Category ID to delete
     */
    void delete(int id);
    
    /**
     * Find categories by user ID
     * @param userId User ID
     * @return List of categories belonging to the user
     */
    List<Category> findByUserId(int userId);
}