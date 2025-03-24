package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession(false); // false: không tạo session mới nếu không tồn tại

        // Nếu session tồn tại, xóa thông tin người dùng và hủy session
        if (session != null) {
            session.removeAttribute("user"); // Xóa thông tin người dùng
            session.invalidate(); // Hủy toàn bộ session
        }

        // Chuyển hướng về courseHome.jsp
        response.sendRedirect("courseHome");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu cần xử lý đăng xuất qua POST, bạn có thể gọi doGet
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý đăng xuất";
    }
}