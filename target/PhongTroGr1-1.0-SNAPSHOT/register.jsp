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
                        <form class="register-form" action="#" method="POST">
                            <div class="form-group">
                                <label for="inputFullName">Họ tên</label>
                                <input type="text" id="inputFullName" name="fullname" placeholder="Nhập họ tên" required
                                       minlength="3" class="input-field">
                            </div>
                            <div class="form-group">
                                <label for="inputPhone">Số điện thoại</label>
                                <input type="text" id="inputPhone" name="phone" placeholder="Nhập số điện thoại" required
                                       minlength="10" maxlength="11" class="input-field">
                            </div>
                            <div class="form-group">
                                <label for="password">Mật khẩu</label>
                                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required
                                       minlength="6" class="input-field">
                            </div>
                            <div class="form-group">
                                <div class="radio-group">
                                    <label class="account-type">Loại tài khoản</label>
                                    <input type="radio" id="user_type_guest" name="user_type" value="1" required>
                                    <label for="user_type_guest">Tìm kiếm</label>
                                    <input type="radio" id="user_type_owner" name="user_type" value="2">
                                    <label for="user_type_owner">Chính chủ</label>

                                    <input type="radio" id="user_type_broker" name="user_type" value="3">
                                    <label for="user_type_broker">Môi giới</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <button type="submit" name="wp-submit-register" class="custom-btn">Tạo tài
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
