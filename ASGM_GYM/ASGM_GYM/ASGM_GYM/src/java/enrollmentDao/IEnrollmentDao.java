package enrollmentDao;

import java.sql.SQLException;
import java.util.List;
import model.Enrollment;

public interface IEnrollmentDao {
    int insertEnrollment(Enrollment enrollmentObj) throws SQLException; // Thay đổi từ void thành int
    Enrollment getEnrollmentById(int id);
    List<Enrollment> selectAllEnrollments();
    boolean updateEnrollment(Enrollment enrollmentObj) throws SQLException;
    boolean deleteEnrollment(int id) throws SQLException;
}