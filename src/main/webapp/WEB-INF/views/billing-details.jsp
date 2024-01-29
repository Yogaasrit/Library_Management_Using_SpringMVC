<%@page import="java.util.Map"%>
<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Invoice</title>
    <style>
        /* Add your CSS styles here */
        body{
         background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
         background-size: cover;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .total-amount {
            font-weight: bold;
            margin-top: 20px;
            text-align: right;
            margin-right: 180px;
        }
        
        .proceed-to-pay-btn {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            
        }
        .shipping-form {
            margin-top: 20px;
            text-align: center;
        }
        .shipping-label {
            display: block;
            margin-bottom: 5px;
        }
        .shipping-input {
            width: 50%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
            background-color: rgba(255,255,255,0.3);
        }
        
        h2{
        	text-align: center;
        }
    </style>

</head>
<body>
<header>
	<jsp:include page="Header.jsp" />
</header>


    <h2>Bill Invoice</h2>
    <p><strong>
    Billing Date: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></strong>
    </p>

    <table>
        <thead>
            <tr>
                <th>Book Name</th>
                <th>Quantity</th>
                <th>Price per unit</th>
                <th>Total Amount</th>
            </tr>
        </thead>
        <tbody>
            <% List<Book> books = (List<Book>) request.getAttribute("books"); %>
            <% Map<String, Integer> updatedCart = (Map<String, Integer>) request.getAttribute("updatedCart"); %>

            <% double grandTotal = 0; %>
            <% for (Map.Entry<String, Integer> entry : updatedCart.entrySet()) { %>
                <% String bookId = entry.getKey(); %>
                <% int count = entry.getValue(); %>
                <% for (Book book : books) { %>
                    <% if ((book.getBookId()+"").equals(bookId)) { %>
                        <tr>
                            <td><%= book.getBookName() %></td>
                            <td><%= count %></td>
                            <td><%= book.getBookPrice() %></td>
                            <td><%= count * book.getBookPrice() %></td>
                        </tr>
                        <% grandTotal += count * book.getBookPrice(); %>
                    <% } %>
                <% } %>
            <% } %>
        </tbody>
    </table>
    <script>
    function validateAndProceed() {
        // Validate email
        var emailInput = document.getElementById('contactEmail');
        var emailError = document.getElementById('emailError');
        var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(emailInput.value)) {
            emailError.innerHTML = 'Invalid email address';
            alert('Invalid email address. Please enter a valid email.');
            return;
        } else {
            emailError.innerHTML = '';
        }

        // Validate phone number
        var phoneInput = document.getElementById('phoneNo');
        var phoneError = document.getElementById('phoneError');
        var phonePattern = /^\d{10}$/;
        if (!phonePattern.test(phoneInput.value)) {
            phoneError.innerHTML = 'Phone number must be 10 digits';
            alert('Phone number must be 10 digits. Please enter a valid phone number.');
            return;
        } else {
            phoneError.innerHTML = '';
        }

        // If both email and phone are valid, proceed to payment page
        var grandTotal = <%= grandTotal %>;
        alert('Validation successful! Proceeding to payment page.');
        window.location.href = 'payment-page?grandTotal=' + grandTotal;
    }
</script>
    <p class="total-amount">Grand Total: <%= grandTotal %></p>

    <div class="shipping-form">
    <label class="shipping-label" for="shippingAddress">Shipping Address:</label>
    <input class="shipping-input" type="text" id="shippingAddress" name="shippingAddress" required>

    <label class="shipping-label" for="contactEmail">Contact Email:</label>
    <input class="shipping-input" type="email" id="contactEmail" name="contactEmail" required>
    <span id="emailError" style="color: red;"></span>

    <label class="shipping-label" for="phoneNo">Phone Number:</label>
    <input class="shipping-input" type="tel" id="phoneNo" name="phoneNo" required>
    <span id="phoneError" style="color: red;"></span> <br><br>
    <a href="#" onclick="validateAndProceed()" class="proceed-to-pay-btn">Proceed to Pay</a>
    
</div>

<!-- Proceed to Pay button -->
</body>
</html>
