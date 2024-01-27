<%@page import="library.management.entities.FreeBook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Free Books</title>
</head>
<body>

    <h2>Free Books</h2>

    <% List<FreeBook> freeBooks = (List<FreeBook>) request.getAttribute("freeBooks"); %>
    
    <% for (FreeBook freeBook : freeBooks) { %>
        <div>
            <p><strong>Title:</strong> <%= freeBook.getPdfName() %></p>
            <p><strong>Author:</strong> <%= freeBook.getPdfAuthorName() %></p>
            
            <!-- Assuming your controller endpoint is "/free-books/pdf" -->
            <a href="free-books-pdf?id=<%= freeBook.getPdfId() %>" target="_blank">Open PDF</a>
        </div>
        <hr>
    <% } %>

</body>
</html>
