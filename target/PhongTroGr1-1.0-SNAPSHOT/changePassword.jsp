<%-- 
    Document   : change-password
    Created on : Mar 13, 2025, 9:56:26 PM
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
        <%@include file="header.jsp" %>
        <%if (user.getUserId() == -1) {
                response.sendRedirect("Home");
                return;
            }%>
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <%@include file="postHeader.jsp" %>
            <div class="post-container">
                <div class="account-management">
                    <form class="form-account" action="User?action=changePass" method="POST">
                        <input name="id" value="<%= user.getUserId()%>" hidden>
                        <div class="rounded">
                            <h2 class="fs-5 fw-semibold mb-3">Thay đổi mật khẩu</h2>
                            <div class="form-floating">
                                <input type="password" name="old_pass" id="password"
                                       class="form-control form-control-lg border-secondary-subtle" value=""
                                       placeholder="Nhập mật khẩu cũ" required>
                                <label for="password">Nhập mật khẩu cũ</label>
                                <%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%>
                            </div>
                            <div class="form-floating mt-3">
                                <input type="password" name="new_pass" id="new_password"
                                       class="form-control form-control-lg border-secondary-subtle" value=""
                                       placeholder="Nhập mật khẩu mới" required>
                                <label for="new_password">Nhập mật khẩu mới</label>
                            </div>
                            <div class="form-floating mt-3">
                                <input type="password" name="cf_password" id="re-password"
                                       class="form-control form-control-lg border-secondary-subtle" value=""
                                       placeholder="Xác nhận mật khẩu mới" required>
                                <label for="re-password">Xác nhận mật khẩu mới</label>
                            </div>
                        </div>
                        <button type="submit" class="post-button">Cập nhật</button>
                    </form>
                </div>
            </div>
        </main>
        <!-- Liên kết tới file JavaScript validation -->
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelector("form").addEventListener("submit", function (event) {
                    var newPassword = document.getElementById("new_password").value; // Mật khẩu mới
                    var rePassword = document.getElementById("re-password").value; // Xác nhận mật khẩu mới
                    var errorMessage = "";

                    // Kiểm tra mật khẩu nhập lại có khớp không
                    if (newPassword !== rePassword) {
                        errorMessage += "Mật khẩu mới và xác nhận mật khẩu mới không khớp!\n";
                    }

                    // Kiểm tra độ mạnh của mật khẩu mới
                    var passwordRegex = /^(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{6,}$/;
                    if (!newPassword.match(passwordRegex)) {
                        errorMessage += "Mật khẩu mới phải có ít nhất 6 ký tự, chứa chữ cái, số và ký tự đặc biệt!\n";
                    }

                    if (errorMessage !== "") {
                        alert(errorMessage);
                        event.preventDefault(); // Ngăn form submit nếu có lỗi
                    }
                });
            });
        </script>
    </body>
</html>
