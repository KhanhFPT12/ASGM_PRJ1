package controller;

import CourseDAO.CourseDao;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Courses;

@WebServlet("/courseHome")
public class CourseHomeServlet extends HttpServlet {
    private CourseDao courseDao = new CourseDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Tải danh sách khóa học từ cơ sở dữ liệu
            List<Courses> courses = courseDao.selectAllCourses();
            if (courses == null) {
                courses = new ArrayList<>(); // Đảm bảo không trả về null
            }
            request.setAttribute("courses", courses);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải danh sách khóa học: " + e.getMessage());
        }

        // Chuyển tiếp đến courseHome.jsp
        request.getRequestDispatcher("/courseHome.jsp").forward(request, response);
    }
}