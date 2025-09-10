-- =====================================================
-- Create Database Script for Login Demo Application
-- Database: SQL Server
-- Author: Three-Tier Architecture Team
-- Date: 2025-09-27
-- =====================================================

-- Create Database (if not exists)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BaiTap2')
BEGIN
    CREATE DATABASE BaiTap2;
    PRINT 'Database BaiTap2 created successfully!';
END
ELSE
BEGIN
    PRINT 'Database BaiTap2 already exists.';
END
GO

-- Use the database
USE BaiTap2;
GO

-- =====================================================
-- Create User table with all required columns
-- =====================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='User' AND xtype='U')
BEGIN
    CREATE TABLE [User] (
        id INT IDENTITY(1,1) PRIMARY KEY,
        email NVARCHAR(255) NOT NULL UNIQUE,
        username NVARCHAR(100) NOT NULL UNIQUE,
        fullname NVARCHAR(255) NOT NULL,
        password NVARCHAR(255) NOT NULL,
        avatar NVARCHAR(500) NULL,
        roleid INT NOT NULL DEFAULT 5,
        phone NVARCHAR(20) NULL,
        createddate DATETIME NOT NULL DEFAULT GETDATE()
    );
    PRINT 'Table [User] created successfully!';
END
ELSE
BEGIN
    PRINT 'Table [User] already exists.';
    
    PRINT 'Table [User] structure is up to date.';
END
GO

-- =====================================================
-- Create Category table
-- =====================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Category' AND xtype='U')
BEGIN
    CREATE TABLE [Category] (
        cate_id INT IDENTITY(1,1) PRIMARY KEY,
        cate_name NVARCHAR(255) NOT NULL,
        icons NVARCHAR(500) NULL,
        user_id INT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES [User](id)
    );
    PRINT 'Table [Category] created successfully!';
END
ELSE
BEGIN
    PRINT 'Table [Category] already exists.';
END
GO

-- =====================================================
-- Create indexes for better performance
-- =====================================================
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_User_Email')
BEGIN
    CREATE INDEX IX_User_Email ON [User](email);
    PRINT 'Index IX_User_Email created.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_User_Username')
BEGIN
    CREATE INDEX IX_User_Username ON [User](username);
    PRINT 'Index IX_User_Username created.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_User_Roleid')
BEGIN
    CREATE INDEX IX_User_Roleid ON [User](roleid);
    PRINT 'Index IX_User_Roleid created.';
END
GO

-- Create indexes for Category table
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Category_UserId')
BEGIN
    CREATE INDEX IX_Category_UserId ON [Category](user_id);
    PRINT 'Index IX_Category_UserId created.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Category_Name')
BEGIN
    CREATE INDEX IX_Category_Name ON [Category](cate_name);
    PRINT 'Index IX_Category_Name created.';
END
GO

-- =====================================================
-- Insert sample data (only if table is empty)
-- =====================================================
IF NOT EXISTS (SELECT * FROM [User])
BEGIN
    INSERT INTO [User] (email, username, fullname, password, avatar, roleid, phone, createddate)
    VALUES 
    ('admin@example.com', 'admin', 'Administrator', '123456', NULL, 1, '0123456789', GETDATE()),
    ('manager@example.com', 'manager', 'Manager User', '123456', NULL, 2, '0123456790', GETDATE()),
    ('user@example.com', 'user', 'Regular User', '123456', NULL, 5, '0123456791', GETDATE()),
    ('test@example.com', 'test', 'Test User', '123456', NULL, 5, '0123456792', GETDATE());
    
    PRINT 'Sample data inserted successfully!';
END
ELSE
BEGIN
    PRINT 'Sample data already exists.';
END
GO

-- Insert sample categories
IF NOT EXISTS (SELECT * FROM [Category])
BEGIN
    INSERT INTO [Category] (cate_name, icons, user_id)
    VALUES 
    ('Technology', 'fas fa-laptop', 1),
    ('Business', 'fas fa-briefcase', 1),
    ('Education', 'fas fa-graduation-cap', 2),
    ('Health', 'fas fa-heart', 2),
    ('Entertainment', 'fas fa-film', 3),
    ('Sports', 'fas fa-football-ball', 3);
    
    PRINT 'Sample categories inserted successfully!';
END
ELSE
BEGIN
    PRINT 'Sample categories already exist.';
END
GO

-- =====================================================
-- Display created table structure
-- =====================================================
PRINT '==============================================';
PRINT 'TABLE STRUCTURE:';
PRINT '==============================================';

SELECT 
    COLUMN_NAME as 'Column Name',
    DATA_TYPE as 'Data Type',
    CHARACTER_MAXIMUM_LENGTH as 'Max Length',
    IS_NULLABLE as 'Nullable',
    COLUMN_DEFAULT as 'Default Value'
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'User'
ORDER BY ORDINAL_POSITION;
GO

-- =====================================================
-- Display sample data
-- =====================================================
PRINT '==============================================';
PRINT 'SAMPLE DATA:';
PRINT '==============================================';

SELECT 
    id,
    username,
    fullname,
    email,
    roleid,
    phone,
    createddate
FROM [User]
ORDER BY roleid, id;
GO

-- =====================================================
-- Final Summary
-- =====================================================
PRINT '==============================================';
PRINT 'DATABASE SETUP COMPLETED SUCCESSFULLY!';
PRINT '==============================================';
PRINT 'Connection Information:';
PRINT 'Server: localhost:1433';
PRINT 'Database: BaiTap2';
PRINT 'Username: sa';
PRINT 'Password: Admin123@';
PRINT '';
PRINT 'Sample Users Created:';
PRINT '1. admin/123456 (Role: 1 - Admin)';
PRINT '2. manager/123456 (Role: 2 - Manager)';
PRINT '3. user/123456 (Role: 5 - Regular User)';
PRINT '4. test/123456 (Role: 5 - Test User)';
PRINT '';
PRINT 'Features Supported:';
PRINT '- User Login & Registration';
PRINT '- Role-based Access Control';
PRINT '- Simple Password Reset by Email';
PRINT '- Remember Me functionality';
PRINT '- Category CRUD Management';
PRINT '- Admin Dashboard with Category Management';
PRINT '==============================================';
GO
