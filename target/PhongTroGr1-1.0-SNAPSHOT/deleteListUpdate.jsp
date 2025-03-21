<%-- 
    Document   : deleteListUpdate
    Created on : Mar 15, 2025, 3:30:36 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <div class="post-sticky">
                <div class="post">
                    <h1 class="fs-3 fw-semibold text-nowrap mb-1">Danh sách xóa</h1>
                </div>
            </div>
            <div class="list-post-update">
                <p><i class="bi bi-arrow-return-right"></i> Bạn chắc chắn xóa bài đăng tên <b class="p_name">Minh Kha</b> với STT <b class="p_id">1</b> này không?</p>
                <form method="POST" action="Product?action=update">
                    <input type="text" name="id" value="" hidden />
                    <div class="mb-3"> 
                        <label class="form-label">STT</label>
                        <input id="pId" type="text" name="pId" class="form-control" required value="" disabled >
                    </div>
                    <div class="mb-3"> 
                        <label class="form-label">Người đăng</label>
                        <input id="pName" type="text" name="pName" class="form-control" required value="">
                    </div>
                    <div class="mb-3"> 
                        <label class="form-label">Tiêu đề</label>
                        <input id="pPrice" type="text" name="pPrice" min="0" step="any" class="form-control" required value="">
                    </div>
                    <div class="mb-3"> 
                        <label class="form-label">Mô tả</label>
                        <input id="pQuantity" type="text" name="pQuantity" class="form-control" required value="">
                    </div>
                    <div class="mb-3"> 
                        <label class="form-label">Hình ảnh</label>
                        <input id="pDescription" type="text"  name="pDescription" class="form-control" required value="">
                    </div>
                    <div class="mb-3"> 
                        <label class="form-label">Giá tiền</label>
                        <input id="pDescription" type="number" min="0"  name="pDescription" class="form-control" required value="">
                    </div>
                    <div class="mb-3"> 
                        <label class="form-label">Danh mục</label>
                        <input id="pDescription" type="text"  name="pDescription" class="form-control" required value="">
                    </div>

                    <a href="./listPost.jsp" id="back" class="btn btn-secondary"><i class="bi bi-arrow-return-left"></i> Trở về</a>
                    <button type="submit" class="btn btn-primary" id="submit"><i class="bi bi-tools"></i> Xóa </button>
                </form>
            </div>
        </main>
    </body>
</html>
