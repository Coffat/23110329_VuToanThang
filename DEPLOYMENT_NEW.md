# Deployment Guide - Three-Tier Architecture Login Application

This guide provides comprehensive instructions for deploying the Java Web Login Application built with Three-Tier Architecture and MVC2 pattern.

## Prerequisites

- **Java**: 17 or higher
- **Application Server**: Apache Tomcat 11
- **Database**: SQL Server (recommended) or MySQL
- **Build Tool**: Maven 3.6+
- **IDE**: IntelliJ IDEA, Eclipse, or VS Code (optional)

## Architecture Overview

The application follows strict **Three-Tier Architecture**:

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  ┌─────────────────┐ ┌─────────────────┐│
│  │   Controllers   │ │      Views      ││
│  │   (Servlets)    │ │     (JSP)       ││
│  └─────────────────┘ └─────────────────┘│
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│        Business Logic Layer            │
│  ┌─────────────────────────────────────┐│
│  │           Services                  ││
│  │      (Business Logic)              ││
│  └─────────────────────────────────────┘│
└─────────────────────────────────────────┘
┌─────────────────────────────────────────┐
│         Data Access Layer              │
│  ┌─────────────────┐ ┌─────────────────┐│
│  │      DAO        │ │     Models      ││
│  │  (Database)     │ │   (JavaBeans)   ││
│  └─────────────────┘ └─────────────────┘│
└─────────────────────────────────────────┘
```

## Database Setup

### Option 1: SQL Server (Recommended)

1. **Install SQL Server**:
   ```bash
   # Download SQL Server Developer Edition (Free)
   # Install SQL Server Management Studio (SSMS)
   ```

2. **Create Database**:
   ```sql
   -- Execute: database/create_database.sql
   -- Creates: LoginDemo database with User table
   -- Sample users: admin, manager, user (password: 123456)
   ```

3. **Default Configuration**:
   ```properties
   URL: jdbc:sqlserver://localhost:1433;databaseName=LoginDemo
   Username: sa
   Password: 123456
   ```

### Option 2: MySQL (Alternative)

1. **Install MySQL**:
   ```bash
   # Download MySQL Server 8.0+
   # Install MySQL Workbench
   ```

2. **Create Database**:
   ```sql
   -- Execute: database/create_database_mysql.sql
   -- Creates: logindemo database with User table
   ```

3. **Default Configuration**:
   ```properties
   URL: jdbc:mysql://localhost:3306/logindemo
   Username: root
   Password: 123456
   ```

## Application Configuration

### Database Configuration

Edit `src/main/resources/database.properties`:

```properties
# Switch between databases
active.database=sqlserver  # or mysql

# SQL Server settings
sqlserver.url=jdbc:sqlserver://localhost:1433;databaseName=LoginDemo;encrypt=true;trustServerCertificate=true
sqlserver.username=sa
sqlserver.password=123456

# MySQL settings  
mysql.url=jdbc:mysql://localhost:3306/logindemo?useSSL=false&serverTimezone=UTC
mysql.username=root
mysql.password=123456
```

### Package Structure Verification

Ensure the following package structure exists:

```
src/main/java/vn/iotstar/
├── config/          # Database configuration
├── controller/      # Presentation Layer (Servlets)
├── service/         # Business Logic Layer
├── dao/            # Data Access Layer
├── model/          # Data Models (JavaBeans)
└── filter/         # Servlet Filters
```

## Build and Deployment

### Method 1: Maven Tomcat Plugin (Development)

```bash
# Clean and compile
mvn clean compile

# Run with embedded Tomcat
mvn tomcat7:run

# Access application
# URL: http://localhost:8080
# Redirects to: http://localhost:8080/login
```

### Method 2: WAR Deployment (Production)

```bash
# Build WAR file
mvn clean package

# Deploy to Tomcat
cp target/ROOT.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh

# Access application
# URL: http://localhost:8080
```

### Method 3: IDE Deployment

1. **Import Maven Project**
2. **Configure Tomcat Server**:
   - Add Tomcat 11 server
   - Set deployment context: `/` or `/login-demo`
3. **Run/Debug Application**

## Application Testing

### Default Test Users

| Username | Password | Role ID | Role Name | Redirect URL |
|----------|----------|---------|-----------|--------------|
| admin    | 123456   | 1       | Admin     | `/admin/home` |
| manager  | 123456   | 2       | Manager   | `/manager/home` |
| user     | 123456   | 5       | User      | `/home` |

### Test Scenarios

#### 1. Login Flow Test
```
1. GET /login → Display login form
2. POST /login → Authenticate user
3. GET /waiting → Role-based redirection
4. GET /home (or /admin/home, /manager/home)
```

#### 2. Registration Flow Test
```
1. GET /register → Display registration form
2. POST /register → Validate and create user
3. Redirect to /login → Login with new account
```

#### 3. Session Management Test
```
1. Login → Verify session creation
2. Navigate pages → Verify session persistence
3. Logout → Verify session destruction
4. "Remember Me" → Verify cookie functionality
```

### API Endpoints Testing

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/login` | Login page | No |
| POST | `/login` | Process login | No |
| GET | `/register` | Registration page | No |
| POST | `/register` | Process registration | No |
| GET | `/waiting` | Role redirection | Yes |
| GET | `/home` | User dashboard | Yes |
| GET | `/logout` | Logout user | Yes |

## Troubleshooting

### Database Issues

1. **Connection Failed**:
   ```bash
   # Check database server status
   # Verify connection parameters in database.properties
   # Test connection using database client
   ```

2. **Driver Not Found**:
   ```bash
   # Verify JDBC driver in pom.xml dependencies
   # Check driver class loading in DBConnection.java
   ```

3. **Table Not Found**:
   ```sql
   -- Execute database creation scripts
   -- Verify table exists: SELECT * FROM [User];
   ```

### Application Issues

1. **404 Errors**:
   ```
   - Check servlet URL patterns in @WebServlet annotations
   - Verify web.xml configuration
   - Check deployment context path
   ```

2. **500 Errors**:
   ```
   - Check Tomcat logs: catalina.out
   - Verify database connectivity
   - Check for missing dependencies
   ```

3. **Session Issues**:
   ```
   - Clear browser cookies
   - Check session timeout in web.xml
   - Verify session management in controllers
   ```

### Build Issues

1. **Maven Compilation Errors**:
   ```bash
   # Check Java version compatibility
   mvn -version
   
   # Clean and rebuild
   mvn clean compile
   
   # Check dependencies
   mvn dependency:tree
   ```

2. **Missing Dependencies**:
   ```xml
   <!-- Verify in pom.xml -->
   <dependency>
       <groupId>jakarta.servlet</groupId>
       <artifactId>jakarta.servlet-api</artifactId>
       <version>6.0.0</version>
   </dependency>
   ```

## Production Deployment

### Security Hardening

1. **Database Security**:
   ```properties
   # Use strong passwords
   # Create dedicated database user
   # Enable SSL/TLS for database connections
   ```

2. **Application Security**:
   ```xml
   <!-- web.xml: Enable HTTPS -->
   <security-constraint>
       <user-data-constraint>
           <transport-guarantee>CONFIDENTIAL</transport-guarantee>
       </user-data-constraint>
   </security-constraint>
   ```

3. **Server Security**:
   ```bash
   # Remove default Tomcat applications
   # Configure firewall rules
   # Enable access logging
   ```

### Performance Optimization

1. **Database Connection Pooling**:
   ```java
   // Implement connection pooling in DBConnection.java
   // Use HikariCP or Apache DBCP
   ```

2. **Session Management**:
   ```xml
   <!-- web.xml: Optimize session settings -->
   <session-config>
       <session-timeout>30</session-timeout>
       <cookie-config>
           <http-only>true</http-only>
           <secure>true</secure>
       </cookie-config>
   </session-config>
   ```

### Monitoring and Logging

1. **Application Monitoring**:
   ```bash
   # Monitor Tomcat JVM metrics
   # Set up health check endpoints
   # Configure log rotation
   ```

2. **Database Monitoring**:
   ```sql
   -- Monitor connection counts
   -- Track query performance
   -- Set up database alerts
   ```

## Architecture Compliance Verification

### Three-Tier Verification Checklist

- ✅ **Presentation Layer**: Controllers (Servlets) + Views (JSP)
- ✅ **Business Logic Layer**: Services with interfaces
- ✅ **Data Access Layer**: DAO with interfaces + Models

### MVC2 Pattern Verification

- ✅ **Model**: JavaBeans (User.java)
- ✅ **View**: JSP pages (login.jsp, register.jsp, home.jsp)
- ✅ **Controller**: Servlets (LoginController, RegisterController, etc.)

### Package Structure Compliance

- ✅ **vn.iotstar.controller.*** - Presentation Layer
- ✅ **vn.iotstar.service.*** - Business Logic Layer  
- ✅ **vn.iotstar.dao.*** - Data Access Layer
- ✅ **vn.iotstar.model.*** - Data Models

## Support and Maintenance

### Log Locations
```bash
# Tomcat logs
$TOMCAT_HOME/logs/catalina.out
$TOMCAT_HOME/logs/localhost.log

# Application logs
# Check console output for database connection status
```

### Configuration Files
```
src/main/resources/database.properties    # Database configuration
src/main/webapp/WEB-INF/web.xml          # Web application configuration
pom.xml                                  # Maven dependencies
```

### Contact and Documentation
- **README.md**: Detailed application documentation
- **Database Scripts**: `/database/` directory
- **Source Code**: Fully documented with JavaDoc comments

---

**Note**: This application demonstrates strict adherence to Three-Tier Architecture and MVC2 pattern as required for enterprise Java web development.
