<%-- 
    Document   : account-management
    Created on : Mar 13, 2025, 9:40:32 PM
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="./css/style.css"/>  
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%if (user.getUserId() == -1) {
                response.sendRedirect("Home");
                return;
            }%>
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <%@include file="postHeader.jsp" %>
            <div class="post-container">
                <div class="account-management">
                    <form class="form-account" action="#" method="POST">
                        <div class="account-info">
                            <div class="account-box">
                                <div class="avatar-account">
                                    <%if (user.getImageData() != null) {%>
                                    <img src="ImageHandler?action=displayAvatar&userId=<%=user.getUserId()%>" alt="avatar">
                                    <%} else {%>  
                                    <img src="./images/default_user.svg" alt="avatar">
                                    <%}%>
                                </div>
                                <div class="account-name">
                                    <span class="name color-font"><%= user.getFullname()%></span> <br>
                                    <%= user.getPhone()%>
                                </div>
                            </div>
                            <label class="w-100">
                                <input class="d-none" type="file" />
                                <a href="./changeInformation.jsp">
                                    <div class="btn bg-white border border-secondary-subtle d-flex w-100">
                                        <i class="bi bi-camera"></i>&nbsp&nbsp Đổi ảnh đại diện</div>
                                </a>
                            </label>
                            <div class="form-floating mt-3">
                                <input type="phone" 
                                       class="cursor-pointer form-control form-control-lg fs-5-5 border-secondary-subtle"
                                       name="phone" id="user_phone" value="<%= user.getPhone()%>" readonly>
                                <label class="cursor-pointer" for="user_phone"  >Số điện thoại</label>
                            </div>
                            <div class="form-floating mt-3">
                                <input type="text" class="form-control form-control-lg fs-5-5 border-secondary-subtle"
                                       id="user_name" name="name" value="<%=user.getFullname()%>" readonly>
                                <label for="user_name">Tên liên hệ</label>
                                <%= request.getAttribute("msgInfo") != null ? request.getAttribute("msgInfo") : ""%>
                            </div>
                            </a>
                            <a class="form-floating d-block mt-3 position-relative text-decoration-none"
                               href="./changeEmail.jsp">
                                <input type="email" readonly class="cursor-pointer form-control form-control-lg fs-5-5 border-secondary-subtle"
                                       id="user_email" name="email" value="<%= user.getEmail()%>"
                                       placeholder="nguyenvana@gmail.com">
                                <label class="cursor-pointer" for="user_email">Email</label>
                                <%= request.getAttribute("msgEmail") != null ? request.getAttribute("msgEmail") : ""%>
                            </a>
                            <a class="form-floating d-block mt-3 position-relative text-decoration-none" href="./changePassword.jsp">
                                <input type="password" readonly
                                       class="cursor-pointer form-control form-control-lg fs-5-5 border-secondary-subtle"
                                       placeholder="********" value="********">
                                <label class="cursor-pointer">Mật khẩu</label>
                                <%= request.getAttribute("msgPass") != null ? request.getAttribute("msgPass") : ""%>
                            </a>
                        </div>
                    </form>
                    <%if (user.getRole() == 1 || user.getRole() == 2) {%>
                    <button class="btn btn-danger btn-sm3 mt-3"style="margin-left: 80%;" onclick="confirmDelete(<%=user.getUserId()%>)">Xóa tài khoản</button>
                    <%}%>
                </div>
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
                        <form id="deleteUserForm" method="post" action="User">
                            <input type="hidden" name="action" value="deleteAccount">
                            <input type="hidden" name="userId" id="deleteUserId">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </div>
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
    </body>
</html>