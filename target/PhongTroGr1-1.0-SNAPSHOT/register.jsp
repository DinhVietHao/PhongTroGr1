<%--  
    Document   : register  
    Created on : Feb 6, 2025, 10:37:50 AM  
    Author     : Admin  
--%>

<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  <%-- Định dạng trang HTML với mã hóa UTF-8 --%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">

        <!-- Bootstrap CSS -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/style.css">

        <!-- Liên kết tới file JavaScript validation -->
        <script src="./js/validation.js"></script>
    </head>
    <body>
        <%@include file="header.jsp" %> <!-- Nhúng file header.jsp (chứa menu, logo, v.v.) -->
        <main class="main">
            <div class="center">
                <div class="center-box">
                    <div class="custom-box">
                        <!-- Tabs chuyển đổi giữa đăng nhập và đăng ký -->
                        <div class="tab-container">
                            <a class="tab-inactive" href="Login">Đăng nhập</a>
                            <a class="tab-active" href="./register.jsp">Tạo tài khoản mới</a>
                        </div>
                        <!-- Form đăng ký -->
                        <form class="register-form" action="Register?action=register" method="POST" onsubmit="return validateForm()">
                            <!-- Họ tên -->
                            <div class="form-group">
                                <label for="inputFullName">Họ tên</label>
                                <input type="text" id="inputFullName" name="fullname" placeholder="Vui lòng nhập họ tên" required
                                       minlength="3" class="input-field" value="<%= user.getFullname() != null ? user.getFullname() : ""%>">
                            </div>
                            <!-- Tên đăng nhập -->
                            <div class="form-group">
                                <label for="inputUsername">Tên đăng nhập</label>
                                <input type="text" id="inputUsername" name="username" placeholder="Vui lòng nhập tên đăng nhập" required
                                       minlength="3" class="input-field" value="<%= user.getUsername() != null ? user.getUsername() : ""%>">
                            </div>
                            <!-- Số điện thoại -->
                            <div class="form-group">
                                <label for="inputPhone">Số điện thoại</label>
                                <input type="text" id="inputPhone" name="phone" placeholder="Vui lòng nhập số điện thoại" required
                                       minlength="10" maxlength="11" class="input-field" value="<%= user.getPhone() != null ? user.getPhone() : ""%>">
                            </div>
                            <!-- Email -->
                            <div class="form-group">
                                <label for="inputEmail">Email</label>
                                <input type="email" id="inputEmail" name="email" placeholder="Vui lòng nhập email" required
                                       class="input-field" value="<%= user.getEmail() != null ? user.getEmail() : ""%>">
                            </div>
                            <!-- Mật khẩu -->
                            <div class="form-group">
                                <label for="password">Mật khẩu</label>
                                <input type="password" id="password" name="password" placeholder="Vui lòng nhập mật khẩu" required
                                       minlength="6" class="input-field">
                            </div>

                            <!-- Xác nhận mật khẩu -->
                            <div class="form-group">
                                <label for="re-password">Xác nhận mật khẩu</label>
                                <input type="password" id="re-password" name="re-pass" placeholder="Vui lòng xác nhận lại mật khẩu" required
                                       minlength="6" class="input-field">
                            </div>

                            <!-- Lựa chọn loại tài khoản (Tìm kiếm hoặc Chính chủ) -->

                            <div class="form-group">
                                <div class="radio-group">
                                    <label class="account-type">Loại tài khoản</label>
                                    <input type="radio" id="user_type_guest" name="user_type" value="1" <%= user.getRole() == 1 ? "checked" : ""%> required>
                                    <label for="user_type_guest">Tìm kiếm</label>
                                    <input type="radio" id="user_type_owner" name="user_type" value="2" <%= user.getRole() == 2 ? "checked" : ""%>>
                                    <label for="user_type_owner">Chính chủ</label>
                                </div>
                            </div>

                            <!-- Hiển thị lỗi nếu có -->
                            <p><%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%></p>        

                            <!-- Nút tạo tài khoản -->
                            <div class="form-group">
                                <button type="submit" class="custom-btn">Tạo tài khoản</button>
                            </div>
                        </form>

                        <!-- Điều khoản và bản quyền -->
                        <p class="copyright">
                            Khi đăng ký, bạn đồng ý với <a href="/terms-of-use">quy định sử dụng</a> và <a href="/privacy-policy">chính sách bảo mật</a> của chúng tôi.
                        </p>
                        <p class="copyright">Bản quyền © 2024 - 2025 PhongTroG1.com</p>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>