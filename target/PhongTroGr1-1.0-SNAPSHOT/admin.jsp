<%-- 
    Document   : admin
    Created on : Mar 24, 2025, 1:32:08 PM
    Author     : Admin
--%>

<%@page import="model.Category"%>
<%@page import="java.time.Duration"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="model.User"%>
<%@page import="model.Post"%>
<%@page import="model.Post"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = new User();
    if (session.getAttribute("user") != null) {
        user = (User) session.getAttribute("user");
    } else if (request.getAttribute("user") != null && session.getAttribute("user") == null) {
        user = (User) request.getAttribute("user");
    }

    List<Category> listCategory = (List<Category>) session.getAttribute("listCate");

    String messageAdmin = (String) session.getAttribute("messageAdmin");
    if (messageAdmin != null) {
%>
<div class="admin-aler alert alert-success" role="alert">
    <%= messageAdmin%>
</div>
<%
        session.removeAttribute("messageAdmin");
    }

    List<Post> lunapprovedList = (List) request.getAttribute("lunapprovedList");
    List<User> listAllUserOwner = (List) request.getAttribute("listAllUserOwner");
    List<User> listAllUserViewer = (List) request.getAttribute("listAllUserViewer");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">
        <!-- boostrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/style.css"/>
        <link rel="stylesheet" href="./css/discribe.css"/>
    </head>
    <body>
        <div class="admin">
            <div class="admin-sidebar">
                <h2>Admin Panel</h2>
                <div class="profile-section">
                    <div class="profile-avatar">
                        <%if (user.getImageData() != null) {%>
                        <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%=user.getUserId()%>" alt="avatar">
                        <% } else { %>  
                        <img class="avatar" src="https://phongtro123.com/images/default-user.svg" alt="avatar">
                        <% }%>
                    </div>
                    <div class="profile-details">
                        <span class="user-name color-font"><%= user != null ? user.getFullname() : "No account"%></span> <br>
                        <span class="user-phone"><%= user != null ? user.getPhone() : "No phone"%></span> <br>
                        <span class="account-id">Mã tài khoản: <%= user != null ? user.getUserId() : "No id"%></span>
                    </div>
                </div>
                <ul class="sidebar-menu">
                    <li><a class="sidebar-item" href="#" id="danh-sach-bai-chua-duyet"> <i class="fas fa-list" ></i> Danh sách chưa duyệt</a></li>
                    <li><a class="sidebar-item" href="#" id="quan-ly-tai-khoan"><i class="fas fa-user"></i> Quản lý tài khoản</a></li>
                    <li><a class="sidebar-item logout" href="./login.jsp"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                </ul>
            </div>
            <div class="admin-header">
                <div class="header">
                    <div class="header-left">
                        <div class="header-logo">
                            <a href="Home">
                                <img src="./images/logo.gif" alt="Logo Admin" title="PhongtroG1.com">
                            </a>
                        </div>
                        <h2>Trang quản trị</h2>
                    </div>
                    <div class="header-right">
                        <form action="" method="GET" class="header-search">
                            <input oninput="searchUser(this)" class="search" type="text" name="text" placeholder="Tìm kiếm...">
                            <button type="submit" class="search-btn">
                                <i class="bi bi-search"></i>
                            </button>
                        </form>     
                        <button class="icon-btn"><i class="fas fa-bell"></i></button>
                        <div class="profile-menu">
                            <%if (user.getImageData() != null) {%>
                            <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%=user.getUserId()%>" alt="avatar">
                            <% } else { %>  
                            <img class="avatar" src="https://phongtro123.com/images/default-user.svg" alt="avatar">
                            <% }%>
                            <span class="color-font"><%= user != null ? user.getFullname() : "No account"%></span>
                        </div>
                    </div>
                </div>

                <main class="admin-post">
                    <!--danh-sach-bai-chua-duyet-->
                    <div id="danh-sach-bai-chua-duyet-table" style="display:none;">
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

                    <!-- quan-ly-tai-khoan-->
                    <div id="quan-ly-tai-khoan-table" style="display:none;">
                        <h1 class="fs-3 fw-semibold text-nowrap mb-1">Quản lý Tài Khoản</h1>
                        <div id="infoAcc">
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
                                    <% int tmp = 0;
                                        for (User userOwner : listAllUserOwner) {
                                    %>
                                    <tr>
                                        <td><%= ++tmp%></td>
                                        <td><%= userOwner.getFullname()%></td>
                                        <td><%= userOwner.getUsername()%></td>
                                        <td><%= userOwner.getEmail()%></td>
                                        <td><%= userOwner.getPhone()%></td>
                                        <td><%="Chủ trọ"%></td>
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
                                        <td><%="Người thuê"%></td>
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
                    </div>
                </main>
            </div>
        </div>

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
            function searchUser(input) {
                var txtSearch = input.value;

                if (txtSearch.length === 0) {
                    location.reload();
                    return;
                }

                $.ajax({
                    url: "/PhongTroGr1/Search",
                    type: 'POST',
                    data: {
                        action: "searchUser",
                        txt: txtSearch
                    },
                    success: function (data) {
                        document.getElementById("infoAcc").innerHTML = data;
                        document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "none";
                        document.getElementById("quan-ly-tai-khoan-table").style.display = "block";
                    }
                });
            }

            function confirmDelete(userId) {
                document.getElementById("deleteUserId").value = userId; // Gán userId vào input ẩn
                var deleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
                deleteModal.show();
            }

            document.getElementById("danh-sach-bai-chua-duyet").onclick = function () {
                document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "block";
                document.getElementById("quan-ly-tai-khoan-table").style.display = "none";
            };
            document.getElementById("quan-ly-tai-khoan").onclick = function () {
                document.getElementById("danh-sach-bai-chua-duyet-table").style.display = "none";
                document.getElementById("quan-ly-tai-khoan-table").style.display = "block";
            };
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./js/describe.js"></script>
    </body>
</html>
