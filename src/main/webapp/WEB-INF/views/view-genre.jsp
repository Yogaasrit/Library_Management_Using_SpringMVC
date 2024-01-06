<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
	<%
	List<Book> genres = (List<Book>) request.getAttribute("genreList");
	%>
	<%
	if (genres.isEmpty()) {
	%>
	No books found!!
	<%
	} else {
	for (Book genre : genres) {
	%>
	<h1><%=genre.getBookGenre()%></h1>
	<%
	}
	}
	%>
</body>
</html>