<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book Form</title>
    <script>function goBack() {
        window.history.back();
    }
        function validateForm() {
            var quantity = document.getElementById('bookQuantity').value;
            var edition = document.getElementById('bookEdition').value;
            var price = document.getElementById('bookPrice').value;
            var publishDate = document.getElementById('bookPublishDate').value;

            if (!isInteger(quantity) || !isInteger(edition) || !isInteger(price)) {
                alert('Quantity, Edition, and Price must be integers.');
                return false;
            }

            var currentDate = new Date();
            var selectedDate = new Date(publishDate);

            if (selectedDate > currentDate) {
                alert('Publish date must be in the past.');
                return false;
            }

            return true;
        }

        function isInteger(value) {
            return /^\d+$/.test(value);
        
    }</script>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 0;
            display: flex;
            height: 100vh;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
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
    </style>
</head>
<header>
        <jsp:include page="admin-header.jsp" />
    </header>
<body>

    <form action="handle-add-books" onsubmit="return validateForm()" method = "post" enctype="multipart/form-data">
<h2>Add book</h2>
        <label for="bookName">Book Name:</label>
        <input type="text" id="bookName" name="bookName" required><br>

        <label for="bookPrice">Book Price:</label>
        <input type="text" id="bookPrice" name="bookPrice" required><br>

        <label for="bookGenre">Book Genre:</label>
        <input type="text" id="bookGenre" name="bookGenre" required><br>

        <label for="bookPublication">Book Publication:</label>
        <input type="text" id="bookPublication" name="bookPublication" required><br>

        <label for="bookPublishDate">Book Publish Date:</label>
        <input type="date" id="bookPublishDate" name="bookPublishDate" required><br>

        <label for="bookEdition">Book Edition:</label>
        <input type="text" id="bookEdition" name="bookEdition" required><br>

        <label for="bookQuantity">Book Quantity:</label>
        <input type="text" id="bookQuantity" name="bookQuantity" required><br>

        <label for="authorName">Author Name:</label>
        <input type="text" id="authorName" name="authorName" required><br>

        <!-- <label for="bookCover">Book Cover:</label>
        <input type="file" id="bookCover" name="bookCover" required><br> -->
        
        <label for="bookCover">Book Cover : </label>
            <input type="file" placeholder="Choose cover" 
            name="bookCover" id="bookCover"  required>
            <br><br>

        <input type="submit">
        <div class="button-container">
        <button class="button" onclick="goBack()">Back</button></div> 
    </form>

  
</body>
</html>

