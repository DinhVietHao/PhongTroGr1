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
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("Home");
        }
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
                    StringBuilder sb = new StringBuilder();
                    sb.append("<div class=\"have-comment\">\n")
                            .append("    <div class=\"comment-info\">\n")
                            .append("        <img class=\"avatar\" src=\"")
                            .append(user.getImageData() != null
                                    ? "ImageHandler?action=displayAvatar&userId=" + user.getUserId()
                                    : "./images/default_user.svg")
                            .append("\" alt=\"avatar\">\n")
                            .append("        <span class=\"comment-name color-font2\">").append(user.getFullname()).append("</span>\n")
                            .append("        <span class=\"comment-time\"> • ").append(calculateTimeAgo(rev.getCreated_at().toLocalDateTime())).append("</span>\n")
                            .append("        <button onclick=\"deleteComment(").append(rev.getReviewId()).append(")\" class=\"delete-comment\" data-user-id=\"").append(user.getUserId()).append("\">\n")
                            .append("            <i class=\"bi bi-trash\"></i>\n")
                            .append("        </button>\n")
                            .append("    </div>\n")
                            .append("    <div class=\"comment-content\">\n")
                            .append("        <p>").append(rev.getComment()).append("</p>\n")
                            .append("    </div>\n")
                            .append("</div>");
                    out.println(sb.toString());
                }
            } else if (action.equalsIgnoreCase("deleteCom")) {
                int reviewId = Integer.parseInt(request.getParameter("reviewId"));
                postId = Integer.parseInt(request.getParameter("postId"));
                reviewDao.deleteReviewById(reviewId);
                List<Review> list = reviewDao.selectAllReviewsByPostId(postId);

                if (list.isEmpty()) {
                    out.println("<div class=\"no-comment\">\n"
                            + "    <i class=\"bi bi-chat-left-dots-fill\"></i>\n"
                            + "    <p>Chưa có bình luận của khách hàng về bài viết này!</p>\n"
                            + "</div>");
                } else {
                    for (Review rev : list) {
                        User user = postDao.getUserById(rev.getUserId());
                        StringBuilder sb = new StringBuilder();
                        sb.append("<div class=\"have-comment\">\n")
                                .append("    <div class=\"comment-info\">\n")
                                .append("        <img class=\"avatar\" src=\"")
                                .append(user.getImageData() != null
                                        ? "ImageHandler?action=displayAvatar&userId=" + user.getUserId()
                                        : "./images/default_user.svg")
                                .append("\" alt=\"avatar\">\n")
                                .append("        <span class=\"comment-name color-font2\">").append(user.getFullname()).append("</span>\n")
                                .append("        <span class=\"comment-time\"> • ").append(calculateTimeAgo(rev.getCreated_at().toLocalDateTime())).append("</span>\n")
                                .append("        <button onclick=\"deleteComment(").append(rev.getReviewId()).append(")\" class=\"delete-comment\" data-user-id=\"").append(user.getUserId()).append("\">\n")
                                .append("            <i class=\"bi bi-trash\"></i>\n")
                                .append("        </button>\n")
                                .append("    </div>\n")
                                .append("    <div class=\"comment-content\">\n")
                                .append("        <p>").append(rev.getComment()).append("</p>\n")
                                .append("    </div>\n")
                                .append("</div>");
                        out.println(sb.toString());
                    }
                }
            }
        }
    }

}
