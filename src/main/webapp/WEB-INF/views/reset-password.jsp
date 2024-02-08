<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <style>body {
    background: url('/path/to/your/background-image.jpg') center center fixed;
    background-size: cover;
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
     background: url('/LibraryManagement/resources/images/userimg45.jpg') center center fixed;
            background-size: cover;
}

form {
    max-width: 400px;
    margin: auto;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.3);
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
    display: block;
    margin-bottom: 8px;
}

input {
    width: 100%;
    padding: 8px;
    margin-bottom: 16px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: rgba(255, 255, 255, 0.5);
}
header h1{
color:#fff;
}
button {
    background-color: #4caf50;
    color: #fff;
    padding: 10px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width: 100%;
}

button:hover {
    background-color: #45a049;
}

h2 {
    text-align: center;
    color: #333;
}
    </style>
    <script>
        function validatePassword() {
            var newPassword = document.getElementById("newPassword").value;

            // Minimum 8 characters
            if (newPassword.length < 8) {
                alert("Password must be at least 8 characters long.");
                return false;
            }

            // Check for at least one lowercase, one uppercase, one special character, and one number
            var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$/;

            if (!regex.test(newPassword)) {
                alert("Password must contain at least one lowercase letter, one uppercase letter, one special character, and one number.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
   <header><jsp:include page="user-header.jsp" /></header>
    <form action="reset-password" method = "post" onsubmit="return validatePassword()">
     <h2>Reset Password</h2>
        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required>
        <br>
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>
        <br>
        <button type="submit">Reset Password</button>
    </form>
</body>
</html>
