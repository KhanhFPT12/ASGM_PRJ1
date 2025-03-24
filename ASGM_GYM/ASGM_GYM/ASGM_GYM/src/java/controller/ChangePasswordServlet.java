package controller;

import model.User;
import userDAO.IUserDAO;
import userDAO.UserDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private IUserDAO userDao; // Use the interface

    @Override
    public void init() throws ServletException {
        userDao = new UserDao(); // Instantiate the concrete class
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu cũ
        User checkedUser = userDao.checkLogin(user.getUsername(), oldPassword);
        if (checkedUser == null) {
            request.setAttribute("error", "Mật khẩu cũ không đúng. Vui lòng thử lại.");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu mới và xác nhận mật khẩu có khớp nhau không
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu mới và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới
        user.setPassword(newPassword);
        boolean updated = false; // Declare outside try to use in the message if necessary.
        try {

             updated = userDao.updateUser(user);
        } catch (Exception e){
            e.printStackTrace();
             request.setAttribute("error", "Có lỗi xảy ra khi thay đổi mật khẩu. Vui lòng thử lại.");
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
        }


        if (updated) {
            request.setAttribute("success", "Thay đổi mật khẩu thành công!");
            session.setAttribute("user", user); // Cập nhật lại thông tin user trong session
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi thay đổi mật khẩu. Vui lòng thử lại.");
        }

        request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
    }
}