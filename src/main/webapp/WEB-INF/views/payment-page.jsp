<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Page</title>
    <style>
  body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            background-color: rgba(255,255,255,0.3);
        }
        select {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
             background-color: rgba(255,255,255,0.3);
        }
        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
        }
        .readonly-input {
            background-color: rgba(255,255,255,0.3);
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ddd;
        }
        .error-message {
            color: red;
            margin-top: 5px;
        }
        #cardImages {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        #cardImages img {
            width: 50px;
            height: auto;
        }  
        h2{
        text-align: center;
        color: black;}
          </style>
</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
    <h2>Payment Page</h2>
    <% String grandTotal = request.getAttribute("grandTotal")+""; %>

    <form action="view-your-books" method="post">
        <label>Select Payment Method:</label>
        <select name="paymentMethod" id="paymentMethodSelect">
            <option value="COD">Cash on Delivery</option>
            <option value="Card">Credit/Debit Card</option>
        </select>

        <div id="cardDetails" style="display: none;">
            <label>Card Number:</label>
            <input type="text" name="cardNumber" id="cardNumber" placeholder="Card Number" required pattern="\d{16}" title="Please enter a 16-digit card number">

            <label>Expiry Date:</label>
            <input type="text" name="expiryDate" id="expiryDate" placeholder="MM/YY" required pattern="(0[1-9]|1[0-2])\/\d{2}" title="Please enter a valid expiry date (MM/YY)">

            <label>Card Type:</label>
            <select name="cardType" required>
                <option value="Visa">Visa</option>
                <option value="MasterCard">MasterCard</option>
                <!-- Add other card types as needed -->
            </select>

            <label>CVV:</label>
            <input type="text" name="cvv" id="cvv" placeholder="CVV" required pattern="\d{3}" title="Please enter a valid 3-digit CVV">

            <div id="errorMessages"></div>
        </div>

        <label>Grand Total:</label>
        <input type="text" class="readonly-input" value="<%= grandTotal %>" readonly>

        <button type="button" id="confirmPaymentButton" onclick="validateAndSubmit()">Confirm Payment</button>
    </form>

    <script>
        function validateAndSubmit() {
            var selectedPaymentMethod = document.getElementById('paymentMethodSelect').value;

            if (selectedPaymentMethod === 'Card') {
                if (!validateForm()) {
                    return;
                }
            }

            document.forms[0].submit();
        }

        function validateForm() {
            var cardNumber = document.getElementById('cardNumber').value;
            var expiryDate = document.getElementById('expiryDate').value;
            var cvv = document.getElementById('cvv').value;

            var cardNumberPattern = /\d{16}/;
            var expiryDatePattern = /(0[1-9]|1[0-2])\/\d{2}/;
            var cvvPattern = /\d{3}/;

            var errorMessages = [];

            if (!cardNumberPattern.test(cardNumber)) {
                errorMessages.push('Please enter a valid 16-digit card number');
            }

            if (!expiryDatePattern.test(expiryDate)) {
                errorMessages.push('Please enter a valid expiry date (MM/YY)');

                // Additional validation for expiry month (1 to 12)
                var enteredMonth = parseInt(expiryDate.split('/')[0]);
                if (enteredMonth < 1 || enteredMonth > 12) {
                    errorMessages.push('Expiry month should be between 1 and 12');
                }
            }

            var currentYear = new Date().getFullYear() % 100;
            var enteredYear = parseInt(expiryDate.split('/')[1]);

            if (enteredYear < currentYear) {
                errorMessages.push('Expiry Year should not be in the past');
            }

            if (!cvvPattern.test(cvv)) {
                errorMessages.push('Please enter a valid 3-digit CVV');
            }

            var errorMessageContainer = document.getElementById('errorMessages');
            errorMessageContainer.innerHTML = '';

            if (errorMessages.length > 0) {
                for (var i = 0; i < errorMessages.length; i++) {
                    showError(errorMessages[i]);
                }
                return false;
            }

            return true;
        }

        function showError(message) {
            var errorMessageContainer = document.getElementById('errorMessages');
            var errorParagraph = document.createElement('p');
            errorParagraph.className = 'error-message';
            errorParagraph.textContent = message;
            errorMessageContainer.appendChild(errorParagraph);
        }

        document.getElementById('paymentMethodSelect').addEventListener('change', function () {
            var cardDetails = document.getElementById('cardDetails');
            cardDetails.style.display = this.value === 'Card' ? 'block' : 'none';
        });
    </script>
</body>
</html>





