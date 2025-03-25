/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ImageDAO;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import model.User;
import util.Email;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/User"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB - Kích thước tối đa trước khi lưu file vào đĩa
        maxFileSize = 1024 * 1024 * 10, // 10MB - Kích thước tối đa mỗi file
        maxRequestSize = 1024 * 1024 * 50 // 50MB - Kích thước tối đa của toàn bộ request
)
public class UserServlet extends HttpServlet {

    private final UserDAO userDao = new UserDAO();
    private final Email mail = new Email();
    private String email = "";
    private int code = -1;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (email.isEmpty()) {
            response.sendRedirect("Home");
            return;
        }

        if (action.equalsIgnoreCase("updateMail")) {
            if (userDao.updateMailById(code, email)) {

                User user = (User) session.getAttribute("user");
                user.setEmail(email);
                session.setAttribute("user", user);

                request.setAttribute("msgEmail", "<p style='color:green'>Cập nhật email thành công!</p>");
                request.getRequestDispatcher("accountManagement.jsp").forward(request, response);
            } else {
                request.setAttribute("new_email", email);
                request.setAttribute("err", "<p style='color:red'>Cập nhật email thất bại! Vui lòng thử lại</p>");
                request.getRequestDispatcher("changeEmail.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("sendCode")) {
            User user = new User();
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String new_email = request.getParameter("new_email");
                String fullname = request.getParameter("fullname");

                user.setUserId(userId);
                user.setFullname(fullname);
                user.setEmail(new_email);
                request.setAttribute("new_email", new_email);
                request.setAttribute("flag", "1");
                mail.sendVerificationCode(request, response, user, "changeEmail.jsp");
            } catch (NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equalsIgnoreCase("verifyCode")) {
            this.code = Integer.parseInt(request.getParameter("id"));
            this.email = request.getParameter("new_email");
            request.setAttribute("new_email", email);
            mail.verifyCode(request, response, "User?action=updateMail", "changeEmail.jsp");
        } else if (action.equalsIgnoreCase("updateInfo")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String phone = request.getParameter("phone");
            String fullname = request.getParameter("fullname");
            Part filePart = request.getPart("avatar");
            boolean isUpdated = false;
            try {
                UserDAO userDAO = new UserDAO();
                isUpdated = userDAO.updateUserInfo(userId, fullname, phone);
                if (filePart != null && filePart.getSize() > 0) {
                    if (filePart.getSize() > 10 * 1024 * 1024) {
                        request.setAttribute("err", "<p style='color:red'>File quá lớn! Vui lòng chọn ảnh nhỏ hơn 10MB.</p>");
                        request.getRequestDispatcher("changeInformation.jsp").forward(request, response);
                        return;
                    }

                    try ( InputStream inputStream = filePart.getInputStream()) {
                        ImageDAO imageDAO = new ImageDAO();
                        isUpdated = imageDAO.updateAvatar(userId, inputStream);
                    }
                }

                if (isUpdated) {
                    User userS = (User) session.getAttribute("user");
                    userS = userDAO.selectUserById(userId);
                    session.setAttribute("user", userS);

                    request.setAttribute("msgInfo", "<p style='color:green'>Cập nhật thông tin cá nhân thành công!</p>");
                    request.getRequestDispatcher("accountManagement.jsp").forward(request, response);
                } else {
                    request.setAttribute("err", "<p style='color:red'>Cập nhật thất bại. Hãy thử lại!</p>");
                    request.getRequestDispatcher("changeInformation.jsp").forward(request, response);
                }
            } catch (ServletException | IOException e) {
                request.setAttribute("err", "<p style='color:red'>" + e.getMessage() + "</p>");
                request.getRequestDispatcher("changeInformation.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("changePass")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String oldPass = request.getParameter("old_pass");
                if (userDao.checkPass(id, oldPass)) {
                    String newPass = request.getParameter("new_pass");
                    if (userDao.updatePass(id, newPass)) {
                        Cookie p = new Cookie("passC", newPass);
                        p.setMaxAge(60 * 60 * 24);
                        response.addCookie(p);
                        request.setAttribute("msgPass", "<p style='color:green'>Cập nhật mật khẩu mới thành công!</p>");
                        request.getRequestDispatcher("accountManagement.jsp").forward(request, response);
                    } else {
                        request.setAttribute("err", "<p style='color:red'>Cập nhật mật khẩu mới thất bại. Hãy thử lại!</p>");
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("err", "<p style='color:red'>Mật khẩu cũ không đúng. Hãy thử lại!</p>");
                    request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                }
            } catch (ServletException | IOException | NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equalsIgnoreCase("deleteAccount")) {
            String userIdStr = request.getParameter("userId");
            UserDAO dao = new UserDAO();
            try {
                int userId = Integer.parseInt(userIdStr);
                User user = dao.selectUserById(userId);
                if (dao.deleteUser(userId)) {
                    session.invalidate();
                    request.getSession().setAttribute("Messages", "Tài khoản với tên tài khoản " + user.getUsername() + " đã được xóa!");
                    response.sendRedirect("Home");
                } else {
                    response.getWriter().println("<h3>Failed to delete user.</h3>");
                }
            } catch (NumberFormatException e) {
                response.getWriter().println("<h3>Invalid post user ID.</h3>");
            } catch (IOException e) {
                response.getWriter().println("<h3>" + e.getMessage() + "</h3>");
            }
        }
    }

}
