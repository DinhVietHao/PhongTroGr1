<%-- 
    Document   : home
    Created on : Feb 6, 2025, 1:35:18 PM
    Author     : Admin
--%>

<%@page import="model.User"%>
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
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%
            User user = (User) request.getAttribute("user");
        %>
        <div class="card shadow p-4 card-forgot-password" style="width: 500px;">
            <h4 class="text-center mb-3 text-danger">Mã Xác Thực</h4>
            <p class="text-muted text-center">Mã xác thực đã được gửi về: <strong><%= user.getEmail()%></strong> </p>

            <form id="forgotPasswordForm" action="Register?action=verify" method="POST">
                <input name="username" value="<%= user.getUsername()%>" hidden>
                <input name="password" value="<%= user.getPassword()%>" hidden>
                <div class="mb-3">
                    <label for="authencation" class="form-label">Code:</label>
                    <input type="number" pattern="[0-9]*" inputmode="numeric" class="form-control no-spinner" id="authencation" name="authCode" placeholder="Nhập mã xác thực" required>
                    <!-- Hiển thị lỗi nếu có -->
                    <p><%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%></p> 
                </div>
                <!-- Nút tạo tài khoản -->
                <div class="form-group">
                    <button type="submit" class="custom-btn">Xác nhận</button>
                </div>
            </form>

            <div class="mt-3 text-center">
                <a href="Register">Quay lại đăng ký</a>
            </div>
        </div>
    </body>
</html>
