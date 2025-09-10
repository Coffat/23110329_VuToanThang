<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        .welcome-card {
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        .user-info {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">
                <i class="fas fa-home"></i> Trang chủ
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text me-3">
                    <i class="fas fa-user"></i> Xin chào, ${user.fullName}!
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container main-content">
        <!-- User Info Card -->
        <div class="user-info">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h3><i class="fas fa-user-circle"></i> Thông tin tài khoản</h3>
                    <p class="mb-1"><strong>Tên đăng nhập:</strong> ${user.userName}</p>
                    <p class="mb-1"><strong>Họ và tên:</strong> ${user.fullName}</p>
                    <p class="mb-1"><strong>Email:</strong> ${user.email}</p>
                    <c:if test="${not empty user.phone}">
                        <p class="mb-1"><strong>Số điện thoại:</strong> ${user.phone}</p>
                    </c:if>
                    <p class="mb-0"><strong>Vai trò:</strong> 
                        <c:choose>
                            <c:when test="${user.roleid == 1}">
                                <span class="badge bg-warning">Quản trị viên</span>
                            </c:when>
                            <c:when test="${user.roleid == 2}">
                                <span class="badge bg-info">Quản lý</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-success">Người dùng</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="col-md-4 text-center">
                    <i class="fas fa-user-circle" style="font-size: 5rem; opacity: 0.3;"></i>
                </div>
            </div>
        </div>

        <!-- Welcome Card -->
        <div class="welcome-card text-center">
            <h1 class="mb-3">
                <i class="fas fa-home"></i> Chào mừng đến với hệ thống!
            </h1>
            <p class="lead text-muted">
                Bạn đã đăng nhập thành công. Khám phá các tính năng bên dưới.
            </p>
        </div>

        <!-- Features -->
        <div class="row">
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-user-cog"></i>
                    </div>
                    <h4>Quản lý tài khoản</h4>
                    <p class="text-muted">Cập nhật thông tin cá nhân và thay đổi mật khẩu của bạn.</p>
                    <button class="btn btn-outline-primary">Xem chi tiết</button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-chart-bar"></i>
                    </div>
                    <h4>Thống kê</h4>
                    <p class="text-muted">Xem các báo cáo và thống kê về hoạt động của bạn.</p>
                    <button class="btn btn-outline-primary">Xem chi tiết</button>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-cog"></i>
                    </div>
                    <h4>Cài đặt</h4>
                    <p class="text-muted">Tùy chỉnh các thiết lập và cấu hình hệ thống.</p>
                    <button class="btn btn-outline-primary">Xem chi tiết</button>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="welcome-card">
            <h3 class="mb-3"><i class="fas fa-bolt"></i> Thao tác nhanh</h3>
            <div class="row">
                <div class="col-md-6 mb-2">
                    <button class="btn btn-primary w-100">
                        <i class="fas fa-plus"></i> Tạo mới
                    </button>
                </div>
                <div class="col-md-6 mb-2">
                    <button class="btn btn-success w-100">
                        <i class="fas fa-search"></i> Tìm kiếm
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
