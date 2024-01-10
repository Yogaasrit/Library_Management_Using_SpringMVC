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
	<% String message =(String) request.getAttribute("message"); 
        if(message!=null){ %>
    <h1><%=message %></h1>
    <%} %>
	</form>
	<a href = "UserRegister" >New User? Register</a>
	<a href = "forget-password">Forgot password?</a>
</body>
</html>