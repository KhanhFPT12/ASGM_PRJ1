package paymentDAO;

import dao.DBConnection;
import model.Payment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PaymentDao implements IPaymentDao {
    private static final String INSERT_PAYMENT = "INSERT INTO Payments (EnrollmentID, PaymentMethod, PaymentDate, Amount, Status) VALUES (?, ?, GETDATE(), ?, ?)";
    private static final String UPDATE_PAYMENT = "UPDATE Payments SET Status = ? WHERE PaymentID = ?";
    private static final String DELETE_PAYMENT = "DELETE FROM Payments WHERE PaymentID = ?";

    @Override
    public int insertPayment(Payment payment) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_PAYMENT, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, payment.getEnrollmentId());
            ps.setString(2, payment.getPaymentMethod());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, "Pending");
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
            return 0;
        }
    }

    @Override
    public boolean updatePayment(Payment payment) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_PAYMENT)) {
            ps.setString(1, payment.getStatus());
            ps.setInt(2, payment.getPaymentId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deletePayment(int paymentId) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_PAYMENT)) {
            ps.setInt(1, paymentId);
            return ps.executeUpdate() > 0;
        }
    }
}