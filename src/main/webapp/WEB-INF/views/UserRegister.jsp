<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Register</title>
</head>
<body>
<form action = "handle-register" method = "post">
	<p>Email Id : </p>
	<input type = "text" name = "emailId">
	<p>User Name : </p>
	<input type = "text" name = "userName">
	<p>Password : </p>
	<input type = "password" name = "passWord">
	<button onClick = "submit">Register</button>
	</form>
</body>
</html>