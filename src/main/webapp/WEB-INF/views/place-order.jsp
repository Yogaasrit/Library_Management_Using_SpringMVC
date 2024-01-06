<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Place order</title>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        .book-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .book-cover {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .action-button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin: 0 10px;
        }

        .action-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Place Order</h1>

    <% List<Book> books = (List<Book>)request.getAttribute("books"); %>

    <% if (books.isEmpty()) { %>
        No books found!!
    <% } else { %>
        <% for (Book book : books) { 
        	String bookCover = Base64.getEncoder().encodeToString(
					(book.getBookCover())
							.getBytes(1, (int) 
							(book.getBookCover()
									.length())));
        %>
        
            <div class="book-card">
                <!-- Print all columns in the table -->
                <h1><%= book.getBookName() + " " + book.getBookId() %></h1>
                <img class="book-cover" src="data:image/png;base64, <%= bookCover %>" width="100" />

                <!-- Buttons below the book cover image -->
                <div class="button-container">
                    <button class="action-button"> <a href = "handlePlaceOrder?bookId=<%=book.getBookId()%>">Place Order</a></button>
                    <button class="action-button" >Borrow Book</button>
                </div>
            </div>
        <% } %>
    <% } %>
</body>
</html>