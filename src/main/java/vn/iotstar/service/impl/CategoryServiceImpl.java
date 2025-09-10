package vn.iotstar.service.impl;

import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;

import java.util.List;

/**
 * Category Service Implementation
 * Implements CategoryService interface with business logic
 */
public class CategoryServiceImpl implements CategoryService {
    
    private CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    public boolean create(Category category) {
        try {
            // Business logic validation
            if (category == null || category.getCateName() == null || category.getCateName().trim().isEmpty()) {
                return false;
            }
            
            // Trim and validate category name
            category.setCateName(category.getCateName().trim());
            
            // Set default icon if not provided
            if (category.getIcons() == null || category.getIcons().trim().isEmpty()) {
                category.setIcons("fas fa-folder");
            }
            
            categoryDao.insert(category);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }
    
    @Override
    public Category findById(int id) {
        if (id <= 0) {
            return null;
        }
        return categoryDao.findById(id);
    }
    
    @Override
    public boolean update(Category category) {
        try {
            // Business logic validation
            if (category == null || category.getCateId() <= 0 || 
                category.getCateName() == null || category.getCateName().trim().isEmpty()) {
                return false;
            }
            
            // Check if category exists
            Category existingCategory = categoryDao.findById(category.getCateId());
            if (existingCategory == null) {
                return false;
            }
            
            // Trim and validate category name
            category.setCateName(category.getCateName().trim());
            
            // Set default icon if not provided
            if (category.getIcons() == null || category.getIcons().trim().isEmpty()) {
                category.setIcons("fas fa-folder");
            }
            
            categoryDao.update(category);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean delete(int id) {
        try {
            if (id <= 0) {
                return false;
            }
            
            // Check if category exists
            Category existingCategory = categoryDao.findById(id);
            if (existingCategory == null) {
                return false;
            }
            
            categoryDao.delete(id);
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<Category> findByUserId(int userId) {
        if (userId <= 0) {
            return List.of(); // Return empty list
        }
        return categoryDao.findByUserId(userId);
    }
}