package util;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import model.User;

public class Email {

    // Email: dvhaoce190204@gmail.com
    // Password: tfvd mpey htkh xvqm
    private static final String from = "phongtrogr1@gmail.com";
    private static final String pass = "aqis xlns bkkw evnn";
    private final UserDAO userDao = new UserDAO();

    public Email() {

    }

    public static boolean sendEmail(String to, String title, String content) {
        // Properties : khai báo các thuộc tính
        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
        props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                // TODO Auto-generated method stub
                return new PasswordAuthentication(from, pass);
            }
        };

        // Phiên làm việc
        Session session = Session.getInstance(props, auth);

        // Tạo một tin nhắn
        MimeMessage msg = new MimeMessage(session);

        try {
            // Kiểu nội dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");

            // Người gửi
            msg.setFrom(from);

            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));

            // Tiêu đề email
            msg.setSubject(title, "UTF-8");

            // Quy đinh ngày gửi
            msg.setSentDate(new java.util.Date());

            // Quy định email nhận phản hồi
            // msg.setReplyTo(InternetAddress.parse(from, false))
            // Nội dung
            msg.setContent(content, "text/HTML; charset=UTF-8");

            // Gửi email
            Transport.send(msg);
            System.out.println("Gửi email thành công");
            return true;
        } catch (MessagingException e) {
            System.out.println("Gặp lỗi trong quá trình gửi email");
            return false;
        }
    }

    public String createRandomNumber() {
        Random rd = new Random();
        String s1, s2, s3, s4, s5, s6;
        s1 = rd.nextInt(10) + "";
        s2 = rd.nextInt(10) + "";
        s3 = rd.nextInt(10) + "";
        s4 = rd.nextInt(10) + "";
        s5 = rd.nextInt(10) + "";
        s6 = rd.nextInt(10) + "";
        String s = s1 + s2 + s3 + s4 + s5 + s6;
        return s;
    }

    public String getVerifyContent(User t) {
        String content = "<p>PhongTroGr1.com xin ch&agrave;o bạn <strong>" + t.getFullname() + "</strong>,</p>\n"
                + "<p>Vui l&ograve;ng x&aacute;c thực t&agrave;i khoản của bạn bằng c&aacute;ch nhập m&atilde; <strong>" + t.getAuthCode() + "</strong>.</p>\n"
                + "<p>Đ&acirc;y l&agrave; email tự động, vui l&ograve;ng kh&ocirc;ng phản hồi email n&agrave;y!</p>\n"
                + "<p>Tr&acirc;n trọng cảm ơn.</p>";
        return content;
    }

    public String getApprovalContent(User t, String postTitle) {
        String content = "<p>PhongTroGr1.com xin ch&agrave;o bạn <strong>" + t.getFullname() + "</strong>,</p>\n"
                + "<p>Bài đăng của bạn với tiêu đề <strong>" + postTitle + "</strong> đã được duyệt thành công.</p>\n"
                + "<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi. Bạn có thể xem bài đăng của mình ngay bây giờ!</p>\n"
                + "<p>Đ&acirc;y l&agrave; email tự động, vui l&ograve;ng kh&ocirc;ng phản hồi email n&agrave;y!</p>\n"
                + "<p>Tr&acirc;n trọng cảm ơn.</p>";
        return content;
    }

    public String getRejectionContent(User t, String postTitle) {
        String content = "<p>PhongTroGr1.com xin ch&agrave;o bạn <strong>" + t.getFullname() + "</strong>,</p>\n"
                + "<p>Rất tiếc, bài đăng của bạn với tiêu đề <strong>" + postTitle + "</strong> không được duyệt do vi phạm quy tắc cộng đồng của chúng tôi.</p>\n"
                + "<p>Vui lòng kiểm tra lại bài đăng và đăng lại một bài khác phù hợp với quy định. Chúng tôi rất mong bạn sẽ tiếp tục sử dụng dịch vụ của chúng tôi.</p>\n"
                + "<p>Đ&acirc;y l&agrave; email tự động, vui l&ograve;ng kh&ocirc;ng phản hồi email n&agrave;y!</p>\n"
                + "<p>Tr&acirc;n trọng cảm ơn.</p>";
        return content;
    }

    public String getAccountDeletionContent(User t) {
        String content = "<p>PhongTroGr1.com xin ch&agrave;o bạn <strong>" + t.getFullname() + "</strong>,</p>\n"
                + "<p>Chúng tôi rất tiếc phải thông báo rằng tài khoản của bạn đã bị xóa do vi phạm quy tắc cộng đồng.</p>\n"
                + "<p>Việc vi phạm có thể liên quan đến nội dung bài đăng không phù hợp, spam, hoặc các hành vi không tuân thủ chính sách của chúng tôi.</p>\n"
                + "<p>Nếu bạn cho rằng đây là nhầm lẫn, vui lòng liên hệ với bộ phận hỗ trợ khách hàng của chúng tôi để được xem xét.</p>\n"
                + "<p>Đây là email tự động, vui lòng không phản hồi email này!</p>\n"
                + "<p>Trân trọng,</p>\n"
                + "<p>Đội ngũ PhongTroGr1</p>";
        return content;
    }

    public void sendVerificationCode(HttpServletRequest request, HttpServletResponse response, User user, String path) {
        int userId = -1;

        if (user.getUsername() != null && user.getPassword() != null) {
            userId = userDao.verifyMD5(user.getUsername(), user.getPassword()).getUserId();
        } else {
            userId = user.getUserId();
        }

        // Dãy số xác thực random ngẫu nhiên
        String randomNumber = createRandomNumber();

        // Trạng thái xác thực = false
        boolean verifStatus = false;

        // Lấy thời gian hiện tại
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());

        // Tăng độ trễ, ví dụ 5 phút (300 giây)
        Calendar calendar = Calendar.getInstance();
        calendar.setTimeInMillis(currentTime.getTime());
        calendar.add(Calendar.MINUTE, 5);  // Cộng 5 phút
        Timestamp expirationTime = new Timestamp(calendar.getTimeInMillis());

        user.setUserId(userId);
        user.setAuthCode(randomNumber);
        user.setExpirationTime(expirationTime);
        user.setVerifStatus(verifStatus);

        try {
            if (userDao.updateVerifyInformation(user) > 0) {
                // Gửi mail xác thực cho khách hàng
                sendEmail(user.getEmail(), "Xác thực tài khoản tại PhongTroGr1", getVerifyContent(user));
                request.setAttribute("user", user);
                request.getRequestDispatcher(path).forward(request, response);
            }
        } catch (ServletException | IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public void verifyCode(HttpServletRequest request, HttpServletResponse response, String pathTo, String pathReturn) {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String authCode = request.getParameter("authCode");
            User user = new User();
            if (username != null && password != null) {
                user = userDao.verifyMD5(username, password);
            } else {
                user = userDao.selectUserById(Integer.parseInt(request.getParameter("id")));
            }

            if (user.getUserId() != -1) {

                if (password != null) {
                    user.setPassword(password);
                }

                if (user.getAuthCode() != null && user.getAuthCode().equals(authCode)) {
                    Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                    long difference = user.getExpirationTime().getTime() - currentTime.getTime();
                    System.out.println("Difference in milliseconds: " + difference);
                    if (difference > 0 && difference <= 300000) {  // 300000ms = 5 minutes
                        user.setVerifStatus(true);
                        user.setRegisStatus(true);
                        userDao.updateVerifyInformation(user);
                        response.sendRedirect(pathTo);
                    } else {
                        request.setAttribute("user", user);
                        request.setAttribute("err", "<p style='color:red'>Mã xác thực đã hết hạn! Vui lòng nhấn nút gửi mã lại.</p>");
                        request.getRequestDispatcher(pathReturn).forward(request, response);
                    }
                } else {
                    request.setAttribute("user", user);
                    request.setAttribute("err", "<p style='color:red'>Mã xác thực không đúng!</p>");
                    request.getRequestDispatcher(pathReturn).forward(request, response);
                }
            }
        } catch (ServletException | IOException e) {
            System.out.println(e.getMessage());
        }
    }

}
