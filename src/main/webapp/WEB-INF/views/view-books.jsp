<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>List of books</h1>
	<% List<Book> books = (List<Book>)request.getAttribute("bookList"); %>
	
	
	<%
		if(books.isEmpty()){ 
	%>
		No books found!!
	<%} 
	else{
		for(Book book : books)
		{
		%>	
			<!-- print all columns in table -->
			<h1><%= book.getBookName() +" " + book.getBookId()%></h1>
		<%}
	} %>
	
</body>
</html>