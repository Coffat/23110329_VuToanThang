<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/></title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #8B4513;
            --secondary-color: #D2691E;
            --accent-color: #F4A460;
            --dark-color: #5D4037;
            --light-color: #FFF8DC;
        }
        
        body {
            background: linear-gradient(135deg, var(--light-color) 0%, #F5F5DC 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--dark-color) 100%) !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .navbar-brand {
            font-weight: bold;
            color: white !important;
        }
        
        .navbar-nav .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover {
            color: var(--accent-color) !important;
            transform: translateY(-1px);
        }
        
        .btn-coffee {
            background: linear-gradient(135deg, var(--secondary-color) 0%, var(--primary-color) 100%);
            border: none;
            color: white;
            font-weight: 500;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s ease;
        }
        
        .btn-coffee:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(139, 69, 19, 0.3);
            color: white;
        }
        
        .footer {
            background: linear-gradient(135deg, var(--dark-color) 0%, var(--primary-color) 100%);
            color: white;
            padding: 20px 0;
            margin-top: 50px;
        }
        
        .content-wrapper {
            min-height: calc(100vh - 200px);
            padding: 20px 0;
        }
        
        .dropdown-menu {
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        
        .dropdown-item:hover {
            background-color: var(--accent-color);
            color: var(--dark-color);
        }
    </style>
    
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-coffee"></i> Coffee Management
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home"></i> Trang chủ
                        </a>
                    </li>
                    
                    <c:if test="${sessionScope.account != null}">
                        <c:if test="${sessionScope.account.roleId == 1}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">
                                    <i class="fas fa-cog"></i> Quản trị
                                </a>
                            </li>
                        </c:if>
                        
                        <c:if test="${sessionScope.account.roleId == 2}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/manager/home">
                                    <i class="fas fa-chart-bar"></i> Quản lý
                                </a>
                            </li>
                        </c:if>
                        
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user"></i> Tài khoản
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                    <i class="fas fa-user-edit"></i> Hồ sơ cá nhân
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                </a></li>
                            </ul>
                        </li>
                    </c:if>
                </ul>
                
                <div class="navbar-nav">
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            <span class="navbar-text me-3">
                                <i class="fas fa-user-circle"></i> Xin chào, ${sessionScope.account.fullName}!
                            </span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-coffee me-2">
                                <i class="fas fa-sign-in-alt"></i> Đăng nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light">
                                <i class="fas fa-user-plus"></i> Đăng ký
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="content-wrapper">
        <sitemesh:write property='body'/>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="fas fa-coffee"></i> Coffee Management System</h5>
                    <p class="mb-0">Hệ thống quản lý cà phê chuyên nghiệp</p>
                </div>
                <div class="col-md-6 text-end">
                    <p class="mb-0">© 2024 Coffee Management. All rights reserved.</p>
                    <small>Phát triển bởi IoT Star Team</small>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Add smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
        
        // Add loading animation for forms
        document.querySelectorAll('form').forEach(form => {
            form.addEventListener('submit', function() {
                const submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                    submitBtn.disabled = true;
                }
            });
        });
    </script>
</body>
</html>
