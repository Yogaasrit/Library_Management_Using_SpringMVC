<%@page import="library.management.entities.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet" type="text/css"
	href="/LibraryManagement/resources/css/style.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Add any additional CSS styles if needed -->

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background: url('/LibraryManagement/resources/images/adminimg3.jpg')
		center center fixed;
	background-size: cover;
}

.container {
	max-width: 800px;
	margin: 400px auto 20px; /* Adjust margin for better positioning */
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	background-color: transparent;
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
header{
position:fixed;
margin-right:1450px;
}

</style>
</head>

<body>

	<header >
		<jsp:include page="admin-header.jsp" />
	</header>

	<div class="container">

		<%
		Admin admin = (Admin) session.getAttribute("adminSession");
		int totalUserCount = (Integer) request.getAttribute("totalUserCount");
		int totalBookCount = (Integer) request.getAttribute("totalBookCount");
		int totalBooksBorrowed = (Integer) request.getAttribute("totalBooksBorrowed");
		int totalBooksBought = (Integer) request.getAttribute("totalBooksBought");
		int totalPendingApproval = (Integer) request.getAttribute("totalPendingApproval");
		int totalBooksBorrowedToday = (Integer) request.getAttribute("totalBooksBorrowedToday");
		int totalBooksBoughtToday = (Integer) request.getAttribute("totalBooksBoughtToday");
		int totalUserOverDueCount = (Integer) request.getAttribute("totalUserOverDueCount");
		%>

		<div class="dashboard">
			<div class="card">
				<i class="fas fa-users"></i>
				<h3>Total Users</h3>
				<p><%=totalUserCount%></p>
			</div>

			<div class="card">
				<i class="fas fa-book"></i>
				<h3>Total Books</h3>
				<p><%=totalBookCount%></p>
			</div>

			<div class="card">
				<i class="fa fa-hourglass-1"></i>
				<h3>Total Borrowed Books</h3>
				<p><%=totalBooksBorrowed%></p>
			</div>

			<div class="card">
				<i class="fas fa-book"></i>
				<h3>Total Bought Books</h3>
				<p><%=totalBooksBought%></p>
			</div>

			<div class="card">
				<i class="fa fa-clock-o"></i>
				<h3>Total Pending Return Approval</h3>
				<p><%=totalPendingApproval%></p>
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
<jsp:include page="footer.jsp" />
</html>

