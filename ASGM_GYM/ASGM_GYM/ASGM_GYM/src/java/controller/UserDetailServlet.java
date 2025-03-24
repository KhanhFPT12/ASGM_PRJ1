package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import userDAO.UserDao;

@WebServlet(name = "UserDetailServlet", urlPatterns = {"/userDetail"})
public class UserDetailServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy userId từ session (giả sử userId đã được lưu khi đăng nhập)
        Integer userId = (Integer) request.getSession().getAttribute("userId");

        if (userId != null) {
            // Lấy thông tin người dùng dựa trên userId
            User user = userDao.selectUser(userId);
            if (user != null) {
                // Đặt thông tin người dùng vào request attribute
                request.setAttribute("user", user);
            } else {
                // Nếu không tìm thấy user, hiển thị lỗi
                request.setAttribute("error", "Không tìm thấy thông tin người dùng.");
            }
        } else {
            // Nếu chưa đăng nhập, chuyển hướng về trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }

        // Chuyển hướng đến detailUser.jsp
        request.getRequestDispatcher("/detailUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to display current user details by userId";
    }
}