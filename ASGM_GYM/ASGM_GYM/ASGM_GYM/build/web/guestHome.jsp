<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>6Gym - Khóa Học Tập Gym</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        /* CSS giống như trong home.jsp */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
        }
        .top-banner {
            background-color: #ffb700;
            color: white;
            padding: 8px 0;
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
        .jumbotron {
            background-color: #f8f9fa;
            padding: 4rem 2rem;
        }
        .jumbotron-heading {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .card-title a {
            color: #333;
            text-decoration: none;
        }
        .card-title a:hover {
            color: #ffb700;
        }
        .btn-warning {
            background-color: #ffb700;
            border-color: #ffb700;
        }
        .btn-warning:hover {
            background-color: #e6a500;
            border-color: #e6a500;
        }
        footer {
            background-color: #343a40;
            color: white;
            padding: 40px 0;
        }
        footer h5 {
            font-weight: 600;
            margin-bottom: 20px;
        }
        footer ul {
            list-style: none;
            padding: 0;
        }
        footer ul li {
            margin-bottom: 10px;
        }
        footer a {
            color: #f8f9fa;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        footer a:hover {
            color: #ffb700;
            text-decoration: underline;
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #ffb700;
        }
        .features {
            padding: 60px 0;
            background-color: #f8f9fa;
        }
        .popular-courses {
            padding: 60px 0;
        }
        .section-title {
            text-align: center;
            margin-bottom: 40px;
        }
        .section-title h2 {
            font-weight: 700;
            position: relative;
            display: inline-block;
            padding-bottom: 10px;
        }
        .section-title h2:after {
            content: '';
            position: absolute;
            display: block;
            width: 50px;
            height: 3px;
            background: #ffb700;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }
        .category_block li a {
            color: #343a40;
            transition: all 0.3s;
        }
        .category_block li a:hover {
            color: #ffb700;
            transform: translateX(5px);
        }
        .testimonial {
            padding: 60px 0;
            background-color: #f8f9fa;
        }
        .testimonial-item {
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .testimonial-item img {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
        }
        .stats {
            padding: 60px 0;
            background-color: #343a40;
            color: white;
        }
        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #ffb700;
            transition: color 0.3s ease;
        }
        .stats-number:hover {
            color: #e6a500;
        }
        .stats-text {
            font-size: 1.2rem;
            transition: color 0.3s ease;
        }
        .stats-text:hover {
            color: #ffb700;
        }
        .stats-icon {
            font-size: 2rem;
            color: #ffb700;
            margin-bottom: 10px;
            transition: color 0.3s ease;
        }
        .stats-icon:hover {
            color: #e6a500;
        }
        @keyframes count-up {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        .stats-number {
            animation: count-up 1s ease-out;
        }
        .list-inline {
            font-size: 50px;
            margin-left: 10px;
        }
        .navbar-brand {
            display: flex;
            align-items: center;
        }
        .navbar-brand img {
            height: 50px;
            margin-right: 15px;
            border-radius: 50%;
        }
        .navbar-brand span {
            font-size: 1.8rem;
            font-weight: 700;
            color: #ffb700;
        }
        .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
        }
        .dropdown-item {
            padding: 10px 20px;
            font-size: 1rem;
            color: #343a40;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .dropdown-item:hover {
            background-color: #ffb700;
            color: white;
        }
        .dropdown-toggle {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .dropdown-toggle i {
            font-size: 1.5rem;
        }
        .upload-section {
            margin: 20px 0;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 5px;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
        .jumbotron {
            position: relative;
            overflow: hidden;
            min-height: 500px;
            padding: 150px 20px;
        }
        .jumbotron::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.7));
            z-index: 0;
        }
        .jumbotron .container {
            position: relative;
            z-index: 1;
        }
        .jumbotron h1 {
            font-family: 'Arial Black', Gadget, sans-serif;
            text-transform: uppercase;
        }
        .jumbotron .btn-warning {
            transition: all 0.3s ease;
        }
        .jumbotron .btn-warning:hover {
            background-color: #e6a500;
            transform: scale(1.05);
        }
        df-messenger {
            z-index: 1000 !important;
            position: fixed !important;
            bottom: 20px !important;
            right: 20px !important;
        }
    </style>
</head>
<body>

    <!-- Thanh Banner Trên Cùng -->
    <div class="top-banner">
        <div class="top-banner-text">
            GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI • GYM CHO MỌI NGƯỜI
        </div>
    </div>

    <!-- Thanh Điều Hướng -->
    <nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <div class="container">
            <!-- Logo và chữ 6Gym -->
            <a class="navbar-brand" href="guestHome.jsp">
                <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="6Gym Logo" style="height: 50px; margin-right: 15px;">
                <span class="text-warning" style="font-size: 1.8rem; font-weight: 700;">6Gym</span>
            </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse justify-content-center" id="navbarsExampleDefault">
                <ul class="navbar-nav">
                    <li class="nav-item active"><a class="nav-link" href="guestHome.jsp">Trang chủ</a></li>
                    <li class="nav-item"><a class="nav-link" href="#popular-courses">Khóa học</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Liên hệ</a></li>
                </ul>
            </div>

            <!-- Tìm kiếm (vô hiệu hóa cho khách) -->
            <form action="#" class="form-inline my-2 my-lg-0 ml-auto" onsubmit="alert('Vui lòng đăng nhập để sử dụng tính năng này!'); return false;">
                <div class="input-group">
                    <input name="txt" type="text" class="form-control" placeholder="Tìm kiếm..." disabled>
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-dark">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>

            <!-- Nút Đăng nhập và Đăng ký -->
            <div class="ml-3 d-none d-lg-block">
                <a href="login.jsp" class="btn btn-outline-light mr-2">Đăng nhập</a>
                <a href="register.jsp" class="btn btn-warning">Đăng ký</a>
            </div>
        </div>
    </nav>

    <!-- Banner Chính -->
    <section class="jumbotron text-center" style="background-image: url('${pageContext.request.contextPath}/images/khoahoc.jpg'); background-size: cover; background-position: center; position: relative; color: #fff; padding: 100px 20px;">
        <div class="container" style="position: relative; z-index: 1; background-color: rgba(0, 0, 0, 0.5); padding: 20px; border-radius: 10px;">
            <h1 class="jumbotron-heading" style="font-size: 3rem; font-weight: 700; color: #ffb700; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);">Khóa Học Gym Chất Lượng Cao</h1>
            <p class="lead" style="color: #fff; font-size: 1.2rem; text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.7);">Huấn luyện viên chuyên nghiệp, giáo trình khoa học, giúp bạn đạt được mục tiêu thể hình nhanh chóng!</p>
            <p>
                <a href="register.jsp" class="btn btn-warning btn-lg my-2" style="background-color: #ffb700; border-color: #ffb700; font-weight: bold;">Tham gia ngay</a>
                <a href="#" class="btn btn-outline-light btn-lg my-2" style="border-color: #fff; color: #fff;">Tìm hiểu thêm</a>
            </p>
        </div>
    </section>

    <!-- Khóa Học Nổi Bật -->
    <section class="popular-courses" id="popular-courses">
        <div class="container">
            <div class="section-title">
                <h2>Khóa học nổi bật</h2>
            </div>
            <div class="row">
                <!-- Danh mục -->
                <div class="col-md-3">
                    <div class="card">
                        <div class="card-header bg-dark text-white text-uppercase">Danh mục khóa học</div>
                        <ul class="list-group category_block">
                            <li class="list-group-item"><a href="#">Tăng cơ giảm mỡ</a></li>
                            <li class="list-group-item"><a href="#">Giảm cân</a></li>
                            <li class="list-group-item"><a href="#">Thể hình nữ</a></li>
                            <li class="list-group-item"><a href="#">Fitness</a></li>
                            <li class="list-group-item"><a href="#">Yoga</a></li>
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
                                            <a href="#" onclick="alert('Vui lòng đăng nhập để xem chi tiết khóa học!'); return false;">${course.courseName}</a>
                                        </h5>
                                        <p class="card-text">${course.description}</p>
                                        <p class="text-danger font-weight-bold">${course.price} ₫</p>
                                        <button class="btn btn-warning btn-block" onclick="alert('Vui lòng đăng nhập để đăng ký khóa học!');">Đăng ký ngay</button>
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

    <!-- Phản Hồi Từ Học Viên -->
    <section class="testimonial">
        <div class="container">
            <div class="section-title">
                <h2>Học viên nói gì về chúng tôi?</h2>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="testimonial-item text-center">
                        <img src="https://via.placeholder.com/70x70" alt="Học viên 1">
                        <h5>Nguyễn Gia Khánh</h5>
                        <p>"6Gym thực sự thay đổi cuộc sống của tôi. Tôi đã giảm 10kg chỉ sau 2 tháng tập luyện và ăn uống khoa học!"</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-item text-center">
                        <img src="https://via.placeholder.com/70x70" alt="Học viên 2">
                        <h5>Võ Văn Tin</h5>
                        <p>"HLV tận tâm, giáo trình bài bản. Tôi cảm thấy tràn đầy năng lượng và tự tin hơn mỗi ngày!"</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-item text-center">
                        <img src="https://via.placeholder.com/70x70" alt="Học viên 3">
                        <h5>Nguyễn Cao Hoàng Huy</h5>
                        <p>"Không gian tập luyện hiện đại, đội ngũ nhân viên thân thiện. Tôi rất hài lòng khi tham gia 6Gym và đã đạt được mục tiêu của mình."</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Thống Kê -->
    <section class="stats">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3">
                    <div class="stats-icon"><i class="fa fa-calendar-check-o"></i></div>
                    <div class="stats-number">10+</div>
                    <div class="stats-text">Năm kinh nghiệm</div>
                </div>
                <div class="col-md-3">
                    <div class="stats-icon"><i class="fa fa-smile-o"></i></div>
                    <div class="stats-number">5000+</div>
                    <div class="stats-text">Học viên hài lòng</div>
                </div>
                <div class="col-md-3">
                    <div class="stats-icon"><i class="fa fa-check-circle-o"></i></div>
                    <div class="stats-number">100%</div>
                    <div class="stats-text">Cam kết chất lượng</div>
                </div>
                <div class="col-md-3">
                    <div class="stats-icon"><i class="fa fa-book"></i></div>
                    <div class="stats-number">50+</div>
                    <div class="stats-text">Khóa học đa dạng</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Chân Trang -->
    <footer id="contact">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>Thông tin liên hệ</h5>
                    <ul>
                        <li><i class="fa fa-map-marker"></i> 151 Huỳnh Ngọc Đủ, Hòa Xuân, Cẩm Lệ, Đà Nẵng</li>
                        <li><i class="fa fa-phone"></i> 0819734122</li>
                        <li><i class="fa fa-envelope"></i> 6gym@gmail.com</li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Liên kết nhanh</h5>
                    <ul>
                        <li><a href="guestHome.jsp"><i class="fa fa-home"></i> Trang chủ</a></li>
                        <li><a href="#"><i class="fa fa-book"></i> Khóa học</a></li>
                        <li><a href="#"><i class="fa fa-rss"></i> Blog</a></li>
                        <li><a href="#"><i class="fa fa-phone"></i> Liên hệ</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Theo dõi chúng tôi</h5>
                    <ul class="list-inline">
                        <li class="list-inline-item"><a href="#"><i class="fa fa-facebook"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-instagram"></i></a></li>
                        <li class="list-inline-item"><a href="#"><i class="fa fa-youtube"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    <script>
        // Cuộn mượt khi click vào liên kết anchor
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            });
        });

        // Cuộn tự động khi tải trang với anchor trong URL
        window.addEventListener('load', function () {
            const hash = window.location.hash;
            if (hash) {
                const target = document.querySelector(hash);
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                }
            }
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