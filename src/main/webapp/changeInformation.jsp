<%--
    Document   : changeInformation
    Created on : Mar 15, 2025, 5:04:16 PM
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
        <link rel="stylesheet" href="./css/style.css"/> 
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <%@include file="postHeader.jsp" %>
            <div class="post-container">
                <div class="account-management">
                    <form class="form-account" action="User?action=updateInfo" method="POST" enctype="multipart/form-data">
                        <div class="account-box">
                            <div class="avatar-account">
                                <%if (user.getImageData() != null) {%>
                                <img src="ImageHandler?action=displayAvatar&userId=<%=user.getUserId()%>" alt="avatar">
                                <%} else {%>  
                                <img src="./images/default_user.svg" alt="avatar">
                                <%}%>
                            </div>
                            <input type="hidden" name="userId" value="<%=user.getUserId()%>">
                        </div>

                        <!-- Chọn ảnh đại diện -->
                        <label class="w-100">
                            <input class="d-none" name="avatar" type="file" accept="image/*" />
                            <div class="btn bg-white border border-secondary-subtle d-flex w-100">
                                <i class="bi bi-camera"></i>&nbsp&nbsp Đổi ảnh đại diện
                            </div>
                        </label>
                        
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const fileInput = document.querySelector("input[name='avatar']");
                                const avatarPreview = document.querySelector(".avatar-account img");

                                fileInput.addEventListener("change", function (event) {
                                    const file = event.target.files[0];

                                    if (file) {
                                        // Kiểm tra dung lượng file
                                        if (file.size > 10 * 1024 * 1024) { // 10MB
                                            alert("Dung lượng ảnh quá lớn! Vui lòng chọn ảnh dưới 10MB.");
                                            fileInput.value = ""; // Reset input file
                                            return;
                                        }

                                        // Hiển thị ảnh trước khi upload
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            avatarPreview.src = e.target.result;
                                        };
                                        reader.readAsDataURL(file);
                                    }
                                });
                            });
                        </script>

                        <!-- Cập nhật số điện thoại -->
                        <div class="form-floating mt-3">
                            <input type="text" 
                                   class="form-control form-control-lg fs-5-5 border-secondary-subtle"
                                   name="phone" id="user_phone" placeholder="0854453340" 
                                   value="<%= user.getPhone()%>">
                            <label for="user_phone">Số điện thoại</label>
                        </div>

                        <!-- Cập nhật tên -->
                        <div class="form-floating mt-3">
                            <input type="text" class="form-control form-control-lg fs-5-5 border-secondary-subtle"
                                   id="user_name" name="fullname" value="<%= user.getFullname()%>" placeholder="Ex: Nguyễn Văn A">
                            <label for="user_name">Tên liên hệ</label>
                        </div>
                        <button type="submit" class="post-button">Cập nhật</button>
                        <%= request.getAttribute("err") != null ? request.getAttribute("err") : ""%>
                    </form>
                </div>
            </div>
        </main>
    </body>
</html>