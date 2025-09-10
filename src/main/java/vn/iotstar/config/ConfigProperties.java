package vn.iotstar.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Configuration Properties Utility
 * Loads and manages application configuration from properties file
 */
public class ConfigProperties {
    
    private static Properties properties = new Properties();
    private static final String CONFIG_FILE = "/database.properties";
    
    static {
        loadProperties();
    }
    
    /**
     * Load properties from configuration file
     */
    private static void loadProperties() {
        try (InputStream inputStream = ConfigProperties.class.getResourceAsStream(CONFIG_FILE)) {
            if (inputStream != null) {
                properties.load(inputStream);
            } else {
                System.err.println("Configuration file not found: " + CONFIG_FILE);
            }
        } catch (IOException e) {
            System.err.println("Error loading configuration file: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Get property value by key
     * @param key Property key
     * @return Property value or null if not found
     */
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    /**
     * Get property value with default value
     * @param key Property key
     * @param defaultValue Default value if property not found
     * @return Property value or default value
     */
    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }
    
    /**
     * Get database URL based on active database configuration
     * @return Database URL
     */
    public static String getDatabaseUrl() {
        String activeDb = getProperty("active.database", "sqlserver");
        return getProperty(activeDb + ".url");
    }
    
    /**
     * Get database username based on active database configuration
     * @return Database username
     */
    public static String getDatabaseUsername() {
        String activeDb = getProperty("active.database", "sqlserver");
        return getProperty(activeDb + ".username");
    }
    
    /**
     * Get database password based on active database configuration
     * @return Database password
     */
    public static String getDatabasePassword() {
        String activeDb = getProperty("active.database", "sqlserver");
        return getProperty(activeDb + ".password");
    }
    
    /**
     * Get database driver based on active database configuration
     * @return Database driver class name
     */
    public static String getDatabaseDriver() {
        String activeDb = getProperty("active.database", "sqlserver");
        return getProperty(activeDb + ".driver");
    }
    
    /**
     * Get application name
     * @return Application name
     */
    public static String getAppName() {
        return getProperty("app.name", "Login Demo Application");
    }
    
    /**
     * Get application version
     * @return Application version
     */
    public static String getAppVersion() {
        return getProperty("app.version", "1.0.0");
    }
    
    /**
     * Get session timeout in minutes
     * @return Session timeout
     */
    public static int getSessionTimeout() {
        String timeout = getProperty("app.session.timeout", "30");
        try {
            return Integer.parseInt(timeout);
        } catch (NumberFormatException e) {
            return 30; // Default 30 minutes
        }
    }
}
