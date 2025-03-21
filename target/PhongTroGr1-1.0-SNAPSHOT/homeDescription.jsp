<%-- 
    Document   : homeDescription
    Created on : Mar 20, 2025, 1:22:57 AM
    Author     : Admin
--%>

<%@page import="model.Image"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Post post = (Post) request.getAttribute("post");
%>
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
        <div class="home-description">
            <div class="description">
                <div id="carousel_Photos" class="carousel bg-white shadow-sm " data-bs-touch="true">
                    <div class="carousel-inner bg-dark rounded-top">
                        <%for (Image img : post.getImages()) {
                        %>
                        <div class="carousel-item" data-bs-toggle="offcanvas" data-bs-target="#offcanvasPhotos"
                             aria-controls="offcanvasPhotos">
                            <img alt="" class="lazy" src="ImageHandler?action=display&imgId=<%= img.getImageId()%>">
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div
                        class="carousel-indicators position-relative d-none d-lg-flex flex-wrap p-2 m-0 border-top rounded-bottom">
                        <%for (Image img : post.getImages()) {
                        %>
                        <button class="active" type="button" data-bs-target="#carousel_Photos" data-bs-slide-to="0"
                                aria-current="true" aria-label="Slide 1">
                            <img class="lazy size-60" src="ImageHandler?action=display&imgId=<%= img.getImageId()%>" alt="Đi đến slide 1">
                        </button>
                        <%
                            }
                        %>
                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#carousel_Photos"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Slide trước</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carousel_Photos"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Slide tiếp theo</span>
                    </button>
                </div>

                <div class="listing">
                    <header class="listing-header">
                        <h1 class="listing-title"><%= post.getTitle()%></h1>
                        <address class="listing-address">
                            <i class="icon-location"></i>
                            <%= post.getAddress()%>
                        </address>
                        <div class="listing-info">
                            <div class="info-details">
                                <span class="price"><%= post.getPrice()%> vnd/tháng</span>
                                <span class="dot">•</span>
                                <span class="size"><%= post.getArea()%> m<sup>2</sup></span>
                                <span class="dot">•</span>
                                <time class="update-time">Cập nhật: 8 giờ trước</time>
                            </div>
                            <div class="listing-id">Mã tin: #676255</div>
                        </div>
                    </header>
                    <div class="description-container">
                        <h2 class="description-title"><%= post.getDescription()%></h2>
                        <p>Cho thuê phòng cửa sổ tầng trệt</p>
                        <p>Giờ tự do, cổng vân tay</p>
                        <p>Gần ĐHCN, gần chợ Gò Vấp</p>
                        <p>Số nhà 36 Thích Bửu Đăng, P1, Gò Vấp</p>
                        <p><strong>Liên hệ:</strong> <span class="contact-number"><%= post.getUser().getPhone()%></span></p>
                    </div>
                    <div class="featured">
                        <h2 class="mb-3 featured-title">Nổi bật</h2>
                        <div class="row">
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Đầy đủ nội thất
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có gác
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có kệ bếp
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có máy lạnh
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có máy giặt
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có tủ lạnh
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có thang máy
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Không chung chủ
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Giờ giấc tự do
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có bảo vệ 24/24
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1">
                                    <i class="bi bi-check-circle-fill"></i>
                                    Có hầm để xe
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="description-contact">
                        <h2 class="contact-title">Thông tin liên hệ</h2>
                        <div class="contact-info">
                            <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%= post.getUser().getUserId()%>" alt="Anh Thanh">
                            <div class="contact-details">
                                <div class="contact-name-status">
                                    <div class="contact-name"><%= post.getUser().getFullname()%></div>
                                    <div class="contact-status">
                                        <i class="status-indicator"></i>
                                        <span>Đang hoạt động</span>
                                    </div>
                                </div>
                                <div class="contact-meta">
                                    2 tin đăng <span class="dot">•</span> Tham gia từ: 19/03/2025
                                </div>
                                <div class="contact-actions">
                                    <a class="contact-button phone-button" href="tel:0854453340">
                                        <i class="bi bi-telephone-forward"></i>&nbsp; <%=post.getUser().getPhone()%>
                                    </a>
                                    <a class="contact-button zalo-button" href="https://zalo.me/<%=post.getUser().getPhone()%>" target="_blank"
                                       rel="nofollow">
                                        <i class="bi bi-chat-dots"></i>&nbsp;Nhắn Zalo
                                    </a>
                                </div>
                                <button class="secondary-button">
                                    <i class="bi bi-share"></i>&nbsp; Chia sẻ
                                </button>
                                <button class="secondary-button">
                                    <i class="bi bi-exclamation-triangle"></i>&nbsp; Báo xấu
                                </button>
                                <%
                                    if (user.getRole() == 3 && post.getStatus().equalsIgnoreCase("Chưa duyệt")) {
                                %>
                                <form action="" class="float-end">
                                    <button type="submit" class="btn btn-secondary" id="submit"><i
                                            class="bi bi-bookmark-check-fill"></i>
                                        Duyệt bài</button>
                                    <button type="submit" class="btn btn-danger" id="submit"><i class="bi bi-trash"></i> Xóa
                                        bài</button>
                                </form>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="comment">
                    <h3 class="comment-title">0 Bình luận</h3>
                    <div class="comment-box">
                        <input type="text" class="comment-input" placeholder="Nhập nội dung bình luận">
                        <span class="char-count">0/3000</span>
                        <button class="comment-button">Gửi bình luận</button>
                    </div>
                    <div class="no-comment">
                        <i class="bi bi-chat-left-dots-fill"></i>
                        <p>Chưa có bình luận của khách hàng về bài viết này!</p>
                    </div>
                    <!-- <div class="have-comment">
                        <div class="comment-info">
                            <img class="avatar" src="./images/default_user.svg" alt="Anh Thanh">
                            <span class="comment-name">VÕ THỊ THU HÀ</span>
                            <span class="comment-time"> •  16 ngày trước</span>
                        </div>
                        <div class="comment-content">
                            <p>Nhà trọ này sạch sẽ và bà chủ thì dễ thương lắm </p>
                        </div>
                        <div class="comment-actions">
                            <button class="like-btn"><i class="bi bi-heart-fill"></i> 0</button>
                            <button class="reply-btn"><i class="bi bi-reply"></i> Trả lời</button>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <script src="./js/homeDescription.js"></script>
    </body>
</html>