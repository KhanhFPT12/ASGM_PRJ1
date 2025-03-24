package controller;

import model.Cart;
import model.CartItem;
import model.User;
import service.CartService;
import service.ICartService;
import tools.SendEmail;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import dao.DBConnection;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private ICartService cartService;

    @Override
    public void init() throws ServletException {
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp?error=emptyCart");
            return;
        }
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        // Kiểm tra giỏ hàng và thông tin người dùng
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp?error=emptyCart");
            return;
        }
        if (user == null) {
            response.sendRedirect("login.jsp?error=notLoggedIn");
            return;
        }

        String username = request.getParameter("username");
        String paymentMethod = request.getParameter("paymentMethod");
        String toEmail = user.getEmail();

        // Kiểm tra dữ liệu đầu vào
        if (username == null || paymentMethod == null || username.isEmpty() || paymentMethod.isEmpty()) {
            request.setAttribute("cart", cart);
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin thanh toán.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Chỉ xử lý phương thức "Trực tiếp"
        if (!paymentMethod.equals("TrucTiep")) {
            request.setAttribute("cart", cart);
            request.setAttribute("error", "Phương thức thanh toán không hợp lệ.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }
try {
            // Lưu thông tin vào bảng Enrollments và Payments
            Connection connection = DBConnection.getConnection();
            connection.setAutoCommit(false); // Bắt đầu transaction

            int learnerId = user.getId();
            for (CartItem item : cart.getItems()) {
                // Thêm vào bảng Enrollments
                String insertEnrollmentSQL = "INSERT INTO Enrollments (LearnerID, CourseID, EnrollmentDate, PaymentStatus) VALUES (?, ?, ?, ?)";
                PreparedStatement enrollmentStmt = connection.prepareStatement(insertEnrollmentSQL, PreparedStatement.RETURN_GENERATED_KEYS);
                enrollmentStmt.setInt(1, learnerId);
                enrollmentStmt.setInt(2, item.getCourses().getCourseId());
                enrollmentStmt.setTimestamp(3, new Timestamp(new Date().getTime()));
                enrollmentStmt.setString(4, "Completed");
                enrollmentStmt.executeUpdate();

                // Lấy EnrollmentID vừa tạo
                int enrollmentId;
                try (var rs = enrollmentStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        enrollmentId = rs.getInt(1);
                    } else {
                        throw new SQLException("Không thể lấy EnrollmentID.");
                    }
                }

                // Thêm vào bảng Payments
                String insertPaymentSQL = "INSERT INTO Payments (EnrollmentID, PaymentMethod, PaymentDate, Amount, Status) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement paymentStmt = connection.prepareStatement(insertPaymentSQL);
                paymentStmt.setInt(1, enrollmentId);
                paymentStmt.setString(2, "TrucTiep");
                paymentStmt.setTimestamp(3, new Timestamp(new Date().getTime()));
                paymentStmt.setDouble(4, item.getTotalPrice());
                paymentStmt.setString(5, "Completed");
                paymentStmt.executeUpdate();
            }

            // Commit transaction
            connection.commit();

            // Tính tổng tiền với giảm giá
            double totalWithDiscount = cartService.calculateTotalWithDiscount(cart);

            // Gửi email xác nhận mua hàng
            StringBuilder courseNames = new StringBuilder();
            for (CartItem item : cart.getItems()) {
                courseNames.append(item.getCourses().getCourseName()).append(", ");
            }
            SendEmail.sendPurchaseConfirmation(toEmail, username, courseNames.toString(), totalWithDiscount, 30);

            // Xóa giỏ hàng sau khi gửi bill thành công
            cart.clear();
            session.setAttribute("cart", cart);

            // Chuyển hướng đến trang xác nhận
            response.sendRedirect("confirmation.jsp?success=purchaseCompleted");
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                Connection connection = DBConnection.getConnection();
                connection.rollback(); // Rollback nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            request.setAttribute("cart", cart);
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình thanh toán. Vui lòng thử lại.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý thanh toán";
    }
}
            
