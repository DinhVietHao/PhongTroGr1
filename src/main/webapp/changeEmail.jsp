<%-- 
    Document   : change-password
    Created on : Mar 13, 2025, 9:56:26 PM
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
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <%@include file="postHeader.jsp" %>
            <div class="post-container">
                <div class="account-management">
                    <form class="form-account" action="User?action=sendCode" method="POST">
                        <div class="rounded">
                            <h2 class="fs-5 fw-semibold mb-3">Thay đổi email</h2>
                            <div class="form-floating">
                                <input name="userId" value="<%= user.getUserId()%>" hidden>
                                <input name="fullname" value="<%= user.getFullname()%>" hidden>
                                <input type="email" name="old_email" readonly disabled
                                       class="form-control form-control-lg border-secondary-subtle" id="user_email"
                                       value="<%= user.getEmail() != null ? user.getEmail() : ""%>">
                                <label for="user_phone">Email cũ</label>
                            </div>
                            <div class="form-floating mt-3">
                                <input type="email" name="new_email"
                                       class="form-control form-control-lg border-secondary-subtle js-input-email"
                                       id="user_phone" value="<%= request.getAttribute("new_email") != null ? request.getAttribute("new_email") : ""%>" 
                                       placeholder="Nhập email mới" <%= request.getAttribute("flag") != null ? "readonly disabled" : ""%>>
                                <label for="user_phone">Email mới</label>
                            </div>
                            <div class="d-grid mt-3">
                                <button class="btn btn-warning js-btn-get-verify-code"
                                        >Lấy mã xác thực</button>
                            </div>
                        </div>
                    </form>
                    <form action="User?action=verifyCode" method="POST">
                        <input name="id" value="<%= user.getUserId()%>" hidden>
                        <input name="new_email" value="<%= request.getAttribute("new_email") != null ? request.getAttribute("new_email") : ""%>" hidden>
                        <div class="form-floating mt-5">
                            <input type="text" name="authCode"
                                   class="form-control form-control-lg border-secondary-subtle" id="user_email2" value=""
                                   placeholder="Nhập mã xác thực">
                            <label for="user_pemail2">Nhập mã xác thực</label>
                            <%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%>
                        </div>
                        <button type="submit" class="post-button">Cập nhật</button>
                    </form>
                </div>
            </div>
        </main>
    </body>
</html>