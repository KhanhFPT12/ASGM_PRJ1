<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Khóa Học: Tập Luyện HIIT - 6Gym</title>
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
        }

        .navbar {
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 0.8rem 1rem;
        }

        .navbar-brand {
            display: flex;
            align-items: center;
        }

        .navbar-brand img {
            height: 50px;
            width: 50px;
            object-fit: cover;
            margin-right: 15px;
            border-radius: 50%;
            border: 2px solid var(--primary-color);
            transition: transform 0.3s ease;
        }

        .navbar-brand img:hover {
            transform: scale(1.1);
        }

        .navbar-brand span {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
            text-shadow: 1px 1px 1px rgba(0,0,0,0.2);
        }

        .navbar-nav .nav-link {
            font-weight: 600;
            padding: 0.8rem 1.2rem;
            position: relative;
            transition: color 0.3s ease;
        }

        .navbar-nav .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: 0;
            left: 50%;
            background-color: var(--primary-color);
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover:after,
        .navbar-nav .active .nav-link:after {
            width: 80%;
            left: 10%;
        }

        .navbar-nav .active .nav-link {
            color: var(--primary-color) !important;
        }

        .dropdown-menu {
            border: none;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            padding: 0.5rem 0;
            margin-top: 0.5rem !important;
            opacity: 0;
            transform: translateY(-10px);
            transition: opacity 0.3s ease, transform 0.3s ease;
            display: block;
            visibility: hidden;
        }

        .dropdown:hover .dropdown-menu {
            opacity: 1;
            transform: translateY(0);
            visibility: visible;
        }

        .dropdown-item {
            padding: 0.8rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .dropdown-item i {
            margin-right: 10px;
            width: 18px;
            text-align: center;
        }

        .dropdown-item:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateX(5px);
        }

        .dropdown-divider {
            margin: 0.5rem 0;
            border-color: #e9ecef;
        }

        .search-form .form-control {
            border-radius: 20px 0 0 20px;
            border: none;
            box-shadow: inset 0 0 5px rgba(0,0,0,0.1);
        }

        .search-form .btn {
            border-radius: 0 20px 20px 0;
            padding: 0.375rem 1rem;
        }

        .btn-cart {
            border-radius: 20px;
            padding: 0.375rem 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-cart .badge {
            position: relative;
            top: -2px;
        }

        .user-dropdown {
            cursor: pointer;
        }

        .user-dropdown i {
            font-size: 1.8rem;
            margin-right: 5px;
        }

        .course-detail {
            padding: 80px 0;
            background-color: #f9f9f9;
        }

        .course-header {
            margin-bottom: 2rem;
        }

        .course-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1rem;
            position: relative;
            padding-bottom: 15px;
        }

        .course-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 80px;
            height: 4px;
            background-color: var(--primary-color);
        }

        .course-image {
            width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: transform 0.5s ease;
            overflow: hidden;
            position: relative;
        }

        .course-image img {
            width: 100%;
            height: auto;
            transition: transform 0.5s ease;
        }

        .course-image:hover img {
            transform: scale(1.05);
        }

        .course-description {
            font-size: 1.1rem;
            line-height: 1.8;
            margin-bottom: 40px;
            text-align: justify;
        }

        .features-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark-color);
        }

        .features-list {
            padding-left: 20px;
        }

        .features-list li {
            margin-bottom: 15px;
            position: relative;
            padding-left: 30px;
            font-size: 1.1rem;
        }

        .features-list li i {
            position: absolute;
            left: 0;
            top: 5px;
            color: var(--primary-color);
        }

        .course-info-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-top: 0;
            overflow: hidden;
        }

        .course-info-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .card-header {
            background-color: var(--dark-color);
            color: white;
            border: none;
            padding: 1.5rem;
            text-align: center;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin: 0;
        }

        .card-body {
            padding: 1.5rem;
        }

        .course-price {
            font-size: 2rem;
            font-weight: 700;
            color: var(--accent-color);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .course-info {
            margin-bottom: 1.5rem;
        }

        .course-info p {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .course-info i {
            width: 25px;
            margin-right: 10px;
            color: var(--primary-color);
        }

        .btn-register {
            padding: 12px 24px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.3s ease;
            letter-spacing: 1px;
        }

        .btn-register:hover {
            background-color: #e6a500;
            border-color: #e6a500;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 183, 0, 0.4);
        }

        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 60px 0 30px;
            position: relative;
        }

        footer:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(to right, var(--primary-color), #ff7e00);
        }

        footer h5 {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
        }

        footer h5:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background-color: var(--primary-color);
        }

        footer ul {
            list-style: none;
            padding: 0;
        }

        footer ul li {
            margin-bottom: 15px;
        }

        footer ul li i {
            margin-right: 10px;
            color: var(--primary-color);
            width: 16px;
            text-align: center;
        }

        footer a {
            color: #f8f9fa;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        footer a:hover {
            color: var(--primary-color);
            transform: translateX(5px);
            display: inline-block;
        }

        .social-icons {
            display: flex;
            gap: 15px;
        }

        .social-icons a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .social-icons a:hover {
            background-color: var(--primary-color);
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .social-icons i {
            font-size: 20px;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 30px;
            margin-top: 30px;
            border-top: 1px solid rgba(255,255,255,0.1);
            font-size: 0.9rem;
        }

        @media (max-width: 991.98px) {
            .navbar-brand img {
                height: 40px;
                width: 40px;
            }
            .navbar-brand span {
                font-size: 1.5rem;
            }
            .course-title {
                font-size: 2rem;
            }
            .course-info-card {
                margin-top: 2rem;
            }
        }

        @media (max-width: 767.98px) {
            .course-detail {
                padding: 40px 0;
            }
            .course-title {
                font-size: 1.8rem;
            }
            .features-list li {
                font-size: 1rem;
            }
            .course-price {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="6Gym Logo">
                <span>6Gym</span>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarMain">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home">
                            <i class="fas fa-home mr-1"></i> Trang chủ
                        </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="#popular-courses">
                            <i class="fas fa-dumbbell mr-1"></i> Khóa học
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">
                            <i class="fas fa-phone-alt mr-1"></i> Liên hệ
                        </a>
                    </li>
                </ul>

                <div class="d-flex align-items-center">
                    <form action="search" method="post" class="search-form d-flex mr-3">
                        <input name="txt" type="text" class="form-control" placeholder="Tìm kiếm...">
                        <button type="submit" class="btn btn-dark">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>

                    <a class="btn btn-warning btn-cart mr-3" href="cart">
                        <i class="fas fa-shopping-cart mr-1"></i> Giỏ hàng
                        <span class="badge badge-light">3</span>
                    </a>

                    <div class="dropdown">
                        <a class="dropdown-toggle text-light user-dropdown" href="#" id="userDropdown" data-toggle="dropdown" style="text-decoration: none;">
                            <i class="fas fa-user-circle"></i>
                            <span class="d-none d-lg-inline"><c:out value="${sessionScope.username}" default="User" /></span>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/detailUser.jsp">
                                <i class="fas fa-user"></i> Thông tin cá nhân
                            </a>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/changePassword.jsp">
                                <i class="fas fa-lock"></i> Mật khẩu và bảo mật
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="users?action=logout">
                                <i class="fas fa-sign-out-alt"></i> Đăng xuất
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- Course Detail -->
    <section class="course-detail">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="course-header">
                        <h2 class="course-title">Tập Luyện HIIT (High-Intensity Interval Training)</h2>
                    </div>

                    <div class="course-image">
                        <img src="${pageContext.request.contextPath}/images/HIIT.jpg" alt="Tập Luyện HIIT" class="img-fluid">
                    </div>

                    <p class="course-description">
                        Khóa học "Tập Luyện HIIT" được thiết kế để giúp bạn đốt cháy calo và cải thiện sức khỏe tim mạch một cách nhanh chóng thông qua các bài tập cường độ cao ngắt quãng. Dưới sự hướng dẫn của các huấn luyện viên chuyên nghiệp, bạn sẽ được cung cấp một chương trình tập luyện và chế độ dinh dưỡng phù hợp để đạt được mục tiêu của mình.
                    </p>

                    <h4 class="features-title">Đặc điểm nổi bật:</h4>
                    <ul class="features-list">
                        <li><i class="fas fa-check-circle"></i> Các bài tập cường độ cao ngắt quãng.</li>
                        <li><i class="fas fa-check-circle"></i> Thời gian tập luyện ngắn, hiệu quả cao.</li>
                        <li><i class="fas fa-check-circle"></i> Hướng dẫn kỹ thuật tập luyện đúng cách.</li>
                        <li><i class="fas fa-check-circle"></i> Phù hợp với người bận rộn.</li>
                        <li><i class="fas fa-check-circle"></i> Hỗ trợ 1:1 từ huấn luyện viên.</li>
                    </ul>
                </div>

                <div class="col-lg-4">
                    <div class="course-info-card card">
                        <div class="card-header">
                            <h5 class="card-title">Thông Tin Khóa Học</h5>
                        </div>
                        <div class="card-body">
                            <div class="course-price">1,600,000 ₫</div>
                            <div class="course-info">
                                <p><i class="far fa-calendar-alt"></i> <strong>Thời gian:</strong> 6 tuần</p>
                                <p><i class="fas fa-users"></i> <strong>Đối tượng:</strong> Người muốn giảm cân và tăng cường sức khỏe nhanh chóng</p>
                                <p><i class="fas fa-user-tie"></i> <strong>Huấn luyện viên:</strong> Chuyên gia HIIT</p>
                                <p><i class="fas fa-stopwatch"></i> <strong>Thời lượng:</strong> 30 phút/buổi</p>
                            </div>
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="courseId" value="6">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="btn btn-warning btn-register btn-block">
                                    <i class="fas fa-bolt mr-2"></i> Đăng ký ngay
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5>Thông tin liên hệ</h5>
                    <ul>
                        <li><i class="fas fa-map-marker-alt"></i> 151 Huỳnh Ngọc Đủ, Hòa Xuân, Cẩm Lệ, Đà Nẵng</li>
                        <li><i class="fas fa-phone-alt"></i> 0819734122</li>
                        <li><i class="fas fa-envelope"></i> 6gym@gmail.com</li>
                        <li><i class="fas fa-clock"></i> Thứ 2 - Chủ nhật: 6:00 - 22:00</li>
                    </ul>
                </div>

                <div class="col-md-4 mb-4">
                    <h5>Liên kết nhanh</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Trang chủ</a></li>
                        <li><a href="#popular-courses"><i class="fas fa-dumbbell"></i> Khóa học</a></li>
                        <li><a href="#"><i class="fas fa-blog"></i> Blog</a></li>
                        <li><a href="#"><i class="fas fa-users"></i> Về chúng tôi</a></li>
                        <li><a href="#contact"><i class="fas fa-phone-alt"></i> Liên hệ</a></li>
                    </ul>
                </div>

                <div class="col-md-4 mb-4">
                    <h5>Theo dõi chúng tôi</h5>
                    <p>Cập nhật thông tin mới nhất về các khóa học và khuyến mãi đặc biệt.</p>
                    <div class="social-icons">
                        <a href="#"><i class="fab fa-facebook-f"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                        <a href="#"><i class="fab fa-tiktok"></i></a>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>© 2025 6Gym - Trung tâm thể hình hàng đầu Đà Nẵng. Đã đăng ký Bản quyền.</p>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
</body>
</html>