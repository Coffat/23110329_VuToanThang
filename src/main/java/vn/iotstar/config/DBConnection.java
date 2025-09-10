package vn.iotstar.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Database Connection utility class
 * Manages database connections using JDBC with configurable properties
 */
public class DBConnection {
    
    // Database configuration from properties file
    private static final String DB_URL = ConfigProperties.getDatabaseUrl();
    private static final String DB_USERNAME = ConfigProperties.getDatabaseUsername();
    private static final String DB_PASSWORD = ConfigProperties.getDatabasePassword();
    private static final String DB_DRIVER = ConfigProperties.getDatabaseDriver();
    
    static {
        try {
            // Load database driver dynamically based on configuration
            Class.forName(DB_DRIVER);
            System.out.println("Database driver loaded: " + DB_DRIVER);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Database driver not found: " + DB_DRIVER, e);
        }
    }
    
    /**
     * Get database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
    }
    
    /**
     * Close database connection safely
     * @param connection Connection to close
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    /**
     * Test database connection
     * @return true if connection successful, false otherwise
     */
    public static boolean testConnection() {
        try (Connection connection = getConnection()) {
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
