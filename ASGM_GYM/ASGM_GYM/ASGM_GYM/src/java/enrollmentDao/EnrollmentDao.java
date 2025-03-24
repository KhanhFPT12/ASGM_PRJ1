package enrollmentDao;

import dao.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Courses;
import model.Enrollment;
import model.User;

public class EnrollmentDao implements IEnrollmentDao {
    private static final String INSERT_ENROLLMENT = "INSERT INTO Enrollments (LearnerID, CourseID, EnrollmentDate, PaymentStatus) VALUES (?, ?, GETDATE(), ?)";
    private static final String SELECT_ENROLLMENT_BY_ID = "SELECT e.*, u.Username, u.Email, u.Country, u.Phone, u.Role, u.Status as UserStatus, u.Password, " +
            "c.CourseName, c.Description, c.TrainerID, c.Price, c.Status as CourseStatus " +
            "FROM Enrollments e " +
            "JOIN Users u ON e.LearnerID = u.UserID " +
            "JOIN Courses c ON e.CourseID = c.CourseID " +
            "WHERE e.EnrollmentID = ?";
    private static final String UPDATE_ENROLLMENT = "UPDATE Enrollments SET LearnerID = ?, CourseID = ?, EnrollmentDate = ?, PaymentStatus = ? WHERE EnrollmentID = ?";
    private static final String SELECT_ALL_ENROLLMENTS = "SELECT e.*, u.Username, u.Email, u.Country, u.Phone, u.Role, u.Status as UserStatus, u.Password, " +
            "c.CourseName, c.Description, c.TrainerID, c.Price, c.Status as CourseStatus " +
            "FROM Enrollments e " +
            "JOIN Users u ON e.LearnerID = u.UserID " +
            "JOIN Courses c ON e.CourseID = c.CourseID";
    private static final String DELETE_ENROLLMENT = "DELETE FROM Enrollments WHERE EnrollmentID = ?";

    @Override
    public int insertEnrollment(Enrollment enrollmentObj) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_ENROLLMENT, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, enrollmentObj.getLearnerID());
            ps.setInt(2, enrollmentObj.getCourseID());
            ps.setString(3, enrollmentObj.getPaymentStatus());
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // Trả về EnrollmentID vừa tạo
                    }
                }
            }
            return 0; // Trả về 0 nếu không tạo được bản ghi
        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm enrollment: " + e.getMessage());
            throw e;
        }
    }

    @Override
    public Enrollment getEnrollmentById(int id) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ENROLLMENT_BY_ID)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToEnrollment(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy enrollment: " + e.getMessage());
        }
        return null;
    }

    @Override
    public List<Enrollment> selectAllEnrollments() {
        List<Enrollment> enrollments = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_ENROLLMENTS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                enrollments.add(mapResultSetToEnrollment(rs));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách enrollment: " + e.getMessage());
        }
        return enrollments;
    }

    @Override
    public boolean updateEnrollment(Enrollment enrollmentObj) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_ENROLLMENT)) {
            ps.setInt(1, enrollmentObj.getLearnerID());
            ps.setInt(2, enrollmentObj.getCourseID());
            ps.setTimestamp(3, new java.sql.Timestamp(enrollmentObj.getEnrollmentDate().getTime()));
            ps.setString(4, enrollmentObj.getPaymentStatus());
            ps.setInt(5, enrollmentObj.getEnrollmentID());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật enrollment: " + e.getMessage());
            throw e;
        }
    }

    @Override
    public boolean deleteEnrollment(int id) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_ENROLLMENT)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa enrollment: " + e.getMessage());
            throw e;
        }
    }

    private Enrollment mapResultSetToEnrollment(ResultSet rs) throws SQLException {
        Enrollment enrollment = new Enrollment();
        enrollment.setEnrollmentID(rs.getInt("EnrollmentID"));
        enrollment.setLearnerID(rs.getInt("LearnerID"));
        enrollment.setCourseID(rs.getInt("CourseID"));
        enrollment.setEnrollmentDate(rs.getTimestamp("EnrollmentDate"));
        enrollment.setPaymentStatus(rs.getString("PaymentStatus"));

        User user = new User(
            rs.getInt("LearnerID"),
            rs.getString("Username"),
            rs.getString("Email"),
            rs.getString("Country"),
            rs.getString("Phone"),
            rs.getString("Role"),
            rs.getBoolean("UserStatus"),
            rs.getString("Password")
        );
        enrollment.setUser(user);

        Courses course = new Courses(
            rs.getInt("CourseID"),
            rs.getString("CourseName"),
            rs.getString("Description"),
            rs.getInt("TrainerID"),
            rs.getDouble("Price"),
            rs.getBoolean("CourseStatus")
        );
        enrollment.setCourse(course);

        return enrollment;
    }
}