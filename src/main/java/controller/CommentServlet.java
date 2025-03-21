/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PostDAO;
import dao.ReviewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import model.Review;
import model.User;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "CommentServlet", urlPatterns = {"/Comment"})
public class CommentServlet extends HttpServlet {

    private final ReviewDAO reviewDao = new ReviewDAO();
    private final PostDAO postDao = new PostDAO();

    public String calculateTimeAgo(LocalDateTime createdAt) {
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(createdAt, now);
        long days = duration.toDays();
        long hours = duration.toHours() % 24;
        long minutes = duration.toMinutes() % 60;
        if (days >= 7) {
            return (days / 7) + " tuần trước";
        } else if (days > 0) {
            return days + " ngày trước";
        } else if (hours > 0) {
            return hours + " giờ trước";
        } else {
            return minutes + " phút trước";
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            int userId = 0, postId = 0;
            if (action.equalsIgnoreCase("submitCom")) {
                try {
                    userId = Integer.parseInt(request.getParameter("userId"));
                    postId = Integer.parseInt(request.getParameter("postId"));
                    String comment = request.getParameter("comment");
                    if (!reviewDao.checkCommentExists(userId, postId, comment)) {
                        Review r = new Review();
                        r.setUserId(userId);
                        r.setPostId(postId);
                        r.setComment(comment);
                        if (reviewDao.insertReview(r)) {
                            System.out.println("Lưu bình luận thành công.");
                        } else {
                            System.out.println("Lưu bình luận thất bại.");
                        }
                    }
                } catch (NumberFormatException e) {
                    System.out.println(e.getMessage());
                }

                List<Review> list = reviewDao.selectAllReviewsByPostId(postId);
                for (Review rev : list) {
                    User user = postDao.getUserById(rev.getUserId());
                    out.println("<div class=\"have-comment\">\n"
                            + "    <div class=\"comment-info\">\n"
                            + "        <img class=\"avatar\" src=\"ImageHandler?action=displayAvatar&userId=" + user.getUserId() + "\" alt=\"\">\n"
                            + "        <span class=\"comment-name\">" + user.getFullname() + "</span>\n"
                            + "        <span class=\"comment-time\"> •  " + calculateTimeAgo(rev.getCreated_at().toLocalDateTime()) + "</span>\n"
                            + "    </div>\n"
                            + "    <div class=\"comment-content\">\n"
                            + "        <p>" + rev.getComment() + "</p>\n"
                            + "    </div>\n"
                            + "</div>");
                }
            }
        }
    }

}
