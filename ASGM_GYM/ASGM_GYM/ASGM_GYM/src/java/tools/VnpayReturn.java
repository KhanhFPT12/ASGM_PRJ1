package tools;

import paymentDAO.PaymentDao;
import enrollmentDao.EnrollmentDao;
import model.Enrollment;
import model.Payment;
import model.Cart;
import model.CartItem;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "VnpayReturn", urlPatterns = {"/vn_pay/vnpayReturn"})
public class VnpayReturn extends HttpServlet {
    private EnrollmentDao enrollmentDao = new EnrollmentDao();
    private PaymentDao paymentDao = new PaymentDao();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("VnpayReturn servlet called with parameters: " + request.getQueryString());
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }
            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            System.out.println("vnp_SecureHash: " + vnp_SecureHash);
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);
            System.out.println("Computed signValue: " + signValue);
            if (signValue.equals(vnp_SecureHash)) {
                String paymentCode = request.getParameter("vnp_TransactionNo");
                System.out.println("Transaction No: " + paymentCode);
                HttpSession session = request.getSession();
                List<Integer> enrollmentIds = (List<Integer>) session.getAttribute("enrollmentIds");
                List<Integer> paymentIds = (List<Integer>) session.getAttribute("paymentIds");
                System.out.println("Enrollment IDs: " + enrollmentIds);
                System.out.println("Payment IDs: " + paymentIds);
                boolean transSuccess = false;
                if ("00".equals(request.getParameter("vnp_TransactionStatus"))) {
                    transSuccess = true;
                    for (Integer paymentId : paymentIds) {
                        Payment payment = new Payment();
                        payment.setPaymentId(paymentId);
                        payment.setStatus("Completed");
                        paymentDao.updatePayment(payment);
                    }
                    for (Integer enrollmentId : enrollmentIds) {
                        Enrollment enrollment = enrollmentDao.getEnrollmentById(enrollmentId);
                        if (enrollment != null) {
                            enrollment.setPaymentStatus("Completed");
                            enrollmentDao.updateEnrollment(enrollment);
                        }
                    }

                    // Gửi email xác nhận mua hàng
                    User user = (User) session.getAttribute("user");
                    Cart cart = (Cart) session.getAttribute("cart");
                    if (user != null && cart != null && !cart.getItems().isEmpty()) {
                        String toEmail = user.getEmail();
                        String username = user.getUsername();
                        StringBuilder courseNames = new StringBuilder();
                        for (CartItem item : cart.getItems()) {
                            courseNames.append(item.getCourses().getCourseName()).append(", ");
                        }
                        double totalWithDiscount = cart.getTotalAmountWithDiscount();
                        SendEmail.sendPurchaseConfirmation(toEmail, username, courseNames.toString(), totalWithDiscount, 30);
                    }

                    // Xóa giỏ hàng sau khi thanh toán thành công
                    session.removeAttribute("cart");
                } else {
                    for (Integer paymentId : paymentIds) {
                        paymentDao.deletePayment(paymentId);
                    }
                    for (Integer enrollmentId : enrollmentIds) {
                        enrollmentDao.deleteEnrollment(enrollmentId);
                    }
                }
                session.removeAttribute("enrollmentIds");
                session.removeAttribute("paymentIds");
                request.setAttribute("transResult", transSuccess);
                request.getRequestDispatcher("/paymentResult.jsp").forward(request, response);
            } else {
                System.out.println("GD KO HOP LE (invalid signature)");
                response.sendRedirect("error.jsp?message=Invalid signature");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=Error processing payment result");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}