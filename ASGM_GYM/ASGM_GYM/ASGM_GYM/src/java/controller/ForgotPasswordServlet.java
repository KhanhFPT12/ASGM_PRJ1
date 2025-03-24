package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import userDAO.UserDao;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {
    private UserDao userDAO = new UserDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String identifier = request.getParameter("identifier");

        // Find user by username or email
        User user = userDAO.findUserByUsernameOrEmail(identifier);

        if (user != null) {
            // Redirect to reset password page with user ID
            response.sendRedirect(request.getContextPath() + "/resetPassword.jsp?userId=" + user.getId());
        } else {
            // Redirect back to forgot password page with error
            response.sendRedirect(request.getContextPath() + "/forgotPassword.jsp?error=notFound");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/forgotPassword.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Handles forgot password requests";
    }
}