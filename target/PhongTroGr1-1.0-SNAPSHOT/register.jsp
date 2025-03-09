<%-- 
    Document   : register
    Created on : Feb 6, 2025, 10:37:50 AM
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
        <%@include file="header.jsp" %>
        <main class="main">
            <div class="container">
                <div class="center-box">
                    <div class="custom-box">
                        <div class="tab-container">
                            <a class="tab-inactive" href="./login.jsp">Đăng nhập</a>
                            <a class="tab-active" href="./register.jsp">Tạo tài khoản mới</a>
                        </div>
                        <%
                            String status = (String)request.getAttribute("status");
                        %>
                        <form class="register-form" action="Register" method="POST">
                            <div class="form-group">
                                <label for="inputFullName">Họ tên</label>
                                <input type="text" id="inputFullName" name="fullname" placeholder="Vui lòng nhập họ tên" required
                                       minlength="3" class="input-field" value="<%= request.getAttribute("fullname") != null ? request.getAttribute("fullname") : ""%>"
                                       <%= (status != null) ? "readonly" : ""%>>
                            </div>
                            <div class="form-group">
                                <label for="inputFullName">Tên đăng nhập</label>
                                <input type="text" id="inputUsername" name="username" placeholder="Vui lòng nhập tên đăng nhập" required
                                       minlength="3" class="input-field" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : ""%>"
                                       <%= (status != null) ? "readonly" : ""%>>
                            </div>
                            <div class="form-group">
                                <label for="inputPhone">Số điện thoại</label>
                                <input type="text" id="inputPhone" name="phone" placeholder="Vui lòng nhập số điện thoại" required
                                       minlength="10" maxlength="11" class="input-field" value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : ""%>"
                                       <%= (status != null) ? "readonly" : ""%>>

                            </div>
                            <div class="form-group">
                                <label for="inputPhone">Email</label>
                                <input type="email" id="inputEmail" name="email" placeholder="Vui lòng nhập email" required
                                       class="input-field" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : ""%>"
                                       <%= (status != null) ? "readonly" : ""%>>
                            </div>
                            <div class="form-group">
                                <label for="password">Mật khẩu</label>
                                <input type="password" id="password" name="password" placeholder="Vui lòng nhập mật khẩu" required
                                       minlength="6" class="input-field" value="<%= request.getAttribute("password") != null ? request.getAttribute("password") : ""%>"
                                       <%= (status != null) ? "readonly" : ""%>>
                            </div>
                            <div class="form-group">
                                <label for="password">Xác nhận mật khẩu</label>
                                <input type="password" id="re-password" name="re-pass" placeholder="Vui lòng xác nhận lại mật khẩu" required
                                       minlength="6" class="input-field" value="<%= request.getAttribute("re-pass") != null ? request.getAttribute("re-pass") : ""%>"
                                       <%= (status != null) ? "readonly" : ""%>>
                            </div>
                            <div class="form-group">
                                <label for="authentication">Mã xác thực</label>
                                <input type="text" id="authentication" name="authCode" placeholder="Vui lòng mã xác thực"
                                       class="input-field">
                                <button type="submit" name="action" value="verify" class="custom-btn">Gửi mã tại đây!</button>
                            </div>
                            <%
                                Integer role = (Integer) request.getAttribute("role");
                                role = (role == null) ? 0 : role; // Nếu role null thì gán 0 để tránh lỗi
                            %>
                            <div class="form-group">
                                <div class="radio-group">
                                    <label class="account-type">Loại tài khoản</label>
                                    <input type="radio" id="user_type_guest" name="user_type" value="1" <%= (role == 1) ? "checked" : ""%> required>
                                    <label for="user_type_guest">Tìm kiếm</label>
                                    <input type="radio" id="user_type_owner" name="user_type" value="2" <%= (role == 2) ? "checked" : ""%>>
                                    <label for="user_type_owner">Chính chủ</label>
                                </div>
                            </div>
                            <p><%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%></p>        
                            <div class="form-group">
                                <button type="submit" name="action" value="register" class="custom-btn">Tạo tài
                                    khoản</button>
                            </div>
                            <input type="hidden" name="redirect" value="">
                        </form>
                        <p class="copyright">
                            Khi đăng ký, bạn đồng ý với <a href="/quy-dinh-su-dung">quy định sử dụng</a> và <a
                                href="/chinh-sach-bao-mat">chính sách bảo mật</a> của chúng tôi.
                        </p>
                        <p class="copyright">Bản quyền © 2024 - 2025 PhongTroG1.com</p>
                    </div>
                </div>
            </div>
        </main>

    </body>
</html>
