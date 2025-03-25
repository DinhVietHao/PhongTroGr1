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
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import model.Post;
import model.User;

/**
 *
 * @author DVHao
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/Search"})
public class SearchServlet extends HttpServlet {

    private final PostDAO postDao = new PostDAO();
    private final UserDAO userDao = new UserDAO();

    private String formatPrice(double price) {
        DecimalFormat df = new DecimalFormat("#,###");
        return df.format(price);
    }

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User();
        }

        String txtSearch = request.getParameter("txt");
        if (txtSearch == null) {
            response.sendRedirect("Home");
            return;
        }

        List<Post> list = postDao.selectPostAll();
        PrintWriter out = response.getWriter();

        for (Post p : list) {
            if (p.toString().toLowerCase().contains(txtSearch.toLowerCase())) {
                StringBuilder htmlBuilder = new StringBuilder();
                htmlBuilder.append("<div class=\"card\">")
                        .append("<div class=\"image-gallery\">")
                        .append("<div class=\"images-main\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().isEmpty() ? "" : p.getImages().get(0).getImageId()).append("\" alt=\"Room Image\" class=\"room-main\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"images-sub\">")
                        .append("<div class=\"images-box1\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 1 ? p.getImages().get(1).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image1\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"images-box2\">")
                        .append("<div class=\"box1\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 2 ? p.getImages().get(2).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image2\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"box2\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 3 ? p.getImages().get(3).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image3\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>")
                        .append("<div id=\"imagePopup\" class=\"image-popup\" onclick=\"closeImage()\">")
                        .append("<span class=\"close-btn\" onclick=\"closeImage()\">&#10006;</span>")
                        .append("<img id=\"popupImg\" src=\"\">")
                        .append("</div>")
                        .append("</div>")
                        .append("<div class=\"card-content\">")
                        .append("<a href=\"Post?action=postDescription&postId=").append(p.getPostId()).append("\">")
                        .append("<h2 class=\"card-title\"><span class=\"star star-5 mt-1\"></span> ").append(p.getTitle()).append("</h2>")
                        .append("<div class=\"card-info\">")
                        .append("<p class=\"card-price\">").append(formatPrice(p.getPrice())).append(" Vnd/tháng</p>")
                        .append("<span class=\"dot\">•</span>")
                        .append("<p>").append(p.getArea()).append(" m<sup>2</sup></p>")
                        .append("<span class=\"dot\">•</span>")
                        .append("<p>").append(p.getAddress()).append("</p>")
                        .append("</div>")
                        .append("<p class=\"post-date\"> <i class=\"bi bi-signpost\"></i> Đăng ").append(calculateTimeAgo(p.getCreated_at().toLocalDateTime())).append("</p>")
                        .append("</a>")
                        .append("<div class=\"contact-info\">")
                        .append("<a href=\"Post?action=postDescription&postId=").append(p.getPostId()).append("\">")
                        .append("<div class=\"contact-user\">")
                        .append("<img class=\"avatar\" src=\"").append(p.getUser().getImageData() != null ? "ImageHandler?action=displayAvatar&userId=" + p.getUserId() : "./images/default_user.svg").append("\" alt=\"avatar\">")
                        .append("<span class=\"color-font\">").append(p.getUser().getFullname()).append("</span>")
                        .append("</div>")
                        .append("</a>")
                        .append("<div class=\"contact-phone\">");

                if (user.getRole() == 3) {
                    htmlBuilder.append("<button class=\"delete\" onclick=\"confirmDelete(").append(p.getPostId()).append(")\">Xóa</button>");
                }

                htmlBuilder.append("<span class=\"phone\">").append(p.getUser().getPhone()).append("</span>");

                if (user.getUserId() != -1) {
                    htmlBuilder.append("<button onclick=\"savePost(event)\" class=\"btn btn-white btn__save d-flex px-2 js-btn-save ")
                            .append(p.isSavedStatus() ? "saved" : "")
                            .append("\" aria-label=\"Lưu tin này\" data-postid=\"")
                            .append(p.getPostId())
                            .append("\" data-userid=\"")
                            .append(user.getUserId())
                            .append("\">")
                            .append("<i class=\"heart size-18\"></i>")
                            .append("</button>");
                }

                htmlBuilder.append("</div>")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>");

                out.println(htmlBuilder.toString());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            user = new User();
        }

        String action = request.getParameter("action");

        if (action == null) {
            action = "filter";
        }

        if ("uploadByCat".equals(action)) {
            String postType = request.getParameter("type");
            int currentPage = 1; // Mặc định là trang 1
            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page")); // Lấy số trang từ request
            }

            List<Post> list = postDao.selectPostAll();
            List<Post> filteredList = new ArrayList<>();

            for (Post p : list) {
                if (p.getPostType().getCatName().equalsIgnoreCase(postType)) {
                    filteredList.add(p);
                }
            }

            int pageSize = 3; // Số bài đăng hiển thị trên mỗi trang
            int totalPosts = filteredList.size();
            int totalPages = (int) Math.ceil((double) totalPosts / pageSize);

            int start = (currentPage - 1) * pageSize;
            int end = Math.min(start + pageSize, totalPosts);
            List<Post> paginatedList = filteredList.subList(start, end);
            for (Post p : paginatedList) {
                StringBuilder htmlBuilder = new StringBuilder();
                htmlBuilder.append("<div class=\"card\">")
                        .append("<div class=\"image-gallery\">")
                        .append("<div class=\"images-main\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().isEmpty() ? "" : p.getImages().get(0).getImageId()).append("\" alt=\"Room Image\" class=\"room-main\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"images-sub\">")
                        .append("<div class=\"images-box1\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 1 ? p.getImages().get(1).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image1\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"images-box2\">")
                        .append("<div class=\"box1\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 2 ? p.getImages().get(2).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image2\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"box2\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 3 ? p.getImages().get(3).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image3\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>")
                        .append("<div id=\"imagePopup\" class=\"image-popup\" onclick=\"closeImage()\">")
                        .append("<span class=\"close-btn\" onclick=\"closeImage()\">&#10006;</span>")
                        .append("<img id=\"popupImg\" src=\"\">")
                        .append("</div>")
                        .append("</div>")
                        .append("<div class=\"card-content\">")
                        .append("<a href=\"Post?action=postDescription&postId=").append(p.getPostId()).append("\">")
                        .append("<h2 class=\"card-title\"><span class=\"star star-5 mt-1\"></span> ").append(p.getTitle()).append("</h2>")
                        .append("<div class=\"card-info\">")
                        .append("<p class=\"card-price\">").append(formatPrice(p.getPrice())).append(" Vnd/tháng</p>")
                        .append("<span class=\"dot\">•</span>")
                        .append("<p>").append(p.getArea()).append(" m<sup>2</sup></p>")
                        .append("<span class=\"dot\">•</span>")
                        .append("<p>").append(p.getAddress()).append("</p>")
                        .append("</div>")
                        .append("<p class=\"post-date\"> <i class=\"bi bi-signpost\"></i> Đăng ").append(calculateTimeAgo(p.getCreated_at().toLocalDateTime())).append("</p>")
                        .append("</a>")
                        .append("<div class=\"contact-info\">")
                        .append("<a href=\"Post?action=postDescription&postId=").append(p.getPostId()).append("\">")
                        .append("<div class=\"contact-user\">")
                        .append("<img class=\"avatar\" src=\"").append(p.getUser().getImageData() != null ? "ImageHandler?action=displayAvatar&userId=" + p.getUserId() : "./images/default_user.svg").append("\" alt=\"avatar\">")
                        .append("<span class=\"color-font\">").append(p.getUser().getFullname()).append("</span>")
                        .append("</div>")
                        .append("</a>")
                        .append("<div class=\"contact-phone\">");

                if (user.getRole() == 3) {
                    htmlBuilder.append("<button class=\"delete\" onclick=\"confirmDelete(").append(p.getPostId()).append(")\">Xóa</button>");
                }

                htmlBuilder.append("<span class=\"phone\">").append(p.getUser().getPhone()).append("</span>");

                if (user.getUserId() != -1) {
                    htmlBuilder.append("<button onclick=\"savePost(event)\" class=\"btn btn-white btn__save d-flex px-2 js-btn-save ")
                            .append(p.isSavedStatus() ? "saved" : "")
                            .append("\" aria-label=\"Lưu tin này\" data-postid=\"")
                            .append(p.getPostId())
                            .append("\" data-userid=\"")
                            .append(user.getUserId())
                            .append("\">")
                            .append("<i class=\"heart size-18\"></i>")
                            .append("</button>");
                }

                htmlBuilder.append("</div>")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>");

                out.println(htmlBuilder.toString());
            }

            if (totalPages > 1) {
                StringBuilder paginationBuilder = new StringBuilder();
                paginationBuilder.append("<ul class=\"pagination\">");
                paginationBuilder.append("<li class=\"page-item ").append(currentPage == 1 ? "disabled" : "").append("\">")
                        .append("<a class=\"page-link\" href=\"javascript:loadPage('").append(postType).append("', ").append(currentPage - 1).append(")\">&laquo; Trang trước</a>")
                        .append("</li>");

                for (int i = 1; i <= totalPages; i++) {
                    paginationBuilder.append("<li class=\"page-item ").append(currentPage == i ? "active" : "").append("\">")
                            .append("<a class=\"page-link\" href=\"javascript:loadPage('").append(postType).append("', ").append(i).append(")\">").append(i).append("</a>")
                            .append("</li>");
                }

                paginationBuilder.append("<li class=\"page-item ").append(currentPage == totalPages ? "disabled" : "").append("\">")
                        .append("<a class=\"page-link\" href=\"javascript:loadPage('").append(postType).append("', ").append(currentPage + 1).append(")\">Trang sau &raquo;</a>")
                        .append("</li>")
                        .append("</ul>");

                out.println(paginationBuilder.toString());
            }
        } else if (action.equalsIgnoreCase("filter")) {
            String type = request.getParameter("category");
            String district = request.getParameter("district");
            String price = request.getParameter("price");
            String area = request.getParameter("area");
            List<Post> list = postDao.selectByFilter(type, district, price, area);
            for (Post p : list) {
                StringBuilder htmlBuilder = new StringBuilder();
                htmlBuilder.append("<div class=\"card\">")
                        .append("<div class=\"image-gallery\">")
                        .append("<div class=\"images-main\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().isEmpty() ? "" : p.getImages().get(0).getImageId()).append("\" alt=\"Room Image\" class=\"room-main\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"images-sub\">")
                        .append("<div class=\"images-box1\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 1 ? p.getImages().get(1).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image1\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"images-box2\">")
                        .append("<div class=\"box1\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 2 ? p.getImages().get(2).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image2\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("<div class=\"box2\">")
                        .append("<img src=\"ImageHandler?action=display&imgId=").append(p.getImages().size() > 3 ? p.getImages().get(3).getImageId() : "").append("\" alt=\"Room Image\" class=\"room-image3\" onclick=\"openImage(this)\">")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>")
                        .append("<div id=\"imagePopup\" class=\"image-popup\" onclick=\"closeImage()\">")
                        .append("<span class=\"close-btn\" onclick=\"closeImage()\">&#10006;</span>")
                        .append("<img id=\"popupImg\" src=\"\">")
                        .append("</div>")
                        .append("</div>")
                        .append("<div class=\"card-content\">")
                        .append("<a href=\"Post?action=postDescription&postId=").append(p.getPostId()).append("\">")
                        .append("<h2 class=\"card-title\"><span class=\"star star-5 mt-1\"></span> ").append(p.getTitle()).append("</h2>")
                        .append("<div class=\"card-info\">")
                        .append("<p class=\"card-price\">").append(formatPrice(p.getPrice())).append(" Vnd/tháng</p>")
                        .append("<span class=\"dot\">•</span>")
                        .append("<p>").append(p.getArea()).append(" m<sup>2</sup></p>")
                        .append("<span class=\"dot\">•</span>")
                        .append("<p>").append(p.getAddress()).append("</p>")
                        .append("</div>")
                        .append("<p class=\"post-date\"> <i class=\"bi bi-signpost\"></i> Đăng ").append(calculateTimeAgo(p.getCreated_at().toLocalDateTime())).append("</p>")
                        .append("</a>")
                        .append("<div class=\"contact-info\">")
                        .append("<a href=\"Post?action=postDescription&postId=").append(p.getPostId()).append("\">")
                        .append("<div class=\"contact-user\">")
                        .append("<img class=\"avatar\" src=\"").append(p.getUser().getImageData() != null ? "ImageHandler?action=displayAvatar&userId=" + p.getUserId() : "./images/default_user.svg").append("\" alt=\"avatar\">")
                        .append("<span class=\"color-font\">").append(p.getUser().getFullname()).append("</span>")
                        .append("</div>")
                        .append("</a>")
                        .append("<div class=\"contact-phone\">");

                if (user.getRole() == 3) {
                    htmlBuilder.append("<button class=\"delete\" onclick=\"confirmDelete(").append(p.getPostId()).append(")\">Xóa</button>");
                }

                htmlBuilder.append("<span class=\"phone\">").append(p.getUser().getPhone()).append("</span>");

                if (user.getUserId() != -1) {
                    htmlBuilder.append("<button onclick=\"savePost(event)\" class=\"btn btn-white btn__save d-flex px-2 js-btn-save ")
                            .append(p.isSavedStatus() ? "saved" : "")
                            .append("\" aria-label=\"Lưu tin này\" data-postid=\"")
                            .append(p.getPostId())
                            .append("\" data-userid=\"")
                            .append(user.getUserId())
                            .append("\">")
                            .append("<i class=\"heart size-18\"></i>")
                            .append("</button>");
                }

                htmlBuilder.append("</div>")
                        .append("</div>")
                        .append("</div>")
                        .append("</div>");

                out.println(htmlBuilder.toString());
            }
        } else if (action.equalsIgnoreCase("searchUser")) {
            String txtSearch = request.getParameter("txt").toLowerCase();
            List<User> allUsers = userDao.getAllUserInfo();
            List<User> allOwners = new ArrayList<>();
            List<User> allViewers = new ArrayList<>();

            for (User u : allUsers) {
                if (u.getFullname().toLowerCase().contains(txtSearch)
                        || u.getUsername().toLowerCase().contains(txtSearch)
                        || u.getEmail().toLowerCase().contains(txtSearch)
                        || u.getPhone().toLowerCase().contains(txtSearch)) {

                    if (u.getRole() == 2) {
                        allOwners.add(u);
                    } else if (u.getRole() == 1) {
                        allViewers.add(u);
                    }
                }
            }

            StringBuilder htmlResponse = new StringBuilder();

            // Phần Owner
            if (!allOwners.isEmpty()) {
                htmlResponse.append("<table class='table table-bordered table-hover mt-3'>")
                        .append("<thead class='table-dark'><tr>")
                        .append("<th>STT</th><th>Tên người dùng</th><th>Tên tài khoản</th>")
                        .append("<th>Email</th><th>Số điện thoại</th><th>Vai trò</th>")
                        .append("<th>Avatar</th><th>Chức năng</th></tr></thead><tbody>");

                int tmp = 0;
                for (User userOwner : allOwners) {
                    htmlResponse.append("<tr>")
                            .append("<td>").append(++tmp).append("</td>")
                            .append("<td>").append(userOwner.getFullname()).append("</td>")
                            .append("<td>").append(userOwner.getUsername()).append("</td>")
                            .append("<td>").append(userOwner.getEmail()).append("</td>")
                            .append("<td>").append(userOwner.getPhone()).append("</td>")
                            .append("<td>Owner</td>")
                            .append("<td><img class='avatar' src='")
                            .append(userOwner.getImageData() != null
                                    ? "ImageHandler?action=displayAvatar&userId=" + userOwner.getUserId()
                                    : "./images/default_user.svg")
                            .append("' alt='avatar'></td>")
                            .append("<td><button class='btn btn-danger btn-sm' onclick='confirmDelete(")
                            .append(userOwner.getUserId()).append(")'>Xóa</button></td>")
                            .append("</tr>");
                }
                htmlResponse.append("</tbody></table>");
            } else {
                htmlResponse.append("<p class='text-center mt-3 text-muted'>Không tìm thấy chủ nhà nào phù hợp.</p>");
            }

            // Phần Viewer
            if (!allViewers.isEmpty()) {
                htmlResponse.append("<table class='table table-bordered table-hover mt-3'>")
                        .append("<thead class='table-dark'><tr>")
                        .append("<th>STT</th><th>Tên người dùng</th><th>Tên tài khoản</th>")
                        .append("<th>Email</th><th>Số điện thoại</th><th>Vai trò</th>")
                        .append("<th>Avatar</th><th>Chức năng</th></tr></thead><tbody>");

                int count = 0;
                for (User userViewer : allViewers) {
                    htmlResponse.append("<tr>")
                            .append("<td>").append(++count).append("</td>")
                            .append("<td>").append(userViewer.getFullname()).append("</td>")
                            .append("<td>").append(userViewer.getUsername()).append("</td>")
                            .append("<td>").append(userViewer.getEmail()).append("</td>")
                            .append("<td>").append(userViewer.getPhone()).append("</td>")
                            .append("<td>Viewer</td>")
                            .append("<td><img class='avatar' src='")
                            .append(userViewer.getImageData() != null
                                    ? "ImageHandler?action=displayAvatar&userId=" + userViewer.getUserId()
                                    : "./images/default_user.svg")
                            .append("' alt='avatar'></td>")
                            .append("<td><button class='btn btn-danger btn-sm' onclick='confirmDelete(")
                            .append(userViewer.getUserId()).append(")'>Xóa</button></td>")
                            .append("</tr>");
                }
                htmlResponse.append("</tbody></table>");
            } else {
                htmlResponse.append("<p class='text-center mt-3 text-muted'>Không tìm thấy người xem nào phù hợp.</p>");
            }

            response.setContentType("text/html");
            response.getWriter().write(htmlResponse.toString());
        }
    }

}
