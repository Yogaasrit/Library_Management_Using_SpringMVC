<%@page import="library.management.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
        .user-card {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            width: 300px;
        }
    </style>
</head>
<body>
<h1>View particular user</h1>
<form action="viewParticularUser">
<input type="text" name="userid">
<input type="submit" value="view">
</form>
<% User user=(User)request.getAttribute("userInfo");
if (user != null) {
	%>
	<div class="user-card">
    <h2>User Details</h2>
    <p><strong>User ID:</strong> <%= user.getUserId() %></p>
    <p><strong>User Name:</strong> <%= user.getUserName() %></p>
    <p><strong>User Email:</strong> <%= user.getUserEmailId() %></p>
   


</div>
<%  
}
%>

</body>
</html>