<%@page import="library.management.entities.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/LibraryManagement/resources/css/style.css">
    <!-- Add any additional CSS styles if needed -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
        }

        h1 {
            color: #333;
            text-align: center;
        }

        .dashboard {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .card {
            width: 200px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            border-radius: 8px;
        }

        .card h3 {
            color: #333;
        }

        .card i {
            font-size: 36px;
            color: #007bff; /* Blue color for icons */
        }

        .card p {
            margin-top: 10px;
            font-size: 18px;
            color: #555;
        }
    </style>
</head>

<body>

    <jsp:include page="admin-header.jsp" />

    <div class="container">
        <h1>ADMIN DASHBOARD</h1>
        <%
            Admin admin = (Admin) session.getAttribute("adminSession");
            int totalUserCount = (Integer) request.getAttribute("totalUserCount");
            int totalBookCount = (Integer) request.getAttribute("totalBookCount");
        %>

        <div class="dashboard">
            <div class="card">
                <i class="fas fa-users"></i>
                <h3>Total Users</h3>
                <p><%= totalUserCount %></p>
            </div>

            <div class="card">
                <i class="fas fa-book"></i>
                <h3>Total Books</h3>
                <p><%= totalBookCount %></p>
            </div>
        </div>
    </div>

</body>
</html>
