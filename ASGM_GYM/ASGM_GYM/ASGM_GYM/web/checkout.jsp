<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán - 6Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        .logo img {
            display: block;
            margin: 0 auto 20px;
            max-width: 120px;
            transition: transform 0.3s;
        }
        .logo img:hover {
            transform: scale(1.05);
        }
        .checkout-header {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 40px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }
        .checkout-form {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .form-group label {
            font-weight: 600;
            color: #34495e;
            margin-bottom: 8px;
        }
        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 10px;
            transition: border-color 0.3s;
        }
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
        }
        .order-summary {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .order-summary h3 {
            color: #2c3e50;
            font-size: 1.3rem;
            margin-bottom: 15px;
        }
        .order-summary ul {
            list-style: none;
            padding: 0;
            margin-bottom: 20px;
        }
        .order-summary ul li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
            color: #7f8c8d;
        }
        .total-amount {
            font-weight: 700;
            font-size: 1.5rem;
            color: #e74c3c;
            text-align: right;
        }
        .btn-submit {
            background: #27ae60;
            border: none;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            transition: all 0.3s;
            width: 100%;
            margin-top: 20px;
        }
        .btn-submit:hover {
            background: #219653;
            transform: scale(1.02);
        }
        .btn-back {
            display: block;
            text-align: center;
            color: #7f8c8d;
            text-decoration: none;
            margin-top: 20px;
            transition: all 0.3s;
        }
        .btn-back:hover {
            color: #2c3e50;
            text-decoration: underline;
        }
        .empty-cart {
            text-align: center;
            padding: 50px;
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            color: #7f8c8d;
        }
        .empty-cart i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #e74c3c;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="6Gym Logo">
        </div>
        <h1 class="checkout-header">Thanh Toán</h1>

        <c:choose>
            <c:when test="${empty cart.items}">
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <p>Giỏ hàng của bạn đang trống. Vui lòng thêm khóa học trước khi thanh toán.</p>
                    <a href="${pageContext.request.contextPath}/cart" class="btn-back">Quay lại giỏ hàng</a>
                </div>
            </c:when>
            <c:otherwise>
                <form id="paymentForm" method="post" class="checkout-form">
                    <div class="form-group">
                        <label for="username">Họ và tên:</label>
                        <input type="text" id="username" name="username" class="form-control" required placeholder="Nhập họ và tên của bạn">
                    </div>
                    <div class="form-group">
                        <label for="paymentMethod">Phương thức thanh toán:</label>
                        <select id="paymentMethod" name="paymentMethod" class="form-control" required>
                            <option value="">Chọn phương thức thanh toán</option>
                            <option value="TrucTiep">Trực tiếp (Gửi bill qua email)</option>
                            <option value="VN_PAY">VNPAY</option>
                        </select>
                    </div>

                    <div class="order-summary">
                        <h3>Tóm tắt đơn hàng</h3>
                        <ul>
                            <c:forEach var="item" items="${cart.items}">
                                <li>${item.courses.courseName} - ${item.totalPrice} ₫</li>
                            </c:forEach>
                        </ul>
                        <div class="total-amount">
                            Tổng cộng: ${cart.totalAmountWithDiscount} ₫
                            <input type="hidden" name="totalBill" value="${cart.totalAmountWithDiscount}">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-submit">Hoàn tất mua hàng</button>
                </form>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/cart" class="btn-back">Quay lại giỏ hàng</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('paymentForm')?.addEventListener('submit', function(event) {
            const paymentMethod = document.getElementById('paymentMethod').value;
            if (paymentMethod === 'TrucTiep') {
                this.action = '${pageContext.request.contextPath}/checkout';
            } else if (paymentMethod === 'VN_PAY') {
                this.action = '${pageContext.request.contextPath}/ajaxServlet';
            }
        });
    </script>
</body>
</html>