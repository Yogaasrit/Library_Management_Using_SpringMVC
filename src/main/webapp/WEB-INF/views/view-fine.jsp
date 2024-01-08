<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment</title>
</head>
<body>
	<h1>Pay your fine</h1>

	<%
	String borrowedId = (String)request.getAttribute("borrowedId");
	%>
	<%=borrowedId%>
	<form action="pay-fine-form">
		<input type="hidden" name="borrowedId"
			value="<%=borrowedId%>"> <input
			type="submit">
	</form>
</body>
</html>