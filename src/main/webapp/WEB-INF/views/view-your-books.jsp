<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@page import="library.management.entities.PurchasedBook"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script >
function goBack() {
    window.history.back();
}
</script>

<style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
            background: url('/LibraryManagement/resources/images/userimg34.avif') center center fixed;
            background-size: 100% 100%;
            background-repeat: no-repeat;
                        margin-bottom: 30px;
            
        }

        h1 {
        margin-top:40px;
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
        	display:block; 	
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 10px;
            padding: 15px;
            background-color: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .book-details {
            margin-top: 10px;
            display:block;
        }

        .book-name {
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
            display:block;
        }

        .book-price {
        display:block;
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
            display:block;
        }

        .order-date,
        .book-count {
            margin-top: 10px;
            color: #555;
            font-weight: bold;
            display:block;
        }
    </style>
</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
<h1>Your purchased books</h1>
<% List<PurchasedBook> bookList = (List<PurchasedBook>)request.getAttribute("bookList"); %>


    <div class="order-container">
        <% for (PurchasedBook purchasedBook : bookList) { 
        	
        	String bookCover = Base64.getEncoder().encodeToString(
					(purchasedBook.getBookCover())
							.getBytes(1, (int) 
							(purchasedBook.getBookCover()
									.length())));
        
        %>
            <div class="order-card">
                <div class="book-details">
                    <div class="book-name"><%= purchasedBook.getBookName() %></div>
                    <div class="book-price">
                        <span class="rupees-symbol">&#8377;</span>
                        <%= purchasedBook.getBookPrice() * purchasedBook.getBookCount() %>
                    </div>
                    <img class="book-cover" src="data:image/png;base64, <%= bookCover %>" 
                    alt="<%= purchasedBook.getBookName() %>">
                </div>
                <div class="order-date">Order Date: <%= purchasedBook.getOrderDate() %></div>
                <div class="book-count">Book Count: <%= purchasedBook.getBookCount() %></div>
            </div>
        <% } %>
    </div>
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button></div> 
</body>





</html>