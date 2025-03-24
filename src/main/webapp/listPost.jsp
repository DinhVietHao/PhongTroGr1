<%-- 
    Document   : listPost
    Created on : Mar 15, 2025, 2:40:24 PM
    Author     : Admin
--%>
<%@page import="model.User"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@page import="java.util.List"%>
<%@page import="model.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PhongTroG1</title>
    </head>
    <body>     
        <div class="post-sticky">
            <div class="post">
                <h1 class="fs-3 fw-semibold text-nowrap mb-1">Danh sách đăng tin</h1>
            </div>
            <nav class="nav">
                <ul class="post-navbar ">
                    <li class="nav-item ">
                        <a class="nav-link active click-effect" href="Post?action=approvedList&userId=<%=user.getUserId()%>">Tin đã duyệt</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Post?action=pendingList&userId=<%=user.getUserId()%>">Tin đã chưa duyệt</a>
                    </li>
                </ul>
            </nav>
        </div>  
    </body>
</html>
