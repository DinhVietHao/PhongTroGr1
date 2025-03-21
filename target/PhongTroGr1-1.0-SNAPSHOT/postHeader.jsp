<%-- 
    Document   : post-header
    Created on : Mar 13, 2025, 9:48:10 PM
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
        <div class="post-sticky">
            <div class="post">
                <h1 class="fs-3 fw-semibold text-nowrap mb-1">Quản lý tài khoản</h1>
            </div>
            <nav class="nav">
                <ul class="post-navbar">
                    <li id="itemClick3" class="nav-item add-click">
                        <a class="nav-link active" href="accountManagement.jsp">Thông tin cá nhân</a>
                    </li>
                    <li id="itemClick4" class="nav-item add-click">
                        <a class="nav-link" href="changeEmail.jsp">Đổi email</a>
                    </li>
                    <li id="itemClick5" class="nav-item add-click">
                        <a class="nav-link" href="changePassword.jsp">Đổi mật khẩu</a>
                    </li>
                    <li id="itemClick16" class="nav-item add-click">
                        <a class="nav-link" href="changeInformation.jsp">Đổi thông tin cá nhân</a>
                    </li>
                </ul>
            </nav>
        </div>
    </body>
</html>
