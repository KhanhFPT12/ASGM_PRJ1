/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tools;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import static org.apache.tomcat.jni.User.username;


public class SendEmail {
    private static final String FROM_EMAIL = "tintinvo1209@gmail.com";
    private static final String PASSWORD = "nqqw fmkg size lzub"; // App Password từ Gmail
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    

    // Khởi tạo session chung để tái sử dụng
    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });
    }

    // 1. Gửi email xác nhận đăng ký thành công
    public static void sendRegistrationConfirmation(String toEmail, String username) {
        Session session = getSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Đăng ký thành công tại GYM Course");

            String emailBody = "Xin chào " + username + ",\n\n" +
                    "Cảm ơn bạn đã đăng ký tại hệ thống khóa học GYM của chúng tôi!\n" +
                    "Đăng ký của bạn đã được ghi nhận thành công.\n" +
                    "Hãy khám phá các gói tập luyện phù hợp với bạn nhé!\n\n" +
                    "Trân trọng,\n" +
                    "Đội ngũ GYM Course";

            message.setText(emailBody);
            Transport.send(message);
            System.out.println("Email xác nhận đăng ký đã gửi tới: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi gửi email đăng ký: " + e.getMessage());
        }
    }

    // 2. Gửi email xác nhận mua gói tại trang Checkout
    public static void sendPurchaseConfirmation(String toEmail, String username, String courseName, 
                                               double price, int durationInDays) {
        Session session = getSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
message.setSubject("Xác nhận mua gói tập luyện #" + courseName);

            String emailBody = "Xin chào " + username + ",\n\n" +
                    "Cảm ơn bạn đã mua gói tập luyện tại GYM Course!\n" +
                    "Thông tin gói của bạn:\n" +
                    "- Tên gói: " + courseName + "\n" +
                    "- Giá tiền: " + price + " Dollar\n" +
                    "- Thời hạn sử dụng: " + durationInDays + " ngày\n\n" +
                    "Chúng tôi sẽ kích hoạt gói của bạn trong thời gian sớm nhất.\n" +
                    "Chúc bạn có những buổi tập hiệu quả!\n\n" +
                    "Trân trọng,\n" +
                    "Đội ngũ GYM Course";

            message.setText(emailBody);
            Transport.send(message);
            System.out.println("Email xác nhận mua gói đã gửi tới: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi gửi email xác nhận mua gói: " + e.getMessage());
        }
    }

    // 3a. Thông báo gói sắp hết hạn
    public static void sendExpirationWarning(String toEmail, String username, String courseName, int daysLeft) {
        Session session = getSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Thông báo: Gói " + username + " sắp hết hạn");

            String emailBody = "Xin chào " + courseName + ",\n\n" +
                    "Gói tập luyện " + courseName + " của bạn sẽ hết hạn trong " + daysLeft + " ngày nữa.\n" +
                    "Bạn có muốn gia hạn gói để tiếp tục hành trình tập luyện không?\n" +
                    "Vui lòng liên hệ hoặc truy cập hệ thống để gia hạn nhé!\n\n" +
                    "Trân trọng,\n" +
                    "Đội ngũ GYM Course";

            message.setText(emailBody);
            Transport.send(message);
            System.out.println("Email cảnh báo hết hạn đã gửi tới: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi gửi email cảnh báo hết hạn: " + e.getMessage());
        }
    }

    // 3b. Thông báo đã gia hạn gói
    public static void sendRenewalConfirmation(String toEmail, String customerName, String packageName, int newDurationInDays) {
        Session session = getSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
message.setSubject("Xác nhận gia hạn gói " + packageName);

            String emailBody = "Xin chào " + customerName + ",\n\n" +
                    "Gói tập luyện " + packageName + " của bạn đã được gia hạn thành công!\n" +
                    "- Thời hạn mới: " + newDurationInDays + " ngày\n" +
                    "Cảm ơn bạn đã tiếp tục đồng hành cùng GYM Course.\n" +
                    "Chúc bạn tập luyện hiệu quả!\n\n" +
                    "Trân trọng,\n" +
                    "Đội ngũ GYM Course";

            message.setText(emailBody);
            Transport.send(message);
            System.out.println("Email xác nhận gia hạn đã gửi tới: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi gửi email xác nhận gia hạn: " + e.getMessage());
        }
    }

    // 3c. Thông báo gói đã hết hạn và bị hủy
    public static void sendExpirationNotice(String toEmail, String customerName, String packageName) {
        Session session = getSession();
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Thông báo: Gói " + packageName + " đã hết hạn");

            String emailBody = "Xin chào " + customerName + ",\n\n" +
                    "Gói tập luyện " + packageName + " của bạn đã hết hạn và bị hủy.\n" +
                    "Nếu bạn muốn tiếp tục tập luyện, vui lòng đăng ký gói mới tại hệ thống của chúng tôi.\n" +
                    "Rất mong được đồng hành cùng bạn trong tương lai!\n\n" +
                    "Trân trọng,\n" +
                    "Đội ngũ GYM Course";

            message.setText(emailBody);
            Transport.send(message);
            System.out.println("Email thông báo hết hạn đã gửi tới: " + toEmail);
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("Lỗi khi gửi email thông báo hết hạn: " + e.getMessage());
        }
    }

    // Main để test (có thể xóa khi tích hợp vào hệ thống)
    public static void main(String[] args) {
        // Test các phương thức
        sendRegistrationConfirmation("customer@example.com", "Nguyen Van A");
        sendExpirationWarning("customer@example.com", "Nguyen Van A", "Gói Cơ Bản", 3);
        sendRenewalConfirmation("customer@example.com", "Nguyen Van A", "Gói Cơ Bản", 30);
        sendExpirationNotice("customer@example.com", "Nguyen Van A", "Gói Cơ Bản");
    }
}