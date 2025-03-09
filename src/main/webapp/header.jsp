<%-- 
    Document   : home
    Created on : Feb 6, 2025, 10:23:56 AM
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
        <link rel="stylesheet" href="./css/style.css">
    </head>
    <body>
        <header class="header">
            <div class="container-xl">
                <div class="col-md-12 header-content">
                    <div class="header-logo">
                        <a href="./room">
                            <img classs="header-logo" src="./images/logo-phongtro.svg"
                                 alt="Kênh thông tin cho thuê phòng trọ số 1 Việt Nam" title="PhongtroG1.com">
                        </a>
                    </div>
                    <div class="header-search">
                        <img class="icon" src="./images/location-pin.svg" alt="location">
                        Tìm theo khu vực
                    </div>
                    <div class="header-filter">
                        <button class="btn-filter"> <img class="icon" src="./images/bi-funnel.svg" alt="funnel"><span>Bộ
                                lọc</span></button>
                    </div>
                    <div class="header-manager">
                        <a href="./login.jsp">
                            <img src="./images/bi-folder.svg" alt="folder"> Quản lý
                        </a>
                    </div>
                    <div class="dropdown">
                        <img class="avatar" src="./images/default_user.svg" alt="user">
                        <button class="dropdown-btn">Tài khoản</button>
                        <div class="dropdown-menu">
                            <a href="./register.jsp"><img class="icon-one" src="./images/bi-register.svg" alt="register"> Tạo tài khoản mới</a>
                            <a href="./login.jsp"><img class="icon-one" src="./images/bi-login.svg" alt="login"> Đăng nhập</a>
                        </div>
                    </div>
                    <div class="header-post">
                        <a href="./post.jsp">
                            <img src="./images/bi-posting-white.svg" alt=""> Đăng tin
                        </a>
                    </div>
                </div>
                <div class="menu">
                    <ul class="menu-content col-md-12">
                        <li>
                            <a title="Cho thuê phòng trọ" href="">Phòng trọ</a>
                        </li>
                        <li>
                            <a title="Cho thuê nhà nguyên căn" href="">Nhà nguyên căn</a>
                        </li>
                        <li>
                            <a title="Cho thuê căn hộ chung cư" href="">Căn hộ chung cư</a>
                        </li>
                        <li>
                            <a title="Cho thuê căn hộ mini" href="">Căn hộ mini</a>
                        </li>
                        <li>
                            <a title="Cho thuê căn hộ dịch vụ" href="">Căn hộ dịch vụ</a>
                        </li>
                        <li>
                            <a title="Tìm người ở ghép" href="">Ở ghép</a>
                        </li>
                        <li>
                            <a title="Cho thuê mặt bằng" href="">Mặt bằng</a>
                        </li>
                        <li>
                            <a title="Blog" href="">Blog</a>
                        </li>
                        <li>
                            <a title="Bảng giá dịch vụ" href="">Bảng giá dịch vụ</a>
                        </li>
                    </ul>
                </div>
            </div>


            <div class="offcanvas rounded-top-4 table-filler" id="filterModal"">
                <div class="offcanvas-header shadow-sm">
                    <h5 class="modal-title" id="filterModalLabel">Bộ lọc</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body p-4">
                    <div class="mb-4 pb-2">
                        <div class="fs-5 fw-normal mb-3">Danh mục cho thuê</div>
                        <div class="d-flex flex-wrap">
                            <button class="btn-filter active">
                                <i class="bi bi-house-door filter-icon"></i> Phòng trọ
                                <span class="active-marker">?</span>
                            </button>
                            <button class="btn-filter"><i class="bi bi-house"></i> Nhà riêng</button>
                            <button class="btn-filter"><i class="bi bi-people"></i> Căn hộ ghép</button>
                            <button class="btn-filter"><i class="bi bi-shop"></i> Mặt bằng</button>
                            <button class="btn-filter"><i class="bi bi-building"></i> Căn hộ chung cư</button>
                        </div>
                    </div>

                    <div class="mb-4 pb-2">
                        <div class="fs-5 fw-normal mb-2">Lọc theo khu vực</div>
                        <div class="row gx-2">
                            <div class="col-4">
                                <label class="form-label mb-1">Tỉnh thành</label>
                                <select class="form-select">
                                    <option>Cần Thơ</option>
                                    <option>Hồ Chí Minh</option>
                                    <option>Hà Nội</option>
                                </select>
                            </div>
                            <div class="col-4">
                                <label class="form-label mb-1">Quận huyện</label>
                                <select class="form-select">
                                    <option>Tất cả</option>
                                </select>
                            </div>
                            <div class="col-4">
                                <label class="form-label mb-1">Phường xã</label>
                                <select class="form-select">
                                    <option>Tất cả</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4 pb-2">
                        <div class="fs-5 fw-normal mb-3">Khoảng giá</div>
                        <div class="d-flex flex-wrap">
                            <button class="btn-filter active">Tất cả <span class="active-marker">?</span></button>
                            <button class="btn-filter">Dưới 1 triệu</button>
                            <button class="btn-filter">1 - 2 triệu</button>
                            <button class="btn-filter">2 - 3 triệu</button>
                        </div>
                    </div>
                </div>
                <div class="offcanvas-footer p-3 shadow-lg">
                    <button type="button" class="btn apply-button w-100">Áp dụng</button>
                </div>
            </div>
        </header>
        <script src="./js/codeme.js"></script>
    </body>
</html>
