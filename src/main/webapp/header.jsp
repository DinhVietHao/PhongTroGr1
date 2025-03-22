<%-- 
    Document   : home
    Created on : Feb 6, 2025, 10:23:56 AM
    Author     : Admin
--%>

<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user = new User();
    if (session.getAttribute("user") != null) {
        user = (User) session.getAttribute("user");
    } else if (request.getAttribute("user") != null && session.getAttribute("user") == null) {
        user = (User) request.getAttribute("user");
    }

    List<Category> listCategory = (List<Category>) session.getAttribute("listCate");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
        <link rel="icon" type="image/png" href="./images/favicon.jpg">

        <!-- boostrap -->
        <link href="./css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="./css/style.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <style>
            /* Tùy chỉnh menu và nút */
            .menu-content {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                font-family: 'Arial', sans-serif;
            }

            .add-click button.no-border {
                border: none;
                background: none;
                padding: 8px 16px;
                font-size: 16px;
                color: #333;
                cursor: pointer;
                transition: color 0.3s ease, background-color 0.3s ease;
                font-weight: 500;
            }

            .add-click button.no-border:hover {
                color: #007bff;
                background-color: #f8f9fa;
                border-radius: 4px;
            }

            .add-click button.no-border:active {
                transform: scale(0.95);
            }
        </style>
    </head>
    <body>
        <header class="header">
            <div class="container-xl">
                <div class="col-md-12 header-content">
                    <div class="header-logo">
                        <a href="Home">
                            <img classs="header-logo" src="./images/logo.gif"
                                 alt="Kênh thông tin cho thuê phòng trọ số 1 Việt Nam" title="PhongtroG1.com">
                        </a>
                    </div>
                    <form action="" method="GET" class="header-search">
                        <img class="icon" src="./images/location-pin.svg" alt="location">
                        <input oninput="searchByKey(this)" class="search" type="text" name="text" placeholder="Nhập từ khóa cần tìm">
                        <button type="submit" class="search-btn">
                            <i class="bi bi-search"></i>
                        </button>
                    </form>           

                    <%
                        if (user.getUserId() != -1 && user.getRole() == 2) {
                    %>

                    <div class="header-manager">
                        <a href="Post?action=listPosted&userId=<%= user.getUserId()%>">
                            <img src="./images/bi-folder.svg" alt="folder"> Quản lý bài đăng
                        </a>
                    </div>
                    <%
                        }
                        if (user.getUserId() != -1 && user.getRole() == 3) {
                    %>

                    <div class="header-manager">
                        <a href="Admin?action=adminManagerPost">
                            <img src="./images/bi-folder.svg" alt="folder"> Quản lý
                        </a>
                    </div>

                    <%
                        }
                    %>
                    <div class="dropdown">
                        <% if (user.getImageData() != null) {%>
                        <img class="avatar" src="ImageHandler?action=displayAvatar&userId=<%=user.getUserId()%>" alt="avatar">
                        <% } else { %>  
                        <img class="avatar" src="./images/default_user.svg" alt="avatar">
                        <% }%>
                        <button class="dropdown-btn color-font"><%= user.getUserId() != -1 ? user.getFullname() : "Tài khoản"%></button>
                        <div class="dropdown-menu">
                            <%
                                if (user.getUserId() != -1) {
                            %>
                            <a href="./accountManagement.jsp"><i class="bi bi-archive"></i> Quản lí tài khoản</a>
                            <a href="Logout"><img class="icon-one" src="./images/bi-login.svg" alt="login"> Đăng xuất</a>
                                <%
                                } else {
                                %>
                            <a href="register.jsp"><img class="icon-one" src="./images/bi-register.svg" alt="register"> Tạo tài khoản mới</a>
                            <a href="Login"><img class="icon-one" src="./images/bi-login.svg" alt="login"> Đăng nhập</a>
                                <%
                                    }
                                %>
                        </div>
                    </div>
                    <%
                        if (user.getUserId() != -1 && user.getRole() == 2) {
                    %>  
                    <div class="header-post">
                        <a href="Post">
                            <img src="./images/bi-posting-white.svg" alt=""> Đăng tin
                        </a>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div class="menu">
                    <ul class="menu-content col-md-12">
                        <%
                            if (listCategory != null && !listCategory.isEmpty()) {
                                for (Category c : listCategory) {
                        %>
                        <li class="add-click">
                            <button onclick="uploadPostByType('<%= c.getCatName()%>')" class="no-border"><%= c.getCatName()%></button>
                        </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>
            </div>
        </header>
        <script>
            function searchByKey(input) {
                var txtSearch = input.value;
                $.ajax({
                    url: "/PhongTroGr1/Search",
                    type: 'GET',
                    data: {
                        txt: txtSearch
                    },
                    success: function (data) {
                        var row = document.getElementById("contentPost");
                        row.innerHTML = data;
                    }
                });
            }

            function uploadPostByType(postType) {
                $.ajax({
                    url: "/PhongTroGr1/Search",
                    type: "POST",
                    data: {
                        type: postType,
                        action: "uploadByCat"
                    },
                    success: function (data) {
                        var row = document.getElementById("contentPost");
                        row.innerHTML = data;
                    }
                });
            }

            function loadPage(postType, pageNumber) {
                $.ajax({
                    url: "/PhongTroGr1/Search",
                    type: "POST",
                    data: {
                        action: "uploadByCat",
                        type: postType,
                        page: pageNumber
                    },
                    success: function (data) {
                        document.getElementById("contentPost").innerHTML = data;
                    },
                    error: function (error) {
                        console.error("Error:", error);
                    }
                });
            }
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                const dropdownBtn = document.querySelector(".dropdown-btn");
                const dropdownMenu = document.querySelector(".dropdown-menu");

                dropdownBtn.addEventListener("click", () => {
                    dropdownMenu.style.display =
                            dropdownMenu.style.display === "block" ? "none" : "block";
                });

                // Đóng menu khi nhấp ra ngoài
                document.addEventListener("click", (event) => {
                    if (!dropdownBtn.contains(event.target) && !dropdownMenu.contains(event.target)) {
                        dropdownMenu.style.display = "none";
                    }
                });
            });

            document.addEventListener("DOMContentLoaded", () => {
                const filterBtn = document.querySelector(".btn-filter");
                const filterModal = document.getElementById("filterModal");
                const closeModalBtn = filterModal.querySelector(".btn-close");

                // Toggle the visibility of the filter modal when the button is clicked
                filterBtn.addEventListener("click", (event) => {
                    // Prevent the event from propagating so it doesn't trigger closing when clicking the button itself
                    event.stopPropagation();

                    // Toggle the modal's visibility
                    filterModal.classList.toggle("show");
                });

                // Close the modal when clicking the close button
                closeModalBtn.addEventListener("click", (event) => {
                    event.stopPropagation();
                    filterModal.classList.remove("show");
                });

                // Close the modal if clicked outside of the modal
                document.addEventListener("click", (event) => {
                    if (!filterBtn.contains(event.target) && !filterModal.contains(event.target)) {
                        filterModal.classList.remove("show");
                    }
                });
            });
        </script>
        <script src="./js/codeme.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>