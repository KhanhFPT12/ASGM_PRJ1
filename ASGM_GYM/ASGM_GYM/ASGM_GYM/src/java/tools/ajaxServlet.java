package tools;

import paymentDAO.PaymentDao;
import enrollmentDao.EnrollmentDao;
import model.Enrollment;
import model.Payment;
import model.Cart;
import model.CartItem;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ajaxServlet", urlPatterns = {"/ajaxServlet"})
public class ajaxServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String bankCode = req.getParameter("bankCode");
        String paymentMethod = req.getParameter("paymentMethod");

        // Kiểm tra phương thức thanh toán
        if (!"VN_PAY".equals(paymentMethod)) {
            resp.sendRedirect("checkout.jsp?error=InvalidPaymentMethod");
            return;
        }

        // Kiểm tra totalBill
        if (req.getParameter("totalBill") == null || req.getParameter("totalBill").isEmpty()) {
            resp.sendRedirect("cart");
            return;
        }

        double amountDouble;
        try {
            amountDouble = Double.parseDouble(req.getParameter("totalBill"));
        } catch (NumberFormatException e) {
            resp.sendRedirect("cart");
            return;
        }

        // Lấy userId từ session
        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            resp.sendRedirect("login");
            return;
        }

        // Lấy giỏ hàng từ session
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect("cart");
            return;
        }

        // Kiểm tra totalBill có khớp với giỏ hàng không
        if (Math.abs(amountDouble - cart.getTotalAmountWithDiscount()) > 0.01) {
            resp.sendRedirect("cart");
            return;
        }

        // Tạo danh sách enrollmentId và paymentId
        EnrollmentDao enrollmentDao = new EnrollmentDao();
        PaymentDao paymentDao = new PaymentDao();
        List<Integer> enrollmentIds = new ArrayList<>();
        List<Integer> paymentIds = new ArrayList<>();

        try {
            for (CartItem item : cart.getItems()) {
                int courseId = item.getCourses().getCourseId();

                // Tạo bản ghi Enrollment
                Enrollment enrollment = new Enrollment();
                enrollment.setLearnerID(userId);
                enrollment.setCourseID(courseId);
                enrollment.setPaymentStatus("Pending");

                int enrollmentId = enrollmentDao.insertEnrollment(enrollment);
                if (enrollmentId < 1) {
                    resp.sendRedirect("cart");
                    return;
                }
                enrollmentIds.add(enrollmentId);

                // Tạo bản ghi Payment
                Payment payment = new Payment(enrollmentId, "VN_PAY", item.getTotalPrice());
                int paymentId = paymentDao.insertPayment(payment);
                if (paymentId < 1) {
                    resp.sendRedirect("cart");
                    return;
                }
                paymentIds.add(paymentId);
            }

            // Lưu danh sách enrollmentIds và paymentIds vào session
            session.setAttribute("enrollmentIds", enrollmentIds);
            session.setAttribute("paymentIds", paymentIds);

            // Tạo mã giao dịch duy nhất (vnp_TxnRef)
            String vnp_TxnRef = paymentIds.get(0) + "_" + System.currentTimeMillis(); // Kết hợp paymentId với thời gian hiện tại

            // Tạo URL thanh toán VNPAY
            String vnp_Version = "2.1.0";
            String vnp_Command = "pay";
            String orderType = "other";
            long amount = (long) (amountDouble * 100);
            String vnp_IpAddr = Config.getIpAddress(req);
            String vnp_TmnCode = Config.vnp_TmnCode;

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", vnp_Version);
            vnp_Params.put("vnp_Command", vnp_Command);
            vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", "VND");

            if (bankCode != null && !bankCode.isEmpty()) {
                vnp_Params.put("vnp_BankCode", bankCode);
            }
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang:" + vnp_TxnRef);
            vnp_Params.put("vnp_OrderType", orderType);

            String locate = req.getParameter("language");
            if (locate != null && !locate.isEmpty()) {
                vnp_Params.put("vnp_Locale", locate);
            } else {
                vnp_Params.put("vnp_Locale", "vn");
            }
            vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            List fieldNames = new ArrayList(vnp_Params.keySet());
            Collections.sort(fieldNames);
            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();
            Iterator itr = fieldNames.iterator();
            while (itr.hasNext()) {
                String fieldName = (String) itr.next();
                String fieldValue = (String) vnp_Params.get(fieldName);
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    hashData.append(fieldName);
                    hashData.append('=');
                    hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                    query.append('=');
                    query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                    if (itr.hasNext()) {
                        query.append('&');
                        hashData.append('&');
                    }
                }
            }

            String queryUrl = query.toString();
            String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
            queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
            String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
            resp.sendRedirect(paymentUrl);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp?message=Failed to process VNPAY payment");
        }
    }
}