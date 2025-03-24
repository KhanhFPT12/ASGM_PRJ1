<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
             font-family: Arial, sans-serif;
            margin: 0;
            background-color: var(--dark-color); /* Set to dark color */
            color: white; /* Set text color to white for better readability */
            background-image: url('https://img.freepik.com/premium-photo/blurred-fitness-healthy-background-concept-workout-personal-training-studio-generative-ai_1002555-13295.jpg');
            background-size: cover; /* Cover the entire area */
            background-blend-mode: overlay;
            
           
        }

        /* Sidebar */
        .sidebar {
            background-color: rgba(52, 58, 64, 0.8); /* Semi-transparent dark color */
            color: white;
            height: 100vh; /* Full height */
            padding-top: 20px;
            position: fixed; /* Fixed sidebar */
            width: 250px;
        }

        .sidebar h2 {
            padding: 20px;
            text-align: center;
            margin-bottom: 30px;
            font-size: 1.5rem;
        }

         /* Logo Styling */
        .sidebar .logo {
            display: block;
            margin: 20px auto;
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--primary-color);
            transition: transform 0.3s ease;
        }

        .sidebar .logo:hover {
            transform: scale(1.1);
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar li {
            padding: 10px 20px;
            transition: background-color 0.3s ease;
        }

        .sidebar li a {
            color: white;
            text-decoration: none;
            display: block;
        }

        .sidebar li:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .sidebar i {
            margin-right: 10px;
        }

        /* Main Content */
        .main-content {
            margin-left: 250px; /* Match sidebar width */
            padding: 20px;
        }

        .button { padding: 10px 20px; margin: 5px; background-color: var(--primary-color); color: white; text-decoration: none; border-radius: 5px; transition: all 0.3s ease; display: inline-block;}
        .button:hover { background-color: #e6a500; transform: translateY(-3px); box-shadow: 0 5px 15px rgba(255, 183, 0, 0.4);}
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .package-stats { margin: 20px 0; }

         /* Card Styling */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 30px;
            overflow: hidden;
             background-color: rgba(255, 255, 255, 0.8); /* Make card translucent */
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        }

        .card-header {
            background-color: var(--dark-color);
            color: white;
            border: none;
            padding: 1.5rem;
            text-align: center;
            border-radius: 12px 12px 0 0; /* Rounded top corners */
        }
         .stats{
            display:flex;
            align-items: center;
            justify-content: center;

         }

         .title{
           text-align: center;
           margin-bottom: 10px
         }
          .logout {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .logout:hover {
            color: #e6a500;
            text-decoration: none;
            transform: translateX(5px);
        }
          .card-body table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .card-body th,
        .card-body td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        .card-body th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
        
        /* Thanh tìm kiếm */
        .search-bar {
            margin-bottom: 20px;
        }

        .search-bar .input-group {
            width: 100%;
            max-width: 400px; /* Giới hạn chiều rộng tối đa */
        }

        .search-bar .form-control {
            background-color: rgba(255, 255, 255, 0.1); /* Nền sáng hơn một chút */
            color: white; /* Chữ trắng */
            border: none; /* Không viền */
            border-radius: 5px; /* Bo góc */
            padding-left: 35px; /* Chừa chỗ cho biểu tượng kính lúp */
        }

        .search-bar .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5); /* Màu chữ placeholder */
        }

        .search-bar .input-group-text {
            background-color: transparent; /* Nền trong suốt */
            border: none; /* Không viền */
            color: rgba(255, 255, 255, 0.5); /* Màu biểu tượng kính lúp */
            position: absolute; /* Đặt biểu tượng bên trong input */
            z-index: 3;
            height: 100%;
            border-radius: 5px 0 0 5px;
        }

        .search-bar .input-group-text i {
            margin: 0; /* Xóa margin mặc định của biểu tượng */
        }

        .search-bar .form-control:focus {
            background-color: rgba(255, 255, 255, 0.2); /* Nền sáng hơn khi focus */
            box-shadow: none; /* Xóa bóng mặc định của Bootstrap */
            border-color: var(--primary-color); /* Viền màu vàng khi focus */
        }

          /* Responsive */
        @media (max-width: 767.98px) {
           .sidebar {
                position: static;
                width: 100%;
                height: auto;
                padding-bottom: 20px;
            }

            .main-content {
                margin-left: 0;
            }

            .stats {
                flex-direction: column;
            }
        }
             .welcome-content {
            color: white;
            font-size: 1.2rem;
            line-height: 1.8;
            text-align: center; /* Center-align the text */
        }

        .main-content h1.title {
            text-align: center;  /* Center-align the heading */
            margin-bottom: 20px;
        }

    </style>
</head>
<body>
     <div class="container-fluid">
    <div class="row">

        <!-- Sidebar -->
        <nav class="col-md-3 col-lg-2 d-md-block sidebar">
            <div class="sidebar-sticky">
                <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="6Gym Logo" class="logo">
                  <h2 class = "title">6 Gym</h2>
                <ul class="nav flex-column">
                    
                    <li class="nav-item">
                        <a class="nav-link active" href="adminDashboard.jsp">
                            <i class="fas fa-home"></i>Tổng Quan
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="courseList">
                            <i class="fas fa-dumbbell"></i>Quản lý khóa học GYM
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="users?action=list">
                            <i class="fas fa-users"></i>Quản lý khách hàng
                        </a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="courseStat">
                            <i class="fas fa-chart-bar"></i>Thống kê
                        </a>
                    </li>
                     
                  <li class="nav-item">
                        <a class="nav-link" href="logout">
                            <i class="fas fa-sign-out-alt"></i>Đăng xuất
                        </a>
                    </li>
                    <!-- Add more links here -->
                </ul>
            </div>
        </nav>

        <!-- Main Content -->
        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-md-4 main-content">
          
              <h1 class = "title">Welcome to Admin Dashboard</h1>

               <div class="welcome-content">
                  This would help and show statistics about the dashboard that is available here.
                                      It would also link up to all items here.
             </div>
                        
        </main>
    </div>
</div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>
</html>