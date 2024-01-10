<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
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
    <h2>Reset Password</h2>
    <form action="reset-password" onsubmit="return validatePassword()">
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
