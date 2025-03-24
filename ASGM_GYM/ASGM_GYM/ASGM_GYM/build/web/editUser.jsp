<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa thông tin người dùng - 6Gym</title>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <style>
        /* CSS Variables */
        :root {
            --primary-color: #ffb700;
            --dark-color: #343a40;
            --light-color: #f8f9fa;
            --accent-color: #dc3545;
            --text-color: #495057;
        }

        /* General Body Styling */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-color);
            line-height: 1.6;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 600px;
        }

        .user-edit-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin: 50px auto;
            overflow: hidden;
        }

        .user-edit-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .card-header {
            background-color: var(--dark-color);
            color: white;
            border: none;
            padding: 1.5rem;
            text-align: center;
            border-radius: 12px 12px 0 0;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }

        .card-body {
            padding: 1.5rem;
        }

        .form-group label {
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ced4da;
            padding: 0.8rem;
            margin-bottom: 1.5rem;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(255, 183, 0, 0.25);
        }

        .btn-primary {
            padding: 12px 24px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.3s ease;
            letter-spacing: 1px;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #e6a500;
            border-color: #e6a500;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 183, 0, 0.4);
        }

        .error-message {
            color: var(--accent-color);
            font-size: 1.1rem;
            margin-top: 5px;
            text-align: center;
        }

        .success-message {
            color: #28a745;
            font-size: 1.1rem;
            margin-top: 5px;
            text-align: center;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .back-link:hover {
            color: #e6a500;
            text-decoration: none;
            transform: translateX(5px);
        }

    </style>
</head>
<body>
    <div class="container">
        <div class="user-edit-card card">
            <div class="card-header">
                <h5 class="card-title">Sửa thông tin người dùng</h5>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>

                <form action="users" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${user.id}">

                    <div class="form-group">
                        <label for="username"><i class="fas fa-user mr-2"></i>Tên đăng nhập</label>
                        <input type="text" class="form-control" id="username" name="username" value="${user.username}" required>
                    </div>

                    <div class="form-group">
                        <label for="email"><i class="fas fa-envelope mr-2"></i>Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                    </div>

                    <div class="form-group">
                        <label for="country"><i class="fas fa-flag mr-2"></i>Quốc gia</label>
                        <input type="text" class="form-control" id="country" name="country" value="${user.country}">
                    </div>

                    <div class="form-group">
                        <label for="phone"><i class="fas fa-phone mr-2"></i>Số điện thoại</label>
                        <input type="text" class="form-control" id="phone" name="phone" value="${user.phone}">
                    </div>

                    <div class="form-group">
                        <label for="role"><i class="fas fa-user-tag mr-2"></i>Vai trò</label>
                        <select class="form-control" id="role" name="role">
                            <option value="User" ${user.role == 'User' ? 'selected' : ''}>User</option>
                            <option value="Admin" ${user.role == 'Admin' ? 'selected' : ''}>Admin</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-check-circle mr-2"></i>Trạng thái</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusActive" value="true" ${user.status ? 'checked' : ''}>
                            <label class="form-check-label" for="statusActive">Hoạt động</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="status" id="statusInactive" value="false" ${!user.status ? 'checked' : ''}>
                            <label class="form-check-label" for="statusInactive">Không hoạt động</label>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block"><i class="fas fa-save mr-2"></i>Lưu thay đổi</button>
                </form>

                <a href="users?action=list" class="back-link"><i class="fas fa-arrow-left mr-2"></i>Quay lại danh sách người dùng</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
     <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>
</html>