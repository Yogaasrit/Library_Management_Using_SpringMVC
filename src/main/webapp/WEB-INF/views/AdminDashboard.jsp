<%@page import="library.management.entities.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/LibraryManagement/resources/css/admin-dashboard.css">
</head>
<body>
    <h1>ADMIN DASHBOARD</h1>
    <%
    Admin admin = (Admin) session.getAttribute("adminSession");
    %>

    <div class="dashboard">
        <div class="card">
            <h3>View Books</h3>
            <a href="book/admin-book-operation" class="button">View</a>
        </div>

        <div class="card">
            <h3>Filter by Book Name</h3>
            <a href="book/filter-bookname" class="button">Filter</a>
        </div>

        <div class="card">
            <h3>Filter by Author</h3>
            <a href="book/filter-bookauthor" class="button">Filter</a>
        </div>

        <div class="card">
            <h3>Filter by Genre</h3>
            <a href="book/filter-bookgenre" class="button">Filter</a>
        </div>

        <div class="card">
            <h3>View All User</h3>
            <a href="handle-view-user" class="button">View</a>
        </div>

        <div class="card">
            <h3>View Particular User</h3>
            <a href="view-particular-user" class="button">View</a>
        </div>

        <div class="card">
            <h3>Delete User</h3>
            <a href="delete-user" class="button">Delete</a>
        </div>

        <div class="card">
            <h3>Add Books</h3>
            <a href="add-books" class="button">Add</a>
        </div>

        <div class="card">
            <h3>Delete Books</h3>
            <a href="delete-books" class="button">Delete</a>
        </div>
    </div>

</body>
</html>
