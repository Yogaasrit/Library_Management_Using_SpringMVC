<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ordering Page</title>
    <style>
         body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }

        .book-card {
            display: flex;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 20px;
            padding: 20px;
            background-color: rgba(255,255,255,0.3);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
        }

        .book-wrapper {
            display: flex;
            align-items: left; /* Vertically center align items */
        }

        .book-image-container {
            flex: 2;
            text-align: left;
            padding: 10px;
        }

        .book-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .book-details-container {
           display: block;
           align-items: left;
        }

        .book-details p {
            margin: 0;
            margin-bottom: 10px;
            color: #555;
        }

        .counter-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }

        .counter {
            font-size: 18px;
            margin: 0 10px;
        }

        .counter-buttons {
            display: flex;
            align-items: center;
        }

        .counter-button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 5px;
            transition: background-color 0.3s;
        }

        .counter-button:hover {
            background-color: #45a049;
        }

        .button-container {
            display: flex;
            justify-content: center;
        }

        .back-button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            
            border-radius: 20px;
            cursor: pointer;
            margin: 0 10px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .back-button:hover {
            background-color: #45a049;
        }
        
         div {
                 display: block;
                 align-items: center;
             }
             
         h1 {
         	color:#fff;
         }
         
         .action-button a{
         	text-decoration: none;
         	color:#fff;
         	
         }
         
         .action-button{
         	padding: 10px 20px;
         	background-color: #2980b9;
         	border-radius: 20px;
         	border: none;
         	margin-top: 5px;
         	}
    </style>
</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
    <h1>Ordering Page</h1>

    <% Book book = (Book) request.getAttribute("book");
    
    String bookCover = Base64.getEncoder().encodeToString(
			(book.getBookCover())
					.getBytes(1, (int) 
					(book.getBookCover()
							.length())));
    
    %>

	 <div class="book-card">
        <!-- Wrapper for Book Image and Container Details -->
        <div class="book-wrapper">
            <!-- Left side: Book Image -->
            <div class="book-image-container">
                <img class="book-image" src="data:image/png;base64, <%= bookCover %>" alt="<%= book.getBookName() %>" />
            </div>

            <!-- Right side: Book Details -->
            <div class="book-details-container">
                <p><strong>Book ID:</strong> <%= book.getBookId() %></p>
                <p><strong>Book Name:</strong> <%= book.getBookName() %></p>
                <p><strong>Book Price:</strong> <%= book.getBookPrice() %></p>
                <p><strong>Book Genre:</strong> <%= book.getBookGenre() %></p>
                <p><strong>Book Publication:</strong> <%= book.getBookPublication() %></p>
                <p><strong>Book Publish Date:</strong> <%= book.getBookPublishDate() %></p>
                <p><strong>Book Edition:</strong> <%= book.getBookEdition() %></p>
                <p><strong>Book Quantity:</strong> <%= book.getBookQuantity() %></p>
                <p><strong>Author Name:</strong> <%= book.getAuthorName() %></p>
            </div>
        </div>
    </div>
    <!-- Book counter -->
    <div class="counter-container">
        <label for="bookCount" class="counter">Book Count:</label>
        <div class="counter-buttons">
            <button class="counter-button" onclick="decrementCount()">-</button>
            <span id="bookCount">1</span>
            <button class="counter-button" onclick="incrementCount()">+</button>
        </div>
    </div>
    

     <!-- Buttons -->
    <div class="button-container">
        <button class="back-button" onclick="goBack()">Back</button>
       
	 <button class="action-button" onclick="confirmOrder()">
		<a href ="#" id="confirmLink">
			Confirm</a></button>
    	</div> 
     
   
    <script>
        let count = 1; // Initial count value
        const maxQuantity = <%= book.getBookQuantity() %>; // Maximum allowed quantity

        function decrementCount() {
            if (count > 1) {
                count--;
                updateCount();
            }
        }

        function incrementCount() {
            if (count < maxQuantity) {
                count++;
                updateCount();
            } else {
                alert("Maximum limit reached");
            }
        }

        function updateCount() {        	
                document.getElementById("bookCount").innerText = count;
        }

        function goBack() {
            window.history.back();
        }

        function confirmOrder() {
            // Display the confirmation alert
            alert("Order confirmed for " + count + " books!");

            // Update count in the href and navigate to the link
            var href = "add-to-cart?bookId=<%= book.getBookId() %>&count=" + count;
            window.location.href = href;

            // Add additional logic for confirming the order, if needed
        }
    </script>
</body>
</html>

    