/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.PostDAO;
import dao.ReviewDAO;
import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import model.Category;
import model.Post;
import model.Review;
import model.User;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "PostServlet", urlPatterns = {"/Post"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class PostServlet extends HttpServlet {

    private final PostDAO postDao = new PostDAO();
    private final ReviewDAO reviewDao = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "createPost";
        }

        if (action.equalsIgnoreCase("createPost")) {
            response.sendRedirect("post.jsp");
        } else if (action.equalsIgnoreCase("savePost")) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                int postId = Integer.parseInt(request.getParameter("postId"));
                postDao.savePostById(userId, postId);
            } catch (NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equalsIgnoreCase("deletePost")) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                int postId = Integer.parseInt(request.getParameter("postId"));
                postDao.deletePostById(userId, postId);
            } catch (NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equals("listPosted")) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                List<Post> listPostAccept = postDao.getListPostAccpetByUserId(userId);
                request.setAttribute("listPostAccept", listPostAccept);
                request.getRequestDispatcher("approvedList.jsp").forward(request, response);
            } catch (ServletException | IOException | NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equals("updatePost")) {
            try {
                int postId = Integer.parseInt(request.getParameter("postId"));
                Post post = postDao.getPostByPostId(postId);
                request.setAttribute("post", post);
                request.getRequestDispatcher("updateListPost.jsp").forward(request, response);
            } catch (ServletException | IOException | NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equalsIgnoreCase("uploadSavedPost")) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                List<Post> listSavedPost = postDao.selectAllSavedPost(userId);
                request.setAttribute("list", listSavedPost);
                request.getRequestDispatcher("saved.jsp").forward(request, response);
            } catch (ServletException | IOException | NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equalsIgnoreCase("postDescription")) {
            try {
                PostDAO dao = new PostDAO();
                UserDAO userdao = new UserDAO();
                int postId = Integer.parseInt(request.getParameter("postId"));
                List<Review> listReview = reviewDao.selectAllReviewsByPostId(postId);
                Post post = dao.getPostByPostId(postId);
                int countPost = userdao.countPostforUserByUserId(post.getUserId());
                request.setAttribute("post", post);
                request.setAttribute("list", listReview);
                request.setAttribute("countPost", countPost);
                request.getRequestDispatcher("homeDescription.jsp").forward(request, response);
            } catch (ServletException | IOException | NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equalsIgnoreCase("approvedList")) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                List<Post> listPostAccept = postDao.getListPostAccpetByUserId(userId);
                request.setAttribute("listPostAccept", listPostAccept);
                request.getRequestDispatcher("approvedList.jsp").forward(request, response);
            } catch (ServletException | IOException | NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        } else if (action.equalsIgnoreCase("pendingList")) {
            try {
                int userId = Integer.parseInt(request.getParameter("userId"));
                List<Post> listNotApproved = postDao.getListPostNotApprovedByUserId(userId);
                request.setAttribute("listNotApproved", listNotApproved);
                request.getRequestDispatcher("pendingList.jsp").forward(request, response);
            } catch (ServletException | IOException | NumberFormatException e) {
                System.out.println(e.getMessage());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("Home");
            return;
        }

        if (action.equalsIgnoreCase("uploadPost")) {
            // Lấy userId từ request
            String userIdStr = request.getParameter("userId");
            if (userIdStr == null || userIdStr.isEmpty()) {
                request.setAttribute("errorMessage", "Thiếu thông tin userId!");
                request.getRequestDispatcher("post.jsp").forward(request, response);
                return;
            }

            try {
                int userId = Integer.parseInt(userIdStr);

                // Lấy postId tiếp theo
                int maxPostId = postDao.getMaxPostIDByUserId(userId);
                int postId = (maxPostId < 0) ? 1 : maxPostId + 1;

                // Lấy dữ liệu từ form và kiểm tra dữ liệu nhập vào
                String catIdStr = request.getParameter("loai_chuyen_muc");
                String district = request.getParameter("district");
                String address = request.getParameter("address");
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String priceStr = request.getParameter("price");
                String areaStr = request.getParameter("area");
                String roomCountStr = request.getParameter("roomCount");
                String[] selectedUtilities = request.getParameterValues("Utilities");
                int catId = Integer.parseInt(catIdStr);
                double price = Double.parseDouble(priceStr);
                double area = Double.parseDouble(areaStr);
                int roomCount = Integer.parseInt(roomCountStr);
                String city = "Cần Thơ";
                String status = "Chưa duyệt";
                String utilitiesString = ""; 
                if (selectedUtilities != null) {
                    utilitiesString = String.join(",", selectedUtilities);
                } else {
                    System.out.println("Không có tiện ích nào được chọn!");
                }
                Collection<Part> fileParts = request.getParts();
                List<InputStream> imageStreams = new ArrayList<>();
                try {
                    for (Part filePart : fileParts) {
                        if ("photos".equals(filePart.getName()) && filePart.getSize() > 0) {
                            imageStreams.add(filePart.getInputStream());
                        }
                    }
                } catch (IOException ex) {
                    request.setAttribute("errorMessage", "Lỗi khi tải ảnh: " + ex.getMessage());
                    request.getRequestDispatcher("post.jsp").forward(request, response);
                    return;
                }

                Category postType = postDao.selectCategoryById(catId);
                User user = postDao.getUserById(userId);
                Timestamp currentTime = new Timestamp(System.currentTimeMillis());
                Post post = new Post(postId, userId, catId, title, description, price, address, city, district, area, roomCount, utilitiesString, postType, status, user, null, currentTime, currentTime);

                if (postDao.createPost(post, imageStreams)) {
                    request.getSession().setAttribute("Messages", "Bài của bạn được gửi lên hệ thống, chờ admin duyệt nhé!");
                    response.sendRedirect("Home");
                } else {
                    request.setAttribute("errorMessage", "Đăng bài thất bại, vui lòng thử lại!");
                    request.getRequestDispatcher("post.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Dữ liệu nhập không hợp lệ! Vui lòng kiểm tra lại.");
                request.getRequestDispatcher("post.jsp").forward(request, response);
            } catch (ServletException | IOException e) {
                request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
                request.getRequestDispatcher("post.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("updatePost")) {
            String postIdStr = request.getParameter("postId");
            String userIdStr = request.getParameter("userId");

            try {
                if (postIdStr == null || userIdStr == null || postIdStr.isEmpty() || userIdStr.isEmpty()) {
                    throw new NumberFormatException("Thiếu thông tin postId hoặc userId.");
                }

                int userId = Integer.parseInt(userIdStr);
                int postId = Integer.parseInt(postIdStr);

                String catIdStr = request.getParameter("loai_chuyen_muc");
                String district = request.getParameter("district");
                String address = request.getParameter("address");
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String priceStr = request.getParameter("price");
                String areaStr = request.getParameter("area");
                String roomCountStr = request.getParameter("roomCount");
                String[] selectedUtilities = request.getParameterValues("Utilities");
                if (catIdStr == null || priceStr == null || areaStr == null || roomCountStr == null
                        || catIdStr.isEmpty() || priceStr.isEmpty() || areaStr.isEmpty() || roomCountStr.isEmpty()) {
                    throw new NumberFormatException("Dữ liệu nhập vào không hợp lệ.");
                }
                String utilitiesString = ""; 
                if (selectedUtilities != null) {
                    utilitiesString = String.join(",", selectedUtilities);
                } else {
                    System.out.println("Không có tiện ích nào được chọn!");
                }
                int catId = Integer.parseInt(catIdStr);
                double price = Double.parseDouble(priceStr);
                double area = Double.parseDouble(areaStr);
                int roomCount = Integer.parseInt(roomCountStr);
                String city = "Cần Thơ";
                PostDAO dao = new PostDAO();
                String status = dao.getStatusByPostId(postId);

                // Xử lý ảnh
                List<InputStream> imageStreams = new ArrayList<>();
                try {
                    Collection<Part> fileParts = request.getParts();
                    for (Part filePart : fileParts) {
                        if ("photos".equals(filePart.getName()) && filePart.getSize() > 0) {
                            imageStreams.add(filePart.getInputStream());
                        }
                    }
                } catch (IOException ex) {
                    request.setAttribute("errorMessage", "Lỗi khi tải ảnh: " + ex.getMessage());
                    request.getRequestDispatcher("post.jsp").forward(request, response);
                    return;
                }

                Category postType = postDao.selectCategoryById(catId);
                Timestamp currentTime = new Timestamp(System.currentTimeMillis());

                Post post = new Post(postId, catId, title, description, price, address, city, district, area, roomCount, utilitiesString, postType, status, currentTime);

                if (postDao.updatePost(post, imageStreams)) {
                    response.sendRedirect("Post?action=listPosted&userId=" + userId);
                } else {
                    request.setAttribute("errorMessage", "<p style='color:red;'>Cập nhật thất bại, vui lòng thử lại!</p>");
                    request.getRequestDispatcher("updateListPost.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "<p style='color:red;'>Dữ liệu nhập không hợp lệ! Vui lòng kiểm tra lại.</p>");
                request.getRequestDispatcher("post.jsp").forward(request, response);
            } catch (IOException e) {
                request.setAttribute("errorMessage", "<p style='color:red;'>Lỗi: " + e.getMessage() + "</p>");
                request.getRequestDispatcher("post.jsp").forward(request, response);
            }
        } else if (action.equalsIgnoreCase("deletePost")) {
            String postIdStr = request.getParameter("postId");

            System.out.println("Giá trị postId nhận được: " + postIdStr);

            if (postIdStr == null || postIdStr.isEmpty()) {
                System.out.println("LỖI: Không nhận được postId!");
                response.sendRedirect("listPost.jsp?error=missingPostId");
                return;
            }

            try {
                int postId = Integer.parseInt(postIdStr);
                UserDAO userDao = new UserDAO();

                int userId = userDao.getUserIdByPostId(postId);
                System.out.println("Thực hiện xóa bài đăng với ID: " + postId);

                if (postDao.deletePostByPostId(postId)) {
                    response.sendRedirect("Post?action=listPosted&userId=" + userId);
                } else {
                    System.out.println("Xóa thất bại!");
                    response.sendRedirect("Home");
                }
            } catch (NumberFormatException e) {
                System.out.println("LỖI: postId không hợp lệ!");
                response.sendRedirect("listPost.jsp?error=invalidPostId");
            } catch (IOException e) {
                System.out.println("LỖI: " + e.getMessage());
            }
        } else if (action.equalsIgnoreCase("deleteSavedPost")) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            int postId = Integer.parseInt(request.getParameter("postId"));
            postDao.deletePostById(userId, postId);
            List<Post> listSavedPost = postDao.selectAllSavedPost(userId);
            PrintWriter out = response.getWriter();
            StringBuilder htmlBuilder = new StringBuilder();
            if (listSavedPost == null || listSavedPost.isEmpty()) {
                htmlBuilder.append("<p>Bạn chưa có bài yêu thích nào!</p>");
            } else {
                for (Post p : listSavedPost) {
                    String imageUrl = p.getImages().isEmpty() ? "./images/default-image.jpg"
                            : "ImageHandler?action=display&imgId=" + p.getImages().get(0).getImageId();
                    String location = p.getCity() + ", " + p.getDistrict() + ", " + p.getAddress();

                    DecimalFormat df = new DecimalFormat("#,###");
                    String formattedPrice = df.format(p.getPrice()) + " Vnd/tháng";

                    htmlBuilder.append("<div class=\"saved-post\" data-post-id=\"").append(p.getPostId()).append("\">")
                            .append("<div class=\"saved-image\">")
                            .append("<img src=\"").append(imageUrl).append("\" alt=\"Hình ảnh tin đã lưu\">")
                            .append("</div>")
                            .append("<div class=\"saved-post-content\">")
                            .append("<a href=\"Post?action=postDescription&postId=").append(p.getPostId()).append("\">")
                            .append("<h3>").append(p.getTitle()).append("</h3>")
                            .append("<p class=\"price\">").append(formattedPrice).append("</p>")
                            .append("<p class=\"location\">").append(location).append("</p>")
                            .append("<p class=\"description\">").append(p.getDescription()).append("</p>")
                            .append("</a>")
                            .append("<div onclick=\"deleteSavedPost(").append(p.getPostId()).append(")\" class=\"heart float-end\">")
                            .append("<img src=\"./images/bi-heart-fill.svg\" alt=\"Xóa khỏi danh sách yêu thích\">")
                            .append("</div>")
                            .append("</div>")
                            .append("</div>");
                }
            }
            out.println(htmlBuilder.toString());
        }
    }
}
