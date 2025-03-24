<%-- 
    Document   : PendingList
    Created on : Mar 23, 2025, 10:33:16 PM
    Author     : Admin
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Post> listPostNotApproved = (List) request.getAttribute("listNotApproved");
%>
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
        <link rel="stylesheet" href="./css/discribe.css"/>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <%@include file="listPost.jsp" %>
            <%!
                NumberFormat formatter = NumberFormat.getInstance(Locale.GERMANY);
            %>

            <h2>Danh sách bài đang duyệt</h2>
            <%if (listPostNotApproved == null || listPostNotApproved.isEmpty()) {
            %>
            <p>Bạn chưa có bài đăng nào chờ duyệt.</p>
            <%
            } else {
            %>
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>STT</th>
                        <th>Tiêu đề</th>
                        <th>Mô tả</th>
                        <th>Hình ảnh</th>
                        <th>Giá tiền Vnd/Tháng</th>
                        <th>Danh mục</th>
                        <th>Trạng Thái</th>
                        <th>Bài đăng chi tiết</th>
                        <th>Chức năng</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int res = 0;
                        for (Post post : listPostNotApproved) {%>
                    <tr>
                        <td><%=++res%></td>
                        <td><%=post.getTitle()%></td>
                        <td><span class="description" data-description="<%= post.getDescription()%>">Xem mô tả</span></td>
                        <td><img src="ImageHandler?action=display&imgId=<%= post.getImages().get(1).getImageId()%>" class="product-img" width="100" height="80"></td>

                        <%
                            DecimalFormat df = new DecimalFormat("#,###");
                            String formattedPrice = df.format(post.getPrice());
                        %>
                        <td><%= formattedPrice%></td>
                        <td><%= post.getPostType().getCatName()%></td>
                        <td><%= post.getStatus()%></td>
                        <td><a href="Post?action=postDescription&postId=<%= post.getPostId()%>">Bài đăng chi tiết</a></td>
                        <td>
                            <a href="Post?action=updatePost&postId=<%= post.getPostId()%>" class="btn btn-warning"><i class="bi bi-tools"></i> Sửa</a>
                            <a href="#" class="btn btn-danger delete-btn"
                               data-bs-toggle="modal"
                               data-bs-target="#deleteModal"
                               data-postid="<%= post.getPostId()%>">
                                <i class="bi bi-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                }
            %>
        </main>
        <div class="describe" id="modalOverlay">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thông tin mô tả nhà trọ</h5>
                    <button class="close-modal" id="closeModal">&times;</button>
                </div>
                <div class="modal-body" id="modalBody">
                </div>
            </div>
        </div>
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Xác nhận xóa</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Bạn có chắc chắn muốn xóa bài đăng này không?
                    </div>
                    <div class="modal-button">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <form id="deleteForm" method="POST" action="Post">
                            <input type="hidden" name="action" value="deletePost">
                            <input type="hidden" id="deletePostId" name="postId">
                            <button type="submit" class="btn btn-danger">Xóa</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const deleteButtons = document.querySelectorAll(".delete-btn");
                const deletePostId = document.getElementById("deletePostId");

                deleteButtons.forEach(button => {
                    button.addEventListener("click", function () {
                        let postId = this.getAttribute("data-postid");
                        deletePostId.value = postId; // Gán postId vào input hidden
                    });
                });
            });
        </script>
        <script src="./js/describe.js"></script>
    </body>
</html>
