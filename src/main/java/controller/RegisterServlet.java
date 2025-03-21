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
import model.User;
import util.Email;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/Register"})
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDao = new UserDAO();
    private final Email mail = new Email();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("return")) {
            int id = Integer.parseInt(request.getParameter("id"));
            User user = userDao.selectUserById(id);
            userDao.deleteUnverifiedAccounts();
            request.setAttribute("user", user);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            userDao.deleteUnverifiedAccounts();
            response.sendRedirect("register.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("register")) {
            String fullname = request.getParameter("fullname");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            int role = Integer.parseInt(request.getParameter("user_type"));
            User user = new User(fullname, username, password, email, phone, role);

            // Kiểm tra xem email đã được đăng ký hay chưa
            if (userDao.isEmailExists(email)) {
                request.setAttribute("user", user);
                request.setAttribute("err", "<p style='color:red'>Email đã được đăng ký với một tài khoản khác. Vui lòng nhập email chưa đăng ký!</p>");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (userDao.insertUser(user)) {
                mail.sendVerificationCode(request, response, user, "verifyRegistration.jsp");
            } else {
                request.setAttribute("user", user);
                request.setAttribute("err", "<p style='color:red'>Tên đăng nhập đã tồn tại!</p>");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("verify")) {
            mail.verifyCode(request, response, "login.jsp", "verifyRegistration.jsp");
        } else if (action.equalsIgnoreCase("resendCode")) {
            User user = new User();
            user.setUsername(request.getParameter("username"));
            user.setPassword(request.getParameter("password"));
            user.setEmail(request.getParameter("email"));
            mail.sendVerificationCode(request, response, user, "verifyRegistration.jsp");
        }
    }

}
