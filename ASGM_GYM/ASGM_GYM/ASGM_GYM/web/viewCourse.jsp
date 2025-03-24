<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin chi tiết khóa học - 6Gym</title>
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
            max-width: 800px;
        }

        .course-detail-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin: 30px auto;
            overflow: hidden;
        }

        .course-detail-card:hover {
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

        .course-info {
            margin-bottom: 1.5rem;
        }

        .course-info p {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .course-info i {
            width: 25px;
            margin-right: 10px;
            color: var(--primary-color);
            text-align: center;
        }

        .btn-back {
            padding: 12px 24px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 30px;
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            transition: all 0.3s ease;
            letter-spacing: 1px;
            display: block; /* Make it a block-level element */
            margin: 20px auto 0; /* Center horizontally */
            max-width: 200px; /* Limit width for better appearance */
            text-align: center;
            text-decoration: none; /* Remove underline from link */
            color: #fff;
        }

        .btn-back:hover {
            background-color: #e6a500;
            border-color: #e6a500;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 183, 0, 0.4);
        }

        .error-message {
            color: var(--accent-color);
            text-align: center;
            margin-bottom: 20px;
            font-size: 1.1rem;
        }

        .description {
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="course-detail-card card">
            <div class="card-header">
                <h5 class="card-title">Thông tin chi tiết khóa học</h5>
            </div>
            <div class="card-body">
                <c:if test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:if>

                <c:if test="${not empty course}">
                    <div class="course-info">
                        <p><i class="fas fa-id-card"></i> <strong>ID:</strong> ${course.courseId}</p>
                        <p><i class="fas fa-dumbbell"></i> <strong>Tên khóa học:</strong> ${course.courseName}</p>
                        <p><i class="fas fa-file-alt"></i> <strong>Mô tả:</strong></p>
                        <p class="description">${course.description}</p>
                        <p><i class="fas fa-user-tie"></i> <strong>ID Trainer:</strong> ${course.trainerId}</p>
                        <p><i class="fas fa-dollar-sign"></i> <strong>Giá:</strong> ${course.price} ₫</p>
                        <p><i class="fas fa-toggle-on"></i> <strong>Trạng thái:</strong> ${course.status ? 'Hoạt động' : 'Không hoạt động'}</p>
                    </div>
                </c:if>

                <a href="courseList" class="btn btn-primary"><i class="fas fa-arrow-left mr-2"></i>Quay lại danh sách khóa học</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
</body>
</html>