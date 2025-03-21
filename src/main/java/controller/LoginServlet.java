/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.Email;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

    private final UserDAO dao = new UserDAO();
    private final Email mail = new Email();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "login";
        }

        if (action.equalsIgnoreCase("login")) {
            dao.deleteUnverifiedAccounts();
            Cookie arr[] = request.getCookies();
            
            if (arr != null) {
                for (Cookie cookie : arr) {
                    if (cookie.getName().equals("userC")) {
                        request.setAttribute("userC", cookie.getValue());
                    }
                    if (cookie.getName().equals("passC")) {
                        request.setAttribute("passC", cookie.getValue());
                        request.setAttribute("remember", "1");
                    }
                }
            }
            
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else if (action.equalsIgnoreCase("forgotPass")) {
            response.sendRedirect("forgotPass.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "Login";
        }

        if (action.equalsIgnoreCase("Login")) {
            String username = request.getParameter("loginname");
            String password = request.getParameter("password");
            String remember = request.getParameter("remember");
            UserDAO userdao = new UserDAO();
            User user = userdao.verifyMD5(username, password);
            HttpSession session = request.getSession();
            if (user.getUserId() != -1) {
                session.setAttribute("user", user);
                Cookie u = new Cookie("userC", username);
                Cookie p = new Cookie("passC", password);
                
                u.setMaxAge(60 * 60 * 24);
                if (remember != null) {
                    p.setMaxAge(60 * 60 * 24);
                } else {
                    p.setMaxAge(0);
                }
                
                response.addCookie(u);
                response.addCookie(p);

                //request.setAttribute("userLogin", user);
                //request.getRequestDispatcher("home.jsp").forward(request, response);
                response.sendRedirect("Home");
            } else {
                request.setAttribute("err", "<p style='color:red'>Tên đăng nhập hoặc mật khẩu không đúng!</p>");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("sendCode")) {
            String email = request.getParameter("email");
            if (dao.isEmailExists(email)) {
                User user = dao.getUserByEmail(email);
                mail.sendVerificationCode(request, response, user, "resetPass.jsp");
            } else {
                request.setAttribute("email", email);
                request.setAttribute("err", "<p style='color:red'>Mail <strong>" + email + "</strong> chưa được đăng ký với bất kì tài khoản nào!</p>");
                request.getRequestDispatcher("forgotPass.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("resetPass")) {
            int userId = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String password = request.getParameter("newPassword");
            String authCode = request.getParameter("authCode");
            String email = request.getParameter("email");
            User user = dao.selectUserById(userId);

            if (user.getUsername().equals(username) && user.getEmail().equals(email)) {
                if (dao.updatePass(userId, password)) {
                    mail.verifyCode(request, response, "Login", "resetPass.jsp");
                } else {
                    request.setAttribute("username", username);
                    request.setAttribute("err", "<p style='color:red'>Reset password fail!</p>");
                    request.getRequestDispatcher("resetPass.jsp").forward(request, response);
                }
            } else {
                user.setUsername(username);
                request.setAttribute("user", user);
                request.setAttribute("err", "<p style='color:red'>Tên đăng nhập <strong>" + username + "</strong> không được đăng ký với mail <strong>" + email + "</strong>!</p>");
                request.getRequestDispatcher("resetPass.jsp").forward(request, response);
            }
        }
    }

}
