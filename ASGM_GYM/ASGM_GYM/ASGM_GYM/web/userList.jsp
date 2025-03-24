<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Kết quả tìm kiếm người dùng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Nền sáng */
            font-family: Arial, sans-serif;
        }
        .container {
            padding: 20px;
        }
        h2 {
            font-weight: bold;
            border-bottom: 2px solid #f5c518; /* Đường viền vàng */
            display: inline-block;
            padding-bottom: 5px;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .card-body {
            padding: 15px;
        }
        .card-title {
            margin-bottom: 10px;
            font-size: 1.25rem;
            font-weight: bold;
        }
        .card-text {
            margin-bottom: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Kết quả tìm kiếm cho: "${searchQuery}"</h2>
        <div class="row mt-4">
            <div class="col-md-12">
                <!-- Danh sách người dùng -->
                <c:if test="${not empty users}">
                    <div class="row">
                        <c:forEach var="user" items="${users}">
                            <div class="col-md-4 mb-4">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">${user.username}</h5>
                                        <p class="card-text">
                                            Email: ${user.email}<br>
                                            Quốc gia: ${user.country}<br>
                                            Số điện thoại: ${user.phone}<br>
                                            Vai trò: ${user.role}<br>
                                            Trạng thái: ${user.status ? 'Hoạt động' : 'Không hoạt động'}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty users}">
                    <p>Không tìm thấy người dùng nào phù hợp với từ khóa "${searchQuery}".</p>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>