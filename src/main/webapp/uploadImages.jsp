<%-- 
    Document   : upload_images
    Created on : Mar 9, 2025, 3:33:59 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroGr1</title>
    </head>
    <body>
        <br><br><br><br>
        <!--<form action="ImageHandler?action=upload" method="POST" enctype="multipart/form-data">-->
        <form action="ImageHandler?action=upload" method="POST" enctype="multipart/form-data">
            <label for="postId">Post ID:</label>
            <input type="number" name="postId" required>

            <label for="photo">Chọn ảnh:</label>
            <input type="file" name="photo" accept="image/*" required>

            <button type="submit">Upload</button>
        </form>

        <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
        <% if (errorMessage != null) {%>
        <p style="color: red;"><%= errorMessage%></p>
        <% }%>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const fileInput = document.querySelector("input[type='file']");
                if (fileInput) {
                    fileInput.addEventListener("change", function () {
                        const file = this.files[0];
                        if (file && file.size > 10 * 1024 * 1024) { // 16MB
                            alert("File quá lớn! Vui lòng chọn ảnh nhỏ hơn 10MB.");
                            this.value = ""; // Xóa file đã chọn
                        }
                    });
                }
            });
        </script>
    </body>
</html>
