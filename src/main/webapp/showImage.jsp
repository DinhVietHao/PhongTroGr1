<%-- 
    Document   : show_image
    Created on : Mar 9, 2025, 5:51:47 PM
    Author     : ASUS
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Image"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    ArrayList<Image> images = (ArrayList)request.getAttribute("list");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroGr1</title>
    </head>
    <body>
     <h2>Image Gallery</h2>
    <%
       // for (Image img : images) {
    %>
        <img src="ImageHandler?action=displayAvatar&userId=1" alt="avatar">
    <%
      //  }
    %>
    </body>
</html>
