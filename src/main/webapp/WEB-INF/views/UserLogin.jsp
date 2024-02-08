<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/LibraryManagement/resources/css/user-login.css">
   
    <style>
    form{
    background-color: rgba(255, 255, 255, 0.3);}
.form-container {
    max-width: 400px;
    margin: auto;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.8);
    border: 1px solid #ccc;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    position: relative;
    z-index: 1;
}


.form-container button, .form-container a.reject {
    display: inline-block;
    padding: 8px 16px;
    margin-right: 10px;
    text-decoration: none;
    border: 1px solid transparent;
    border-radius: 4px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.form-container button[name="action"][value="approve"] {
    background-color: #28a745;
    color: #fff;
}


.form-container a.reject {
    background-color: #dc3545;
    color: #fff;
}


.form-container button:hover, .form-container a.reject:hover {
    background-color: #007bff;
    border-color: #007bff;
}


body {
    background: url('/LibraryManagement/resources/images/userimg17.jpg') center center fixed;
    background-size: 100% 100%;
    background-repeat: no-repeat;
}

form{
	margin-left: 720px;
}


form h1 {
    text-align: center;
    color: #333;
}

form h4 {
    margin: 10px 0;
}

form input {
    width: 100%;
    padding: 8px;
    margin: 5px 0 15px;
    display: inline-block;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
    background-color: rgba(255, 255, 255, 0.5);
}

form label {
    display: block;
    margin-top: 10px;
    color: #333;
}

form .captcha-container {
    margin-bottom: 15px;
    display: flex;
    align-items: center;
}

header h1{
color:#fff;
}

form .captcha-container span {
    flex-grow: 1;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

form .captcha-container input {
    flex-grow: 2;
}

form .captcha-container button {
    flex-grow: 1;
    background-color: #007BFF;
    color: white;
    padding: 8px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

form .captcha-container button:hover {
    background-color: blue;
}

form button[type="submit"] {
    background-color: #007bff;
    color: #fff;
}

form button[type="submit"]:hover {
    background-color: #0056b3;
}
    
    </style>
    
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

// on page load, captcha load.
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
<header><jsp:include page="user-header.jsp" /></header>
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
        <%@ include file ="errmessage.jsp" %>
        
        
        
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
            <h3><%= message %></h3>
        <% } %>
        
        
         <a href="UserRegister">New User? Register</a>
    	 <a href="forget-password">Forgot password?</a>
    </form>
    
    
    
</body>
</html>
