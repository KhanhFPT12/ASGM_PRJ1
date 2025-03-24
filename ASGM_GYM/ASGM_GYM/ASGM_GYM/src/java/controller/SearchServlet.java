package servlet;

import CourseDAO.CourseDao;
import model.Courses;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    private CourseDao courseDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Đảm bảo nhận dữ liệu UTF-8 từ form
        request.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("txt");
        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu không có từ khóa, hiển thị tất cả khóa học
            List<Courses> courses = courseDao.selectAllCourses();
            request.setAttribute("courses", courses);
            request.setAttribute("searchQuery", "");
        } else {
            // Chuẩn hóa từ khóa: loại bỏ khoảng trắng thừa
            keyword = keyword.trim();
            List<Courses> courses = courseDao.searchCourses(keyword);
            request.setAttribute("courses", courses);
            request.setAttribute("searchQuery", keyword);
        }
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response); // Xử lý GET giống như POST
    }
}