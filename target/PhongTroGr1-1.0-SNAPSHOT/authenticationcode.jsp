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
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="room-list">          
            <c:forEach var="room" items="${rooms}">
                <div class="card">
                    <div class="image-gallery">
                        <!-- Ảnh chính -->
                        <div class="images-main">
                            <img src="${room.images[0]}" alt="Room Image" class="room-main" onclick="openImage(this)">
                        </div>

                        <!-- Ảnh phụ -->
                        <div class="images-sub">
                            <div class="images-box1">
                                <img src="${room.images[1]}" alt="Room Image" class="room-image1" onclick="openImage(this)">
                            </div>
                            <div class="images-box2">
                                <div class="box1">
                                    <img src="${room.images[2]}" alt="Room Image" class="room-image2" onclick="openImage(this)">
                                </div>
                                <div class="box2">
                                    <img src="${room.images[3]}" alt="Room Image" class="room-image3" onclick="openImage(this)">
                                </div>
                            </div>
                        </div>
                        <div id="imagePopup" class="image-popup" onclick="closeImage()">
                            <span class="close-btn" onclick="closeImage()">&#10006;</span>
                            <img id="popupImg" src="">
                        </div>
                    </div>

                    <div class="card-content">
                        <h2 class="card-title"><span class="star star-5 mt-1"></span> ${room.title}</h2>
                        <div class="card-info">
                            <p class="card-price">${room.price}</p>
                            · 
                            <p>${room.area}</p>
                            ·
                            <p>${room.address}</p>
                        </div>

                        <p class="card-details">${room.description}</p>
                        <div class="contact-info">
                            <div class="contact-user">
                                <img class="avatar" src="./images/default_user.svg" alt="user">
                                ${room.contactName}
                            </div>
                            <div class="contact-phone">
                                <span class="phone">${room.contactPhone}</span>
                                <button class="btn btn-white btn__save d-flex px-2 js-btn-save
                                        ${fn:contains(savedPosts, room.id) ? 'saved' : ''}"
                                        aria-label="Lưu tin này">
                                    <i class="heart size-18"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!--Table quen xac thuc OTP (Khang)-->

        <div class="card shadow p-4 card-forgot-password">
            <h4 class="text-center mb-3 text-danger">Mã Xác Thực</h4>
            <p class="text-muted text-center">Mã xác thực đã được gửi về: <strong>${sessionScope.email}</strong> </p>

            <form id="forgotPasswordForm" action="#" method="post">
                <div class="mb-3">
                    <label for="authencation" class="form-label">Code:</label>

                    <input type="number" pattern="[0-9]*" inputmode="numeric" class="form-control no-spinner" id="authencation" placeholder="Nhập mã xác thực" required>

                </div>
                <a class="btn btn-primary w-100 text-decoration" href="./login.jsp">Xác Nhận</a>
            </form>

            <div class="mt-3 text-center">
                <a href="./register.jsp">Quay lại đăng ký</a>
            </div>
        </div>

        <script>
            document.getElementById("forgotPasswordForm").addEventListener("submit", function (event) {
                event.preventDefault();
            });
        </script>

    </body>
</html>
