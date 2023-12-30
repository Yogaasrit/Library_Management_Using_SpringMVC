<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Login</title>
</head>
<body>
<form action = "validate-user" method = "post">
	<p>Email Id : </p>
	<input type = "text" name = "emailId">
	<p>Password : </p>
	<input type = "password" name = "passWord">
	<button onClick = "submit">Login</button>
	</form>
	<a href = "UserRegister" >New User? Register</a>
</body>
</html>