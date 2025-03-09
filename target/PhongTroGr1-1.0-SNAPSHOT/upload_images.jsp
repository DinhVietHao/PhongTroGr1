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
        <title>JSP Page</title>
    </head>
    <body>
        <form action="UploadImageServlet" method="post" enctype="multipart/form-data">
            <label for="postId">Post ID:</label>
            <input type="number" name="postId" required>

            <label for="photo">Chọn ảnh:</label>
            <input type="file" name="photo" accept="image/*" required>

            <button type="submit">Upload</button>
        </form>
    </body>
</html>
