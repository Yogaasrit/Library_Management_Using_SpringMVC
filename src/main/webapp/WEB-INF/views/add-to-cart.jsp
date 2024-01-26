<%-- <%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <style>
        /* Add your CSS styles here */
        .cart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .cart-card {
            border: 1px solid #ddd;
            padding: 10px;
            width: 300px;
        }
        .card-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .card-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .total-price {
            font-weight: bold;
        }
        .no-items-message {
            font-size: 18px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <% Map<String, Integer> cart = (Map<String, Integer>) request.getAttribute("cart"); %>
    <% List<Book> allBooks = (List<Book>) request.getAttribute("books"); %>

    <h2>Your Cart</h2>
    
    <% if (cart == null || cart.isEmpty()) { %>
        <p class="no-items-message">No items in the cart.</p>
    <% } else { %>
        <div class="cart-container">
            <% double totalPrice = 0; %>
            <% for (Map.Entry<String, Integer> entry : cart.entrySet()) { %>
                <% String bookId = entry.getKey(); %>
                <% int count = entry.getValue(); %>
                <% for (Book book : allBooks) { %>
                    <% if ((book.getBookId()+"").equals(bookId)) { %>
                        <div class="cart-card" id="book<%= book.getBookId() %>">
                            <img class="card-image" src="data:image/jpg;base64, <%= book.getBookCover() %>" alt="Book Cover">
                            <h3><%= book.getBookName() %></h3>
                            <p>Quantity: <%= count %></p>
                            <p>Price: <%= count * book.getBookPrice() %></p>
                            <div class="card-actions">
                                <button type="button" onclick="removeFromCart('<%= book.getBookId() %>')">Remove</button>
                            </div>
                        </div>
                        <% totalPrice += count * book.getBookPrice(); %>
                    <% } %>
                <% } %>
            <% } %>
        </div>

        <!-- Assuming you have a confirm order endpoint -->
        <form id="confirmOrderForm" method="post" action="confirm-order">
            <input type="hidden" id="cartData" name="cartData">
            <button type="button" onclick="confirmOrder()">Confirm Order</button>
        </form>
    <% } %>

    <script>
        function removeFromCart(bookId) {
            var cartData = document.getElementById("cartData");
            var bookElement = document.getElementById("book" + bookId);
            if (bookElement) {
                bookElement.remove();

                // Update cartData input value with the updated cart map
                updateCartData();
            }
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
</body>
</html>
 --%>
 
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
        /* Add your CSS styles here */
        .cart-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .cart-card {
            border: 1px solid #ddd;
            padding: 10px;
            width: 300px;
        }
        .card-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .card-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }
        .total-price {
            font-weight: bold;
        }
        .no-items-message {
            font-size: 18px;
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
    <% Map<String, Integer> cart = (Map<String, Integer>) request.getAttribute("cart"); %>
    <% List<Book> allBooks = (List<Book>) request.getAttribute("books"); %>

    <h2>Your Cart</h2>
    
    <% if (cart == null || cart.isEmpty()) { %>
        <p class="no-items-message">No items in the cart.</p>
    <% } else { %>
        <div class="cart-container">
            <% double totalPrice = 0; %>
            <% for (Map.Entry<String, Integer> entry : cart.entrySet()) { %>
                <% String bookId = entry.getKey(); %>
                <% int count = entry.getValue(); %>
                <% for (Book book : allBooks) { %>
                    <% if ((book.getBookId()+"").equals(bookId)) { %>
                        <div class="cart-card" id="book<%= book.getBookId() %>">
                            <img class="card-image" src="data:image/jpg;base64, <%= book.getBookCover() %>" alt="Book Cover">
                            <h3><%= book.getBookName() %></h3>
                            <p>Quantity: <%= count %></p>
                            <p>Price: <%= count * book.getBookPrice() %></p>
                            <div class="card-actions">
                                <button type="button" onclick="removeFromCart('<%= book.getBookId() %>', <%= count %>)">Remove</button>
                            </div>
                        </div>
                        <% totalPrice += count * book.getBookPrice(); %>
                    <% } %>
                <% } %>
            <% } %>
        </div>

        <!-- Assuming you have a confirm order endpoint -->
        <form id="confirmOrderForm" method="post" action="confirm-order">
            <input type="hidden" id="cartData" name="cartData">
            <button type="button" onclick="confirmOrder()">Confirm Order</button>
        </form>
    <% } %>
</body>
</html>
 