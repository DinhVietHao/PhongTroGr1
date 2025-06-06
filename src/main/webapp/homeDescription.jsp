<%-- 
    Document   : homeDescription
    Created on : Mar 20, 2025, 1:22:57 AM
    Author     : Admin
--%>

<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.Duration"%>
<%@page import="dao.PostDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Review"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@page import="model.Image"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    PostDAO postDao = new PostDAO();
    Post post = (Post) request.getAttribute("post");
    if (post == null) {
        response.sendRedirect("Home");
        return;
    }

    List<Review> listReview = (List<Review>) request.getAttribute("list");
    if (listReview == null) {
        listReview = new ArrayList<>();
    }

    int countPost = 0;
    if (request.getAttribute("countPost") != null) {
        countPost = (int) request.getAttribute("countPost");
    }
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
                        <h1 class="listing-title"><i class="bi bi-house-check"></i> <%= post.getTitle()%></h1>
                        <address class="listing-address">
                            <i class="bi bi-geo-alt"></i>&nbsp; 
                            <%= post.getAddress()%>
                        </address>
                        <div class="listing-info">
                            <div class="info-details">
                                <%!
                                    NumberFormat formatter = NumberFormat.getInstance(Locale.GERMANY);
                                %>
                                <%
                                    DecimalFormat df = new DecimalFormat("#,###");
                                    String formattedPrice = df.format(post.getPrice()) + " Vnd/tháng";
                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                                    LocalDateTime now = LocalDateTime.now();
                                    LocalDateTime createdAtPost = post.getCreated_at().toLocalDateTime();
                                    Duration durationPost = Duration.between(createdAtPost, now);
                                    long day = durationPost.toDays();
                                    long hour = durationPost.toHours() % 24;
                                    long minute = durationPost.toMinutes() % 60;
                                    String timeAgos;
                                    if (day >= 7) {
                                        timeAgos = (day / 7) + " tuần trước";
                                    } else if (day > 0) {
                                        timeAgos = day + " ngày trước";
                                    } else if (hour > 0) {
                                        timeAgos = hour + " giờ trước";
                                    } else {
                                        timeAgos = minute + " phút trước";
                                    }
                                %>
                                <span class="price"><%=formattedPrice%></span>
                                <span class="dot">•</span>
                                <span class="size"><%= post.getArea()%> m<sup>2</sup></span>
                                <span class="dot">•</span>
                                <time class="update-time">Cập nhật: <%= timeAgos%></time>
                            </div>
                            <div class="listing-id">Mã tin: #<%= post.getPostId()%></div>
                        </div>
                    </header>
                    <div class="description-container">
                        <h2 class="description-title">Thông tin mô tả</h2>
                        <p><%= post.getDescription().replace("\n", "<br>")%></p>
                        <p><strong>Liên hệ:</strong> <span class="contact-number"><%= post.getUser().getPhone()%></span></p>
                    </div>
                    <div class="featured">
                        <h2 class="mb-3 featured-title">Nổi bật</h2>
                        <div class="row">
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("A") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("A") ? "" : "text-secondary opacity-50"%>"></i>
                                    Đầy đủ nội thất
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("B") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("B") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có gác
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("C") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("C") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có kệ bếp
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("D") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("D") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có máy lạnh
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("E") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("E") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có máy giặt
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("F") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("F") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có tủ lạnh
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("G") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("G") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có thang máy
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("H") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("H") ? "" : "text-secondary opacity-50"%>"></i>
                                    Không chung chủ
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("I") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("I") ? "" : "text-secondary opacity-50"%>"></i>
                                    Giờ giấc tự do
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("J") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("J") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có bảo vệ 24/24
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="text-body d-flex pt-1 pb-1 <%= post.getUtilities().contains("K") ? "" : "opacity-50"%>">
                                    <i class="bi bi-check-circle-fill <%= post.getUtilities().contains("K") ? "" : "text-secondary opacity-50"%>"></i>
                                    Có hầm để xe
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="description-contact">
                        <h2 class="contact-title">Thông tin liên hệ</h2>
                        <div class="contact-info">
                            <%if (post.getUser().getImageData() != null) {%>
                            <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%= post.getUser().getUserId()%>" alt="Anh Thanh">
                            <%} else {%>
                            <img class="avatar" src="./images/default_user.svg" alt="Anh Thanh">
                            <%}%>
                            <div class="contact-details">
                                <div class="contact-name-status">
                                    <div class="contact-name color-font"><%= post.getUser().getFullname()%></div>
                                    <div class="contact-status">
                                        <i class="status-indicator"></i>
                                        <span>Đang hoạt động</span>
                                    </div>
                                </div>
                                <div class="contact-meta">
                                    <%= countPost%> tin đăng 
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
                                <!--                                <button class="secondary-button">
                                                                    <i class="bi bi-share"></i>&nbsp; Chia sẻ
                                                                </button>
                                                                <button class="secondary-button">
                                                                    <i class="bi bi-exclamation-triangle"></i>&nbsp; Báo xấu
                                                                </button>-->
                                <%
                                    if (user.getRole() == 3 && post.getStatus().equalsIgnoreCase("Chưa duyệt")) {
                                %>
                                <div action="" class="float-end">
                                    <button class="btn btn-secondary btn-sm" onclick="showApproveModal(<%= post.getPostId()%>)">
                                        <i class="bi bi-tools"></i> Duyệt bài
                                    </button>
                                    <button class="btn btn-danger btn-sm" onclick="showRejectModal(<%= post.getPostId()%>)">
                                        Từ chối
                                    </button>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="approveModal" tabindex="-1" aria-labelledby="approveModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="approveModalLabel">Xác nhận duyệt bài</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Bạn có chắc chắn muốn <strong>duyệt</strong> bài đăng này không?
                            </div>
                            <div class="modal-button">
                                <form id="approveForm" method="POST" action="Admin">
                                    <input type="hidden" name="action" value="acceptPost">
                                    <input type="hidden" id="acceptPost" name="postId">
                                    <button type="submit" class="btn btn-success">Duyệt bài</button>
                                </form>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Quay lại</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal Từ chối -->
                <div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="rejectModalLabel">Xác nhận từ chối bài</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Bạn có chắc chắn muốn <strong>từ chối</strong> bài đăng này không?
                            </div>
                            <div class="modal-button">
                                <form id="rejectForm" method="POST" action="Admin">
                                    <input type="hidden" name="action" value="rejectPost">
                                    <input type="hidden" id="rejectPostId" name="postId">
                                    <button type="submit" class="btn btn-danger">Từ chối</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Quay lại</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>        
                <%
                    if (user.getUserId() != -1) {
                %>
                <div class="comment">
                    <h3 class="comment-title"><%= listReview.size()%> Bình luận</h3>
                    <div class="comment-box">
                        <input type="text" id="commentInput" class="comment-input" placeholder="Nhập nội dung bình luận" maxlength="3000">
                        <span class="char-count">Tối đa 3000 kí tự!</span>
                        <button onclick="submitComment()" class="comment-button">Gửi bình luận</button>
                    </div>
                    <div id="contentComment">
                        <%
                            if (listReview.isEmpty()) {
                        %>
                        <div class="no-comment">
                            <i class="bi bi-chat-left-dots-fill"></i>
                            <p>Chưa có bình luận của khách hàng về bài viết này!</p>
                        </div>
                        <%
                        } else {
                            for (Review r : listReview) {
                                User u = postDao.getUserById(r.getUserId());
                                LocalDateTime createdAt = r.getCreated_at().toLocalDateTime();
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
                        %>
                        <div class="have-comment">
                            <div class="comment-info">
                                <%if (u.getImageData() != null) {%>
                                <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%=u.getUserId()%>" alt="avatar">
                                <% } else { %>  
                                <img class="avatar" src="./images/default_user.svg" alt="avatar">
                                <% }%>
                                <span class="comment-name color-font2"><%= u.getFullname()%></span>
                                <span class="comment-time"> •  <%= timeAgo%></span>
                                <button onclick="deleteComment(<%= r.getReviewId()%>)" class="delete-comment" 
                                        <% if (user.getUserId() != r.getUserId() && user.getRole() != 3) { %> 
                                        style="display: none;" 
                                        <% }%>>
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                            <div class="comment-content">
                                <p><%= r.getComment()%></p>
                            </div>
                        </div> 
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="./js/homeDescription.js"></script>
        <script>
                                    function showApproveModal(postId) {
                                        document.getElementById('acceptPost').value = postId;
                                        var approveModal = new bootstrap.Modal(document.getElementById('approveModal'));
                                        approveModal.show();
                                    }

                                    function showRejectModal(postId) {
                                        document.getElementById('rejectPostId').value = postId;
                                        var rejectModal = new bootstrap.Modal(document.getElementById('rejectModal'));
                                        rejectModal.show();
                                    }

                                    function submitComment() {
                                        const commentInput = document.getElementById("commentInput");
                                        const comment = commentInput.value.trim();

                                        if (!comment) {
                                            alert("Vui lòng nhập nội dung bình luận!");
                                            return;
                                        }

                                        if (comment.length > 3000) {
                                            alert("Bình luận không được vượt quá 3000 ký tự!");
                                            return;
                                        }

                                        var userId = <%= user.getUserId()%>;
                                        var postId = <%= post.getPostId()%>;

                                        $.ajax({
                                            url: "/PhongTroGr1/Comment",
                                            type: "POST",
                                            data: {
                                                action: "submitCom",
                                                userId: userId,
                                                postId: postId,
                                                comment: comment
                                            },
                                            success: function (data) {
                                                commentInput.value = "";
                                                var row = document.getElementById("contentComment");
                                                row.innerHTML = data;

                                                var commentCount = document.querySelectorAll(".have-comment").length;
                                                document.querySelector(".comment-title").textContent = commentCount + " Bình luận";
                                            }
                                        });
                                    }

                                    function deleteComment(reviewId) {
                                        var postId = <%= post.getPostId()%>;
                                        
                                        if (!confirm("Bạn có chắc chắn muốn xóa bình luận này?")) {
                                            return;
                                        }

                                        $.ajax({
                                            url: "/PhongTroGr1/Comment",
                                            type: "POST",
                                            data: {
                                                action: "deleteCom",
                                                reviewId: reviewId,
                                                postId: postId
                                            },
                                            success: function (data) {
                                                var row = document.getElementById("contentComment");
                                                row.innerHTML = data;

                                                var commentCount = document.querySelectorAll(".have-comment").length;
                                                document.querySelector(".comment-title").textContent = commentCount + " Bình luận";
                                            }
                                        });
                                    }
        </script>
    </body>
</html>