<%-- 
    Document   : updateListPost
    Created on : Mar 15, 2025, 3:07:32 PM
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
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <div class="post-sticky">
                <div class="post">
                    <h1 class="fs-3 fw-semibold text-nowrap mb-1">Chỉnh sửa bài đăng</h1>
                </div>
                <nav class="nav">
                    <ul class="post-navbar">
                        <li class="nav-item add-click">
                            <a class="nav-link active" href="#post-category">Khu vực</a>
                        </li>
                        <li class="nav-item add-click">
                            <a class="nav-link" href="#post-info">Thông tin mô tả</a>
                        </li>
                        <li class="nav-item add-click">
                            <a class="nav-link" href="#post-image">Hình ảnh</a>
                        </li>
                        <li class="nav-item add-click">
                            <a class="nav-link" href="#post-contact">Thông tin liên hệ</a>
                        </li>
                    </ul>
                </nav>
            </div>

            <div class="post-container">
                <div class="post-content">
                    <form id="post-from" class="post-from" method="POST" action="Post?action=updatePost&postId=<%= post.getPostId()%>" enctype="multipart/form-data">
                        <input type="hidden" name="userId" value="<%= user.getUserId()%>">
                        <input type="hidden" name="user" value="<%= user%>">
                        <div class="post-category" id="post-category">
                            <div class="title">Loại chuyên mục</div>
                            <div class="post-input">
                                <label class="label" for="loai_chuyen_muc">Loại chuyên mục
                                    <span class="required">*</span>
                                </label>
                                <select class="select" id="post_cat" name="loai_chuyen_muc" required>
                                    <option value="" selected>-- Chọn loại chuyên mục --</option>
                                    <option value="1" <%= post.getPostType().getCatId() == 1 ? "selected" : ""%>>Nhà Trọ</option>
                                    <option value="2" <%= post.getPostType().getCatId() == 2 ? "selected" : ""%>>Mini house</option>
                                    <option value="3" <%= post.getPostType().getCatId() == 3 ? "selected" : ""%>>Nhà thuê nguyên căn</option>
                                    <option value="4" <%= post.getPostType().getCatId() == 4 ? "selected" : ""%>>Căn hộ</option>

                                </select>
                            </div>
                        </div>
                        <div class="post-location">
                            <div class="title">Khu vực</div>
                            <div class="post-input">
                                <div class="input-group">
                                    <label for="province" class="label">Tỉnh/Thành phố <span class="required">*</span></label>
                                    <select id="province" name="province" class="select" required>
                                        <option value="1" selected>Cần Thơ</option>
                                    </select>
                                </div>
                                <div class="input-group">
                                    <label for="district" class="label">Quận/Huyện <span class="required">*</span></label>
                                    <select id="district" name="district" class="select" required>
                                        <option value="0">-- Chọn Quận/Huyện --</option>
                                        <option value="Ninh Kiều" <%= post.getDistrict().equalsIgnoreCase("Ninh Kiều") ? "selected" : ""%>>Ninh Kiều</option>
                                        <option value="Bình Thủy" <%= post.getDistrict().equalsIgnoreCase("Bình Thủy") ? "selected" : ""%>>Bình Thủy</option>
                                        <option value="Cái Răng" <%= post.getDistrict().equalsIgnoreCase("Cái Răng") ? "selected" : ""%>>Cái Răng</option>
                                        <option value="Ô Môn" <%= post.getDistrict().equalsIgnoreCase("Ô Môn") ? "selected" : ""%>>Ô Môn</option>
                                        <option value="Thốt Nốt" <%= post.getDistrict().equalsIgnoreCase("Thốt Nốt") ? "selected" : ""%>>Thốt Nốt</option>

                                    </select>
                                </div>
                                <div class="input-group">
                                    <label for="ward" class="label">Phường/Xã</label>
                                    <select id="ward" name="ward" class="select">
                                        <option value="0">-- Chọn Phường/Xã --</option>
                                        <option value="An Cư" <%= post.getWard().equalsIgnoreCase("An Cư") ? "selected" : ""%>>An Cư</option>
                                        <option value="An Hòa" <%= post.getWard().equalsIgnoreCase("An Hòa") ? "selected" : ""%>>An Hòa</option>
                                        <option value="An Khánh" <%= post.getWard().equalsIgnoreCase("An Khánh") ? "selected" : ""%>>An Khánh</option>
                                        <option value="An Nghiệp" <%= post.getWard().equalsIgnoreCase("An Nghiệp") ? "selected" : ""%>>An Nghiệp</option>
                                        <option value="An Phú" <%= post.getWard().equalsIgnoreCase("An Phú") ? "selected" : ""%>>An Phú</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="post-info" id="post-info">
                            <div class="title">Địa chỉ cụ thể(Tên đường, tên hẻm, số nhà...)</div>
                            <div class="row post-input">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label for="title">Nội dung<span class="required">*</span></label>
                                        <textarea id="title" name="address" rows="2" required minlength="10"
                                                  maxlength="100"><%= post.getAddress()%></textarea>
                                        <p class="char-count" id="title-count">Tối thiểu 10 ký tự, tối đa 100 ký tự</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="post-info" id="post-info">
                            <div class="title">Thông tin mô tả</div>
                            <div class="row post-input">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label for="title">Tiêu đề <span class="required">*</span></label>
                                        <textarea id="title" name="title" rows="2" required minlength="10"
                                                  maxlength="100"><%= post.getTitle()%></textarea>
                                        <p class="char-count" id="title-count">Tối thiểu 10 ký tự, tối đa 100 ký tự</p>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="input-group">
                                        <label for="description">Nội dung mô tả <span class="required">*</span></label>
                                        <textarea id="description" name="description" rows="10" required minlength="20"
                                                  maxlength="5000"><%= post.getDescription()%></textarea>
                                        <p class="char-count" id="desc-count">Tối thiểu 20 ký tự, tối đa 5000 ký tự</p>
                                    </div>
                                </div>

                                <div class="col-md-7">
                                    <div class="input-group">
                                        <label for="price">Giá cho thuê <span class="required">*</span></label>
                                        <div class="price-group">
                                            <input id="price" name="price" type="text" pattern="[0-9.]+" value="<%= post.getPrice()%>" required>
                                            <select name="unit" id="unit">
                                                <option value="0" selected=>vnd/tháng</option>
                                            </select>
                                        </div>
                                        <p class="note">Nhập đầy đủ số, ví dụ 1 triệu thì nhập là 1000000</p>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="input-group">
                                        <label for="area">Diện tích <span class="required">*</span></label> <br>
                                        <div class="area-group">
                                            <input id="area" type="number" name="area" max="1000" value="<%= post.getArea()%>" required>
                                            <span class="unit">m<sup>2</sup></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="input-group">
                                        <label for="roomCount">Số lượng<span class="required">*</span></label> <br>
                                        <div class="area-group">
                                            <input id="roomCount" type="number" name="roomCount" min="0" max="1000" value="<%= post.getRoomCount()%>" required>
                                            <span class="unit">Phòng</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="post-image" id="post-image">
                            <div class="title">Hình ảnh</div>
                            <div>
                                <div class="post-image-title">
                                    <label for="imageUpload" class="uploadPhotos">
                                        <span>Tải ảnh từ thiết bị</span>
                                    </label>
                                    <input type="file" id="imageUpload" name="photos" multiple accept="image/*">
                                </div>
                                <div class="post-image-content">
                                    <ul>
                                        <li class="text-bg-danger">• Nếu muốn thay đổi ảnh thì phải tải lại tất cả ảnh!!!</li>
                                        <li>• Tải lên tối thiểu 4 ảnh và tối đa 20 ảnh trong một bài đăng</li>
                                        <li>• Dung lượng ảnh tối đa 10MB</li>
                                        <li>• Hình ảnh phải liên quan đến phòng trọ, nhà cho thuê</li>
                                        <li>• Không chèn văn bản, số điện thoại lên ảnh</li>
                                    </ul>
                                </div>
                                
                                <div id="imageError" style="color: red; display: none;"></div>

                                <div class="image-list" id="imagePreviews"></div>
                            </div>
                        </div>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                let previewsContainer = document.getElementById("imagePreviews");
                                let imageInput = document.getElementById("imageUpload");
                                let errorContainer = document.getElementById("imageError");

                                let validFiles = []; // Danh sách ảnh hợp lệ
                                const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
                                const MIN_FILES = 1; // Ít nhất 1 ảnh
                                const MAX_FILES = 20; // Tối đa 20 ảnh

                                function updateImagePreview() {
                                    previewsContainer.innerHTML = "";
                                    errorContainer.style.display = "none"; // Ẩn lỗi khi ảnh hợp lệ

                                    if (validFiles.length < MIN_FILES) {
                                        errorContainer.textContent = `Bạn phải tải lên ít nhất ${MIN_FILES} ảnh.`;
                                        errorContainer.style.display = "block";
                                        return;
                                    }

                                    validFiles.forEach((file, index) => {
                                        let fileURL = URL.createObjectURL(file);
                                        createImagePreview(fileURL, index);
                                    });
                                }

                                function createImagePreview(src, index) {
                                    let previewDiv = document.createElement("div");
                                    previewDiv.style.display = "inline-block";
                                    previewDiv.style.margin = "10px";
                                    previewDiv.style.position = "relative";

                                    let img = document.createElement("img");
                                    img.src = src;
                                    img.style.width = "100px";
                                    img.style.height = "100px";
                                    img.style.border = "1px solid #ccc";
                                    img.style.borderRadius = "5px";
                                    img.style.objectFit = "cover";

                                    let removeBtn = document.createElement("button");
                                    removeBtn.textContent = "X";
                                    removeBtn.style.position = "absolute";
                                    removeBtn.style.top = "5px";
                                    removeBtn.style.right = "5px";
                                    removeBtn.style.background = "red";
                                    removeBtn.style.color = "white";
                                    removeBtn.style.border = "none";
                                    removeBtn.style.borderRadius = "50%";
                                    removeBtn.style.cursor = "pointer";
                                    removeBtn.style.width = "20px";
                                    removeBtn.style.height = "20px";
                                    removeBtn.style.lineHeight = "20px";
                                    removeBtn.style.textAlign = "center";
                                    removeBtn.style.fontSize = "14px";

                                    removeBtn.addEventListener("click", function () {
                                        validFiles.splice(index, 1);
                                        updateImagePreview();
                                    });

                                    previewDiv.appendChild(img);
                                    previewDiv.appendChild(removeBtn);
                                    previewsContainer.appendChild(previewDiv);
                                }

                                imageInput.addEventListener("change", function (event) {
                                    let files = event.target.files;
                                    validFiles = []; // Reset danh sách ảnh khi chọn lại

                                    if (files.length > MAX_FILES) {
                                        alert(`Bạn chỉ có thể tải lên tối thiểu 4 và tối đa 20 ảnh, không tải ảnh lên nếu không muốn thay đổi hình ảnh`);
                                        return;
                                    }

                                    for (let i = 0; i < files.length; i++) {
                                        let file = files[i];

                                        if (file.size > MAX_FILE_SIZE) {
                                            alert(`Ảnh "${file.name}" vượt quá 10MB và sẽ không được tải lên.`);
                                            continue;
                                        }

                                        validFiles.push(file);
                                    }

                                    updateImagePreview();
                                });

                                document.getElementById("post-form").addEventListener("submit", function (event) {
                                    if (validFiles.length < MIN_FILES) {
                                        event.preventDefault();
                                        errorContainer.textContent = `Bạn phải tải lên ít nhất ${MIN_FILES} ảnh.`;
                                        errorContainer.style.display = "block";
                                    }
                                });

                                validFiles = [];
                                updateImagePreview();
                            });
                        </script>

                        <div id="post-contact" class="post-contact">
                            <div class="title">Thông tin liên hệ</div>
                            <div class="input-group row">
                                <div class="col-12 col-md-6 mb-3">
                                    <label for="name" class="form-label mb-1">Họ Tên</label>
                                    <input id="name" type="text" name="ten_lien_he"
                                           class="form-control form-control-lg" readonly required value="<%= user.getFullname()%>">
                                </div>
                                <div class="col-12 col-md-6 mb-3">
                                    <label for="phone" class="form-label mb-1">Số điện thoại</label>
                                    <input id="phone" type="number" name="phone" class="form-control form-control-lg"
                                           readonly required value="<%= user.getPhone()%>">
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="post-button">Chỉnh sửa</button>
                    </form>
                </div>
            </div>
        </main>
        <script src="./js/effectClick.js"></script>
    </body>
</html>
