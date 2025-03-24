package paymentDAO;

import model.Payment;
import java.sql.SQLException;

public interface IPaymentDao {
    int insertPayment(Payment payment) throws SQLException;
    boolean updatePayment(Payment payment) throws SQLException;
    boolean deletePayment(int paymentId) throws SQLException;
}