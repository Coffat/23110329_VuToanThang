**👨‍💻 Tác giả:** Vũ Toàn Thắng - 23110329

## 🚀 Tính năng

### 🔐 Hệ thống đăng nhập
- Đăng nhập/Đăng ký tài khoản
- Phân quyền 3 cấp: Admin, Manager, User
- Quên mật khẩu và reset password
- Ghi nhớ đăng nhập (Remember me)

### 👤 Quản lý hồ sơ
- Cập nhật thông tin cá nhân
- Upload và quản lý ảnh đại diện
- Giao diện responsive và thân thiện

### 🏷️ Quản lý danh mục (Admin)
- Thêm, sửa, xóa danh mục
- Giao diện quản trị chuyên nghiệp

### 🎨 Giao diện
- Thiết kế hiện đại với Bootstrap 5
- Responsive design cho mọi thiết bị
- Animations và transitions mượt mà
- Theme màu sắc nhất quán

## 🛠️ Công nghệ sử dụng

- **Backend:** Java Servlet, JSP
- **Database:** SQL Server / MySQL
- **Frontend:** Bootstrap 5, Font Awesome, CSS3
- **Build Tool:** Maven
- **Server:** Apache Tomcat
- **Page Decoration:** SiteMesh 3

## 📋 Yêu cầu hệ thống

- Java 17+
- Apache Tomcat 11+
- Maven 3.6+
- SQL Server hoặc MySQL
- IDE: IntelliJ IDEA (khuyến nghị)

## 🚀 Cài đặt và chạy

### 1. Clone repository
```bash
git clone <repository-url>
cd 23110329_VuToanThang
```

### 2. Cấu hình database
- Tạo database từ file `database/create_database.sql`
- Cập nhật thông tin kết nối trong `src/main/resources/database.properties`

### 3. Build và chạy
```bash
# Build project
mvn clean compile

# Chạy với Tomcat Maven Plugin
mvn tomcat7:run
```

### 4. Truy cập ứng dụng
- URL: `http://localhost:8080/`
- Tự động redirect đến trang home tương ứng với role

## 👥 Tài khoản mặc định

### Admin
- **Username:** admin
- **Password:** admin123
- **Quyền:** Quản lý danh mục, toàn quyền hệ thống

### Manager  
- **Username:** manager
- **Password:** manager123
- **Quyền:** Quản lý cấp trung

### User
- **Username:** user
- **Password:** user123
- **Quyền:** Người dùng thường

## 📁 Cấu trúc dự án

```
src/
├── main/
│   ├── java/vn/iotstar/
│   │   ├── config/          # Cấu hình database
│   │   ├── controller/      # Servlet controllers
│   │   ├── dao/            # Data Access Objects
│   │   ├── filter/         # Servlet filters
│   │   ├── model/          # Java models
│   │   └── service/        # Business logic
│   ├── resources/
│   │   └── database.properties
│   └── webapp/
│       ├── decorators/     # SiteMesh decorators
│       ├── uploads/        # Thư mục upload files
│       └── views/          # JSP pages
└── database/
    └── create_database.sql
```

## 🔧 Cấu hình

### Database Properties
```properties
# src/main/resources/database.properties
db.driver=com.microsoft.sqlserver.jdbc.SQLServerDriver
db.url=jdbc:sqlserver://localhost:1433;databaseName=CoffeeManagement
db.username=your_username
db.password=your_password
```

### Maven Configuration
```xml
<!-- pom.xml -->
<properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <tomcat.version>11.0.10</tomcat.version>
</properties>
```

## 🎯 Luồng hoạt động

1. **Đăng nhập:** User đăng nhập → Kiểm tra role → Redirect đến trang tương ứng
2. **Admin:** Quản lý danh mục + Cập nhật profile
3. **Manager:** Cập nhật profile + Xem thông tin
4. **User:** Cập nhật profile + Sử dụng hệ thống

## 🎨 Giao diện

- **Home Page:** Dashboard chính với thông tin user
- **Admin Dashboard:** Giao diện quản trị với quản lý danh mục
- **Manager Dashboard:** Giao diện quản lý cấp trung
- **Profile Page:** Cập nhật thông tin cá nhân với upload avatar
- **Login/Register:** Form đăng nhập/đăng ký hiện đại

## 🔒 Bảo mật

- Session management
- Role-based access control
- Input validation
- SQL injection prevention
- File upload security

## 📱 Responsive Design

- Mobile-first approach
- Bootstrap 5 grid system
- Touch-friendly interface
- Cross-browser compatibility

## 🚀 Deployment

### Production Build
```bash
mvn clean package
# File WAR sẽ được tạo trong target/ROOT.war
```

### Tomcat Deployment
1. Copy `target/ROOT.war` vào `webapps/` của Tomcat
2. Start Tomcat server
3. Truy cập ứng dụng qua domain/IP


---

⭐ **Nếu dự án hữu ích, hãy cho một star!** ⭐