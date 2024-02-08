<%@page import="library.management.entities.FeedBack"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Details Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
            background: url('/LibraryManagement/resources/images/userimg9.jpg') center center fixed;
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
            align-items: left;
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
           text-align: left;
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
            border-radius: 4px;
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
         	.reviews-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-around;
        margin-top: 20px;
    }

    .review-card {
        border: 1px solid #ddd;
        border-radius: 8px;
        margin: 10px;
        padding: 15px;
        background-color: rgba(255, 255, 255, 0.3);
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        max-width: 300px;
        text-align: center;
    }

    .star-rating {
        margin-bottom: 10px;
    }

    .star {
        color: gold;
        font-size: 20px;
    }

    .comment {
        color: black;
    }
    </style>
</head>
<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>
    
    <%
		String ctx = application.getContextPath();
		//out.print(ctx);
		String targetUrl = ctx + "/User";
	%>

    <h1>Book Detail</h1>
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
	<%if(book.getBookQuantity()>0){%>
    <div class="button-container">
        <button class="action-button"> 
            <a href="<%=targetUrl%>/handlePlaceOrder?bookId=<%=book.getBookId()%>">Add to cart</a>
        </button>
        <button class="action-button">
            <a href="<%=targetUrl%>/handleBorrowBook?bookId=<%=book.getBookId()%>">Borrow book</a>
        </button>
    </div>
	<%}else{ %>
	<div class="button-container">
        <button class="action-button"> 
            <a href="<%=targetUrl%>/handleRequest?bookId=<%=book.getBookId()%>">Request</a>
        </button>
        <button class="action-button" onclick="reserveBook()">
            <a href="<%=targetUrl%>/handleReserve?bookId=<%=book.getBookId()%>">Reserve</a>
        </button>
    </div>
	<%} %>
	<% List<FeedBack> list = (List<FeedBack>)request.getAttribute("list");
	
	if (list != null && !list.isEmpty()) { %>
    <h2>Book Reviews</h2>
    <div class="reviews-container">
        <% for (FeedBack feedback : list) { %>
            <div class="review-card">
                <div class="star-rating">
                    <%-- Display stars based on the star count --%>
                    <% for (int i = 0; i < feedback.getStar(); i++) { %>
                        <span class="star">&#9733;</span>
                    <% } %>
                </div>
                <p class="comment"><strong>Comment:</strong> <%= feedback.getComment() %></p>
            </div>
        <% } %>
    </div>
<% } else { %>
    <p>No reviews available for this book.</p>
<% } %>
    <!-- Buttons -->
    <div class="button-container">
        <button class="back-button" onclick="goBack()">Back</button>
    </div>

    <script>
    function reserveBook() {
        // Display an alert when the "Reserve" button is clicked
        alert("Reserved confirmed!");
    }
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
 