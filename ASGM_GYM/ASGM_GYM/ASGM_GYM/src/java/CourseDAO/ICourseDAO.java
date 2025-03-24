/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package CourseDAO;

import java.sql.SQLException;
import java.util.List;
import model.Courses;

public interface ICourseDAO {
     public void insertCourse (Courses course) throws SQLException;

    public Courses selectCourse (int courseId);

    public List<Courses> selectAllCourses();

    public boolean deleteCourse (int courseId, boolean status) throws SQLException;

    public boolean updateCourse (Courses course) throws SQLException;
}
