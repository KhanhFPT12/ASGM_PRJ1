<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>6Gym - Trung tâm thể hình hàng đầu Đà Nẵng</title>
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
        }

        /* Top Banner */
        .top-banner {
            background-color: var(--primary-color);
            color: white;
            padding: 0.8rem 0;
            font-weight: bold;
            text-align: center;
            overflow: hidden;
        }

        .top-banner-text {
            white-space: nowrap;
            animation: scroll-text 20s linear infinite;
        }

        @keyframes scroll-text {
            0% { transform: translateX(100%); }
            100% { transform: translateX(-100%); }
        }

        /* Navbar */
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

        /* Dropdown */
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

        /* Search Form */
        .search-form .form-control {
            border-radius: 20px 0 0 20px;
            border: none;
            box-shadow: inset 0 0 5px rgba(0,0,0,0.1);
        }

        .search-form .btn {
            border-radius: 0 20px 20px 0;
            padding: 0.375rem 1rem;
        }

        /* Cart Button */
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

        /* User Dropdown */
        .user-dropdown {
            cursor: pointer;
        }

        .user-dropdown i {
            font-size: 1.8rem;
            margin-right: 5px;
        }

        /* Jumbotron */
        .jumbotron {
            position: relative;
            overflow: hidden;
            padding: 150px 20px;
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.7)), url('${pageContext.request.contextPath}/images/khoahoc.jpg') center/cover no-repeat; /* Gradient overlay */
            color: #fff;
        }

        .jumbotron::before {
            content: ''; /* Required for pseudo-element to display */
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Optional background color */
            z-index: -1; /* Place behind content */
        }

        .jumbotron-heading {
            font-size: 3rem;
            font-weight: 700;
            color: var(--primary-color);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
            font-family: 'Arial Black', Gadget, sans-serif;
            text-transform: uppercase;
        }

        .jumbotron .lead {
            font-size: 1.2rem;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7);
        }

        .jumbotron .btn-warning {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .jumbotron .btn-warning:hover {
            background-color: #e6a500;
            border-color: #e6a500;
            transform: scale(1.05);
        }

        /* Popular Courses Section */
        .popular-courses {
            padding: 80px 0;
            background-color: #f9f9f9;
        }

        .section-title {
            text-align: center;
            margin-bottom: 4rem;
        }

        .section-title h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark-color);
            position: relative;
            padding-bottom: 15px;
            display: inline-block;
        }

        .section-title h2:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background-color: var(--primary-color);
        }

        /* Course Card */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .card-img-top {
            height: 220px; /* Adjusted height for better image display */
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .card:hover .card-img-top {
            transform: scale(1.05);
        }

        .card-body {
            padding: 1.5rem;
        }

        .card-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .card-title a {
            text-decoration: none;
            color: inherit; /* Inherit color from parent */
            transition: color 0.3s ease;
        }

        .card-title a:hover {
            color: var(--primary-color);
        }

        .card-text {
            font-size: 1.1rem;
            line-height: 1.5;
            margin-bottom: 1.5rem;
            color: var(--text-color);
        }

        .card .btn-warning {
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

        .card .btn-warning:hover {
            background-color: #e6a500;
            border-color: #e6a500;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 183, 0, 0.4);
        }

        /* Category Block */
        .category_block .card-header {
            background-color: var(--dark-color);
            color: white;
            text-transform: uppercase;
            font-weight: 600;
            border: none;
            border-radius: 12px 12px 0 0;
            padding: 1.2rem;
        }

        .category_block ul {
            list-style: none;
            padding: 0;
        }

        .category_block li {
            margin-bottom: 0;
            border-bottom: 1px solid #e9ecef;
        }

        .category_block li:last-child {
            border-bottom: none;
        }

        .category_block li a {
            display: block;
            padding: 1rem 1.2rem;
            color: var(--text-color);
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 1.1rem;
        }

        .category_block li a:hover {
            color: var(--primary-color);
            transform: translateX(5px);
            background-color: #f8f9fa; /* Add a subtle background on hover */
        }

        /* Testimonials Section */
        .testimonial {
            padding: 80px 0;
            background-color: var(--light-color);
        }

        .testimonial-item {
            padding: 30px;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
        }

        .testimonial-item img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 1.5rem;
        }

        .testimonial-item h5 {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .testimonial-item p {
            font-style: italic;
            color: var(--text-color);
            line-height: 1.7;
        }

        /* Statistics Section */
        .stats {
            padding: 80px 0;
            background-color: var(--dark-color);
            color: white;
        }

        .stats-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            transition: color 0.3s ease;
        }

        .stats-number {
            font-size: 3rem;
            font-weight: 700;
            color: var(--primary-color);
            transition: color 0.3s ease;
            animation: count-up 1s ease-out;
        }

        .stats-text {
            font-size: 1.2rem;
            transition: color 0.3s ease;
        }

        .stats-icon:hover,
        .stats-number:hover,
        .stats-text:hover {
            color: #e6a500;
        }

        @keyframes count-up {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        /* Footer */
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

        /* Responsive */
        @media (max-width: 991.98px) {
            .navbar-brand img {
                height: 40px;
                width: 40px;
            }

            .navbar-brand span {
                font-size: 1.5rem;
            }

            .jumbotron {
                padding: 100px 20px;
            }

            .jumbotron-heading {
                font-size: 2.2rem;
            }

            .section-title h2 {
                font-size: 2rem;
            }
        }

        @media (max-width: 767.98px) {
            .jumbotron-heading {
                font-size: 2rem;
            }

            .card-title {
                font-size: 1.2rem;
            }

            .testimonial-item p {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

<!-- Top Banner -->
<div class="top-banner">
    <div class="top-banner-text">
        GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI
    </div>
</div>

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
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">
                        <i class="fas fa-home mr-1"></i> Trang chủ
                    </a>
                </li>
                <li class="nav-item">
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
                         <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Đăng xuất
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Banner -->
<section class="jumbotron text-center">
    <div class="container">
        <h1 class="jumbotron-heading">Khóa Học Gym Chất Lượng Cao</h1>
        <p class="lead">Huấn luyện viên chuyên nghiệp, giáo trình khoa học, giúp bạn đạt được mục tiêu thể hình nhanh chóng!</p>
        <p>
            <a href="#popular-courses" class="btn btn-warning btn-lg my-2">Tham gia ngay</a>
            <a href="#" class="btn btn-outline-light btn-lg my-2">Tìm hiểu thêm</a>
        </p>
    </div>
</section>

<!-- Popular Courses -->
<section class="popular-courses" id="popular-courses">
    <div class="container">
        <div class="section-title">
            <h2>Khóa học nổi bật</h2>
        </div>
        <div class="row">
            <!-- Danh mục -->
            <div class="col-md-3">
                <div class="card category_block">
                    <div class="card-header">Danh mục khóa học</div>
                    <ul class="list-group">
                        <li class="list-group-item"><a href="#popular-courses">Tất cả</a></li>
                        <li class="list-group-item"><a href="#popular-courses">Tăng cơ giảm mỡ</a></li>
                        <li class="list-group-item"><a href="#popular-courses">Giảm cân</a></li>
                        <li class="list-group-item"><a href="#popular-courses">Thể hình nữ</a></li>
                        <li class="list-group-item"><a href="#popular-courses">Fitness</a></li>
                        <li class="list-group-item"><a href="#popular-courses">Yoga</a></li>
                    </ul>
                </div>
            </div>

            <!-- Danh sách khóa học -->
            <div class="col-md-9">
                <div class="row">
                    <c:forEach var="course" items="${courses}">
                        <div class="col-md-4">
                            <div class="card">
                                <c:choose>
                                    <c:when test="${course.courseId == 1}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/moitap.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 2}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/giamcan.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 3}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/tangcobap.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 4}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/cardio.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 5}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/sucben.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 6}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/HIIT.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 7}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/tadon.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 8}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/kick.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 9}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/Calis.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:when test="${course.courseId == 10}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/Cross.jpg" alt="${course.courseName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="card-img-top" src="${pageContext.request.contextPath}/images/default.jpg" alt="${course.courseName}">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <c:choose>
                                            <c:when test="${course.courseId == 1}">
                                                <a href="detail_course/coban.jsp">${course.courseName}</a>
                                            </c:when>
                                            <c:when test="${course.courseId == 2}">
                                                <a href="detail_course/giamcan.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 3}">
                                                <a href="detail_course/tangco.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 4}">
                                                <a href="detail_course/cardio.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 5}">
                                                <a href="detail_course/sucben.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 6}">
                                                <a href="detail_course/hiit.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 7}">
                                                <a href="detail_course/tadon.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 8}">
                                                <a href="detail_course/kick.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 9}">
                                                <a href="detail_course/calisthenics.jsp">${course.courseName}</a>
                                            </c:when>
                                             <c:when test="${course.courseId == 10}">
                                                <a href="detail_course/crossfit.jsp">${course.courseName}</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="#">${course.courseName}</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </h5>
                                    <p class="card-text">${course.description}</p>
                                    <p class="text-danger font-weight-bold">${course.price} ₫</p>
                                    <!-- Thay nút thành form -->
                                    <form action="${pageContext.request.contextPath}/cart" method="post">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="courseId" value="${course.courseId}">
                                        <input type="hidden" name="quantity" value="1"> <!-- Mặc định thêm 1 khóa học -->
                                        <button type="submit" class="btn btn-warning btn-block">Đăng ký ngay</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty courses}">
                        <div class="col-12">
                            <p class="text-center">Không có khóa học nào để hiển thị.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials -->
<section class="testimonial">
    <div class="container">
        <div class="section-title">
            <h2>Học viên nói gì về chúng tôi?</h2>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="testimonial-item text-center">
                    <img src="https://via.placeholder.com/100x100" alt="Học viên 1">
                    <h5>Nguyễn Gia Khánh</h5>
                    <p>"6Gym thực sự thay đổi cuộc sống của tôi. Tôi đã giảm 10kg chỉ sau 2 tháng tập luyện và ăn uống khoa học!"</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial-item text-center">
                    <img src="https://via.placeholder.com/100x100" alt="Học viên 2">
                    <h5>Võ Văn Tin</h5>
                    <p>"HLV tận tâm, giáo trình bài bản. Tôi cảm thấy tràn đầy năng lượng và tự tin hơn mỗi ngày!"</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonial-item text-center">
                    <img src="https://via.placeholder.com/100x100" alt="Học viên 3">
                    <h5>Nguyễn Cao Hoàng Huy</h5>
                    <p>"Không gian tập luyện hiện đại, đội ngũ nhân viên thân thiện. Tôi rất hài lòng khi tham gia 6Gym và đã đạt được mục tiêu của mình."</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Statistics -->
<section class="stats">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3">
                <div class="stats-icon"><i class="fas fa-calendar-check"></i></div>
                <div class="stats-number">10+</div>
                <div class="stats-text">Năm kinh nghiệm</div>
            </div>
            <div class="col-md-3">
                <div class="stats-icon"><i class="fas fa-smile"></i></div>
                <div class="stats-number">5000+</div>
                <div class="stats-text">Học viên hài lòng</div>
            </div>
            <div class="col-md-3">
                <div class="stats-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stats-number">100%</div>
                <div class="stats-text">Cam kết chất lượng</div>
            </div>
            <div class="col-md-3">
                <div class="stats-icon"><i class="fas fa-book">
</i></div>
                <div class="stats-number">50+</div>
                <div class="stats-text">Khóa học đa dạng</div>
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
<script>
    // Smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();

            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>

    <!-- Dialogflow Chatbot -->
    <script src="https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1"></script>
    <df-messenger
        intent="WELCOME"
        chat-title="chatbot_ai"
        agent-id="e1bfb444-a9ab-46ec-9efb-9713947f8468"
        language-code="en"
    ></df-messenger>

</body>
</html>