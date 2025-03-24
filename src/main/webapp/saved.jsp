<%@page import="java.util.Locale"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (request.getAttribute("list") == null) {
        response.sendRedirect("Home");
        return;
    }
    List<Post> list = (List<Post>) request.getAttribute("list");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1 - Tin đã lưu</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">

        <!-- Bootstrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/style.css">

        <!-- jQuery (required for AJAX) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="sidebar.jsp" %>
        <main class="saved-main">
            <h2 class="saved-title color-font">Tin đã lưu</h2> <br>
            <div id="savedPost">
                <% if (list == null || list.isEmpty()) { %>
                <p>Bạn chưa có bài yêu thích nào!</p>
                <% } else {
                    for (Post post : list) {
                        String imageUrl = post.getImages().isEmpty() ? "./images/default-image.jpg"
                                : "ImageHandler?action=display&imgId=" + post.getImages().get(0).getImageId();
                        String location = post.getCity() + ", " + post.getDistrict() + ", " + post.getWard() + ", " + post.getAddress();
                %>
                <div class="saved-post" data-post-id="<%= post.getPostId()%>">
                    <div class="saved-image">
                        <img src="<%= imageUrl%>" alt="Hình ảnh tin đã lưu">
                    </div>
                    <div class="saved-post-content">
                        <h3><%= post.getTitle()%></h3>
                                    <%!
                                        NumberFormat formatter = NumberFormat.getInstance(Locale.GERMANY);
                                    %>
                                    <%
                                        DecimalFormat df = new DecimalFormat("#,###");
                                        String formattedPrice = df.format(post.getPrice()) + " Vnd/tháng";
                                    %>
                                    <p class="card-price"><%= formattedPrice%></p>
                        <p class="location"><%= location%></p>
                        <p class="description"><%= post.getDescription()%></p>
                        <div onclick="deleteSavedPost(<%= post.getPostId()%>)" class="heart float-end">
                            <img src="./images/bi-heart-fill.svg" alt="Xóa khỏi danh sách yêu thích">
                        </div>
                    </div>
                </div>
                <% }
                    }%>
            </div>
        </main>

        <script>
            function deleteSavedPost(postId) {
                const url = "/PhongTroGr1/Post?action=deleteSavedPost";
                const userId = <%= user.getUserId()%>;

                $.ajax({
                    url: url,
                    type: "POST",
                    data: {
                        postId: postId,
                        userId: userId
                    },
                    success: function (data) {
                        var row = document.getElementById("savedPost");
                        row.innerHTML = data;
                    }
                });
            }
        </script>
    </body>
</html>