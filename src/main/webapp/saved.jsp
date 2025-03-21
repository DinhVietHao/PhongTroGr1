<%-- 
    Document   : saved
    Created on : Mar 15, 2025, 1:49:17 PM
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    List<Post> list = (List) request.getAttribute("list");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">

        <!-- boostrap -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/style.css">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="sidebar.jsp" %>
        <main class="saved-main">
            <h2 class="saved-title color-font">Tin đã lưu</h2> <br>

            <%if (list == null || list.size() == 0) {%>
            <p>bạn chưa có bài yêu thích nào!</p>
            <%
            } else {
                for (Post post : list) {
            %>
            <div class="saved-post">
                <div class="saved-image">
                    <img src="ImageHandler?action=display&imgId=<%= post.getImages().get(0).getImageId() %>" alt="Hình ảnh tin đã lưu">
                </div>
                <div class="saved-post-content">
                    <h3><%= post.getTitle() %></h3>
                    <p class="price"><%= post.getPrice() %></p>
                    <p class="location"><%= post.getCity() + ", " + post.getDistrict() + ", " + post.getWard() + ", " + post.getAddress()%></p>
                    <p class="description"><%= post.getDescription() %></p>
                    <div class="heart float-end"><img src="./images/bi-heart-fill.svg"></div>
                </div>

            </div>

            <%
                    }
                }
            %>
        </main>
    </body>
</html>
