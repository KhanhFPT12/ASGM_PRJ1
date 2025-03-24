package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import userDAO.UserDao;

@WebServlet(name = "CustomerListServlet", urlPatterns = {"/customerList"})
public class CustomerListServlet extends HttpServlet {
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao(); // Khởi tạo UserDao
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số từ URL (nếu có)
        String foundUserId = request.getParameter("foundUserId");
        String keyword = request.getParameter("keyword");
        String notFoundParam = request.getParameter("notFound");

        // Hiển thị toàn bộ danh sách khách hàng
        List<User> userList = userDao.selectAllUsers();
        request.setAttribute("userList", userList);

        // Nếu có thông báo không tìm thấy từ URL
        if (notFoundParam != null && notFoundParam.equals("true")) {
            request.setAttribute("notFound", true);
            request.setAttribute("keyword", keyword != null ? keyword : "");
        }

        request.getRequestDispatcher("/customerList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("txt");

        List<User> userList;
        String foundUserId = null;
        boolean notFound = false;

        if (keyword == null || keyword.trim().isEmpty()) {
            // Nếu không có từ khóa, hiển thị tất cả người dùng
            userList = userDao.selectAllUsers();
        } else {
            // Tìm kiếm người dùng theo từ khóa
            keyword = keyword.trim();
            userList = userDao.selectAllUsers(); // Lấy toàn bộ danh sách để kiểm tra

            // Tìm người dùng khớp với từ khóa (so sánh username hoặc email)
            for (User user : userList) {
                if (user.getUsername().toLowerCase().contains(keyword.toLowerCase()) ||
                    user.getEmail().toLowerCase().contains(keyword.toLowerCase())) {
                    foundUserId = String.valueOf(user.getId());
                    break;
                }
            }

            // Nếu không tìm thấy, đặt cờ notFound
            if (foundUserId == null) {
                notFound = true;
            }
        }

        // Đặt danh sách người dùng và các thuộc tính vào request
        request.setAttribute("userList", userList);
        request.setAttribute("notFound", notFound);
        request.setAttribute("keyword", keyword);

        // Nếu tìm thấy người dùng, redirect với foundUserId
        if (foundUserId != null) {
            response.sendRedirect("customerList?foundUserId=" + foundUserId);
        } else {
            // Nếu không tìm thấy, redirect với thông báo không tìm thấy
            if (notFound) {
                response.sendRedirect("customerList?notFound=true&keyword=" + (keyword != null ? keyword : ""));
            } else {
                request.getRequestDispatcher("/customerList.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling customer list and search";
    }
}