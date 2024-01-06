<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.BorrowBook"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        h1 {
            color: #333;
        }

        .order-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            max-width: 1200px;
            margin: 20px auto;
        }

        .order-card {
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 10px;
            padding: 15px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .book-details {
            margin-top: 10px;
        }

        .book-name {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .book-price {
            margin-top: 5px;
            font-size: 16px;
            color: #333;
            font-weight: bold;
        }

        .rupees-symbol {
            font-size: 14px;
            color: #333;
        }

        .book-cover {
            margin-top: 10px;
            max-width: 100%;
            height: auto;
        }

        .order-date,
        .book-count {
            margin-top: 10px;
            color: #555;
            font-weight: bold;
        }
    </style>
</head>
<body>
<h1>Your purchased books</h1>
<% List<BorrowBook> bookList = (List<BorrowBook>)request.getAttribute("borrowedBooks"); %>


    <div class="order-container">
        <% for (BorrowBook borrowBook : bookList) { 
        	
        	String bookCover = Base64.getEncoder().encodeToString(
					(borrowBook.getBookCover())
							.getBytes(1, (int) 
							(borrowBook.getBookCover()
									.length())));
        
        %>
            <div class="order-card">
                <div class="book-details">
                    <div class="book-name"><%= borrowBook.getBookName() %></div>
                    <img class="book-cover" src="data:image/png;base64, <%= bookCover %>" 
                    alt="<%= borrowBook.getBookName() %>">
                </div>
                <div class="order-date">Borrow Date: <%= borrowBook.getBorrowDate() %></div>
                <div class="book-count">Return Date: <%= borrowBook.getReturnDate() %></div>
                <div class="book-count">Fine : <%= borrowBook.getFine() %></div>
            </div>
        <% } %>
    </div>
</body>
</html>