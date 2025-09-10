<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #dc3545 0%, #6f42c1 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }
        .main-content {
            padding: 40px 0;
        }
        .admin-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 40px;
            margin-bottom: 30px;
        }
        .feature-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #dc3545 0%, #6f42c1 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .btn-logout {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .btn-logout:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }
        .admin-info {
            background: linear-gradient(135deg, #dc3545 0%, #6f42c1 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        .admin-badge {
            background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
            color: #333;
            font-weight: bold;
            padding: 5px 15px;
            border-radius: 20px;
            display: inline-block;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">
                <i class="fas fa-user-shield"></i> Admin Dashboard
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-crown"></i> Xin chào, ${user.fullName}!
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container main-content">
        <!-- Admin Info Card -->
        <div class="admin-info">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h3><i class="fas fa-user-shield"></i> Thông tin quản trị viên</h3>
                    <p class="mb-1"><strong>Tên đăng nhập:</strong> ${user.userName}</p>
                    <p class="mb-1"><strong>Họ và tên:</strong> ${user.fullName}</p>
                    <p class="mb-1"><strong>Email:</strong> ${user.email}</p>
                    <c:if test="${not empty user.phone}">
                        <p class="mb-1"><strong>Số điện thoại:</strong> ${user.phone}</p>
                    </c:if>
                    <p class="mb-0"><strong>Vai trò:</strong> 
                        <span class="admin-badge">
                            <i class="fas fa-crown"></i> Quản trị viên
                        </span>
                    </p>
                </div>
                <div class="col-md-4 text-center">
                    <i class="fas fa-user-shield" style="font-size: 5rem; opacity: 0.3;"></i>
                </div>
            </div>
        </div>

        <!-- Welcome Card -->
        <div class="admin-card text-center">
            <h1 class="mb-3">
                <i class="fas fa-tachometer-alt"></i> Bảng điều khiển quản trị
            </h1>
            <p class="lead text-muted">
                Chào mừng bạn đến với khu vực quản trị hệ thống. Bạn có toàn quyền quản lý.
            </p>
        </div>

        <!-- Admin Features -->
        <div class="row">
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-list"></i>
                    </div>
                    <h4>Quản lý danh mục</h4>
                    <p class="text-muted">Thêm, sửa, xóa và quản lý các danh mục trong hệ thống.</p>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-danger">
                        <i class="fas fa-arrow-right"></i> Quản lý
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-users-cog"></i>
                    </div>
                    <h4>Quản lý người dùng</h4>
                    <p class="text-muted">Thêm, sửa, xóa và phân quyền cho người dùng trong hệ thống.</p>
                    <button class="btn btn-outline-danger">Quản lý</button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h4>Thống kê hệ thống</h4>
                    <p class="text-muted">Xem báo cáo chi tiết về hoạt động và hiệu suất hệ thống.</p>
                    <button class="btn btn-outline-danger">Xem báo cáo</button>
                </div>
            </div>
        </div>
        
        <div class="row">
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-cogs"></i>
                    </div>
                    <h4>Cấu hình hệ thống</h4>
                    <p class="text-muted">Thiết lập và cấu hình các tham số quan trọng của hệ thống.</p>
                    <button class="btn btn-outline-danger">Cấu hình</button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h4>Bảo mật hệ thống</h4>
                    <p class="text-muted">Quản lý bảo mật, quyền truy cập và kiểm soát hệ thống.</p>
                    <button class="btn btn-outline-danger">Bảo mật</button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-database"></i>
                    </div>
                    <h4>Quản lý dữ liệu</h4>
                    <p class="text-muted">Sao lưu, khôi phục và quản lý cơ sở dữ liệu hệ thống.</p>
                    <button class="btn btn-outline-danger">Quản lý</button>
                </div>
            </div>
        </div>

        <!-- Admin Actions -->
        <div class="admin-card">
            <h3 class="mb-3"><i class="fas fa-tools"></i> Công cụ quản trị</h3>
            <div class="row">
                <div class="col-md-3 mb-2">
                    <button class="btn btn-danger w-100">
                        <i class="fas fa-database"></i> Backup DB
                    </button>
                </div>
                <div class="col-md-3 mb-2">
                    <button class="btn btn-warning w-100">
                        <i class="fas fa-exclamation-triangle"></i> Logs hệ thống
                    </button>
                </div>
                <div class="col-md-3 mb-2">
                    <button class="btn btn-info w-100">
                        <i class="fas fa-shield-alt"></i> Bảo mật
                    </button>
                </div>
                <div class="col-md-3 mb-2">
                    <button class="btn btn-success w-100">
                        <i class="fas fa-sync-alt"></i> Cập nhật
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
