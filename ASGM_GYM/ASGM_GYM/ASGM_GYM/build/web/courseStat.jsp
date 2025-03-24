<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.User, model.CourseStat" %>
<html>
    <head>
        <title>Admin Dashboard - Statistics</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body { margin: 0; font-family: Arial, sans-serif; display: flex; height: 100vh; background-image: url('https://img.freepik.com/premium-photo/blurred-fitness-healthy-background-concept-workout-personal-training-studio-generative-ai_1002555-13295.jpg'); background-size: cover; background-position: center; color: white; }
            .sidebar { width: 250px; background-color: rgba(0, 0, 0, 0.85); padding: 20px; box-sizing: border-box; }
            .sidebar img { display: block; margin: 0 auto; border-radius: 50%; width: 100px; }
            .sidebar h2 { text-align: center; margin-top: 10px; }
            .nav-item { margin: 20px 0; font-size: 16px; color: whitesmoke }
            .nav-item i { margin-right: 8px; color: whitesmoke }
            .nav-item a { margin-right: 8px; color: whitesmoke }
            .main { flex: 1; padding: 30px; background-color: rgba(0,0,0,0.6); overflow-y: auto; }
            h2 { text-align: center; margin-top: 20px; }
            table { width: 90%; margin: 20px auto; border-collapse: collapse; background-color: white; color: black; border-radius: 8px; overflow: hidden; }
            th, td { padding: 12px 15px; border: 1px solid #ddd; }
            th { background-color: #333; color: white; }
            tr:hover { background-color: #f2f2f2; }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <div class="sidebar">
            <img src="https://i.pinimg.com/736x/35/1b/f1/351bf18a4930cd77805595191ea505f7.jpg" alt="Logo">
            <h2>6 Gym</h2>
            <div class="nav-item"><a class="nav-link active" href="admindashboard.jsp"><i class="fas fa-home"></i>Tổng Quan</a></div>
            <div class="nav-item"><a class="nav-link" href="courseList"><i class="fas fa-dumbbell"></i>Quản lý khóa học GYM</a></div>
            <div class="nav-item"><a class="nav-link" href="users?action=list"><i class="fas fa-users"></i>Quản lý khách hàng</a></div>
            <div class="nav-item"><a class="nav-link" href="courseStat"><i class="fas fa-chart-bar"></i>Thống kê</a></div>
            <div class="nav-item"><a class="nav-link" href="customerList"><i class="fas fa-list"></i>Danh sách khách hàng</a></div>
            <div class="nav-item"><a class="nav-link" href="users?action=logout"><i class="fas fa-sign-out-alt"></i>Đăng xuất</a></div>
        </div>

        <!-- Main Content -->
        <div class="main">
            <h2 style="text-align:center;">1. Registration Count by Course</h2>
            <canvas id="barChart" width="800" height="400" style="display:block; margin: 0 auto;"></canvas>
            <script>
                const courseLabels = [];
                const courseData = [];

                <%
                    List<CourseStat> courseStats = (List<CourseStat>) request.getAttribute("courseStats");
                    if (courseStats != null) {
                        for (CourseStat stat : courseStats) {
                %>
                courseLabels.push("<%= stat.getCourseName() %>"); // Sử dụng getCourseName()
                courseData.push(<%= stat.getRegisteredCount() %>);
                <%
                        }
                    }
                %>

                const ctxBar = document.getElementById('barChart').getContext('2d');
                new Chart(ctxBar, {
                    type: 'bar',
                    data: {
                        labels: courseLabels,
                        datasets: [{
                            label: 'Registrations per Course',
                            data: courseData,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: { y: { beginAtZero: true } }
                    }
                });
            </script>

            <h2 style="text-align:center;">2. Enrollments by User</h2>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Courses Purchased</th>
                        <th>Payment Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<User> users = (List<User>) request.getAttribute("users");
                    Map<Integer, List<String>> userCourses = (Map<Integer, List<String>>) request.getAttribute("userCourses");
                    Map<Integer, List<String>> userPaymentStatuses = (Map<Integer, List<String>>) request.getAttribute("userPaymentStatuses");

                    if (users != null && userCourses != null && userPaymentStatuses != null && !users.isEmpty()) {
                        for (User user : users) {
                            List<String> courses = userCourses.getOrDefault(user.getId(), new ArrayList<>());
                            List<String> paymentStatuses = userPaymentStatuses.getOrDefault(user.getId(), new ArrayList<>());
                            if (!courses.isEmpty()) { // Chỉ hiển thị user có khóa học
                %>
                    <tr>
                        <td><%= user.getId() %></td>
                        <td><%= user.getUsername() != null ? user.getUsername() : "N/A" %></td>
                        <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                        <td><%= String.join(", ", courses) %></td>
                        <td><%= String.join(", ", paymentStatuses) %></td>
                    </tr>
                <%
                            }
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" style="text-align:center;">No enrollments found.</td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </body>
</html>