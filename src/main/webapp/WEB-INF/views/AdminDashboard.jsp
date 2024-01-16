<%@page import="library.management.entities.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="/LibraryManagement/resources/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Add any additional CSS styles if needed -->
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
     background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
}

.admin-header {
    background-color: transparent;
    border: none;
    color: #fff;
    padding: 15px; /* Padding adjusted */
    display: flex;
    justify-content: space-between;
    align-items: center; /* Center items vertically */
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1000;
}

.brand {
    font-size: 24px;
}

.profile-section {
    display: flex;
    align-items: center;
}

.actions-dropdown {
    position: relative;
    display: inline-block;
    margin-right: 20px; /* Increased spacing between the dropdown and logout */
}

.dropdown-btn {
        background-color: transparent; /* Blue color */
    color: #fff;
    border: none;
    cursor: pointer;
    padding: 10px 15px; /* Adjusted padding */
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: transparent;
    min-width: 160px;
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    z-index: 1;
}

.dropdown-content a {
    color: #fff;
    padding: 12px 16px; /* Adjusted padding */
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {
    background-color: #2980b9; /* Darker shade on hover */
}

.logout a {
    color: #fff;
    text-decoration: none;
    padding: 10px 15px; /* Adjusted padding */
}

/* Increased spacing between links */
.admin-header a:not(.profile-icon) {
    margin-right: 20px;
}

.container {
    max-width: 800px;
    margin: 400px auto 20px; /* Adjust margin for better positioning */
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    background-color: transparent;
}

h1 {
    color: #333;
    text-align: center;
}

.dashboard {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    margin-top: 20px;
    background-color: transparent;
    border: none;
}

.card {
    width: 200px;
    margin: 10px;
    background-color: rgba(255, 255, 255, 0.9);
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
   
    <header>
        <jsp:include page="admin-header.jsp" />
    </header>
	
    <div class="container">
       
        <%
            Admin admin = (Admin) session.getAttribute("adminSession");
            int totalUserCount = (Integer) request.getAttribute("totalUserCount");
            int totalBookCount = (Integer) request.getAttribute("totalBookCount");
            int totalBooksBorrowed = (Integer) request.getAttribute("totalBooksBorrowed");
            int totalBooksBought = (Integer) request.getAttribute("totalBooksBought");
            int totalPendingApproval=(Integer) request.getAttribute("totalPendingApproval");
            int totalBooksBorrowedToday = (Integer)request.getAttribute("totalBooksBorrowedToday");
            int totalBooksBoughtToday = (Integer)request.getAttribute("totalBooksBoughtToday");
            int totalUserOverDueCount = (Integer)request.getAttribute("totalUserOverDueCount");
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
            
            <div class="card">
                <i class="fa fa-hourglass-1"></i>
                <h3>Total Borrowed Books</h3>
                <p><%=totalBooksBorrowed  %></p>
            </div>
            
            <div class="card">
                <i class="fas fa-book"></i>
                <h3>Total Bought Books</h3>
                <p><%=totalBooksBought  %></p>
            </div>
            
            <div class="card">
                <i class="fa fa-clock-o"></i>
                <h3>Total Pending Return Approval </h3>
                <p><%= totalPendingApproval %></p>
            </div>
            
            <div class="card">
                <i class="fa fa-calendar"></i>
                <h3>Today borrowed count</h3>
                <p><%=totalBooksBorrowedToday%></p>
            </div>
            
            <div class="card">
                <i class="fa fa-shopping-cart"></i>
                <h3>Today orders</h3>
                <p><%=totalBooksBoughtToday%></p>
            </div>
            
            <div class="card">
                <i class="fa fa-hourglass-end"></i>
                <h3>OverDue count</h3>
                <p><%=totalUserOverDueCount%></p>
            </div>
        </div>
    </div>

</body>
</html>
