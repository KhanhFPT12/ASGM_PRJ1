package CourseDAO;

import dao.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Courses;

public class CourseDao implements ICourseDAO {
    private static final String INSERT_COURSE = "INSERT INTO Courses (CourseName, Description, TrainerID, Price, Status) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_COURSE_BY_ID = "SELECT * FROM Courses WHERE CourseID = ?";
    private static final String UPDATE_COURSE = "UPDATE Courses SET CourseName = ?, Description = ?, TrainerID = ?, Price = ?, Status = ? WHERE CourseID = ?";
    private static final String SELECT_ALL_COURSES = "SELECT * FROM Courses";
     private static final String DELETE_COURSES = "UPDATE Courses SET Status = ? WHERE CourseID = ?";
    private static final String SELECT_MAX_ID = "SELECT MAX(CourseID) FROM Courses";

    @Override
    public void insertCourse(Courses course) throws SQLException {
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_COURSE)) {
            ps.setString(1, course.getCourseName());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getTrainerId());
            ps.setDouble(4, course.getPrice());
            ps.setBoolean(5, course.getStatus());
            ps.executeUpdate();
        }
    }

    @Override
    public Courses selectCourse(int courseId) {
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_COURSE_BY_ID)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Courses(
                    rs.getInt("CourseID"),
                    rs.getString("CourseName"),
                    rs.getString("Description"),
                    rs.getInt("TrainerID"),
                    rs.getDouble("Price"),
                    rs.getBoolean("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Courses> selectAllCourses() {
        List<Courses> courses = new ArrayList<>();
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_COURSES);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                courses.add(new Courses(
                    rs.getInt("CourseID"),
                    rs.getString("CourseName"),
                    rs.getString("Description"),
                    rs.getInt("TrainerID"),
                    rs.getDouble("Price"),
                    rs.getBoolean("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }

    @Override
    public boolean updateCourse(Courses course) throws SQLException {
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_COURSE)) {
            ps.setString(1, course.getCourseName());
            ps.setString(2, course.getDescription());
            ps.setInt(3, course.getTrainerId());
            ps.setDouble(4, course.getPrice());
            ps.setBoolean(5, course.getStatus());
            ps.setInt(6, course.getCourseId());
            return ps.executeUpdate() > 0;
        }
    }

    @Override
    public boolean deleteCourse(int courseId, boolean status) throws SQLException {
        boolean rowUpdated = false;
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                PreparedStatement ps = conn.prepareStatement(DELETE_COURSES);
                ps.setBoolean(1, status);
            ps.setInt(2, courseId);
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

    public List<Courses> searchCourses(String query) {
        List<Courses> courses = new ArrayList<>();
        String sql = "SELECT * FROM Courses WHERE CourseName LIKE ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(new Courses(
                    rs.getInt("CourseID"),
                    rs.getString("CourseName"),
                    rs.getString("Description"),
                    rs.getInt("TrainerID"),
                    rs.getDouble("Price"),
                    rs.getBoolean("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return courses;
    }
    
    // Thêm phương thức getMaxId
    public int getMaxId() throws SQLException {
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_MAX_ID);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0; // Trả về 0 nếu bảng rỗng
    }
}