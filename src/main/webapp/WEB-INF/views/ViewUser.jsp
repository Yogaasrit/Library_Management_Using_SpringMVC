<%@page import="library.management.entities.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script >
function goBack() {
    window.history.back();
}
</script>
<body>
<h1>USER LIST</h1>
<%  List<User> list = (List<User>) request.getAttribute("userList");
	if(list.isEmpty()){
		out.print("No users found from list!!");
	}
	else{
		for(User user : list)
		{
			out.print(user.getUserId()+":"+user.getUserName()+":"+user.getUserEmailId()+"<br>");
		}
	}	
%>
<div class="button-container">
        <button class="button" onclick="goBack()">Back</button></div> 
</body>
</html>