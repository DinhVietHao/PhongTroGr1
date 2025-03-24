<%-- 
    Document   : home
    Created on : Feb 6, 2025, 10:23:56 AM
    Author     : Admin
--%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@page import="java.time.Duration"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String messageAdmin = (String) session.getAttribute("messageAdmin");
    if (messageAdmin != null) {
%>
<div class="alert alert-success" role="alert">
    <%= messageAdmin%>
</div>
<%
        session.removeAttribute("messageAdmin");
    }

    List<Post> lunapprovedList = (List) request.getAttribute("lunapprovedList");
    List<User> listAllUserOwner = (List) request.getAttribute("listAllUserOwner");
    List<User> listAllUserViewer = (List) request.getAttribute("listAllUserViewer");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">

        <!-- boostrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/discribe.css">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <!--SIDEBAR-->
        <aside class="sidebar-panel">
            <div class="profile-section">
                <div class="profile-avatar">
                    <%if (user.getImageData() != null) {%>
                    <img class="avatar-admin" src="ImageHandler?action=displayAvatar&userId=<%= user.getUserId()%>">
                    <%} else { %>
                    <img class="avatar-admin" src="./images/default_user.svg">
                    <%}%>
                </div>
                <div class="profile-details">
                    <span class="user-name-admin">Hi! <%= user.getFullname()%></span> <br>
                    <span class="user-phone"><%= user.getPhone()%></span> <br>
                    <span class="account-id">Mã tài khoản: <%= user.getRole()%></span>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li><a class="sidebar-item" href="#" id="quanli-baidang">Quản lí bài đăng</a></li>
                <li>
                    <a class="sidebar-item d-flex align-items-center justify-content-between" href="#" id="danh-sach-bai-chua-duyet">
                        Bài đăng chưa duyệt
                        <span id="pending-count" class="badge bg-danger rounded-pill ms-2"><%= lunapprovedList.size() > 99 ? "99+" : lunapprovedList.size()%></span>
                    </a>
                </li>
                <li><a class="sidebar-item" href="#" id="quan-ly-tai-khoan">Quản lý tài khoản</a></li>
                <li><a class="sidebar-item logout" href="./login.jsp"><i class="bi bi-box-arrow-in-right"></i>Đăng xuất</a></li>
            </ul>
        </aside>

        <main class="post-header">
            <!-- Quản Lí Bài Đăng -->
            <div id="quanli-baidang-table" class="post" style="display:none;">
                <h1 class="fs-3 fw-semibold text-nowrap mb-1">Quản Lí Bài Đăng</h1>
                <table class="table table-bordered table-hover mt-3">
                    <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Người đăng</th>
                            <th>Tiêu đề</th>
                            <th>Mô tả</th>
                            <th>Hình ảnh</th>
                            <th>Giá tiền</th>
                            <th>Danh mục</th>
                            <th>Trạng Thái</th>
                            <th>Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <th>Người đăng</th>
                            <td>Phòng Trọ</td>
                            <td><span class="description" data-description="Lorem ipsum dolor sit amet consectetur adipisicing elit. Sit architecto id ex incidunt assumenda iusto ratione odio, itaque, dolores illo explicabo soluta quos vero facilis iure totam ullam laboriosam eligendi.">Xem mô tả</span></td>
                            <td><img src="https://via.placeholder.com/80x60" class="product-img"></td>
                            <td>5.600.000 đ</td>
                            <td>Phòng Trọ</td>
                            <td>Còn Phòng</td>
                            <td>
                                <button class="btn btn-success btn-sm">Sửa</button>
                                <button class="btn btn-danger btn-sm">Xóa</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div id="danh-sach-bai-chua-duyet-table" class="post" style="display:none;">
                <h1 class="fs-3 fw-semibold text-nowrap mb-1">
                    Danh Sách Bài Chưa Duyệt
                </h1>
                <% if (lunapprovedList != null && !lunapprovedList.isEmpty()) { %>
                <table class="table table-bordered table-hover mt-3">
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        LocalDateTime now = LocalDateTime.now();
                        int res = 0;
                        for (Post post : lunapprovedList) {
                            LocalDateTime createdAt = post.getCreated_at().toLocalDateTime();
                            Duration duration = Duration.between(createdAt, now);
                            long days = duration.toDays();
                            long hours = duration.toHours() % 24;
                            long minutes = duration.toMinutes() % 60;
                            String timeAgo;
                            if (days >= 7) {
                                timeAgo = (days / 7) + " tuần trước";
                            } else if (days > 0) {
                                timeAgo = days + " ngày trước";
                            } else if (hours > 0) {
                                timeAgo = hours + " giờ trước";
                            } else {
                                timeAgo = minutes + " phút trước";
                            }
                    %>
                    <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Người đăng</th>
                            <th>Tiêu đề</th>
                            <th>Mô tả</th>
                            <th>Giá tiền</th>
                            <th>Danh mục</th>
                            <th>Xem chi tiết</th>
                            <th>Thời gian đăng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= ++res%></td>
                            <td><%= post.getUser().getFullname()%></td>
                            <td><%= post.getTitle()%></td>
                            <td><span class="description" data-description="<%= post.getDescription()%>">Xem mô tả</span></td>
                            <%!
                                NumberFormat formatter = NumberFormat.getInstance(Locale.GERMANY);
                            %>
                            <%
                                DecimalFormat df = new DecimalFormat("#,###");
                                String formattedPrice = df.format(post.getPrice()) + " Vnd/tháng";
                            %>
                            <td><%= formattedPrice%></td>
                            <td><%= post.getPostType().getCatName()%></td>
                            <td><a href="Post?action=postDescription&postId=<%= post.getPostId()%>">Xem chi tiết bài đăng</a></td>
                            <td class="time-posted">Đăng <%=timeAgo%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <p class="text-center mt-3 text-muted">Không có bài đăng nào cần duyệt.</p>
                <% }%>
            </div>
            <div id="quan-ly-tai-khoan-table" class="post" style="display:none;">
                <h1 class="fs-3 fw-semibold text-nowrap mb-1">Quản lý Tài Khoản</h1>
                <table class="table table-bordered table-hover mt-3">
                    <%
                        if (listAllUserOwner == null || listAllUserOwner.isEmpty() || listAllUserOwner.get(0).getUserId() == -1) {
                    %>
                    <p> Chưa có User Owner nào đăng kí !<p>
                        <%
                        } else {

                        %>
                    <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Tên người dùng</th>
                            <th>Tên tài khoản</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Avatar</th>
                            <th>Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            int tmp = 0;
                            for (User userOwner : listAllUserOwner) {
                        %>
                        <tr>
                            <td><%= ++tmp%></td>
                            <td><%= userOwner.getFullname()%></td>
                            <td><%= userOwner.getUsername()%></td>
                            <td><%= userOwner.getEmail()%></td>
                            <td><%= userOwner.getPhone()%></td>
                            <td><%="Owner"%></td>
                            <td>
                                <% if (userOwner.getImageData() != null) {%>
                                <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%=userOwner.getUserId()%>" alt="avatar">
                                <% } else { %>  
                                <img class="avatar" src="./images/default_user.svg" alt="avatar">
                                <% }%>
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="confirmDelete(<%= userOwner.getUserId()%>)">Xóa</button>
                            </td>
                        </tr> 
                        <%
                            }
                        %>
                    </tbody>
                    <%
                        }
                    %>
                </table>

                <table class="table table-bordered table-hover mt-3">
                    <%
                        if (listAllUserViewer == null || listAllUserViewer.isEmpty() || listAllUserViewer.get(0).getUserId() == -1) {
                    %>
                    <p> Chưa có User Viewer nào đăng kí !<p>
                        <%
                        } else {

                        %>
                    <thead class="table-dark">
                        <tr>
                            <th>STT</th>
                            <th>Tên người dùng</th>
                            <th>Tên tài khoản</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Vai trò</th>
                            <th>Avatar</th>
                            <th>Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%                            int count = 0;
                            for (User userViewer : listAllUserViewer) {
                        %>
                        <tr>
                            <td><%= ++count%></td>
                            <td><%= userViewer.getFullname()%></td>
                            <td><%= userViewer.getUsername()%></td>
                            <td><%= userViewer.getEmail()%></td>
                            <td><%= userViewer.getPhone()%></td>
                            <td><%="Viewer"%></td>
                            <td>
                                <% if (userViewer.getImageData() != null) {%>
                                <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%=userViewer.getUserId()%>" alt="avatar">
                                <% } else { %>  
                                <img class="avatar" src="./images/default_user.svg" alt="avatar">
                                <% }%>
                            </td>
                            <td>
                                <button class="btn btn-danger btn-sm" onclick="confirmDelete(<%= userViewer.getUserId()%>)">Xóa</button>
                            </td>
                        </tr> 
                        <%
                            }
                        %>
                    </tbody>
                    <%
                        }
                    %>
                </table>
            </div>
        </main>
        <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmDeleteLabel">Xác nhận xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa tài khoản này không?
                    </div>
                    <div class="modal-button">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Quay lại</button>
                        <form id="deleteUserForm" method="post" action="Admin">
                            <input type="hidden" name="action" value="deleteUser">
                            <input type="hidden" name="userId" id="deleteUserId">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="describe" id="modalOverlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thông tin mô tả nhà trọ</h5>
                    <button class="close-modal" id="closeModal">&times;</button>
                </div>
                <div class="modal-body" id="modalBody">
                </div>
            </div>
        </div>

        <script>
            function confirmDelete(userId) {
                document.getElementById("deleteUserId").value = userId; // Gán userId vào input ẩn
                var deleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
                deleteModal.show();
            }
        </script>
        <script src="./js/menusidebarAdmin.js"></script>
        <script src="./js/describe.js"></script>
    </body>
</html>
