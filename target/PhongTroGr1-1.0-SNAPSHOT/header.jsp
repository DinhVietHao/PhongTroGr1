<%-- 
    Document   : home
    Created on : Feb 6, 2025, 10:23:56 AM
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
        <header class="header">
            <div class="container-xl">
                <div class="col-md-12 header-content">
                    <div class="header-logo">
                        <a href="home.jsp">
                            <img src="images/logo.gif" alt="Logo">
                        </a>
                    </div>
                    <div class="header-search">
                        <img class="icon" src="./images/location-pin.svg" alt="location">
                        Tìm theo khu vực
                    </div>
                    <div class="header-filter">
                        <button class="btn-filter"> <img class="icon" src="./images/bi-funnel.svg" alt="funnel"><span>Bộ
                                lọc</span></button>
                    </div>
                    <div class="header-manager">
                        <a href="./login.jsp">
                            <img src="./images/bi-folder.svg" alt="folder"> Quản lý
                        </a>
                    </div>
                    <div class="dropdown">
                        <img class="avatar" src="./images/default_user.svg" alt="user">
                        <button class="dropdown-btn">Tài khoản</button>
                        <div class="dropdown-menu">
                            <a href="./register.jsp"><img class="icon-one" src="./images/bi-register.svg" alt="register"> Tạo tài khoản mới</a>
                            <a href="./login.jsp"><img class="icon-one" src="./images/bi-login.svg" alt="login"> Đăng nhập</a>
                        </div>
                    </div>
                    <div class="header-post">
                        <a href="">
                            <img src="./images/bi-posting-white.svg" alt=""> Đăng tin
                        </a>
                    </div>
                </div>
                <div class="menu">
                    <ul class="menu-content col-md-12">
                        <li>
                            <a title="Cho thuê phòng trọ" href="">Phòng trọ</a>
                        </li>
                        <li>
                            <a title="Cho thuê nhà nguyên căn" href="">Nhà nguyên căn</a>
                        </li>
                        <li>
                            <a title="Cho thuê căn hộ chung cư" href="">Căn hộ chung cư</a>
                        </li>
                        <li>
                            <a title="Cho thuê căn hộ mini" href="">Căn hộ mini</a>
                        </li>
                        <li>
                            <a title="Cho thuê căn hộ dịch vụ" href="">Căn hộ dịch vụ</a>
                        </li>
                        <li>
                            <a title="Tìm người ở ghép" href="">Ở ghép</a>
                        </li>
                        <li>
                            <a title="Cho thuê mặt bằng" href="">Mặt bằng</a>
                        </li>
                        <li>
                            <a title="Blog" href="">Blog</a>
                        </li>
                        <li>
                            <a title="Bảng giá dịch vụ" href="">Bảng giá dịch vụ</a>
                        </li>
                    </ul>
                </div>
            </div>
        </header>
        <script src="./js/codeme.js"></script>
    </body>
</html>
