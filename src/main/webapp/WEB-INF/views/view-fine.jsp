<%@page import="library.management.entities.FineDetails"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Page</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            color: black;
            margin: 0;
            padding: 20px;
            text-align: center;
            background: url('/LibraryManagement/resources/images/userimg.jpg') center center fixed;
        	background-size: cover;
        }

        h1 {
            margin-top: 100px;
            color: #333;
        }

        .payment-form {
            width: 400px;
            margin: 20px auto;
            padding: 15px;
            background-color: rgba(255, 255, 255, 0.5);
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: left;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input, select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.3);
        }

        button {
            background-color: #2980b9;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        .container{
        margin-right:600px;
        }

        button:hover {
            background-color: #216799;
        }
    </style>
</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
    <div class="container">
    <h1>Payment Page</h1>
    <% FineDetails finedetails = (FineDetails) request.getAttribute("finedetails"); %>
    <%if(finedetails != null){ %>
    
    
    <div class="payment-form">
        <form id="paymentForm" method="post" action="update-pay-fine">
            <div class="form-group">
                <label for="fineAmount">Fine Amount:</label>
                <input type="text" id="fineAmount" name="fineAmount" value="<%= finedetails.getFineAmount()%>" readonly>
            </div>

            <div class="form-group">
                <label for="cardName">Name on card:</label>
                <input type="text" id="cardName" name="cardName" required>
            </div>

            <div class="form-group">
                <label for="cardType">Card Type:</label>
                <select id="cardType" name="cardType" required>
                    <option value="credit">Credit Card</option>
                    <option value="debit">Debit Card</option>
                </select>
            </div>

            <div class="form-group">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber" required>
            </div>

            <div class="form-group">
                <label for="cvv">CVV:</label>
                <input type="password" id="cvv" name="cvv" required>
            </div>

            <div class="form-group">
                <label for="expiryDate">Expiry Date (MM/YYYY):</label>
                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YYYY" required>
            </div>

            <!-- Modified "Pay Now" button with finedetails.getBorrowedId as a parameter -->
            <button type="button" onclick="validateAndPay('<%= finedetails.getBorrowedId() %>')">Pay Now</button>
        </form>
    </div>
    
    <%} else{%>
    
    <p>Go back and Pay the book fine!</p>
    <%} %>
    
    
</div>
    <script>
        function validateAndPay(borrowedId) {
            if (
                validateCardName() &&
                validateCardNumber() &&
                validateCVV() &&
                validateExpiryDate()
            ) {
                
                // Redirect to the controller with borrowedId as a parameter
                window.location.href = 'update-paid-fine?borrowedId=' + borrowedId;
            } else {
                // Validation failed, do not submit the form
                alert('Please fix the errors in the form before submitting.');
            }
        }

        function validateCardName() {
            var cardName = document.getElementById('cardName').value;
            if (!/^[a-zA-Z\s]+$/.test(cardName)) {
                alert('Card name should contain only letters and spaces.');
                return false;
            }
            return true;
        }

        function validateCardNumber() {
            var cardNumber = document.getElementById('cardNumber').value;
            if (!/^\d{16}$/.test(cardNumber)) {
                alert('Card number should contain 16 digits.');
                return false;
            }
            return true;
        }

        function validateCVV() {
            var cvv = document.getElementById('cvv').value;
            if (!/^\d{3}$/.test(cvv)) {
                alert('CVV should contain 3 digits.');
                return false;
            }
            return true;
        }

        function validateExpiryDate() {
            var expiryDate = document.getElementById('expiryDate').value;
            var parts = expiryDate.split('/');

            if (parts.length !== 2) {
                alert('Invalid expiry date format. Please use MM/YYYY.');
                return false;
            }

            var selectedMonth = parseInt(parts[0], 10);
            var selectedYear = parseInt(parts[1], 10);

            var currentDate = new Date();
            var currentYear = currentDate.getFullYear();
            var currentMonth = currentDate.getMonth() + 1; // Months are zero-based

            if (
                isNaN(selectedMonth) ||
                isNaN(selectedYear) ||
                selectedMonth < 1 ||
                selectedMonth > 12 ||
                selectedYear < currentYear ||
                (selectedYear === currentYear && selectedMonth < currentMonth)
            ) {
                alert('Expiry date should be in the future.');
                return false;
            }
            return true;
        }
    </script>
</body>
<jsp:include page="footer.jsp" />
</html>
