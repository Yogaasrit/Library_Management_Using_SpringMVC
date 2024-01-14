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
        }

        .book-card {
            display: flex;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: auto;
        }

        .book-image-container {
            flex: 1;
            text-align: center;
            padding: 10px;
        }

        .book-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .book-details-container {
            flex: 2;
            text-align: left;
            padding: 10px;
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

        .button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 0 10px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Borrow Page</h1>

    <% Book book = (Book) request.getAttribute("book");
    
    String bookCover = Base64.getEncoder().encodeToString(
			(book.getBookCover())
					.getBytes(1, (int) 
					(book.getBookCover()
							.length())));
    
    %>

    <div class="book-card">
        <!-- Left side: Book Image -->
        <div class="book-image-container">
            <img class="book-image" src="data:image/png;base64, <%= bookCover %>" alt="<%= book.getBookName() %>" />
        </div>

        <!-- Right side: Book Details -->
        <div class="book-details-container">
            <p><strong>Book ID:</strong> <%= book.getBookId() %></p>
            <p><strong>Book Name:</strong> <%= book.getBookName() %></p>
            <p><strong>Book Genre:</strong> <%= book.getBookGenre() %></p>
            <p><strong>Book Publication:</strong> <%= book.getBookPublication() %></p>
            <p><strong>Book Publish Date:</strong> <%= book.getBookPublishDate() %></p>
            <p><strong>Book Edition:</strong> <%= book.getBookEdition() %></p>
            <p><strong>Book Quantity:</strong> <%= book.getBookQuantity() %></p>
            <p><strong>Author Name:</strong> <%= book.getAuthorName() %></p>
        </div>
    </div>

    
    

     <!-- Buttons -->
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button>
       
	 <button class="button" onclick="confirmOrder()">
		<a href ="#" id="confirmLink">
			Confirm</a></button>
    	</div> 
     
   
    <script>
        let count = 1; //  count value

        function goBack() {
            window.history.back();
        }

        function confirmOrder() {
            // Display the confirmation alert
            alert("Order confirmed for " + count + " books!");

            // Update count in the href and navigate to the link
            var href = "confirm-borrowbook?bookId=<%= book.getBookId() %>&count=" + count;
            window.location.href = href;

            // Add additional logic for confirming the order, if needed
        }
    </script>
</body>
</html>

    