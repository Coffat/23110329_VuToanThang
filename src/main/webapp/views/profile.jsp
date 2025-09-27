<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân - Coffee Management</title>
    
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
        
        .profile-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .profile-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 40px;
            margin-bottom: 30px;
        }
        
        .avatar-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .avatar-preview {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #667eea;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .avatar-placeholder {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 3rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .file-input-wrapper {
            position: relative;
            display: inline-block;
        }
        
        .file-input {
            position: absolute;
            left: -9999px;
        }
        
        .file-input-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            border: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .file-input-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }
        
        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn-update {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }
        
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .info-section {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f0ff 100%);
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            border: 1px solid rgba(102, 126, 234, 0.1);
        }
        
        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .info-item:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: var(--dark-color);
        }
        
        .info-value {
            color: #555;
        }
        
        .role-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-card">
            <h2 class="text-center mb-4">
                <i class="fas fa-user-edit"></i> Hồ sơ cá nhân
            </h2>
            
            <!-- Display Messages -->
            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>
            
            <!-- User Information Section -->
            <div class="info-section">
                <h4 class="mb-3"><i class="fas fa-info-circle"></i> Thông tin tài khoản</h4>
                <div class="info-item">
                    <span class="info-label">Tên đăng nhập:</span>
                    <span class="info-value">${user.userName}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Email:</span>
                    <span class="info-value">${user.email}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Vai trò:</span>
                    <span class="role-badge">
                        <c:choose>
                            <c:when test="${user.roleid == 1}">
                                <i class="fas fa-crown"></i> Quản trị viên
                            </c:when>
                            <c:when test="${user.roleid == 2}">
                                <i class="fas fa-briefcase"></i> Quản lý
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-user"></i> Người dùng
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Ngày tạo:</span>
                    <span class="info-value">
                        <fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy HH:mm"/>
                    </span>
                </div>
            </div>
            
            <!-- Profile Update Form -->
            <form action="${pageContext.request.contextPath}/profile/update" method="post" enctype="multipart/form-data">
                <!-- Avatar Section -->
                <div class="avatar-section">
                    <c:choose>
                        <c:when test="${not empty user.avatar}">
                            <img src="${pageContext.request.contextPath}/${user.avatar}" 
                                 alt="Avatar" class="avatar-preview" id="avatarPreview">
                        </c:when>
                        <c:otherwise>
                            <div class="avatar-placeholder" id="avatarPlaceholder">
                                <i class="fas fa-user"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="file-input-wrapper">
                        <input type="file" id="avatar" name="avatar" class="file-input" 
                               accept="image/*" onchange="previewAvatar(this)">
                        <label for="avatar" class="file-input-button">
                            <i class="fas fa-camera"></i> Chọn ảnh đại diện
                        </label>
                    </div>
                    <div class="mt-2">
                        <small class="text-muted">Hỗ trợ: JPG, PNG, GIF (Tối đa 10MB)</small>
                    </div>
                </div>
                
                <!-- Form Fields -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="fullName" class="form-label">
                                <i class="fas fa-user"></i> Họ và tên *
                            </label>
                            <input type="text" id="fullName" name="fullName" class="form-control" 
                                   value="${user.fullName}" required maxlength="100">
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="phone" class="form-label">
                                <i class="fas fa-phone"></i> Số điện thoại
                            </label>
                            <input type="tel" id="phone" name="phone" class="form-control" 
                                   value="${user.phone}" maxlength="15" pattern="[0-9+\-\s()]+">
                        </div>
                    </div>
                </div>
                
                <!-- Submit Button -->
                <div class="form-group">
                    <button type="submit" class="btn-update">
                        <i class="fas fa-save"></i> Cập nhật hồ sơ
                    </button>
                </div>
            </form>
            
            <!-- Back Button -->
            <div class="text-center mt-3">
                <c:choose>
                    <c:when test="${user.roleId == 1}">
                        <a href="${pageContext.request.contextPath}/admin/home" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại trang quản trị
                        </a>
                    </c:when>
                    <c:when test="${user.roleId == 2}">
                        <a href="${pageContext.request.contextPath}/manager/home" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại trang quản lý
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Quay lại trang chủ
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <script>
        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const placeholder = document.getElementById('avatarPlaceholder');
                    let preview = document.getElementById('avatarPreview');
                    
                    if (!preview) {
                        preview = document.createElement('img');
                        preview.id = 'avatarPreview';
                        preview.className = 'avatar-preview';
                        preview.alt = 'Avatar Preview';
                        placeholder.parentNode.replaceChild(preview, placeholder);
                    }
                    
                    preview.src = e.target.result;
                };
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const fullName = document.getElementById('fullName').value.trim();
            
            if (!fullName) {
                e.preventDefault();
                alert('Vui lòng nhập họ và tên!');
                document.getElementById('fullName').focus();
                return false;
            }
            
            // Show loading state
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang cập nhật...';
            submitBtn.disabled = true;
        });
        
        // Phone number formatting
        document.getElementById('phone').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 0) {
                if (value.length <= 3) {
                    value = value;
                } else if (value.length <= 6) {
                    value = value.slice(0, 3) + '-' + value.slice(3);
                } else if (value.length <= 10) {
                    value = value.slice(0, 3) + '-' + value.slice(3, 6) + '-' + value.slice(6);
                } else {
                    value = value.slice(0, 3) + '-' + value.slice(3, 6) + '-' + value.slice(6, 10);
                }
            }
            e.target.value = value;
        });
    </script>
    
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
