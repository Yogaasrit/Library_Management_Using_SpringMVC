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
        }
        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
        }
        .readonly-input {
            background-color: #f4f4f4;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ddd;
        }
        .error-message {
            color: red;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <h2>Payment Page</h2>
    <% String grandTotal = request.getAttribute("grandTotal")+""; %>

    <form action="view-your-books" method="post" onsubmit="return validateForm()">
        <label>Select Payment Method:</label>
        <select name="paymentMethod">
            <option value="COD">Cash on Delivery</option>
            <option value="Card">Credit/Debit Card</option>
        </select>

        <div id="cardDetails" style="display: none;">
            <label>Card Number:</label>
            <input type="text" name="cardNumber" placeholder="Card Number" required>

            <label>Expiry Date:</label>
            <input type="text" name="expiryDate" placeholder="MM/YY" required>

            <label>Card Type:</label>
            <select name="cardType">
                <option value="Visa">Visa</option>
                <option value="MasterCard">MasterCard</option>
                <!-- Add other card types as needed -->
            </select>

            <label>CVV:</label>
            <input type="text" name="cvv" placeholder="CVV" required>

            <div id="errorMessages"></div>
        </div>

        <label>Grand Total:</label>
        <input type="text" class="readonly-input" value="<%= grandTotal %>" readonly>

        <button type="submit">Confirm Payment</button>
    </form>

    <script>
        function validateForm() {
            var cardDetails = document.getElementById('cardDetails');
            var errorMessageContainer = document.getElementById('errorMessages');
            errorMessageContainer.innerHTML = ''; // Clear previous error messages

            if (cardDetails.style.display === 'block') {
                var cardNumber = document.getElementsByName('cardNumber')[0].value;
                var expiryDate = document.getElementsByName('expiryDate')[0].value;
                var cvv = document.getElementsByName('cvv')[0].value;

                if (!/^\d{16}$/.test(cardNumber)) {
                    showError('Card Number should be a 16-digit number');
                    return false;
                }

                if (!/^\d{3}$/.test(cvv)) {
                    showError('CVV should be a 3-digit number');
                    return false;
                }

                var currentDate = new Date();
                var currentYear = currentDate.getFullYear() % 100;
                var currentMonth = currentDate.getMonth() + 1;

                var enteredYear = parseInt(expiryDate.split('/')[1]);
                var enteredMonth = parseInt(expiryDate.split('/')[0]);

                if (enteredYear < currentYear || (enteredYear === currentYear && enteredMonth < currentMonth)) {
                    showError('Expiry Date should not be in the past');
                    return false;
                }
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

        document.querySelector('select[name="paymentMethod"]').addEventListener('change', function () {
            var cardDetails = document.getElementById('cardDetails');
            cardDetails.style.display = this.value === 'Card' ? 'block' : 'none';
        });
    </script>
</body>
</html>
