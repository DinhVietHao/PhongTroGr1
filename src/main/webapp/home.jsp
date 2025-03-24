<%-- 
    Document   : home
    Created on : Feb 6, 2025, 1:35:18 PM
    Author     : Admin
--%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.Duration"%>
<%@page import="model.Image"%>
<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String Messages = (String) session.getAttribute("Messages");
    if (Messages != null) {
%>
<div class="alert alert-success" role="alert">
    <%= Messages%>
</div>
<%
        session.removeAttribute("Messages");
    }

    int countPost = 0;
    if (request.getAttribute("count") != null) {
        countPost = (int) request.getAttribute("count");
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">
        <!-- boostrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/style.css"/>
        <style>
            .js-btn-save .heart {
                background: url(../images/bi-heart.svg) center no-repeat;
                background-size: contain;
            }
            .js-btn-save .saved .heart {
                background: url(../images/bi-heart-fill.svg) center no-repeat;
                background-size: contain;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="background-home">
            <main class="main-content">
                <header class="layout-header">
                    <h1 class="title">Kênh thông tin Phòng trọ G1 FPT</h1>
                    <%List<Post> listPost = (List) request.getAttribute("listPost");
                        if (listPost == null) {
                            response.sendRedirect("Home");
                            return;
                        }
                        if (listPost.isEmpty()) {%>
                    <p>Không có bài đăng nào!</p>
                    <%} else {%>
                    <p class="subtitle">Có <%= countPost%> tin đăng cho thuê</p>
                </header>
                <div class="layout-filter">
                    <a class="filter-link active-filter active" href="#">Mới đăng</a>
                </div>
                <div id="contentPost" class="room-list">          
                    <%
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        LocalDateTime now = LocalDateTime.now();
                        for (Post list : listPost) {
                            LocalDateTime createdAt = list.getCreated_at().toLocalDateTime();
                            Duration duration = Duration.between(createdAt, now);
                            long days = duration.toDays();
                            long hours = duration.toHours() % 24;
                            long minutes = duration.toMinutes() % 60;
                            String timeAgo;
                            if (days >= 7) {
                                timeAgo = (days / 7) + " tuần trước";
                            } else if (days > 0) {
                                timeAgo = days + " ngày trước";
                            } else if (hours > 0) {
                                timeAgo = hours + " giờ trước";
                            } else {
                                timeAgo = minutes + " phút trước";
                            }
                            if (list.getStatus().equalsIgnoreCase("Còn Phòng")) {
                    %>
                    <div class="card">
                        <div class="image-gallery">
                            <!-- Ảnh chính -->
                            <div class="images-main">
                                <img src="ImageHandler?action=display&imgId=<%=  list.getImages().get(0).getImageId()%>" alt="Room Image" class="room-main" onclick="openImage(this)">
                            </div>

                            <!--Ảnh phụ--> 
                            <div class="images-sub">
                                <div class="images-box1">
                                    <img src="ImageHandler?action=display&imgId=<%= list.getImages().get(1) != null ? list.getImages().get(1).getImageId() : ""%>" alt="Room Image" class="room-image1" onclick="openImage(this)">
                                </div>
                                <div class="images-box2">
                                    <div class="box1">
                                        <img src="ImageHandler?action=display&imgId=<%= list.getImages().get(2) != null ? list.getImages().get(2).getImageId() : ""%>" alt="Room Image" class="room-image2" onclick="openImage(this)">
                                    </div>
                                    <div class="box2">
                                        <img src="ImageHandler?action=display&imgId=<%= list.getImages().get(3) != null ? list.getImages().get(3).getImageId() : ""%>" alt="Room Image" class="room-image3" onclick="openImage(this)">
                                    </div>
                                </div>
                            </div>

                            <div id="imagePopup" class="image-popup" onclick="closeImage()">
                                <span class="close-btn" onclick="closeImage()">&#10006;</span>
                                <img id="popupImg" src="">
                            </div>
                        </div>
                        <div class="card-content">
                            <a href="Post?action=postDescription&postId=<%= list.getPostId()%>">
                                <h2 class="card-title"><span class="star star-5 mt-1"></span> <%= list.getTitle()%></h2>
                                <div class="card-info">
                                    <%!
                                        NumberFormat formatter = NumberFormat.getInstance(Locale.GERMANY);
                                    %>
                                    <%
                                        DecimalFormat df = new DecimalFormat("#,###");
                                        String formattedPrice = df.format(list.getPrice()) + " Vnd/tháng";
                                    %>

                                    <p class="card-price"><%= formattedPrice%></p>
                                    <span class="dot">•</span>
                                    <p><%= list.getArea()%> m<sup>2</sup></p>
                                    <span class="dot">•</span>
                                    <p><%= list.getAddress()%></p>
                                </div>
                                <p class="post-date"> <i class="bi bi-signpost"></i> Đăng <%= timeAgo%></p>
                            </a>
                            <div class="contact-info">
                                <a href="Post?action=postDescription&postId=<%= list.getPostId()%>">
                                    <div class="contact-user">
                                        <% if (list.getUser().getImageData() != null) {%>
                                        <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%= list.getUserId()%>" alt="avatar">
                                        <% } else { %>  
                                        <img class="avatar" src="./images/default_user.svg" alt="avatar">
                                        <% }%> <span class="color-font"><%= list.getUser().getFullname()%></span>
                                    </div>
                                </a>
                                <div class="contact-phone">
                                    <%
                                        if (user.getRole() == 3) {
                                    %>
                                    <button class="delete" onclick="confirmDelete(<%= list.getPostId()%>)">Xóa</button>
                                    <%
                                        }
                                    %>
                                    <span class="phone"><%= list.getUser().getPhone()%></span>
                                    <% if (user.getUserId() != -1) {%>
                                    <button 
                                        onclick="savePost(event)" 
                                        class="btn btn-white btn__save d-flex px-2 js-btn-save <%= list.isSavedStatus() ? "saved" : ""%>" 
                                        aria-label="Lưu tin này" 
                                        data-postid="<%= list.getPostId()%>" 
                                        data-userid="<%= user.getUserId()%>">
                                        <i class="heart size-18"></i>
                                    </button>
                                    <%}%>
                                </div>
                            </div>
                            <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="confirmDeleteLabel">Xác nhận xóa</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            Bạn có chắc chắn muốn xóa bài đăng này không?
                                        </div>
                                        <div class="modal-button">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Quay lại</button>
                                            <form id="deletePostForm" method="post" action="Admin">
                                                <input type="hidden" name="action" value="deletePost">
                                                <input type="hidden" name="postId" id="deletePostId">
                                                <button type="submit" class="btn btn-danger">Xóa</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>                
                        </div>
                    </div>
                    <%
                            }
                        }
                    %>
                    <!-- Phần phân trang -->
                    <c:if test="${endPage > 1}">
                        <ul class="pagination">
                            <li class="page-item ${page == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="Home?page=${page - 1}">&laquo; Trang trước</a>
                            </li>
                            <c:forEach begin="1" end="${endPage}" var="i">
                                <li class="page-item ${page == i ? 'active' : ''}">
                                    <a class="page-link" href="Home?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${page == endPage ? 'disabled' : ''}">
                                <a class="page-link" href="Home?page=${page + 1}">Trang sau &raquo;</a>
                            </li>
                        </ul>
                    </c:if>
                    <%
                        }
                    %>
                </div>
            </main>
        </div>
                
        <!--SUPPORT-->         
        <button class="btn support-button " type="button" data-bs-toggle="offcanvas"
                data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"><i class="bi bi-chat-dots-fill"></i></button>

        <div class="support">
            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="offcanvasRightLabel">Hỗ trợ chủ nhà đăng tin</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body text-center">
                    <img src="./images/contact2.jpg" alt="Support" class="mx-auto mb-4">
                    <p class="text-gray-600 text-sm">Nếu bạn cần hỗ trợ đăng tin, vui lòng liên hệ số điện thoại bên dưới:
                    </p>
                    <div class="mt-4 space-y-2">
                        <a href="tel:0854453340" class="d-block btn btn-danger mb-3">📞 ĐT: 0854453340</a>
                        <a href="https://zalo.me/0854453340" class="d-block btn btn-info mb-3">💬 Zalo: 0854453340</a>
                    </div>

                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <script>

            function savePost(isSaved, userId, postId) {
                const url = isSaved ? "/PhongTroGr1/Post?action=deletePost" : "/PhongTroGr1/Post?action=savePost";

                $.ajax({
                    url: url,
                    type: "GET",
                    data: {
                        postId: postId,
                        userId: userId
                    },
                    success: function () {
                        console.log("Lưu/Hủy lưu thành công");
                        const saveButton = document.querySelector(`.js-btn-save[data-postid="${postId}"]`);
                        if (saveButton) {
                            saveButton.classList.toggle("saved");
                        }
                    }
                });
            }

            document.addEventListener("click", function (event) {
                if (event.target.closest(".js-btn-save")) {
                    event.preventDefault();
                    const saveButton = event.target.closest(".js-btn-save");
                    const isSaved = saveButton.classList.contains("saved");
                    const postId = saveButton.getAttribute("data-postid");
                    const userId = saveButton.getAttribute("data-userid");

                    savePost(isSaved, userId, postId);
                    saveButton.classList.toggle("saved");
                }
            });

            function openImage(img) {
                let popup = document.getElementById("imagePopup");
                let popupImg = document.getElementById("popupImg");
                popupImg.src = img.src;
                popup.classList.add("show");
            }

            function closeImage() {
                document.getElementById("imagePopup").classList.remove("show");
            }

            function confirmDelete(postId) {
                document.getElementById("deletePostId").value = postId;
                var deleteModal = new bootstrap.Modal(document.getElementById('confirmDeleteModal'));
                deleteModal.show();
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    </body>
</html>