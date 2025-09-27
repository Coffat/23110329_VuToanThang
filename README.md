# Java Web Application - Login & Category Management

## Thông tin sinh viên
- **Họ và tên**: Vũ Toàn Thắng
- **MSSV**: 23110329

## Mô tả dự án
Ứng dụng web quản lý người dùng và danh mục sử dụng kiến trúc 3 tầng (3-Tier Architecture) và mô hình MVC2. Hệ thống hỗ trợ đăng nhập, đăng ký, quên mật khẩu và quản lý CRUD danh mục.

## Kiến trúc hệ thống
- **Presentation Layer**: JSP, Servlet Controllers
- **Business Logic Layer**: Service classes
- **Data Access Layer**: DAO pattern with JDBC
- **Database**: SQL Server with optimized indexes

## Công nghệ sử dụng
- **Backend**: Java 17, Servlet API, JSP
- **Database**: SQL Server 2019+
- **Server**: Apache Tomcat 11.0.10
- **Build Tool**: Maven 3.9+
- **Frontend**: Bootstrap 5, Font Awesome 6, JavaScript
- **Architecture**: 3-Tier Architecture, MVC2 Pattern

## Tính năng chính

### 🔐 **Xác thực và Phân quyền**
- ✅ Đăng nhập với validation
- ✅ Đăng ký tài khoản mới
- ✅ Quên mật khẩu (tạo mật khẩu mới tự động)
- ✅ Session management và Remember Me
- ✅ Role-based access control (Admin, Manager, User)

### 📋 **Quản lý Danh mục (CRUD)**
- ✅ Thêm danh mục mới
- ✅ Xem danh sách tất cả danh mục
- ✅ Sửa thông tin danh mục
- ✅ Xóa danh mục
- ✅ Quản lý icon Font Awesome
- ✅ Phân quyền theo người tạo

### 🎨 **Giao diện và Trải nghiệm**
- ✅ Responsive design với Bootstrap 5
- ✅ Modern UI/UX với gradient và animations
- ✅ Real-time form validation
- ✅ Alert messages và notifications
- ✅ Admin dashboard với navigation

### 🛠️ **Kỹ thuật**
- ✅ Database connection pooling
- ✅ Prepared statements (SQL injection prevention)
- ✅ Input validation và sanitization
- ✅ Exception handling
- ✅ Logging và debugging

## Cài đặt và chạy

### Yêu cầu hệ thống
- Java 17+
- Apache Tomcat 11.0.10
- SQL Server
- Maven 3.9+

### Bước 1: Clone repository
```bash
git clone https://github.com/Coffat/23110329_VuToanThang_bai2.git
cd 23110329_VuToanThang_bai2
```

### Bước 2: Cấu hình database
1. Tạo database `BaiTap2` trong SQL Server
2. Chạy script `database/create_database.sql` để tạo bảng và dữ liệu mẫu
3. Cập nhật thông tin kết nối trong `src/main/resources/database.properties`:
   ```properties
   db.url=jdbc:sqlserver://localhost:1433;databaseName=BaiTap2;encrypt=true;trustServerCertificate=true
   db.username=sa
   db.password=Admin123@
   ```

### Bước 3: Build và deploy

#### Option 1: Sử dụng Maven Tomcat Plugin (Khuyến nghị)
```bash
# Chạy trực tiếp với Maven
mvn clean compile
mvn tomcat7:run

# Truy cập: http://localhost:8080
```

#### Option 2: Deploy lên Tomcat Server
```bash
# Build project
mvn clean package

# Copy WAR file vào Tomcat
cp target/ROOT.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh
```

### Bước 4: Truy cập ứng dụng

#### 🌐 **URLs chính** (Maven: `http://localhost:8080`)
- **Trang đăng nhập**: `http://localhost:8080/login`
- **Đăng ký**: `http://localhost:8080/register`
- **Quên mật khẩu**: `http://localhost:8080/forgot-password`
- **Trang chủ**: `http://localhost:8080/home`

#### 🔑 **Admin Panel** (Chỉ Admin/Manager)
- **Admin Dashboard**: `http://localhost:8080/admin/home`
- **Quản lý Danh mục**: `http://localhost:8080/admin/category/list`

## 📊 **Cơ sở dữ liệu**

### Bảng User
| Field | Type | Description |
|-------|------|-------------|
| id | INT (PK) | User ID |
| email | NVARCHAR(255) | Email (unique) |
| username | NVARCHAR(100) | Username (unique) |
| fullname | NVARCHAR(255) | Full name |
| password | NVARCHAR(255) | Password |
| avatar | NVARCHAR(500) | Avatar URL |
| roleid | INT | Role (1=Admin, 2=Manager, 5=User) |
| phone | NVARCHAR(20) | Phone number |
| createddate | DATETIME | Created date |

### Bảng Category
| Field | Type | Description |
|-------|------|-------------|
| cate_id | INT (PK) | Category ID |
| cate_name | NVARCHAR(255) | Category name |
| icons | NVARCHAR(500) | Font Awesome icon class |
| user_id | INT (FK) | Creator user ID |

### Tài khoản mẫu
| Username | Password | Role | Description |
|----------|----------|------|-------------|
| admin | 123456 | Admin | Full access |
| manager | 123456 | Manager | Category management |
| user | 123456 | User | Basic access |
| test | 123456 | User | Test account |

## 📝 **Cấu trúc dự án**

```
src/main/java/vn/iotstar/
├── config/
│   └── DBConnection.java
├── controller/
│   ├── LoginController.java
│   ├── RegisterController.java
│   ├── ForgotPasswordController.java
│   ├── CategoryController.java
│   └── CategoryDeleteController.java
├── dao/
│   ├── UserDao.java
│   ├── CategoryDao.java
│   └── impl/
│       ├── UserDaoImpl.java
│       └── CategoryDaoImpl.java
├── service/
│   ├── UserService.java
│   ├── CategoryService.java
│   └── impl/
│       ├── UserServiceImpl.java
│       └── CategoryServiceImpl.java
└── model/
    ├── User.java
    └── Category.java

src/main/webapp/
├── views/
│   ├── login.jsp
│   ├── register.jsp
│   ├── forgot-password.jsp
│   ├── home.jsp
│   ├── admin-home.jsp
│   └── admin/
│       └── category-list.jsp
└── WEB-INF/
    └── web.xml
```

## 🚀 **Hướng dẫn sử dụng**

### 1. Đăng nhập hệ thống
- Truy cập trang đăng nhập
- Nhập username/password
- Chọn "Ghi nhớ đăng nhập" nếu muốn

### 2. Quên mật khẩu
- Click "Quên mật khẩu?" tại trang login
- Nhập email đã đăng ký
- Hệ thống sẽ tạo mật khẩu mới 6 ký tự
- Sử dụng mật khẩu mới để đăng nhập

### 3. Quản lý danh mục (Admin/Manager)
- Đăng nhập với tài khoản Admin hoặc Manager
- Truy cập Admin Dashboard
- Click "Quản lý danh mục"
- Thực hiện các thao tác CRUD

## 🔧 **Troubleshooting**

### Lỗi kết nối database
- Kiểm tra SQL Server đang chạy
- Xác nhận thông tin kết nối trong `database.properties`
- Kiểm tra firewall và port 1433

### Lỗi 404 Not Found
- Kiểm tra Tomcat đang chạy
- Xác nhận URL mapping trong web.xml
- Kiểm tra servlet annotations

### Lỗi 500 Internal Server Error
- Kiểm tra logs trong Tomcat
- Xác nhận database connection
- Kiểm tra exception stack trace

## 📞 **Liên hệ**
- **Sinh viên**: Vũ Toàn Thắng
- **MSSV**: 23110329
- **Lớp**: DH23DT
- **Email**: 23110329@student.hcmute.edu.vn
