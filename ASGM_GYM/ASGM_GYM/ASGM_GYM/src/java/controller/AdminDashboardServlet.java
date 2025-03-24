package controller;

import enrollmentDao.EnrollmentDao;
import CourseDAO.CourseDao;
import CourseDAO.ICourseDAO;
import enrollmentDao.IEnrollmentDao;
import model.User;
import model.Enrollment;
import model.Courses;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admindashboard")
public class AdminDashboardServlet extends HttpServlet {
    private IEnrollmentDao enrollmentDao = new EnrollmentDao();
    private ICourseDAO courseDao = new CourseDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy danh sách tất cả enrollment
            List<Enrollment> enrollmentList = enrollmentDao.selectAllEnrollments();
            
            // Lấy thông tin user và course cho từng enrollment
            for (Enrollment enrollment : enrollmentList) {
                // Lấy courseId từ enrollment và gọi courseDao.selectCourse
                Courses course = courseDao.selectCourse(enrollment.getCourseID());
                User user = getUserById(enrollment.getLearnerID()); // Giả định có phương thức này
                enrollment.setCourse(course);
                enrollment.setUser(user);
            }

            // Tính toán thống kê số lượng đăng ký theo khóa học
            List<CourseStat> courseStats = calculateCourseStats(enrollmentList);
            courseStats.sort(Comparator.comparingInt(CourseStat::getRegisteredCount).reversed());

            request.setAttribute("enrollmentList", enrollmentList);
            request.setAttribute("courseStats", courseStats);
            request.getRequestDispatcher("/admindashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading dashboard");
        }
    }

    // Giả lập phương thức lấy User (bạn cần implement UserDao)
    private User getUserById(int id) {
        // Thay bằng UserDao thực tế
        return new User(id, "User" + id, "user" + id + "@example.com", "Vietnam", "123456789", "user", true, "pass");
    }

    // Tính toán thống kê khóa học
    private List<CourseStat> calculateCourseStats(List<Enrollment> enrollments) {
        Map<Integer, Long> stats = enrollments.stream()
            .collect(Collectors.groupingBy(Enrollment::getCourseID, Collectors.counting()));
        
        List<CourseStat> courseStats = new ArrayList<>();
        stats.forEach((courseId, count) -> {
            // Sửa lỗi cú pháp: bỏ "int" và sửa "courseID" thành "courseId"
            Courses course = courseDao.selectCourse(courseId);
            if (course != null) {
                courseStats.add(new CourseStat(course.getCourseName(), count.intValue()));
            }
        });
        return courseStats;
    }
}

// Class hỗ trợ thống kê
class CourseStat {
    private String courseName;
    private int registeredCount;

    public CourseStat(String courseName, int registeredCount) {
        this.courseName = courseName;
        this.registeredCount = registeredCount;
    }

    public String getCourseName() { return courseName; }
    public int getRegisteredCount() { return registeredCount; }
}