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



        <!--Table dat lai mat khau (Khang)-->

        <div class="card shadow p-4 card-reset-password">
            <h4 class="text-center mb-3 text-danger">Đặt Lại Mật Khẩu</h4>
            <p class="text-muted text-center">Nhập mật khẩu mới của bạn</p>

            <form action="ResetPasswordController" method="post">
                <div class="mb-3">
                    <label for="newPassword" class="form-label">Mật Khẩu Mới:</label>
                    <input type="password" class="form-control" name="newPassword" placeholder="Nhập mật khẩu mới" required>
                </div>

                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Xác Thực Mật Khẩu Mới:</label>
                    <input type="password" class="form-control" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                </div>

                <!--<button type="submit" class="btn btn-danger w-100">Xác Nhận</button>-->
                <a href="./login.jsp" class="btn btn-danger w-100 text-decoration">Xác Nhận</a>

            </form>

            <div class="mt-3 text-center">
                <a href="./forgotpass.jsp">Quay lại đăng nhập</a>
            </div>
        </div>




    </body>
</html>
