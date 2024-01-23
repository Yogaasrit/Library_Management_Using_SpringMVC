<%@page import="library.management.entities.ReserveBook"%>
<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.RequestBook"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Blob"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reserve Books</title>
    <style>
        /* Add your CSS styles for the card here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            margin: 20px;
            max-width: 300px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        img {
            max-width: 100%;
            height: auto;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>Reserve Books</h1>

    <% List<ReserveBook> bookList = (List<ReserveBook>)request.getAttribute("list"); %>

    <% for (ReserveBook book : bookList) { %>
        <div class="card">
            <h2><%= book.getBookName() %></h2>
            <p><strong>User ID:</strong> <%= book.getUserId() %></p>
            <p><strong>Book ID:</strong> <%= book.getBookId() %></p>
            
            
          
            <!-- Assuming bookCover is stored as a Blob -->
            <% Blob blob = book.getBookCover(); %>
            <img src="<%= blobToBase64(blob) %>" alt="Book Cover" style="max-width: 100%; height: auto;">
            <%if(book.getBookQuantity() == 0){ %>
            Out of stock
            <%}else{ %>
            <a href = "handleReserveBorrowBook?bookId=<%= book.getBookId() %>">Borrow Book</a>
            <%} %>
        </div>
    <% } %>

    <%-- Method to convert Blob to Base64 --%>
    <%!
        private String blobToBase64(Blob blob) {
            try {
                byte[] bytes = blob.getBytes(1, (int) blob.length());
                return Base64.getEncoder().encodeToString(bytes);
            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }
    %>
</body>
</html>
