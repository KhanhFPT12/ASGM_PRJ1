<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách khách hàng - 6Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #ffb700;
            --dark-color: #343a40;
            --light-color: #f8f9fa;
            --accent-color: #dc3545;
            --text-color: #495057;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-color);
            line-height: 1.6;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1200px;
        }

        .customer-table-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin: 30px auto;
            overflow: hidden;
        }

        .customer-table-card:hover {
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

        .table {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: none;
            margin-bottom: 0;
        }

        .table th, .table td {
            vertical-align: middle;
            padding: 1rem;
            border-color: #e9ecef;
        }

        .table thead th {
            background-color: #e9ecef;
            color: var(--dark-color);
            font-weight: 600;
            border-color: #e9ecef;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .btn-view, .btn-edit, .btn-delete {
            padding: 8px 16px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            transition: all 0.3s ease;
            letter-spacing: 1px;
            border: none;
            margin-right: 5px;
        }

        .btn-view {
            background-color: var(--primary-color);
            color: #fff;
        }

        .btn-view:hover {
            background-color: #e6a500;
        }

        .btn-edit {
            background-color: #007bff;
            color: #fff;
        }

        .btn-edit:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: var(--accent-color);
            color: #fff;
        }

        .btn-delete:hover {
            background-color: #c82333;
        }

        h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-color);
            text-align: center;
            margin-bottom: 20px;
        }

        /* Thanh tìm kiếm */
        .search-bar {
            margin-bottom: 30px;
            display: flex;
            justify-content: center; /* Căn giữa thanh tìm kiếm */
        }

        .search-bar .input-group {
            width: 100%;
            max-width: 500px; /* Tăng chiều rộng tối đa để dễ thấy hơn */
            position: relative;
        }

        .search-bar .form-control {
            background-color: #fff; /* Nền trắng để nổi bật */
            color: var(--text-color); /* Màu chữ tối */
            border: 2px solid var(--primary-color); /* Viền màu vàng nổi bật */
            border-radius: 50px; /* Bo góc tròn hơn */
            padding: 12px 20px 12px 50px; /* Tăng padding để thoải mái hơn */
            font-size: 1.1rem; /* Tăng kích thước chữ */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Thêm bóng nhẹ */
            transition: all 0.3s ease; /* Hiệu ứng mượt mà */
        }

        .search-bar .form-control::placeholder {
            color: rgba(0, 0, 0, 0.4); /* Màu placeholder nhẹ */
            font-style: italic; /* Chữ nghiêng cho placeholder */
        }

        .search-bar .input-group-text {
            background-color: transparent; /* Nền trong suốt */
            border: none; /* Không viền */
            color: var(--primary-color); /* Màu biểu tượng kính lúp là màu vàng */
            position: absolute; /* Đặt biểu tượng bên trong input */
            z-index: 3;
            height: 100%;
            display: flex;
            align-items: center;
            padding-left: 20px; /* Căn chỉnh biểu tượng */
        }

        .search-bar .input-group-text i {
            font-size: 1.2rem; /* Tăng kích thước biểu tượng */
            transition: color 0.3s ease; /* Hiệu ứng đổi màu mượt mà */
        }

        .search-bar .form-control:focus {
            background-color: #fff; /* Nền trắng khi focus */
            border-color: #e6a500; /* Viền đổi sang màu vàng đậm hơn */
            box-shadow: 0 0 10px rgba(255, 183, 0, 0.5); /* Thêm hiệu ứng phát sáng */
            outline: none; /* Xóa viền mặc định của trình duyệt */
        }

        .search-bar .form-control:hover {
            border-color: #e6a500; /* Viền đổi màu khi hover */
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15); /* Tăng bóng khi hover */
        }

        .search-bar .input-group-text i:hover {
            color: #e6a500; /* Đổi màu biểu tượng khi hover */
        }

        /* Highlight cho người dùng được tìm thấy */
        .highlight {
            background-color: #fff3cd;
            transition: background-color 0.5s ease;
        }

        /* Thông báo không tìm thấy */
        .not-found-alert {
            max-width: 500px;
            margin: 0 auto 20px auto;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Thanh tìm kiếm -->
        <div class="search-bar">
            <form action="customerList" method="post">
                <div class="input-group">
                    <span class="input-group-text">
                        <i class="fa fa-search"></i>
                    </span>
                    <input name="txt" type="text" class="form-control" placeholder="Tìm kiếm khách hàng...">
                </div>
            </form>
        </div>

        <!-- Thông báo không tìm thấy -->
        <c:if test="${notFound}">
            <div class="alert alert-warning not-found-alert" role="alert">
                Không tìm thấy khách hàng với từ khóa "<strong>${keyword}</strong>".
            </div>
        </c:if>

        <div class="customer-table-card card">
            <div class="card-header">
                <h5 class="card-title">Danh sách khách hàng</h5>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên đăng nhập</th>
                            <th>Email</th>
                            <th>Quốc gia</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr id="user-${user.id}">
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.email}</td>
                                <td>${user.country}</td>
                                <td>${user.phone}</td>
                                <td>${user.role}</td>
                                <td>${user.status ? 'Hoạt động' : 'Không hoạt động'}</td>
                                <td>
                                    <a href="users?action=view&id=${user.id}" class="btn btn-sm btn-view">Xem</a>
                                    <a href="users?action=edit&id=${user.id}" class="btn btn-sm btn-edit">Sửa</a>
                                    <a href="users?action=delete&id=${user.id}" class="btn btn-sm btn-delete" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/admindashboard.jsp" class="btn btn-secondary mt-3">Quay lại trang chủ</a>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>

    <!-- JavaScript để cuộn đến người dùng được tìm thấy -->
    <script>
        // Kiểm tra nếu có tham số tìm kiếm trong URL
        const urlParams = new URLSearchParams(window.location.search);
        const foundUserId = urlParams.get('foundUserId');

        if (foundUserId) {
            const userRow = document.getElementById('user-' + foundUserId);
            if (userRow) {
                // Cuộn đến hàng của người dùng
                userRow.scrollIntoView({ behavior: 'smooth', block: 'center' });
                // Highlight hàng
                userRow.classList.add('highlight');
            }
        }
    </script>
</body>
</html>