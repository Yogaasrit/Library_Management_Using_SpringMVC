<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
</head>
<body>
<H1>ADMIN</H1>
<form action = "validate-admin" method = "post">
<h4>Enter admin Email ID : </h4>
<input type = "text" name = adminEmailId>
<h4>Enter admin password : </h4>
<input type = "password" name = "adminPassword">
<button onClick = "submit">Login</button>
</form>
</body>
</html>