<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-container {
            margin-top: 20px;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px 15px 0 0 !important;
            padding: 20px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        .table th {
            background-color: #f8f9fa;
            border: none;
            font-weight: 600;
        }
        .table td {
            border: none;
            vertical-align: middle;
        }
        .btn-sm {
            border-radius: 8px;
        }
        .form-control {
            border-radius: 10px;
            border: 2px solid #e1e5e9;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .icon-preview {
            width: 30px;
            height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #f8f9fa;
            border-radius: 8px;
            margin-right: 10px;
        }
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
        }
        .navbar-brand, .nav-link {
            color: white !important;
        }
        .nav-link:hover {
            color: #f8f9fa !important;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/home">
                <i class="fas fa-cogs"></i> Admin Panel
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">
                    <i class="fas fa-home"></i> Trang chủ
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/category/list">
                    <i class="fas fa-list"></i> Danh mục
                </a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container main-container">
        <!-- Alert Messages -->
        <c:if test="${not empty sessionScope.alertMsg}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle"></i> ${sessionScope.alertMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="alertMsg" scope="session" />
        </c:if>
        
        <c:if test="${not empty sessionScope.successMsg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${sessionScope.successMsg}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="successMsg" scope="session" />
        </c:if>

        <div class="row">
            <!-- Form Thêm/Sửa Danh Mục -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-plus-circle"></i> 
                            <c:choose>
                                <c:when test="${isEdit}">
                                    Sửa danh mục
                                </c:when>
                                <c:otherwise>
                                    Thêm danh mục mới
                                </c:otherwise>
                            </c:choose>
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/category/list" method="post">
                            <c:if test="${isEdit}">
                                <input type="hidden" name="cateId" value="${category.cateId}">
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="cateName" class="form-label">
                                    <i class="fas fa-tag"></i> Tên danh mục
                                </label>
                                <input type="text" class="form-control" id="cateName" name="cateName" 
                                       placeholder="Nhập tên danh mục" required 
                                       value="${category.cateName}">
                            </div>
                            
                            <div class="mb-3">
                                <label for="icons" class="form-label">
                                    <i class="fas fa-icons"></i> Icon (Font Awesome)
                                </label>
                                <input type="text" class="form-control" id="icons" name="icons" 
                                       placeholder="Ví dụ: fas fa-laptop" 
                                       value="${category.icons}">
                                <small class="form-text text-muted">
                                    Nhập class Font Awesome hoặc để trống để dùng icon mặc định
                                </small>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <c:choose>
                                        <c:when test="${isEdit}">
                                            <i class="fas fa-save"></i> Cập nhật
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-plus"></i> Thêm mới
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                                <c:if test="${isEdit}">
                                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-secondary">
                                        <i class="fas fa-times"></i> Hủy
                                    </a>
                                </c:if>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            
            <!-- Danh Sách Danh Mục -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">
                            <i class="fas fa-list"></i> Danh sách danh mục
                            <span class="badge bg-light text-dark ms-2">${categories.size()}</span>
                        </h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty categories}">
                                <div class="text-center py-5">
                                    <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                                    <h5 class="text-muted">Chưa có danh mục nào</h5>
                                    <p class="text-muted">Hãy thêm danh mục đầu tiên của bạn!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th width="10%">ID</th>
                                                <th width="15%">Icon</th>
                                                <th width="45%">Tên danh mục</th>
                                                <th width="15%">Người tạo</th>
                                                <th width="15%">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="category" items="${categories}">
                                                <tr>
                                                    <td><strong>#${category.cateId}</strong></td>
                                                    <td>
                                                        <div class="icon-preview">
                                                            <i class="${category.icons}"></i>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <strong>${category.cateName}</strong>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">User #${category.userId}</small>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="${pageContext.request.contextPath}/admin/category/list?id=${category.cateId}" 
                                                               class="btn btn-outline-primary btn-sm" title="Sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/category/delete?id=${category.cateId}" 
                                                               class="btn btn-outline-danger btn-sm" title="Xóa"
                                                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Icon preview functionality
        document.getElementById('icons').addEventListener('input', function() {
            const iconClass = this.value;
            const preview = document.querySelector('.icon-preview i');
            if (iconClass) {
                preview.className = iconClass;
            } else {
                preview.className = 'fas fa-folder';
            }
        });
        
        // Auto dismiss alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>