<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Coffee Management</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
        
        .user-info {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        
        .btn-outline-primary {
            border: 2px solid #667eea;
            color: #667eea;
            font-weight: 500;
            border-radius: 25px;
            padding: 10px 25px;
            transition: all 0.3s ease;
        }
        
        .btn-outline-primary:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        .btn-outline-danger {
            border: 2px solid #dc3545;
            color: #dc3545;
            font-weight: 500;
            border-radius: 25px;
            padding: 10px 25px;
            transition: all 0.3s ease;
        }
        
        .btn-outline-danger:hover {
            background: #dc3545;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(220, 53, 69, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
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
                            <c:when test="${user.roleId == 1}">
                                <span class="badge bg-warning">Quản trị viên</span>
                            </c:when>
                            <c:when test="${user.roleId == 2}">
                                <span class="badge bg-info">Quản lý</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-success">Người dùng</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <div class="col-md-4 text-center">
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <img src="${pageContext.request.contextPath}/${user.avatar}" 
                                 alt="Avatar" class="rounded-circle" 
                                 style="width: 80px; height: 80px; object-fit: cover; border: 3px solid rgba(255,255,255,0.3);">
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-user-circle" style="font-size: 5rem; opacity: 0.3;"></i>
                        </c:otherwise>
                    </c:choose>
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
            <div class="col-md-6">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-user-cog"></i>
                    </div>
                    <h4>Quản lý tài khoản</h4>
                    <p class="text-muted">Cập nhật thông tin cá nhân và ảnh đại diện của bạn.</p>
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-primary">Cập nhật hồ sơ</a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="feature-card text-center">
                    <div class="feature-icon">
                        <i class="fas fa-sign-out-alt"></i>
                    </div>
                    <h4>Đăng xuất</h4>
                    <p class="text-muted">Thoát khỏi tài khoản hiện tại một cách an toàn.</p>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger">Đăng xuất</a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
