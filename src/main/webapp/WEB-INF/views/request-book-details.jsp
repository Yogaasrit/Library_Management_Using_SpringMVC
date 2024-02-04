<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Details</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
        background: url('/LibraryManagement/resources/images/userimg8.jpg') center center fixed;
        background-size: cover;
    }

    .card {
        max-width: 500px;
        margin: 0 auto;
        background-color: rgba(255,255,255,0.3);
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.9);
        border-radius: 5px;
        margin-top:70px;
         margin-bottom:30px;
    }

    h2 {
        color: black;
        text-align: center;
    }

    .book-details-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
    }

    .book-image-container {
        flex: 1;
    }

    .book-info {
        flex: 2;
        padding-left: 20px;
    }

    .book-image {
        max-width: 100%;
        height: auto;
    }

    .action-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .action-button a{
    text-decoration:none;
    color:white;
    }
    .action-button, .back-btn {
        background-color: #4CAF50;
        color: white;
        padding: 8px 16px;
        border: none;
        cursor: pointer;
        text-decoration:none;
    }

    .action-button:hover, .back-btn:hover {
        background-color: #45a049;
    }

    .counter-container {
        display: flex;
        align-items: center;
    }

    .counter {
        margin-right: 10px;
    }

    .counter-buttons {
        display: flex;
        align-items: center;
    }

    .counter-button {
        background-color: #4CAF50;
        color: white;
        padding: 8px;
        border: none;
        cursor: pointer;
    }

    .counter-button:hover {
        background-color: #45a049;
    }
</style>

</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
    
    <div class="card">
        <%
            String ctx = application.getContextPath();
            String targetUrl = ctx + "/User";
        %>
        <h2>Confirm your order</h2>

        <div class="book-details-container">
            <div class="book-image-container">
                <% Book book = (Book) request.getAttribute("book");
                    String bookCover = Base64.getEncoder().encodeToString(
                    (book.getBookCover())
                        .getBytes(1, (int) 
                            (book.getBookCover()
                                .length())));
                %>
                <img class="book-image" src="data:image/png;base64, <%= bookCover %>" alt="<%= book.getBookName() %>" />
            </div>

            <div class="book-info">
                <h2><%= book.getBookName() %></h2>
                <p><strong>ID:</strong> <%= book.getBookId() %></p>
                <p><strong>Price:</strong> <%= book.getBookPrice() %></p>
                <p><strong>Genre:</strong> <%= book.getBookGenre() %></p>
                <p><strong>Publication:</strong> <%= book.getBookPublication() %></p>
                <p><strong>Publish Date:</strong> <%= book.getBookPublishDate() %></p>
                <p><strong>Edition:</strong> <%= book.getBookEdition() %></p>
                <p><strong>Author:</strong> <%= book.getAuthorName() %></p>
            </div>
        </div>

        <div class="action-container">
            <button class="action-button" onclick="confirmOrder()">
                <a href ="#" id="confirmLink">
                    Confirm</a>
            </button>
        
            <div class="counter-container">
                <label for="bookCount" class="counter">Book Count:</label>
                <div class="counter-buttons">
                    <button class="counter-button" onclick="decrementCount()">-</button>
                    <span id="bookCount">1</span>
                    <button class="counter-button" onclick="incrementCount()">+</button>
                </div>
            </div>

            <form action="backAction" method="post">
                <input type="submit" class="back-btn" value="Back">
            </form>
        </div>
    </div>
</body>
    <script >
    let count = 1; // Initial count value
   
    function decrementCount() {
        if (count > 1) {
            count--;
            updateCount();
        }
    }

    function incrementCount() {
       
            count++;
            updateCount();
        
    }

    function updateCount() {        	
            document.getElementById("bookCount").innerText = count;
    }
    function confirmOrder() {
        // Display the confirmation alert
        alert("Order confirmed for " + count + " books!");

        // Update count in the href and navigate to the link
        var href = "request-book-handle?bookId=<%= book.getBookId() %>&count=" + count;
        window.location.href = href;

        // Add additional logic for confirming the order, if needed
    }</script>
</html>
