package controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import userDAO.UserDao;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetPassword"})
public class ResetPasswordServlet extends HttpServlet {
    private UserDao userDAO = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdStr = request.getParameter("userId");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate passwords match
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect(request.getContextPath() + "/resetPassword.jsp?userId=" + userIdStr + "&error=passwordMismatch");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdStr);
            // Update password in the database
            boolean updated = userDAO.updatePassword(userId, newPassword);
            if (updated) {
                // Redirect to login page with success message
                response.sendRedirect(request.getContextPath() + "/login.jsp?success=passwordUpdated");
            } else {
                // Redirect back with error
                response.sendRedirect(request.getContextPath() + "/resetPassword.jsp?userId=" + userIdStr + "&error=updateFailed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/resetPassword.jsp?userId=" + userIdStr + "&error=updateFailed");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/forgotPassword.jsp?error=invalidRequest");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/forgotPassword.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Handles password reset requests";
    }
}