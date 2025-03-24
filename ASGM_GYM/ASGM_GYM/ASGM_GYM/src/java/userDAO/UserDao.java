package userDAO;

import dao.DBConnection;
import model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao implements IUserDAO {
    private static final String INSERT_USER = "INSERT INTO Users (Username, Password, Email, Phone, Role, Country, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_ID = "SELECT * FROM Users WHERE UserID = ?";
    private static final String SELECT_ALL_USERS = "SELECT * FROM Users";
    private static final String UPDATE_USER = "UPDATE Users SET Username = ?, Email = ?, Country = ?, Phone = ?, Role = ?, Status = ?, Password = ? WHERE UserID = ?";
    private static final String DELETE_USER = "UPDATE Users SET Status = ? WHERE UserID = ?";
    private static final String LOGIN = "SELECT * FROM Users WHERE Username = ? AND Password = ?";
    private static final String CHECK_USERNAME = "SELECT * FROM Users WHERE Username = ?";
    private static final String FIND_USER_BY_USERNAME_OR_EMAIL = "SELECT * FROM Users WHERE Username = ? OR Email = ?";
    private static final String UPDATE_PASSWORD = "UPDATE Users SET Password = ? WHERE UserID = ?";
    private static final String SEARCH_USERS = "SELECT * FROM Users WHERE Username LIKE ? OR Email LIKE ? OR Phone LIKE ?";

    protected Connection getConnection() {
        return DBConnection.getConnection();
    }

    @Override
    public int insertUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getPassword());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getRole());
            preparedStatement.setString(6, user.getCountry());
            preparedStatement.setBoolean(7, user.isStatus());
            preparedStatement.executeUpdate();
            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    @Override
    public User selectUser(int id) {
        User user = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID)) {
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getString("Country"),
                    rs.getString("Phone"),
                    rs.getString("Role"),
                    rs.getBoolean("Status"),
                    rs.getString("Password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public List<User> selectAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);
             ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                users.add(new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getString("Country"),
                    rs.getString("Phone"),
                    rs.getString("Role"),
                    rs.getBoolean("Status"),
                    rs.getString("Password")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public boolean updateUser(User user) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER)) {
            preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getCountry());
            preparedStatement.setString(4, user.getPhone());
            preparedStatement.setString(5, user.getRole());
            preparedStatement.setBoolean(6, user.isStatus());
            preparedStatement.setString(7, user.getPassword());
            preparedStatement.setInt(8, user.getId());
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    @Override
    public boolean deleteUser(int id, boolean status) throws SQLException {
        boolean rowUpdated = false;
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(DELETE_USER);
                ps.setBoolean(1, status);
                ps.setInt(2, id);
                rowUpdated = ps.executeUpdate() > 0;
                if (rowUpdated) {
                    System.out.println("User status updated successfully!");
                } else {
                    System.out.println("No user found with the given ID!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    @Override
    public User checkLogin(String username, String password) {
        User user = null;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(LOGIN)) {
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getString("Country"),
                    rs.getString("Phone"),
                    rs.getString("Role"),
                    rs.getBoolean("Status"),
                    rs.getString("Password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean checkUsernameExists(String username) {
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(CHECK_USERNAME)) {
            preparedStatement.setString(1, username);
            ResultSet rs = preparedStatement.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // New method to find user by username or email
    @Override
    public User findUserByUsernameOrEmail(String identifier) {
        User user = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(FIND_USER_BY_USERNAME_OR_EMAIL)) {
            preparedStatement.setString(1, identifier);
            preparedStatement.setString(2, identifier);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getString("Country"),
                    rs.getString("Phone"),
                    rs.getString("Role"),
                    rs.getBoolean("Status"),
                    rs.getString("Password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // New method to update password
    @Override
    public boolean updatePassword(int userId, String newPassword) throws SQLException {
        boolean rowUpdated = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PASSWORD)) {
            preparedStatement.setString(1, newPassword);
            preparedStatement.setInt(2, userId);
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
    
    @Override
    public List<User> searchUsers(String keyword) {
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_USERS)) {
            String searchPattern = "%" + keyword + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            preparedStatement.setString(3, searchPattern);
            
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                User user = new User(
                    rs.getInt("UserID"),
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getString("Country"),
                    rs.getString("Phone"),
                    rs.getString("Role"),
                    rs.getBoolean("Status"),
                    rs.getString("Password")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            }
        return users;
    }
}