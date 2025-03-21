<%-- 
    Document   : home
    Created on : Feb 6, 2025, 1:35:18 PM
    Author     : Admin
--%>

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

        <div class="card shadow p-4 card-forgot-password">
            <h4 class="text-center mb-3 text-danger">Quên Mật Khẩu</h4>
            <p class="text-muted text-center">Nhập email của bạn để đặt lại mật khẩu</p>

            <form action="Login?action=sendCode" method="POST">
                <div class="mb-3">
                    <label for="inputEmail" class="form-label">Email:</label>
                    <input type="email" class="form-control" id="inputEmail" name="email" placeholder="Nhập email đã đăng ký tài khoản" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : ""%>"> <br>
                    <p><%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%></p>
                    <button class="btn btn-primary w-100 text-decoration">Xác Nhận</button>
                </div>
            </form>

            <div class="mt-3 text-center">
                <a href="Login">Quay lại đăng nhập</a>
            </div>
        </div>
    </body>
</html>
