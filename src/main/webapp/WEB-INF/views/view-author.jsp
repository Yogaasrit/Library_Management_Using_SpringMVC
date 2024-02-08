<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of Authors</title>
</head>
<body>
<h1>LIST OF AUTHORS</h1>
<% List<Book> authors = (List<Book>)request.getAttribute("authorList"); %>
	
	
	<%
		if(authors.isEmpty()){ 
	%>
		No author found!!
	<%} 
	else{
		for(Book author : authors)
		{
		%>	
			
			<h1><%= author.getAuthorName() %></h1>
		<%}
	} %>
</body>
</html>