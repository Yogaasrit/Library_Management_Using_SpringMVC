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
    <title>Requested Books</title> 
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('/LibraryManagement/resources/images/userimg12.jpg') center center fixed;
             background-size: 100% 100%;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
        }.container{
        margin-top:100px;
        margin-bottom:100px;}

        .card-container {
            text-align: center; 
        }

        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            max-width: 200px; 
            background-color: rgba(255,255,255,0.3);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: inline-block;
            margin: 20px;
            text-align: left; 
        }

        .card img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .details {
            margin-left: 20px;
        }

        .book-cover {
            max-width: 100px;
            height: auto;
        }

        .action-button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
            margin-top: 10px;
            text-decoration: none;
        }

        .action-button:hover {
            background-color: #45a049;
        }
        
        h2{
        text-align: center;}
    </style>
</head>
<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>
    <div class="container">
    <h2>Requested Books</h2>

    <% List<RequestBook> bookList = (List<RequestBook>)request.getAttribute("list");

    if (bookList.isEmpty()) { %>
        <p>No requested books.</p>
    <% } else { %>
        <div class="card-container">
            <% for (RequestBook book : bookList) {
                String bookCover = Base64.getEncoder().encodeToString(
                    (book.getBookCover())
                    .getBytes(1, (int) 
                    (book.getBookCover()
                            .length()))); %>
                
                <div class="card">
                    <img class="book-cover" src="data:image/png;base64, <%=bookCover%>" alt="<%= book.getBookName() %>" />
                    <div class="details">
                        <h2><%= book.getBookName() %></h2>
                        <p><strong>User ID:</strong> <%= book.getUserId() %></p>
                        <p><strong>Book ID:</strong> <%= book.getBookId() %></p>
                        <p><strong>Request Status:</strong> <%= book.isRequestStatus() %></p>
                        <p><strong>Quantity:</strong> <%= book.getBookQuantity() %></p>
                        <p><strong>Book Quantity:</strong> <%= book.getCount() %></p>
                        <% if(book.getBookQuantity() > book.getCount()) { %>
                            <p>Out of stock</p>
                        <% } else { %>
                           <a class="action-button" href="handleRequestPlaceOrder?bookId=<%= book.getBookId() %>&requestId=<%= book.getRequestId()%>">Place order</a>
                        <% } %>
                    </div>
                </div>
            <% } %>
        </div>
    <% } %>
</div>
    <script>
        function placeOrder(bookId, requestId) {
            // Add logic to handle placing the order for the specified book and request
            alert("Place order clicked for Book ID: " + bookId + ", Request ID: " + requestId);
            // You can redirect or perform additional actions as needed
        }
    </script>
</body>


</html>
