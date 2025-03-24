package controller;

import CourseDAO.CourseDao;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Courses;
import model.User;

@WebServlet(name = "CourseServlet", urlPatterns = {"/course", "/courseList"})
@MultipartConfig
public class CourseServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    private CourseDao courseDao;

    @Override
    public void init() {
        courseDao = new CourseDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String servletPath = request.getServletPath();

        if (action == null) {
            action = "";
        }

        try {
            if ("/courseList".equals(servletPath)) {
                listCourses(request, response); // List courses for admin
            } else {
                switch (action) {
                    case "create":
                        showNewForm(request, response);
                        break;
                    case "edit":
                        showEditForm(request, response);
                        break;
                    case "delete":
                        deleteCourse(request, response);
                    break;
                    case "view":
                        viewCourse(request, response);
                        break;
                    default:
                        listCourses(request, response); // List courses as default for /course
                }
            }
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "create":
                    insertCourse(request, response);
                    break;
                case "edit":
                    updateCourse(request, response);
                    break;
               default:
                   response.sendRedirect("courseList"); // Redirect after POST actions
            }
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // Hiển thị danh sách khóa học
    private void listCourses(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String role = "User";
        if (user != null) {
            role = user.getRole();
        }

        List<Courses> listCourses = courseDao.selectAllCourses();
        int pageSize = 10;
        int totalCourses = listCourses.size();
        int totalPages = (int) Math.ceil((double) totalCourses / pageSize);

        String page = request.getParameter("page");
        if (page == null) {
            page = "1";
        }
        int p = Integer.parseInt(page);

        int start = (p - 1) * pageSize;

        List<Courses> paginatedCourses = new ArrayList<Courses>();
        if(listCourses.size() > start){
            if(listCourses.size() > (start + pageSize)){
                paginatedCourses = listCourses.subList(start, start + pageSize);
            }else{
                paginatedCourses = listCourses.subList(start,listCourses.size());
            }

        }

        request.setAttribute("courses", paginatedCourses);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", p);
        RequestDispatcher dispatcher = request.getRequestDispatcher("courseList.jsp");
        dispatcher.forward(request, response);
    }

    // Hiển thị form thêm khóa học
    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("createCourse.jsp");
        dispatcher.forward(request, response);
    }

    // Hiển thị form chỉnh sửa khóa học
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Courses existingCourse = courseDao.selectCourse(id);
        request.setAttribute("course", existingCourse); // Pass the course object
        RequestDispatcher dispatcher = request.getRequestDispatcher("editCourse.jsp");
        dispatcher.forward(request, response);
    }

    // Thêm khóa học mới
    private void insertCourse(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        // Xử lý upload hình ảnh
        Part filePart = request.getPart("image");
        String fileName = extractFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        if (fileName != null && !fileName.isEmpty()) {
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Lấy thông tin khóa học từ form
         String courseName = request.getParameter("courseName");
        String description = request.getParameter("description");
        int trainerId = Integer.parseInt(request.getParameter("trainerId"));
        double price = Double.parseDouble(request.getParameter("price"));
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        
        
        Courses course = new Courses(0,courseName, description, trainerId, price, status); //Id generation issue has been fixed and will not be used for the database, only parameters from user should be sent into this form
        courseDao.insertCourse(course);
         response.sendRedirect("courseList.jsp");
    }

    // Cập nhật thông tin khóa học
    private void updateCourse(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

          Part filePart = request.getPart("image");
        String fileName = extractFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        if (fileName != null && !fileName.isEmpty()) {
            filePart.write(uploadPath + File.separator + fileName);
        }

        // Lấy thông tin khóa học từ form
        int id = Integer.parseInt(request.getParameter("id"));
        String courseName = request.getParameter("courseName");
        String description = request.getParameter("description");
        int trainerId = Integer.parseInt(request.getParameter("trainerId"));
        double price = Double.parseDouble(request.getParameter("price"));
        String status = request.getParameter("status");

         Boolean statusConvert = Boolean.valueOf(status);

          Courses course = new Courses(id, courseName, description, trainerId, price, statusConvert);
        courseDao.updateCourse(course);
        response.sendRedirect("courseList");
    }

    // Xóa khóa học
    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        courseDao.deleteCourse(id, false);
        List<Courses> listCourses = courseDao.selectAllCourses();
        request.setAttribute("courseList", listCourses);
        RequestDispatcher dispatcher = request.getRequestDispatcher("courseList");
        dispatcher.forward(request, response);
    }

    // Xem chi tiết khóa học
    private void viewCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int courseId = Integer.parseInt(request.getParameter("id"));

        Courses course = courseDao.selectCourse(courseId);
        if (course == null) {
                request.setAttribute("errorMessage", "Khóa học không tồn tại.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

        request.setAttribute("course", course);
        request.getRequestDispatcher("viewCourse.jsp").forward(request, response);
    }

    // Trích xuất tên file từ Part
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }

    @Override
    public String getServletInfo() {
        return "Servlet to manage courses (create, read, update, delete)";
    }
}