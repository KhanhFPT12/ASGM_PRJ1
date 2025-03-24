<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu - 6Gym</title>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/login.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        .forgot-password-container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            text-align: center;
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .logo img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            margin-bottom: 20px;
            border: 3px solid #ffb700;
            transition: transform 0.3s ease;
        }
        .logo img:hover {
            transform: scale(1.1);
        }
        h2 {
            font-weight: 700;
            color: #333;
            margin-bottom: 25px;
            font-size: 1.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }
        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: block;
            font-size: 0.95rem;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-group input:focus {
            border-color: #ffb700;
            box-shadow: 0 0 8px rgba(255, 183, 0, 0.2);
            outline: none;
        }
        button {
            background-color: #ffb700;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 5px;
            width: 100%;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        button:hover {
            background-color: #e6a500;
            transform: translateY(-2px);
        }
        .error {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 15px;
            font-style: italic;
        }
        p {
            margin-top: 20px;
            color: #666;
            font-size: 0.9rem;
        }
        p a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        p a:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(255, 183, 0, 0.1) 0%, transparent 70%);
            z-index: -1;
            animation: pulse 10s infinite;
        }
        @keyframes pulse {
           0% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.2); opacity: 0.3; }
            100% { transform: scale(1); opacity: 0.5; }
        }
    </style>
</head>
<body>
    <div class="forgot-password-container">
        <div class="logo">
            <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="6Gym Logo">
        </div>
        <h2>Quên mật khẩu</h2>
        <form action="<%= request.getContextPath() %>/forgotPassword" method="POST">
            <div class="form-group">
                <label for="identifier">Tên đăng nhập hoặc Email:</label>
                <input type="text" id="identifier" name="identifier" required>
            </div>
            <button type="submit">Gửi yêu cầu</button>
        </form>
        <c:if test="${not empty param.error}">
            <p class="error">
                <c:choose>
                    <c:when test="${param.error == 'notFound'}">Không tìm thấy tài khoản với thông tin này. Vui lòng thử lại.</c:when>
                    <c:otherwise>Đã có lỗi xảy ra. Vui lòng thử lại.</c:otherwise>
                </c:choose>
            </p>
        </c:if>
        <p>Quay lại <a href="login.jsp">Đăng nhập</a></p>
    </div>
</body>
</html>