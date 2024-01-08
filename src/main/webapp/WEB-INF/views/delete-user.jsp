
<%@page import="library.management.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
        function validateForm() {
            var userId = document.getElementById('userid').value;

            // Check if the input is an integer
            if (!Number.isInteger(parseInt(userId))) {
                alert("Please enter a valid integer for User ID.");
                return false; // Prevent form submission
            }

            return true; // Allow form submission
        }

        // This function will be called when the page loads
        window.onload = function () {
            var message = '<%= request.getAttribute("message") %>';

            // Check if the message is not empty
            if (message.trim() !== '') {
                alert(message);
            }
        };
    </script>
</head>
<body>
 <form action="deleteuser" onsubmit="return validateForm()">
        <h2>Enter the user ID to Delete:</h2><br>
        <input type="text" name="userid" id="userid">
        <input type="submit" value="Delete">
    </form>

</body>
</html>