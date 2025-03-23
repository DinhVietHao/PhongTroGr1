<%-- 
    Document   : approvedList
    Created on : Mar 23, 2025, 10:35:14 PM
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="model.Post"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    List<Post> listPostAccept = (List) request.getAttribute("listPostAccept");
    List<Post> listPostNotApproved = (List) request.getAttribute("listPostNotApproved");
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
        <link rel="stylesheet" href="./css/discribe.css"/>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <%@include file="listPost.jsp" %>
            <% if ((listPostAccept == null || listPostAccept.isEmpty()) && (listPostNotApproved == null || listPostNotApproved.isEmpty())) { %>
            <p>Bạn chưa đăng bài nào, hãy đăng bài để thấy bài đăng của bạn.</p>
            <%} else {
            %>
            <%!
                NumberFormat formatter = NumberFormat.getInstance(Locale.GERMANY);
            %>
            <%
                if (listPostAccept == null || listPostAccept.isEmpty()) {
            %>
            <p>Bài đăng đang được duyệt, chờ admin duyệt nhé.</p>
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
                        int tmp = 0;
                        for (Post post : listPostAccept) {%>
                    <tr>
                        <td><%=++tmp%></td>
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
                    <%}%>
                </tbody>
            </table>
        </div>
        <%
                }
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
