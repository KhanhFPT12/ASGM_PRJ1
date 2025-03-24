<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin người dùng - 6Gym</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif; /* Font chữ hiện đại, dễ đọc */
            background-color: #2d2d2d; /* Màu đen nhạt cho nền toàn trang */
            padding: 40px 20px; /* Tăng padding để tạo không gian thoáng */
            color: #d4d4d4; /* Màu chữ nhạt để tương phản với nền đen */
        }

        .container {
            max-width: 800px; /* Giảm chiều rộng tối đa để tập trung nội dung */
            margin: 0 auto; /* Căn giữa container */
        }

        .user-info {
            background-color: #3a3a3a; /* Màu đen nhạt hơn cho khung chính */
            border-radius: 10px; /* Bo góc khung */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3); /* Đổ bóng đậm hơn để nổi bật trên nền đen */
            padding: 30px; /* Tăng padding để nội dung thoáng hơn */
            border: 1px solid #ffd700; /* Viền vàng để tạo điểm nhấn */
        }

        .user-info h2 {
            font-weight: 700; /* Chữ đậm */
            color: #ffd700; /* Màu vàng cho tiêu đề */
            margin-bottom: 30px; /* Tăng khoảng cách dưới tiêu đề */
            text-align: center; /* Căn giữa tiêu đề */
            font-size: 2rem; /* Tăng kích thước chữ tiêu đề */
        }

        .user-info p {
            font-size: 1.15rem; /* Tăng kích thước chữ để dễ đọc */
            margin: 15px 0; /* Tăng khoảng cách giữa các dòng */
            padding: 10px; /* Thêm padding để tạo không gian trong khung */
            background-color: #454545; /* Màu đen nhạt hơn cho nền mỗi dòng thông tin */
            border-left: 4px solid #ffd700; /* Viền trái màu vàng để nổi bật */
            border-radius: 5px; /* Bo góc khung thông tin */
            color: #d4d4d4; /* Màu chữ nhạt để dễ đọc trên nền đen */
            transition: all 0.3s ease; /* Hiệu ứng mượt mà khi hover */
        }

        .user-info p:hover {
            background-color: #505050; /* Hiệu ứng hover: đổi màu nền khi di chuột qua */
            transform: translateX(5px); /* Dịch chuyển nhẹ khi hover */
        }

        .user-info p strong {
            color: #ffd700; /* Màu vàng cho phần tiêu đề của thông tin (ID, Tên,...) */
            font-weight: 600; /* Chữ đậm vừa phải */
        }

        .btn-back {
            margin-top: 30px; /* Tăng khoảng cách phía trên nút */
            display: block; /* Chuyển thành block để căn giữa */
            width: 200px; /* Đặt chiều rộng cố định cho nút */
            margin-left: auto; /* Căn giữa nút */
            margin-right: auto;
            background-color: #ffd700; /* Màu vàng cho nút */
            border: none; /* Bỏ viền mặc định */
            padding: 12px 20px; /* Tăng padding để nút lớn hơn */
            font-size: 1.1rem; /* Tăng kích thước chữ của nút */
            font-weight: 500; /* Chữ đậm vừa phải */
            border-radius: 5px; /* Bo góc nút */
            color: #2d2d2d; /* Màu chữ đen nhạt trên nút vàng */
            transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu mượt mà */
        }

        .btn-back:hover {
            background-color: #e6c200; /* Màu vàng đậm hơn khi hover */
            color: #2d2d2d; /* Giữ màu chữ */
        }

        .error-message {
            color: #ff4d4d; /* Màu đỏ cho thông báo lỗi */
            text-align: center; /* Căn giữa thông báo lỗi */
            font-size: 1.2rem; /* Tăng kích thước chữ */
            margin-bottom: 20px; /* Tăng khoảng cách dưới thông báo lỗi */
            padding: 10px; /* Thêm padding */
            background-color: #4a2c2c; /* Nền đỏ đậm nhạt để phù hợp với tông đen */
            border: 1px solid #ff4d4d; /* Viền đỏ */
            border-radius: 5px; /* Bo góc khung lỗi */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="user-info">
            <h2>THÔNG TIN NGƯỜI DÙNG</h2>
            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>
            <c:if test="${not empty user}">
                <p><strong>ID:</strong> ${user.id}</p>
                <p><strong>Tên đăng nhập:</strong> ${user.username}</p>
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Quốc gia:</strong> ${user.country}</p>
                <p><strong>Số điện thoại:</strong> ${user.phone}</p>
                <p><strong>Vai trò:</strong> ${user.role}</p>
                <p><strong>Trạng thái:</strong> ${user.status ? 'Hoạt động' : 'Không hoạt động'}</p>
            </c:if>
            <c:if test="${empty user && empty error}">
                <p class="error-message">Không có dữ liệu người dùng để hiển thị.</p>
            </c:if>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-back">Quay lại Trang chủ</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>