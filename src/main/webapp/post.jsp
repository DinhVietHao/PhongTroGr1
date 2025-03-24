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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <%if (user.getUserId() == -1 || (user.getRole() != 2 && user.getRole() != 3)) {
                response.sendRedirect("Home");
                return;
            }%>
        <%@include file="sidebar.jsp" %>
        <main class="post-header">
            <div class="post-sticky">
                <div class="post">
                    <h1 class="fs-3 fw-semibold text-nowrap mb-1">Đăng tin</h1>
                </div>
                <nav class="nav">
                    <ul class="post-navbar ">
                        <li class="nav-item ">
                            <a class="nav-link active click-effect" href="#post-category">Khu vực</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#post-info">Thông tin mô tả</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#post-image">Hình ảnh</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#post-contact">Thông tin liên hệ</a>
                        </li>
                    </ul>
                </nav>
            </div>

            <div class="post-container">
                <div class="post-content">
                    <form id="post-from" class="post-from" method="POST" action="Post" enctype="multipart/form-data">
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
                                    <option value="1">Nhà Trọ</option>
                                    <option value="2">Mini house</option>
                                    <option value="3">Nhà thuê nguyên căn</option>
                                    <option value="4">Căn hộ</option>

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
                                        <option value="Ninh Kiều">Ninh Kiều</option>
                                        <option value="Bình Thủy">Bình Thủy</option>
                                        <option value="Cái Răng">Cái Răng</option>
                                        <option value="Ô Môn">Ô Môn</option>
                                        <option value="Thốt Nốt">Thốt Nốt</option>

                                    </select>
                                </div>
                                <div class="input-group">
                                    <label for="ward" class="label">Phường/Xã</label>
                                    <select id="ward" name="ward" class="select">
                                        <option value="0">-- Chọn Phường/Xã --</option>
                                        <option value="An Cư">An Cư</option>
                                        <option value="An Hòa">An Hòa</option>
                                        <option value="An Khánh">An Khánh</option>
                                        <option value="An Nghiệp">An Nghiệp</option>
                                        <option value="An Phú">An Phú</option>
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
                                                  maxlength="100"></textarea>
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
                                                  maxlength="100"></textarea>
                                        <p class="char-count" id="title-count">Tối thiểu 10 ký tự, tối đa 100 ký tự</p>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="input-group">
                                        <label for="description">Nội dung mô tả <span class="required">*</span></label>
                                        <textarea id="description" name="description" rows="10" required minlength="20"
                                                  maxlength="5000"></textarea>
                                        <p class="char-count" id="desc-count">Tối thiểu 20 ký tự, tối đa 5000 ký tự</p>
                                    </div>
                                </div>

                                <div class="col-md-7">
                                    <div class="input-group">
                                        <label for="price">Giá cho thuê <span class="required">*</span></label>
                                        <div class="price-group">
                                            <input id="price" name="price" type="text" pattern="[0-9.]+" required>
                                            <select name="unit" id="unit">
                                                <option value="0" selected>vnd/tháng</option>
                                            </select>
                                        </div>
                                        <p class="note">Nhập đầy đủ số, ví dụ 1 triệu thì nhập là 1000000</p>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="input-group">
                                        <label for="area">Diện tích <span class="required">*</span></label> <br>
                                        <div class="area-group">
                                            <input id="area" type="number" name="area" max="1000" required>
                                            <span class="unit">m<sup>2</sup></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <div class="input-group">
                                        <label for="roomCount">Số lượng<span class="required">*</span></label> <br>
                                        <div class="area-group">
                                            <input id="roomCount" type="number" name="roomCount" min="0" max="1000" required>
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
                                        <li>• Tải lên tối thiểu 4 ảnh và  tối đa 20 ảnh trong một bài đăng</li>
                                        <li>• Dung lượng mỗi ảnh tối đa 10MB</li>
                                        <li>• Hình ảnh phải liên quan đến phòng trọ, nhà cho thuê</li>
                                        <li>• Không chèn văn bản, số điện thoại lên ảnh</li>
                                    </ul>
                                </div>
                                <div class="image-list" id="imagePreviews"></div>
                            </div>
                        </div>

                        <script>
                            document.getElementById("imageUpload").addEventListener("change", function (event) {
                                let previewsContainer = document.getElementById("imagePreviews");
                                let files = event.target.files;
                                let validFiles = []; // Mảng chứa các file hợp lệ
                                const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
                                const MIN_FILES = 4;
                                const MAX_FILES = 20;

                                previewsContainer.innerHTML = ""; // Xóa nội dung cũ trước khi thêm ảnh mới

                                for (let i = 0; i < files.length; i++) {
                                    let file = files[i];

                                    // Kiểm tra dung lượng file
                                    if (file.size > MAX_FILE_SIZE) {
                                        alert(`Ảnh "${file.name}" vượt quá dung lượng 10MB và sẽ không được tải lên.`);
                                        continue; // Bỏ qua ảnh này
                                    }

                                    validFiles.push(file);
                                }

                                // Kiểm tra số lượng ảnh hợp lệ
                                if (validFiles.length < MIN_FILES || validFiles.length > MAX_FILES) {
                                    alert(`Bạn phải tải lên từ 4 đến 20 ảnh (mỗi ảnh tối đa 10MB).`);
                                    event.target.value = ""; // Reset input file
                                    previewsContainer.innerHTML = ""; // Xóa nội dung cũ
                                    return;
                                }

                                // Hiển thị ảnh hợp lệ
                                validFiles.forEach(file => {
                                    let fileURL = URL.createObjectURL(file);

                                    let previewDiv = document.createElement("div");
                                    previewDiv.style.display = "inline-block";
                                    previewDiv.style.margin = "10px";
                                    previewDiv.style.position = "relative";

                                    let img = document.createElement("img");
                                    img.src = fileURL;
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
                                        previewDiv.remove(); // Xóa ảnh khỏi giao diện
                                    });

                                    previewDiv.appendChild(img);
                                    previewDiv.appendChild(removeBtn);
                                    previewsContainer.appendChild(previewDiv);
                                });
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
                        <button type="submit" id="submitBtn" class="post-button">Đăng tin</button>
                        <script>
                            document.getElementById("submitBtn").addEventListener("click", function (event) {
                                let fileInput = document.getElementById("imageUpload");
                                let files = fileInput.files;

                                if (files.length === 0) {
                                    alert("Bạn phải tải lên ít nhất 4 ảnh trước khi đăng bài.");
                                    event.preventDefault();
                                }
                            });
                        </script>
                        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                        <% if (errorMessage != null) {%>
                        <p style="color: red;"><%= errorMessage%></p>
                        <% }%>
                    </form>
                </div>
            </div>
        </main>
        <script src="./js/effect.js"></script>      
    </body>
</html>