/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;
import java.util.TimeZone;
import model.User;
import util.Email;
import util.MyLib;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/Register"})
public class RegisterServlet extends HttpServlet {

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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDao = new UserDAO();
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("register")) {
            String fullname = request.getParameter("fullname");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String rePass = request.getParameter("re-pass");
            int role = Integer.parseInt(request.getParameter("user_type"));

            if (!password.equals(rePass)) {
                request.setAttribute("err", "<p style='color:red'>Mật khẩu và xác nhận mật khẩu không khớp!</p>");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (MyLib.isValidPhone(phone)) {
                if (MyLib.checkPasswordStrong(password)) {
                    User user = new User(fullname, username, password, email, phone, role);
                    if (userDao.insertUser(user)) {

                        int userId = userDao.verifyMD5(user.getUsername(), user.getPassword()).getUserId();

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

                        if (userDao.updateVerifyInformation(user) > 0) {
                            // Gửi mail xác thực cho khách hàng
                            Email.sendEmail(user.getEmail(), "Xác thực tài khoản tại PhongTroGr1", getVerifyContent(user));
                            request.setAttribute("user", user);
                            request.getRequestDispatcher("verifyRegistration.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("fullname", fullname);
                        request.setAttribute("username", username);
                        request.setAttribute("email", email);
                        request.setAttribute("phone", phone);
                        request.setAttribute("password", password);
                        request.setAttribute("role", role);
                        request.setAttribute("err", "<p style='color:red'>Đăng kí không thành công!</p>");
                        request.getRequestDispatcher("register.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("fullname", fullname);
                    request.setAttribute("username", username);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("role", role);
                    request.setAttribute("err", "<p style='color:red'>Mật khẩu phải có chữ cái, số và kí tự đặt biệt!</p>");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("fullname", fullname);
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.setAttribute("role", role);
                request.setAttribute("err", "<p style='color:red'>Vui lòng nhập số điện thoại của Việt nam!</p>");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("verify")) {
            try {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String authCode = request.getParameter("authCode");
                User user = userDao.verifyMD5(username, password);
                if (user.getUserId() != -1) {
                    if (user.getAuthCode() != null && user.getAuthCode().equals(authCode)) {
                        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                        long difference = user.getExpirationTime().getTime() - currentTime.getTime();
                        System.out.println("Difference in milliseconds: " + difference);
                        if (difference > 0 && difference <= 300000) {  // 300000ms = 5 minutes
                            user.setVerifStatus(true);
                            userDao.updateVerifyInformation(user);
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        } else {
                            request.setAttribute("user", user);
                            request.setAttribute("err", "<p style='color:red'>Mã xác thực đã hết hạn! Vui lòng nhấn nút gửi mã lại.</p>");
                            request.getRequestDispatcher("verifyRegistration.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("user", user);
                        request.setAttribute("err", "<p style='color:red'>Mã xác thực không đúng!</p>");
                        request.getRequestDispatcher("verifyRegistration.jsp").forward(request, response);
                    }
                }
            } catch (ServletException | IOException e) {
                System.out.println(e.getMessage());
            }
        }
    }

}
