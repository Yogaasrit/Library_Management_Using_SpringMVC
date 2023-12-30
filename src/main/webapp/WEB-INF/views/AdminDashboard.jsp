<%@page import="library.management.entities.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
</head>
<body>
<h1>ADMIN DASHBOARD</h1>
<% Admin admin = (Admin)session.getAttribute("adminSession");%>
<%= admin.getAdminName() +" Welcome back!" %>
<a href = "User/handle-view-user">View All User</a>
</body>
</html>