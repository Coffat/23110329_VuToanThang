package vn.iotstar.dao.impl;

import vn.iotstar.config.DBConnection;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Category Data Access Object Implementation
 * Implements CategoryDao interface with JDBC operations
 */
public class CategoryDaoImpl implements CategoryDao {
    
    @Override
    public void insert(Category category) {
        String sql = "INSERT INTO [Category] (cate_name, icons, user_id) VALUES (?, ?, ?)";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, category.getCateName());
            statement.setString(2, category.getIcons());
            statement.setInt(3, category.getUserId());
            
            statement.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error inserting category", e);
        }
    }
    
    @Override
    public List<Category> findAll() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM [Category] ORDER BY cate_name";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                categories.add(mapResultSetToCategory(resultSet));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    
    @Override
    public Category findById(int id) {
        String sql = "SELECT * FROM [Category] WHERE cate_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                return mapResultSetToCategory(resultSet);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
    
    @Override
    public void update(Category category) {
        String sql = "UPDATE [Category] SET cate_name = ?, icons = ? WHERE cate_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, category.getCateName());
            statement.setString(2, category.getIcons());
            statement.setInt(3, category.getCateId());
            
            statement.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error updating category", e);
        }
    }
    
    @Override
    public void delete(int id) {
        String sql = "DELETE FROM [Category] WHERE cate_id = ?";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, id);
            statement.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error deleting category", e);
        }
    }
    
    @Override
    public List<Category> findByUserId(int userId) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM [Category] WHERE user_id = ? ORDER BY cate_name";
        
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                categories.add(mapResultSetToCategory(resultSet));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return categories;
    }
    
    /**
     * Map ResultSet to Category object
     * @param resultSet ResultSet from database query
     * @return Category object
     * @throws SQLException if mapping fails
     */
    private Category mapResultSetToCategory(ResultSet resultSet) throws SQLException {
        Category category = new Category();
        category.setCateId(resultSet.getInt("cate_id"));
        category.setCateName(resultSet.getString("cate_name"));
        category.setIcons(resultSet.getString("icons"));
        category.setUserId(resultSet.getInt("user_id"));
        return category;
    }
}