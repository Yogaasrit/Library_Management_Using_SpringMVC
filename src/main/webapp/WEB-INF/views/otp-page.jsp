<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OTP Verification</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
	padding: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
	background: url('/LibraryManagement/resources/images/userimg46.jpg')
		center center fixed;
background-size: 100% 100%;
            background-repeat: no-repeat; }

form {
	background-color: rgba(255, 255, 255, 0.3);
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 300px;
}

label {
	display: block;
	margin-bottom: 8px;
}

input {
	width: 100%;
	padding: 8px;
	margin-bottom: 16px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: rgba(255, 255, 255, 0.5);
}
/* Style for the "Resend OTP" link */
a.resend-otp {
    display: inline-block;
    padding: 10px;
    text-decoration: none;
    background-color: #007bff; /* Button background color */
    color: #fff; /* Button text color */
    border: none;
    border-radius: 4px; /* Optional: Rounded corners */
    cursor: pointer;
    width: 100%;
    text-align: center; /* Center text within the button */
    display: block; /* Make it a block-level element */
    margin-top: 10px; /* Adjust margin as needed */
    transition: background-color 0.3s ease; /* Optional: Smooth hover effect */
}

/* Hover effect for the "Resend OTP" link */
a.resend-otp:hover {
    background-color: #0056b3; /* Change the background color on hover */
}

button {
	background-color: #4caf50;
	color: #fff;
	padding: 10px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	width: 100%;
}

button:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
<header><jsp:include page="user-header.jsp" /></header>

	<form action="verify-otp" method="post">
		<label for="otp">Enter OTP:</label> <input type="text" id="otp"
			name="otp" required>
		<button type="submit">Verify OTP</button>
		<a href="resend-otp">Resend OTP</a>
		<%
		String message = (String) request.getAttribute("message");
		%>
		<%
		if (message != null) {
		%>
		<h3><%=message%></h3>
		<%
		}
		%>
	</form>
</body>
</html>
