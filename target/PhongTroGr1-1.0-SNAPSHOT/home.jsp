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

        <main class="main-content">
            <header class="layout-header">
                <h1 class="title">Kênh thông tin Phòng trọ G1 FPT</h1>
                <p class="subtitle">Có 69.311 tin đăng cho thuê</p>
            </header>

            <div class="layout-nav row">
                <div class="layout-links col-md-12">
                    <a class="active-tab" href="https://phongtro123.com" title="Cho thuê phòng trọ Toàn Quốc">Toàn quốc</a>
                    <a class="tab-link" href="/tinh-thanh/ho-chi-minh" title="Cho thuê phòng trọ Hồ Chí Minh">Hồ Chí Minh</a>
                    <a class="tab-link" href="/tinh-thanh/ha-noi" title="Cho thuê phòng trọ Hà Nội">Hà Nội</a>
                    <a class="tab-link" href="/tinh-thanh/da-nang" title="Cho thuê phòng trọ Đà Nẵng">Đà Nẵng</a>
                    <button class="btn-dropdown" data-bs-toggle="offcanvas" data-bs-target="#offcanvasLocation"
                            aria-controls="offcanvasLocation">
                        Khác<i class="caret-down-fill"></i>
                    </button>
                </div>        
            </div>

            <div class="layout-filter">
                <a class="filter-link active-filter" href="https://phongtro123.com/?orderby=mac-dinh">Đề xuất</a>
                <a class="filter-link" href="https://phongtro123.com/?orderby=moi-nhat">Mới đăng</a>
                <a class="filter-link" href="https://phongtro123.com/?orderby=video">Có video</a>
            </div>
        </main>

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
        <%@include file="footer.jsp" %>
        <script src="./js/home.js"></script>
    </body>
</html>
