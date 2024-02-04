<%@page import="library.management.entities.ReserveBook"%>
<%@page import="java.util.Base64"%>
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
        body {
            font-family: Arial, sans-serif;
            background: url('/LibraryManagement/resources/images/userimg4.avif') center center fixed;
             background-size: 100% 100%;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
        }
.container{
        margin-top:100px;
        margin-bottom:100px;}
        .card-container {
            text-align: center;
        }

        .card {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 20px;
            margin: 20px;
            max-width: 200px;
            background-color: rgba(255,255,255,0.3);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: inline-block;
            text-align: left;
        }

        .card img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        h2 {
            color: black;
            text-align: center;
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
    </style>
</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
    <div class="container">
    <h2>Reserve Books</h2>

    <% List<ReserveBook> bookList = (List<ReserveBook>)request.getAttribute("list");

    if (bookList.isEmpty()) { %>
        <p>No reserved books found.</p>
    <% } else { %>
        <div class="card-container">
            <% for (ReserveBook book : bookList) {
                String bookCover = Base64.getEncoder().encodeToString(
                    (book.getBookCover())
                    .getBytes(1, (int) 
                    (book.getBookCover()
                            .length()))); %>
                
                <div class="card">
                    <img class="book-cover" src="data:image/png;base64, <%=bookCover%>" alt="<%= book.getBookName() %>" />
                    <h2><%= book.getBookName() %></h2>
                    <p><strong>User ID:</strong> <%= book.getUserId() %></p>
                    <p><strong>Book ID:</strong> <%= book.getBookId() %></p>
                    <% if(book.getBookQuantity() == 0) { %>
                        <p>Out of stock</p>
                    <% } else { %>
                        <a class = "action-button" href="handleReserveBorrowBook?bookId=<%= book.getBookId() %>&reserveId=<%= book.getReserveId()%>">Borrow Book</a>
                    <% } %>
                </div>
            <% } %>
        </div>
    <% } %>
</div>
    <script>
        function borrowBook(bookId, reserveId) {
            // Add logic to handle borrowing the book for the specified book and reserve
            alert("Borrow Book clicked for Book ID: " + bookId + ", Reserve ID: " + reserveId);
            // You can redirect or perform additional actions as needed
        }
    </script>
</body>

<jsp:include page="footer.jsp" />

</html>
