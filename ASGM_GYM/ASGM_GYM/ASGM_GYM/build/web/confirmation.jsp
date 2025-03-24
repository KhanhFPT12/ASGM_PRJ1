<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác nhận thanh toán - 6Gym</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            overflow: auto;
        }
        .container {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px;
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
        h1 {
            font-weight: 700;
            color: #28a745;
            margin-bottom: 20px;
            font-size: 1.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        p {
            color: #666;
            font-size: 1rem;
            margin-bottom: 20px;
        }
        .btn-home {
            background-color: #ffb700;
            color: #fff;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .btn-home:hover {
            background-color: #e6a500;
            transform: translateY(-2px);
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
    <div class="container">
        <div class="logo">
            <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="6Gym Logo">
        </div>
        <h1>Thanh toán thành công!</h1>
        <p>Cảm ơn bạn đã mua gói tập luyện tại 6Gym. Chúng tôi đã gửi email xác nhận đến địa chỉ email của bạn.</p>
        <a href="${pageContext.request.contextPath}/home" class="btn-home">Quay lại trang chủ</a>
    </div>
</body>
</html>