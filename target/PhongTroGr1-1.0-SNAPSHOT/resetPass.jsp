<%-- 
    Document   : home
    Created on : Feb 6, 2025, 1:35:18 PM
    Author     : Admin
--%>
<%@page import="model.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <!-- Liên kết tới file JavaScript validation -->
        <script src="./js/validation.js"></script>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="card shadow p-4 card-reset-password">
            <h4 class="text-center mb-3 text-danger">Đặt Lại Mật Khẩu</h4>
            <p class="text-muted text-center">Mã xác thực đã được gửi về: <strong><%= user.getEmail()%></strong> </p>

            <form action="Login?action=resetPass" method="POST">
                <input name="id" value="<%= user.getUserId()%>" hidden>
                <input name="email" value="<%= user.getEmail()%>" hidden>

                <div class="mb-3">
                    <label for="inputUsername" class="form-label">Tên Đăng Nhập:</label>
                    <input type="text" class="form-control" id="inputUsername" name="username" placeholder="Nhập tên đăng nhập" 
                           value="<%= user.getUsername() != null ? user.getUsername() : ""%>" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Mật Khẩu Mới:</label>
                    <input type="password" class="form-control" id="password" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                </div>

                <div class="mb-3">
                    <label for="re-password" class="form-label">Xác Thực Mật Khẩu Mới:</label>
                    <input type="password" class="form-control" id="re-password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                </div>

                <div class="mb-3">
                    <label for="authencation" class="form-label">Mã Xác Thực:</label>
                    <input type="number" pattern="[0-9]*" inputmode="numeric" class="form-control" id="authencation" name="authCode" placeholder="Nhập mã xác thực" required>
                </div>

                <p><%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%></p>

                <button type="submit" class="btn btn-danger w-100 text-decoration">Xác Nhận</button>
            </form>

            <!-- Form gửi lại mã xác thực -->
            <form action="Login?action=sendCode" method="POST" class="mt-3">
                <input name="email" value="<%= user.getEmail()%>" hidden>
                <button type="submit" class="btn btn-link p-0 w-100">Gửi lại mã!</button>
            </form>

            <div class="mt-3 text-center">
                <a href="Login">Quay lại đăng nhập</a>
            </div>
        </div>
    </body>
</html>
