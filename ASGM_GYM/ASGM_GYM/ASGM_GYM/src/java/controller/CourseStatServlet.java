/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author codevn
 */
@WebServlet(name = "CourseStatServlet", urlPatterns = {"/courseStat"})
public class CourseStatServlet extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        statisticalAmountByCourse(req, resp);
        getAllCustomerRegister(req, resp);

        req.getRequestDispatcher("courseStat.jsp").forward(req, resp);
        
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    // 1. Thống kê số lượng đăng ký theo khóa học
    private void statisticalAmountByCourse(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<model.CourseStat> courseStats = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();) {
            PreparedStatement ps = conn.prepareStatement("SELECT  C.CourseID,C.CourseName,COUNT(E.EnrollmentID) AS SoLuongDangKy FROM Courses C LEFT JOIN Enrollments E ON C.CourseID = E.CourseID GROUP BY  C.CourseID, C.CourseName ORDER BY C.CourseID ASC;");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int courseId = rs.getInt("CourseID");
                int memberCount = rs.getInt("SoLuongDangKy");
                model.CourseStat courseStat = new model.CourseStat(courseId, memberCount);
                courseStats.add(courseStat);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        req.setAttribute("courseStats", courseStats);
    }

    // 2. Lấy danh sách khách hàng đã đăng ký
    private void getAllCustomerRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    Map<Integer, User> userMap = new HashMap<>(); // Lưu thông tin user duy nhất
    Map<Integer, List<String>> userCourses = new HashMap<>(); // Lưu danh sách khóa học theo user
    Map<Integer, List<String>> userPaymentMethods = new HashMap<>(); // Lưu danh sách phương thức thanh toán theo user
    Map<Integer, List<String>> userPaymentStatuses = new HashMap<>(); // Lưu danh sách trạng thái đăng ký theo user

    try (Connection conn = DBConnection.getConnection()) {
        String sql = "SELECT U.UserID, U.Username, U.Email, U.Phone, U.Country, " +
                     "E.CourseID, E.EnrollmentDate, E.PaymentStatus, C.CourseName, " +
                     "P.PaymentMethod " +
                     "FROM Enrollments E " +
                     "JOIN Users U ON E.LearnerID = U.UserID " +
                     "JOIN Courses C ON E.CourseID = C.CourseID " +
                     "LEFT JOIN Payments P ON E.EnrollmentID = P.EnrollmentID " +
                     "WHERE U.Role = 'User' " +
                     "ORDER BY U.UserID ASC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int userId = rs.getInt("UserID");

            // Nếu user chưa tồn tại trong map, thêm mới
            if (!userMap.containsKey(userId)) {
                User user = new User(
                    userId,
                    rs.getString("Username"),
                    rs.getString("Email"),
                    rs.getString("Country"),
                    rs.getString("Phone")
                );
                userMap.put(userId, user);
                userCourses.put(userId, new ArrayList<>());
                userPaymentMethods.put(userId, new ArrayList<>());
                userPaymentStatuses.put(userId, new ArrayList<>());
            }

            // Thêm tên khóa học, phương thức thanh toán và trạng thái đăng ký vào danh sách của user
            String courseName = rs.getString("CourseName");
            String paymentMethod = rs.getString("PaymentMethod") != null ? rs.getString("PaymentMethod") : "N/A";
            String paymentStatus = rs.getString("PaymentStatus") != null ? rs.getString("PaymentStatus") : "N/A";

            userCourses.get(userId).add(courseName);
            userPaymentMethods.get(userId).add(paymentMethod);
            userPaymentStatuses.get(userId).add(paymentStatus);
        }
    } catch (Exception e) {
        System.out.println("Error in getAllCustomerRegister: " + e.getMessage());
    }

    // Truyền dữ liệu vào request
    req.setAttribute("users", new ArrayList<>(userMap.values()));
    req.setAttribute("userCourses", userCourses);
    req.setAttribute("userPaymentMethods", userPaymentMethods);
    req.setAttribute("userPaymentStatuses", userPaymentStatuses);
}
}