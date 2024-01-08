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
	<%
	Admin admin = (Admin) session.getAttribute("adminSession");
	%>
	<%=admin.getAdminName() + " Welcome back!"%>
	<a href="book/view-books" class="button">View Books</a>
	<!--  <a href="book/view-author" class="button">View Authors</a>
    <a href="book/view-genre" class="button">View Genres</a> -->
	<a href="book/filter-bookname" class="button">Filter by Book Name</a>
	<a href="book/filter-bookauthor" class="button">Filter by Author</a>
	<a href="book/filter-bookgenre" class="button">Filter by Genre</a>
	<a href="handle-view-user">View All User</a>
	<a href="view-particular-user">View particular user</a>
	<a href="delete-user">Delete user</a>
	<a href="add-books">Add books</a>
	<a href="delete-books">Delete books</a>
</body>
</html>