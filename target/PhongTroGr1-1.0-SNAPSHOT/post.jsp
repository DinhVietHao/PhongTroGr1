<%-- 
    Document   : post
    Created on : Mar 9, 2025, 5:12:12 PM
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
        <link rel="stylesheet" href="./css/style.css"/>  
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <aside class="sidebar-panel">
            <div class="profile-section">
                <div class="profile-avatar">
                    <img class="avatar" src="https://phongtro123.com/images/default-user.svg">
                </div>
                <div class="profile-details">
                    <span class="user-name">Lê Minh Kha</span> <br>
                    <span class="user-phone">0854453340</span> <br>
                    <span class="account-id">Mã tài khoản: 150381</span>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li>
                    <a class="sidebar-item" href="">
                        <i class="bi bi-file-earmark-post"></i>Đăng tin mới
                    </a>
                </li>
                <li>
                    <a class="sidebar-item" href="">
                        <i class="bi bi-archive"></i> Danh sách tin đăng
                    </a>
                </li>
                <li>
                    <a class="sidebar-item" href="">
                        <i class="bi bi-tags"></i> Bảng giá dịch vụ
                    </a>
                </li>
                <li>
                    <a class="sidebar-item" href="">
                        <i class="bi bi-person"></i> Quản lý tài khoản
                    </a>
                </li>
                <li>
                    <a class="sidebar-item logout" href="./login.jsp">
                        <i class="bi bi-box-arrow-in-right"></i> Đăng xuất
                    </a>
                </li>
            </ul>
            <div class="support-box">
                <a class="support-contact" href="https://zalo.me/0854453340" target="_blank">
                    <div>
                        <p class="support-label">Nhân viên hỗ trợ riêng của bạn:</p>
                        <p class="support-name">Thanh Ly - LBKCorp <br> 0854453340</p>
                    </div>
                </a>
            </div>
        </aside>

        <main class="post-header">
            <div class="post-sticky">
                <div class="post">
                    <h1 class="fs-3 fw-semibold text-nowrap mb-1">Đăng tin cho thuê</h1>
                </div>
                <nav class="nav">
                    <ul class="post-navbar">
                        <li class="nav-item">
                            <a class="nav-link active" href="#post-category">Khu vực</a>
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
                    <form id="form-post" class="post-from">
                        <div class="post-category" id="post-category">
                            <div class="title">Loại chuyên mục</div>
                            <div class="post-input">
                                <label class="label" for="loai_chuyen_muc">Loại chuyên mục
                                    <span class="required">*</span>
                                </label>
                                <select class="select" id="post_cat" name="loai_chuyen_muc" required>
                                    <option value="" selected>-- Chọn loại chuyên mục --</option>
                                    <option value="1">Phòng trọ, nhà trọ</option>
                                    <option value="2">Nhà thuê nguyên căn</option>
                                    <optgroup label="Căn hộ">
                                        <option value="3">Cho thuê căn hộ</option>
                                        <option value="6">Cho thuê căn hộ mini</option>
                                        <option value="7">Cho thuê căn hộ dịch vụ</option>
                                    </optgroup>
                                    <option value="4">Tìm người ở ghép</option>
                                    <option value="5">Cho thuê mặt bằng + Văn phòng</option>
                                </select>
                            </div>
                        </div>
                        <div class="post-location">
                            <div class="title">Khu vực</div>
                            <div class="post-input">
                                <div class="input-group">
                                    <label for="province" class="label">Tỉnh/Thành phố <span
                                            class="required">*</span></label>
                                    <select id="province" name="province" class="select" required>
                                        <option value="0">-- Chọn Tỉnh/TP --</option>
                                        <option value="1">Hồ Chí Minh</option>
                                        <option value="2">Hà Nội</option>
                                        <option value="3">Cần Thơ</option>
                                    </select>
                                </div>
                                <div class="input-group">
                                    <label for="district" class="label">Quận/Huyện <span class="required">*</span></label>
                                    <select id="district" name="district" class="select" required>
                                        <option value="0">-- Chọn Quận/Huyện --</option>
                                    </select>
                                </div>
                                <div class="input-group">
                                    <label for="ward" class="label">Phường/Xã</label>
                                    <select id="ward" name="ward" class="select">
                                        <option value="0">-- Chọn Phường/Xã --</option>
                                    </select>
                                </div>
                                <div class="input-group">
                                    <label for="street" class="label">Đường/Phố</label>
                                    <select id="street" name="street" class="select">
                                        <option value="0">-- Chọn Đường/Phố --</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="post-info" id="post-info">
                            <div class="title">Thông tin mô tả</div>
                            <div class="row post-input">
                                <div class="col-12">
                                    <div class="input-group">
                                        <label for="title">Tiêu đề <span class="required">*</span></label>
                                        <textarea id="title" name="title" rows="2" required minlength="30"
                                                  maxlength="100"></textarea>
                                        <p class="char-count" id="title-count">Tối thiểu 30 ký tự, tối đa 100 ký tự</p>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="input-group">
                                        <label for="description">Nội dung mô tả <span class="required">*</span></label>
                                        <textarea id="description" name="description" rows="10" required minlength="50"
                                                  maxlength="5000"></textarea>
                                        <p class="char-count" id="desc-count">Tối thiểu 50 ký tự, tối đa 5000 ký tự</p>
                                    </div>
                                </div>

                                <div class="col-md-7">
                                    <div class="input-group">
                                        <label for="price">Giá cho thuê <span class="required">*</span></label>
                                        <div class="price-group">
                                            <input id="price" name="price" type="text" pattern="[0-9.]+" required>
                                            <select name="unit" id="unit">
                                                <option value="0">đồng/tháng</option>
                                                <option value="1">đồng/m2/tháng</option>
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
                            </div>
                        </div>

                        <div class="post-image" id="post-image">
                            <div class="title">Hình ảnh</div>
                            <div>
                                <div class="post-image-title">
                                    <label for="imageUpload" class="uploadPhotos">
                                        <span>Tải ảnh từ thiết bị</span>
                                    </label>
                                    <input type="file" id="imageUpload" name="images[]" multiple accept="image/*">
                                </div>
                                <div class="post-image-content">
                                    <ul>
                                        <li>• Tải lên tối đa 20 ảnh trong một bài đăng</li>
                                        <li>• Dung lượng ảnh tối đa 10MB</li>
                                        <li>• Hình ảnh phải liên quan đến phòng trọ, nhà cho thuê</li>
                                        <li>• Không chèn văn bản, số điện thoại lên ảnh</li>
                                    </ul>
                                </div>
                                <div class="image-list" id="imagePreviews"></div>
                            </div>
                        </div>

                        <div id="post-contact" class="post-contact">
                            <div class="title">Thông tin liên hệ</div>
                            <div class="input-group row">
                                <div class="col-12 col-md-6 mb-3">
                                    <label for="name" class="form-label mb-1">Họ Tên</label>
                                    <input id="name" type="text" name="ten_lien_he"
                                           class="form-control form-control-lg" readonly required value="Lê Minh Kha">
                                </div>
                                <div class="col-12 col-md-6 mb-3">
                                    <label for="phone" class="form-label mb-1">Số điện thoại</label>
                                    <input id="phone" type="number" name="phone" class="form-control form-control-lg"
                                           readonly required value="0854453340">
                                </div>
                            </div>
                        </div>
                         <button type="submit" class="post-button">Đăng tin</button>
                    </form>
                </div>
            </div>
        </main>


        <script src="./js/home.js"></script>
    </body>
</html>
