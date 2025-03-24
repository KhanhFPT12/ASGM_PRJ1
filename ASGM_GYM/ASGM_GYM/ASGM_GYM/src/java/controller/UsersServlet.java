package controller;

import userDAO.IUserDAO;
import userDAO.UserDao;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;


@WebServlet("/users")
public class UsersServlet extends HttpServlet {
    private IUserDAO userDAO; // Now using the interface

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDao(); // Instantiate your UserDAO implementation
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // Default to listing users
        }

        try {
            switch (action) {
                case "list":
                    listUsers(request, response);
                    break;
                case "view":
                    viewUser(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
               
                default:
                    listUsers(request, response); // Default to listing if action is unknown
            }
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "An error occurred: " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "update":
                    updateUser(request, response);
                    break;
                default:
                    response.sendRedirect("users?action=list"); // Redirect to user list
            }
        } catch (SQLException ex) {
            request.setAttribute("errorMessage", "An error occurred: " + ex.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<User> userList = userDAO.selectAllUsers(); // Use the interface method
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("customerList.jsp").forward(request, response);
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.selectUser(id); // Use the interface method
        request.setAttribute("user", user);
        request.getRequestDispatcher("userDetail.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.selectUser(id); // Use the interface method
        request.setAttribute("user", user);
        request.getRequestDispatcher("editUser.jsp").forward(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String country = request.getParameter("country");
        String phone = request.getParameter("phone");
        String role = request.getParameter("role");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));

        User user = new User(id, username, email, country, phone, role, status, phone);
        userDAO.updateUser(user); // Use the interface method
        response.sendRedirect("users?action=list");
    }

     private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.deleteUser(id, false);
        List<User> listUser = userDAO.selectAllUsers();
        request.setAttribute("list", listUser);
        RequestDispatcher dispatcher = request.getRequestDispatcher("users?action=list");
        dispatcher.forward(request, response);
    }
}