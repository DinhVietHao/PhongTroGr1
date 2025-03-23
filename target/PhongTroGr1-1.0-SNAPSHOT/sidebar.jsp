<%-- 
    Document   : sidebar
    Created on : Mar 13, 2025, 9:34:17 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">
        <!-- boostrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/style.css"/>  
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body>
        <aside class="sidebar-panel">
            <div class="profile-section">
                <div class="profile-avatar">
                    <%if (user.getImageData() != null) {%>
                    <img src="ImageHandler?action=displayAvatar&userId=<%=user.getUserId()%>" alt="avatar">
                    <% } else { %>  
                    <img src="https://phongtro123.com/images/default-user.svg" alt="avatar">
                    <% }%>
                </div>
                <div id="avatarModal" class="modal">
                    <span class="close">&times;</span>
                    <img class="modal-content" id="avatarImg">
                </div>

                <div class="profile-details">
                    <span class="user-name"><%= user != null ? user.getFullname() : "No account"%></span> <br>
                    <span class="user-phone"><%= user != null ? user.getPhone() : "No phone"%></span> <br>
                    <span class="account-id">Mã tài khoản: <%= user != null ? user.getUserId() : "No id"%></span>
                </div>
            </div>
            <ul class="sidebar-menu">
                <%
                    if (user.getUserId() != -1 && user.getRole() == 2) {
                %>
                <li>
                    <a  class="sidebar-item click-effect" href="./post.jsp">
                        <i class="bi bi-file-earmark-post "></i>Đăng tin mới
                    </a>
                </li>
                <%
                    }
                    if (user.getUserId() != -1 && user.getRole() == 2) {
                %>
                <li>
                    <a  class="sidebar-item " href="Post?action=listPosted&userId=<%= user.getUserId()%>">
                        <i class="bi bi-archive"></i> Danh sách đăng tin 
                    </a>
                </li>
                <%
                    }
                    if (user.getUserId() != -1 && (user.getRole() == 1 || user.getRole() == 2)) {
                %>
                <li>
                    <a  class="sidebar-item " href="Post?action=uploadSavedPost&userId=<%= user.getUserId()%>">
                        <i class="bi bi-heart"></i> Tin đã lưu
                    </a>
                </li>
                <%
                    }
                %>
                <li>
                    <a  class="sidebar-item " href="./accountManagement.jsp">
                        <i class="bi bi-person"></i> Quản lý tài khoản
                    </a>
                </li>
                <li>
                    <a class="sidebar-item logout " href="Logout">
                        <i class="bi bi-box-arrow-in-right"></i> Đăng xuất
                    </a>
                </li>
            </ul>
            <div class="support-box ">
                <a class="support-contact" href="https://zalo.me/0854453340" target="_blank">
                    <div>
                        <p class="support-label">Nhân viên hỗ trợ riêng của bạn:</p>
                        <p class="support-name">GroupPhongTroG1 <br> 0854453340</p>
                    </div>
                </a>
            </div>
        </aside>
        <script src="./js/effect.js"></script>
    </body>
</html>