package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import userDAO.UserDao;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String role = "User"; // Vai trò mặc định
        String country = "Vietnam"; // Quốc gia mặc định
        boolean status = true; // Trạng thái mặc định là Active

        // Kiểm tra dữ liệu đầu vào
        if (fullname == null || email == null || phone == null || username == null || password == null || confirmPassword == null ||
            fullname.isEmpty() || email.isEmpty() || phone.isEmpty() || username.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            response.sendRedirect("register.jsp?error=emptyFields");
            return;
        }

        // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp không
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=passwordMismatch");
            return;
        }

        // Kiểm tra định dạng số điện thoại (10 chữ số)
        if (!phone.matches("[0-9]{10}")) {
            response.sendRedirect("register.jsp?error=invalidPhone");
            return;
        }

        // Kiểm tra xem tên đăng nhập đã tồn tại chưa
        if (userDao.checkUsernameExists(username)) {
            response.sendRedirect("register.jsp?error=usernameExists");
            return;
        }

        // Tạo đối tượng User mới
        User user = new User(0, username, email, country, phone, role, status, password);

        // Thêm người dùng vào cơ sở dữ liệu
        try {
            userDao.insertUser(user);
            response.sendRedirect("login.jsp?success=registered");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=registrationFailed");
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng ký người dùng";
    }
}