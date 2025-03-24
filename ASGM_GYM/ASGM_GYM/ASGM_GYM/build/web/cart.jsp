    <%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - 6Gym</title>
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

        .cart-table-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin: 30px auto;
            overflow: hidden;
        }

        .cart-table-card:hover {
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

        .btn-update, .btn-remove {
            padding: 8px 16px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            transition: all 0.3s ease;
            letter-spacing: 1px;
            border: none;
        }

        .btn-update {
            background-color: var(--primary-color);
            color: #fff;
        }

        .btn-update:hover {
            background-color: #e6a500;
        }

        .btn-remove {
            background-color: var(--accent-color);
            color: #fff;
        }

        .btn-remove:hover {
            background-color: #c82333;
        }

        .btn-checkout {
            padding: 12px 24px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.3s ease;
            letter-spacing: 1px;
            display: inline-block;
            margin-top: 20px;
        }

        .btn-checkout:hover {
            background-color: #e6a500;
            border-color: #e6a500;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 183, 0, 0.4);
        }

        h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-color);
            text-align: center;
            margin-bottom: 20px;
        }

        .empty-cart-message {
            text-align: center;
            font-size: 1.2rem;
            color: var(--text-color);
            margin-bottom: 20px;
        }

        .back-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #6c757d;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .back-link:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="cart-table-card card">
            <div class="card-header">
                <h5 class="card-title">Giỏ hàng của bạn</h5>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty cart.items}">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Khóa học</th>
                                    <th>Số lượng</th>
                                    <th>Giá</th>
                                    <th>Tổng</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cart.items}">
                                    <tr>
                                        <td>${item.courses.courseName}</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="courseId" value="${item.courses.courseId}">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control d-inline" style="width: 70px;">
                                                <button type="submit" class="btn btn-sm btn-update ml-2">Cập nhật</button>
                                            </form>
                                        </td>
                                        <td>${item.courses.price} ₫</td>
                                        <td>${item.totalPrice} ₫</td>
                                        <td>
                                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                                <input type="hidden" name="action" value="remove">
                                                <input type="hidden" name="courseId" value="${item.courses.courseId}">
                                                <button type="submit" class="btn btn-sm btn-remove">Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr>
                                    <td colspan="3" class="text-right"><strong>Tổng cộng</strong></td>
                                    <td colspan="2">${cart.totalAmountWithDiscount} ₫</td>
                                </tr>
                            </tfoot>
                        </table>
                        <div class="text-center">
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-warning btn-checkout">Tiến hành thanh toán</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="empty-cart-message">Giỏ hàng của bạn đang trống.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="text-center">
           <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary mt-3">Quay lại trang chủ</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
</body>
</html>