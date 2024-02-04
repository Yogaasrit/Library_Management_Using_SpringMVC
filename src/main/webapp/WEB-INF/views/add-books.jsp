<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book Form</title>
    <script>
        function goBack() {
            window.history.back();
        }

        function validateForm() {
            resetErrorMessages();

            var quantity = document.getElementById('bookQuantity').value;
            var edition = document.getElementById('bookEdition').value;
            var price = document.getElementById('bookPrice').value;
            var publishDate = document.getElementById('bookPublishDate').value;

            if (!isInteger(quantity) || !isInteger(edition) || !isInteger(price)) {
                displayErrorMessage('bookQuantity', 'Quantity must be an integer.');
                displayErrorMessage('bookEdition', 'Edition must be an integer.');
                displayErrorMessage('bookPrice', 'Price must be an integer.');
                return false;
            }

            var currentDate = new Date();
            var selectedDate = new Date(publishDate);

            if (selectedDate > currentDate) {
                displayErrorMessage('bookPublishDate', 'Publish date must be in the past.');
                return false;
            }

            return true;
        }

        function isInteger(value) {
            return /^\d+$/.test(value);
        }

        function resetErrorMessages() {
            var elements = document.getElementsByClassName('error-message');
            for (var i = 0; i < elements.length; i++) {
                elements[i].innerHTML = '';
            }
        }

        function displayErrorMessage(elementId, message) {
            var errorMessageElement = document.getElementById(elementId + 'Error');
            errorMessageElement.innerHTML = message;
        }
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 0;
            display: flex;
            height: 100vh;
            background: url('/LibraryManagement/resources/images/adminimg8.jpg') center center fixed;
            background-size: cover;
        }

        form {
            background-color: transparent;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            height:90%;
            margin-left: 410px;
            margin-top: 100px;
            max-width: 600px; /* Adjust the maximum width as needed */
            justify-content: center;
            margin-bottom:120px;
            padding:50px;
        }

        label {
            display: inline-block;
            width: 40%;
            margin-bottom: 8px;
        }

        input {
            width: 55%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.5);
        }

        input[type="file"] {
            width: 55%;
            margin-top: 5px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left:120px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        h2{
            text-align: center;
        }

        .error-message {
            color: red;
            margin-top: -10px;
            margin-bottom: 10px;
        }
    </style>
</head>
<header>
    <jsp:include page="admin-header.jsp" />
</header>
<body>

    <form action="handle-add-books" onsubmit="return validateForm()" method="post" enctype="multipart/form-data">
        <h2>Add book</h2>
        <label for="bookName">Book Name:</label>
        <input type="text" id="bookName" name="bookName" required>
        <div class="error-message" id="bookNameError"></div>

        <label for="bookPrice">Book Price:</label>
        <input type="text" id="bookPrice" name="bookPrice" required>
        <div class="error-message" id="bookPriceError"></div>

        <label for="bookGenre">Book Genre:</label>
        <input type="text" id="bookGenre" name="bookGenre" required>
        <div class="error-message" id="bookGenreError"></div>

        <label for="bookPublication">Book Publication:</label>
        <input type="text" id="bookPublication" name="bookPublication" required>
        <div class="error-message" id="bookPublicationError"></div>

        <label for="bookPublishDate">Book Publish Date:</label>
        <input type="date" id="bookPublishDate" name="bookPublishDate" required>
        <div class="error-message" id="bookPublishDateError"></div>

        <label for="bookEdition">Book Edition:</label>
        <input type="text" id="bookEdition" name="bookEdition" required>
        <div class="error-message" id="bookEditionError"></div>

        <label for="bookQuantity">Book Quantity:</label>
        <input type="text" id="bookQuantity" name="bookQuantity" required>
        <div class="error-message" id="bookQuantityError"></div>

        <label for="authorName">Author Name:</label>
        <input type="text" id="authorName" name="authorName" required>
        <div class="error-message" id="authorNameError"></div>

        <label for="bookCover">Book Cover : </label>
        <input type="file" placeholder="Choose cover" name="bookCover" id="bookCover" required>
        <div class="error-message" id="bookCoverError"></div>
        <br><br>

        <input type="submit">
        <div class="button-container">
            <button class="button" onclick="goBack()">Back</button>
        </div>
    </form>
    
</body>
<jsp:include page="footer.jsp" />
</html>
