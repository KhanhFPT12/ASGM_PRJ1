<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - 6Gym</title>
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

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: var(--dark-color); /* Set to dark color */
            background-image: url('https://img.freepik.com/premium-photo/blurred-fitness-healthy-background-concept-workout-personal-training-studio-generative-ai_1002555-13295.jpg');
            background-size: cover;
            background-position: center;
            background-blend-mode: overlay;
            color: white; /* Default text color */
           overflow: auto; /* Make Scrollable */
        }

        .login-container {
            background-color: rgba(255, 255, 255, 0.7); /* More transparent white */
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15); /* Subtle shadow */
            width: 100%;
            max-width: 450px;
            text-align: center;
            animation: fadeIn 0.5s ease-in-out;
           overflow: auto; /* Enable scrolling within the container */
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
            border: 3px solid var(--primary-color);
            transition: transform 0.3s ease;
        }

        .logo img:hover {
            transform: scale(1.1);
        }

        h2 {
            font-weight: 700;
            color: var(--dark-color);
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
            color: var(--dark-color);
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
            border-color: var(--primary-color);
            box-shadow: 0 0 8px rgba(255, 183, 0, 0.2);
            outline: none;
        }

        button {
            background-color: var(--primary-color);
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
            color: var(--accent-color);
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
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        p a:hover {
            color: #e6a500;
            text-decoration: underline;
        }

        a, a:hover {
            color: var(--primary-color)
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
    <div class="login-container">
        <div class="logo">
            <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="6Gym Logo">
        </div>
        <h2>Đăng ký tài khoản</h2>
        <form action="<%= request.getContextPath() %>/register" method="POST" style="overflow: auto !important;">
            <div class="form-group">
                <label for="fullname">Họ và tên:</label>
                <input type="text" id="fullname" name="fullname" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại:</label>
                <input type="text" id="phone" name="phone" pattern="[0-9]{10}" title="Số điện thoại phải có 10 chữ số" required>
            </div>
            <div class="form-group">
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="confirm_password">Xác nhận mật khẩu:</label>
                <input type="password" id="confirm_password" name="confirm_password" required>
            </div>
            <button type="submit">Đăng ký</button>
        </form>

        <c:if test="${not empty param.error}">
            <p class="error">
                <c:choose>
                    <c:when test="${param.error == 'emptyFields'}">Vui lòng điền đầy đủ thông tin.</c:when>
                    <c:when test="${param.error == 'passwordMismatch'}">Mật khẩu và xác nhận mật khẩu không khớp.</c:when>
                    <c:when test="${param.error == 'invalidPhone'}">Số điện thoại không hợp lệ (phải có 10 chữ số).</c:when>
                    <c:when test="${param.error == 'usernameExists'}">Tên đăng nhập đã tồn tại. Vui lòng chọn tên khác.</c:when>
                    <c:when test="${param.error == 'registrationFailed'}">Đăng ký thất bại. Vui lòng thử lại.</c:when>
                    <c:otherwise>Đã có lỗi xảy ra. Vui lòng thử lại.</c:otherwise>
                </c:choose>
            </p>
        </c:if>

        <p>Đã có tài khoản? <a href="login.jsp">Đăng nhập tại đây</a></p>
    </div>
</body>
</html>