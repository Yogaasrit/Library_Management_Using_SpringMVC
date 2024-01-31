<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
            background-color: #f3f3f3;
            background: url('/LibraryManagement/resources/images/userimg28.avif') center center fixed;
             background-size: 100% 100%;
            background-repeat: no-repeat;
        }

        header {
            margin-bottom: 20px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .cart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .cart-card {
            border: 1px solid #ddd;
            padding: 10px;
            width: 300px;
            background-color: rgba(255,255,255, 0.3);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            transform-origin: center bottom;
        }

        .cart-card:hover {
            transform: scale(1.05);
        }

        .card-image {
            width: 100%;
           border-bottom: 1px solid #ddd;
        }

        h3 {
            margin: 10px 0;
            color: #333;
        }

        p {
            margin: 5px 0;
            color: black;
        }

        .card-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        button {
            background-color: #ff9900;
            color: #fff;
            border: none;
            padding: 8px;
            cursor: pointer;
        }

        button:hover {
            background-color: #e59400;
        }

        .total-price {
            font-weight: bold;
            color: #333;
            margin-top: 20px;
        }
		h2{
		text-align: center;
		color: black;}
        .no-items-message {
            font-size: 18px;
            margin-top: 20px;
            color: #555;
        }

        #confirmOrderForm {
            margin-top: 20px;
        }
    </style>
    <script>
        function removeFromCart(bookId, newQuantity) {
            var bookElement = document.getElementById("book" + bookId);
            if (bookElement) {
                bookElement.remove();

                // Call the server to update the book count
                updateBookCountOnServer(bookId, newQuantity);

                // Update cartData input value with the updated cart map
                updateCartData();
            }
        }

        function updateBookCountOnServer(bookId, newQuantity) {
            // Use AJAX to call the server endpoint
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "removeFromCart?bookId=" + bookId + "&quantity=" + newQuantity, true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        console.log(xhr.responseText);
                    } else {
                        console.error("Error updating book count on server");
                    }
                }
            };
            xhr.send();
        }

        function updateCartData() {
            var cartData = document.getElementById("cartData");
            var cartMap = {};

            // Iterate over each cart card and update the cart map
            var cartCards = document.querySelectorAll('.cart-card');
            cartCards.forEach(function (card) {
                var bookId = card.id.substring(4); // Removing 'book' prefix
                var quantity = card.querySelector('p').textContent.split(":")[1].trim();
                cartMap[bookId] = parseInt(quantity);
            });

            // Set the updated cart map as the input value
            cartData.value = JSON.stringify(cartMap);
        }

        function confirmOrder() {
            // Call updateCartData() to make sure the cartData is up-to-date
            updateCartData();

            // Submit the form
            document.getElementById("confirmOrderForm").submit();
        }
    </script>
</head>
<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>
    
    <% Map<String, Integer> cart = (Map<String, Integer>) request.getAttribute("cart"); %>
    <% List<Book> allBooks = (List<Book>) request.getAttribute("books"); %>

    <h2>Your Cart</h2>
    
    <% if (cart == null || cart.isEmpty()) { %>
        <p class="no-items-message">No items in the cart.</p>
    <% } else { %>
        <div class="cart-container">
            <% double totalPrice = 0; %>
            <% for (Map.Entry<String, Integer> entry : cart.entrySet()) { 
            	
            
            %>
                <% String bookId = entry.getKey(); %>
                <% int count = entry.getValue(); %>
                <% for (Book book : allBooks) { 
                
                	String bookCover = Base64.getEncoder().encodeToString(
                            (book.getBookCover())
                                    .getBytes(1, (int) 
                                    (book.getBookCover()
                                            .length())));
                
                %>
                    <% if ((book.getBookId()+"").equals(bookId)) { %>
                        <div class="cart-card" id="book<%= book.getBookId() %>">
                            <img class="card-image" src="data:image/jpg;base64, <%= bookCover %>" alt="Book Cover">
                            <h3><%= book.getBookName() %></h3>
                            <p>Quantity: <%= count %></p>
                            <p>Price: <%= count * book.getBookPrice() %></p>
                            <div class="card-actions">
                                <button type="button" onclick="removeFromCart('<%= book.getBookId() %>', <%= count %>)">Remove</button>
                            </div>
                        </div>
                       <%--  <% totalPrice += count * book.getBookPrice(); %> --%>
                    <% } %>
                <% } %>
            <% } %>
        </div>

		
		
		
        <!-- If books removed, remove confirm order -->
        <form id="confirmOrderForm" method="post" action="confirm-order">
            <input type="hidden" id="cartData" name="cartData">
            <button type="button" onclick="confirmOrder()">Confirm Order</button>
        </form>

    <% } %>
</body>
</html>
