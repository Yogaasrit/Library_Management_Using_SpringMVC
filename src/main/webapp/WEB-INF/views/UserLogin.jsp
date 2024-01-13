<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/LibraryManagement/resources/css/user-login.css">
    <script>
function generateCaptcha() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let captcha = '';
    for (let i = 0; i < 4; i++) {
        captcha += characters.charAt(Math.floor(Math.random() * characters.length));
    }
    return captcha;
}
function initCaptcha() {
    const captchaElement = document.getElementById('captchaDisplay');
    captchaElement.textContent = generateCaptcha();
}

document.addEventListener('DOMContentLoaded', function() {
    initCaptcha();
});

    function validateCaptcha() {
        const userInput = document.getElementById('userInput').value;
        const captchaText = document.getElementById('captchaDisplay').textContent;

        if (userInput !== captchaText) {
            alert('Captcha is incorrect. Please try again.');
            initCaptcha(); // Refresh captcha
            return false; // Prevent form submission
        }

        return true; // Allow form submission
    }
    </script>
</head>
<body>
    <form action="validate-user" method="post" onsubmit="return validateCaptcha()">
        <h1>USER</h1>
        <h4>Enter Email ID :</h4>
        <input type="text" name="emailId" required>
        <h4>Enter password :</h4>
        <input type="password" name="passWord" required><br>
        <label for="userInput">Captcha</label>
        <div class="captcha-container">
            <span id="captchaDisplay">Captcha</span>
            <input type="text" id="userInput" placeholder="Enter Captcha" required>
            <button type="button" class="refresh-captcha" onclick="initCaptcha()">
                <i class="fas fa-redo"></i>
            </button>
        </div>
        <button type="submit">Login</button>
        
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
            <h3><%= message %></h3>
        <% } %>
        
        
         <a href="UserRegister">New User? Register</a>
    	 <a href="forget-password">Forgot password?</a>
    </form>
</body>
</html>
