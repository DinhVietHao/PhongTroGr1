/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.Calendar;
import java.util.Random;
import model.User;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        int role = Integer.parseInt(request.getParameter("user_type"));
        UserDAO userDao = new UserDAO();
        if (MyLib.isValidPhone(phone)) {
            if (MyLib.checkPasswordStrong(password)) {
                User user = new User(fullname, username, password, email, phone, role);
                if (userDao.insertUser(user)) {

                    int userId = userDao.verifyMD5(user.getUsername(), user.getPassword()).getUserId();

                    // Dãy số xác thực random ngẫu nhiên
                    String randomNumber = createRandomNumber();

                    // Quy định thời gian hiệu lực
                    Date todaysDate = new Date(new java.util.Date().getTime());
                    Calendar c = Calendar.getInstance();
                    c.setTime(todaysDate);
                    c.add(Calendar.DATE, 1);
                    Date expirationTime = new Date(c.getTimeInMillis());

                    // Trạng thái xác thực = false
                    boolean verifStatus = false;

                    user.setUserId(userId);
                    user.setAuthCode(randomNumber);
                    user.setExpirationTime(expirationTime);
                    user.setVerifStatus(verifStatus);

                    System.out.println(user.getAuthCode());
                    System.out.println(user.getExpirationTime());

                    userDao.updateVerifyInformation(user);
                    response.sendRedirect("Login");
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
    }

}
