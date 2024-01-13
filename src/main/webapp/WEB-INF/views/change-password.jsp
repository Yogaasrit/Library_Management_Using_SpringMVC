<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <script>
        function validateForm() {
            var oldPassword = document.getElementById("oldPassword").value;
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;

            // Clear previous error messages
            document.getElementById("oldPasswordError").innerHTML = "";
            document.getElementById("newPasswordError").innerHTML = "";
            document.getElementById("confirmPasswordError").innerHTML = "";

            // Check if old password matches
            var actualOldPassword = '<%= request.getAttribute("password") %>';
            if (oldPassword !== actualOldPassword) {
                document.getElementById("oldPasswordError").innerHTML = "Old Password does not match.";
                return false;
            }

            // Check if new password and confirm password match
            if (newPassword !== confirmPassword) {
                document.getElementById("newPasswordError").innerHTML = "New Password and Confirm Password do not match.";
                return false;
            }

            // Check if old password and new password are not the same
            if (actualOldPassword === newPassword) {
                document.getElementById("newPasswordError").innerHTML = "New Password should be different from the Old Password.";
                return false;
            }

            // Check if new password meets criteria
            var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            if (!passwordRegex.test(newPassword)) {
                document.getElementById("newPasswordError").innerHTML = "New Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and be at least 8 characters long.";
                return false;
            }

            // Form is valid, allow submission
            return true;
        }
    </script>
</head>
<body>

    <h2>Change Password</h2>

    <form action="changePassword" method="post" onsubmit="return validateForm()">

        <!-- Old Password -->
        <label for="oldPassword">Old Password:</label>
        <input type="password" id="oldPassword" name="oldPassword" required />
        <div id="oldPasswordError" style="color: red;"></div>

        <!-- New Password -->
        <label for="newPassword">New Password:</label>
        <input type="password" id="newPassword" name="newPassword" required />
        <div id="newPasswordError" style="color: red;"></div>

        <!-- Confirm Password -->
        <label for="confirmPassword">Confirm Password:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required />
        <div id="confirmPasswordError" style="color: red;"></div>

        <br>

        <input type="submit" value="Change Password" />

    </form>

</body>
</html>

