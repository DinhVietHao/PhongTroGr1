/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PostDAO;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Post;
import model.User;
import util.Email;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/Admin"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("Home");
            return;
        }
        
        if (action.equalsIgnoreCase("adminManagerPost")) {
            PostDAO dao = new PostDAO();
            UserDAO userdao = new UserDAO();
            List<Post> lunapprovedList = new ArrayList<>();
            List<User> listAllUserViewer = new ArrayList<>();
            List<User> listAllUserOwner = new ArrayList<>();
            lunapprovedList = dao.selectPostAllNotApproved();
            listAllUserOwner = userdao.getAllUserOwner();
            listAllUserViewer = userdao.getAllUserViewer();
            request.setAttribute("lunapprovedList", lunapprovedList);
            request.setAttribute("listAllUserViewer", listAllUserViewer);
            request.setAttribute("listAllUserOwner", listAllUserOwner);
            request.getRequestDispatcher("managerAdmin.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Email mail = new Email();
        PostDAO postDao = new PostDAO();
        UserDAO userDao = new UserDAO();
        String action = request.getParameter("action");
        if (action != null && action.equalsIgnoreCase("acceptPost")) {
            String postIdStr = request.getParameter("postId");
            try {
                int postId = Integer.parseInt(postIdStr);
                Post post = postDao.getPostByPostId(postId);
                User user = userDao.selectUserById(post.getUserId());
                if (postDao.acceptPost(postId)) {
                    Email.sendEmail(user.getEmail(), "[PhongTroGr1] Bài đăng của bạn đã được duyệt", mail.getApprovalContent(user, post.getTitle()));
                    request.getSession().setAttribute("Messages", "Bài đăng đã được đăng lên trang");
                    response.sendRedirect("Home");
                } else {
                    response.getWriter().println("<h3>Failed to accept post.</h3>");
                }
            } catch (NumberFormatException e) {
                response.getWriter().println("<h3>Invalid post ID.</h3>");
            } catch (IOException e) {
                response.getWriter().println("<h3>" + e.getMessage() + "</h3>");
            }
        } else if (action != null && action.equalsIgnoreCase("rejectPost")) {
            String postIdStr = request.getParameter("postId");
            PostDAO dao = new PostDAO();
            try {
                int postId = Integer.parseInt(postIdStr);
                Post post = postDao.getPostByPostId(postId);
                User user = userDao.selectUserById(post.getUserId());
                if (dao.deletePostByPostId(postId)) {
                    Email.sendEmail(user.getEmail(), "[PhongTroGr1] Bài đăng của bạn không được duyệt", mail.getRejectionContent(user, post.getTitle()));
                    request.getSession().setAttribute("messageAdmin", "Bài đăng đã bị từ chối");
                    response.sendRedirect("Admin?action=adminManagerPost");
                } else {
                    response.getWriter().println("<h3>Failed to reject post.</h3>");
                }
            } catch (NumberFormatException e) {
                response.getWriter().println("<h3>Invalid post ID.</h3>");
            } catch (IOException e) {
                response.getWriter().println("<h3>" + e.getMessage() + "</h3>");
            }
        }else if(action != null && action.equalsIgnoreCase("deleteUser")){
            String userIdStr = request.getParameter("userId");
            UserDAO dao = new UserDAO();
            try {
                int userId = Integer.parseInt(userIdStr);
                User user = dao.selectUserById(userId);
                if(dao.deleteUser(userId)){
                    Email.sendEmail(user.getEmail(), "[PhongTroGr1] Tài khoản của bạn đã bị xóa do vi phạm quy tắc cộng đồng",  mail.getAccountDeletionContent(user));
                    request.getSession().setAttribute("messageAdmin", "tài khoản với tên tài khoản " + user.getUsername() + " đã được xóa!");
                    response.sendRedirect("Admin?action=adminManagerPost");
                }else {
                    response.getWriter().println("<h3>Failed to delete user.</h3>");
                }
            } catch (NumberFormatException e) {
                response.getWriter().println("<h3>Invalid post user ID.</h3>");
            } catch (IOException e) {
                response.getWriter().println("<h3>" + e.getMessage() + "</h3>");
            }
        }else if(action != null && action.equalsIgnoreCase("deletePost")){
            String postIdStr = request.getParameter("postId");
            PostDAO dao = new PostDAO();
            try {
                int postId = Integer.parseInt(postIdStr);
                Post post = postDao.getPostByPostId(postId);
                User user = userDao.selectUserById(post.getUserId());
                if (dao.deletePostByPostId(postId)) {
                    request.getSession().setAttribute("Messages", "Đã xóa bài đăng");
                    response.sendRedirect("Home");
                } else {
                    response.getWriter().println("<h3>Failed to reject post.</h3>");
                }
            } catch (NumberFormatException e) {
                response.getWriter().println("<h3>Invalid post ID.</h3>");
            } catch (IOException e) {
                response.getWriter().println("<h3>" + e.getMessage() + "</h3>");
            }
        }
    }

}
