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
        <!-- bootstrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/style.css"/>  
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%if (user.getEmail() == null) {
                response.sendRedirect("Home");
                return;
            }%>
        <div class="card shadow p-4 card-forgot-password" style="width: 500px;">
            <h4 class="text-center mb-3 text-danger">Mã Xác Thực</h4>
            <p class="text-muted text-center">Mã xác thực đã được gửi về: <strong><%= user.getEmail()%></strong> </p>

            <form id="forgotPasswordForm" action="Register?action=verify" method="POST">
                <input name="username" value="<%= user.getUsername()%>" hidden>
                <input name="password" value="<%= user.getPassword()%>" hidden>

                <div class="mb-3">
                    <label for="authencation" class="form-label">Code:</label>
                    <div class="input-group">
                        <input type="number" pattern="[0-9]*" inputmode="numeric" class="form-control" id="authencation" name="authCode" placeholder="Nhập mã xác thực">
                    </div>
                </div>

                <!-- Hiển thị lỗi nếu có -->
                <p><%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%></p>

                <!-- Nút xác nhận -->
                <div class="form-group">
                    <button type="submit" class="btn btn-danger w-100">Xác nhận</button>
                </div>
            </form>

            <!-- Form gửi lại mã xác thực -->
            <form action="Register?action=resendCode" method="POST" class="mt-3">
                <input name="username" value="<%= user.getUsername()%>" hidden>
                <input name="password" value="<%= user.getPassword()%>" hidden>
                <input name="email" value="<%= user.getEmail()%>" hidden>
                <button type="submit" class="btn btn-link p-0 w-100">Gửi lại mã!</button>
            </form>

            <div class="mt-3 text-center">
                <a href="Register?action=return&id=<%= user.getUserId()%>">Quay lại đăng ký</a>
            </div>
        </div>

        <!-- Bootstrap JS và Popper (nếu cần) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

