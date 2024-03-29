<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Book</title>
<script>
    function validateForm() {
        var userId = document.getElementById('bookid').value;

        // Check if the input is an integer
        if (!Number.isInteger(parseInt(userId))) {
            alert("Please enter a valid integer for User ID.");
            return false; // Prevent form submission
        }

        return true; // Allow form submission
    }
    window.onload = function () {
        var message = '<%= request.getAttribute("message") %>';

        // Check if the message is not empty
        if (message !== "null" && message.trim() !== '') {
            alert(message);
        }
    };
    function goBack() {
        window.history.back();
    }
</script>
</head>
<body>
    <form action="deletebook" onsubmit="return validateForm()">
        <h2>Enter the book ID to Delete:</h2><br>
        <input type="text" name="bookid" id="bookid">
        <input type="submit" value="Delete">
    </form>
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button></div> 
</body>
</html>
