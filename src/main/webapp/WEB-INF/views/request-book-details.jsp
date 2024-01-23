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
            margin: 20px auto;
            max-width: 600px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        p {
            margin: 10px 0;
        }

        img {
            max-width: 100%;
            height: auto;
            margin-top: 10px;
        }

        /* Add any additional styling as needed */
        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .confirm-btn, .back-btn {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        .confirm-btn {
            background-color: #4CAF50;
            color: #fff;
            border: none;
        }

        .back-btn {
            background-color: #f44336;
            color: #fff;
            border: none;
        }
    </style>

</head>
<body>
    <div class="card">
    <%
		String ctx = application.getContextPath();
		//out.print(ctx);
		String targetUrl = ctx + "/User";
	%>
    <h2>Confirm your order</h2>
        <% Book book = (Book) request.getAttribute("book");
        String bookCover = Base64.getEncoder().encodeToString(
        (book.getBookCover())
            .getBytes(1, (int) 
                (book.getBookCover()
                    .length())));
         %>
        <h2><%= book.getBookName() %></h2>
        <p><strong>ID:</strong> <%= book.getBookId() %></p>
        <p><strong>Price:</strong> <%= book.getBookPrice() %></p>
        <p><strong>Genre:</strong> <%= book.getBookGenre() %></p>
        <p><strong>Publication:</strong> <%= book.getBookPublication() %></p>
        <p><strong>Publish Date:</strong> <%= book.getBookPublishDate() %></p>
        <p><strong>Edition:</strong> <%= book.getBookEdition() %></p>
        <p><strong>Author:</strong> <%= book.getAuthorName() %></p>
		<img class="book-image" src="data:image/png;base64, <%= bookCover %>" alt="<%= book.getBookName() %>" />
        

        
            <button class="action-button" onclick="confirmOrder()">
		<a href ="#" id="confirmLink">
			Confirm</a></button>
        
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
