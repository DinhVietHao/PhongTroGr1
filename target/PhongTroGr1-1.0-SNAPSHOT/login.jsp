<%-- 
    Document   : login
    Created on : Feb 6, 2025, 10:36:02 AM
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
        <link rel="stylesheet" href="./css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        <%--<%@include file="header.jsp" %>--%>
        <main class="main">
            <div class="container">
                <div class="center-box">
                    <div class="custom-box">
                        <div class="tab-container">
                            <a class="tab-active" href="./login.jsp">Đăng nhập</a>
                            <a class="tab-inactive" href="./register.jsp">Tạo tài khoản mới</a>
                        </div>
                        <form class="login-form" method="POST">
                            <div class="form-group">
                                <label for="inputPhoneEmailLogin">Số điện thoại</label>
                                <input type="text" id="inputPhoneEmailLogin" name="loginname" class="input-field"
                                       placeholder="Nhập số điện thoại" minlength="10" maxlength="11" required>
                            </div>
                            <div class="form-group">
                                <label for="password">Mật khẩu</label>
                                <input type="password" id="password" name="password" class="input-field"
                                       placeholder="Nhập mật khẩu" minlength="6" required>
                            </div>
                            <button type="submit" name="wp-submit-login" class="custom-btn">Đăng nhập</button>
                            <p>
                                <a class="forgot-password" href="">Bạn quên mật khẩu?</a>
                            </p>
                            <input type="hidden" name="redirect" value="./register.html" />
                        </form>
                        <p class="copyright">Bản quyền © 2024 - 2025 PhongtroG1.com</p>
                    </div>
                </div>
            </div>
        </main>

    </body>
</html>
