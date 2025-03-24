package userDAO;

import model.User;
import java.sql.SQLException;
import java.util.List;

public interface IUserDAO {
    int insertUser(User user) throws SQLException;
    User selectUser(int id);
    List<User> selectAllUsers();
    boolean updateUser(User user) throws SQLException;
    boolean deleteUser(int id, boolean status) throws SQLException;
    User checkLogin(String username, String password);
    boolean checkUsernameExists(String username);
    
    // New methods for password reset
    User findUserByUsernameOrEmail(String identifier); // Find user by username or email
    boolean updatePassword(int userId, String newPassword) throws SQLException; // Update password
    List<User> searchUsers(String keyword);
}