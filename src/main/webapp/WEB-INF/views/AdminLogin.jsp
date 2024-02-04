<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/LibraryManagement/resources/css/admin-login.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('/LibraryManagement/resources/images/adminimg1.jpg') center/cover no-repeat fixed;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background for the form */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2); /* Box shadow for a subtle effect */
            text-align: center;
            background-color: transparent;
            color:white;
        }

        h1 {
            color: #333;
        }

        .captcha-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 15px;
        }

        #captchaDisplay {
            flex: 1;
            background-color: #fff;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
             background-color: rgba(255, 255, 255, 0.5);
        }

        #userInput {
            flex: 1;
            margin-left: 10px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color:rgb(255,255,255,0.5);
            width: 150px; /* Adjust the width as needed */
        }
        input {
            
           
            background-color: rgba(255, 255, 255, 0.5);
        }

        .refresh-captcha {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 8px;
            border-radius: 5px;
            cursor: pointer;
            
        }

        button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 15px;
        }

        h3 {
            color: #ff0000; /* Red color for error message */
        }
        header {
            background-color: transparent;
            color: #fff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: fixed;
            top: 0;
            width: 100%;
            height: 50px;
            z-index: 1000;
        }

        header a {
            color: #fff;
            text-decoration: none;
            margin-left: 10px;
            font-size: 20px;
            display: inline-block;
            background-color: transparent;
            border:none;
        }

        header h1 {
            margin: 10px;
            font-size: 32px;
            color:#fff;
        }
		header :hover {
        color: #001f3f; /* Dark blue color */
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
<header>
        <h1>APJ Abdul Kalam Library</h1>
    </header>
    <form action="validate-admin" method="post" onsubmit="return validateCaptcha()">
        <h1>ADMIN</h1>
        <h4>Enter admin Email ID :</h4>
        <input type="text" name="adminEmailId" required>
        <h4>Enter admin password :</h4>
        <input type="password" name="adminPassword" required><br>
        <label for="userInput">Captcha</label>
        <div class="captcha-container">
            <span id="captchaDisplay">Captcha</span>
            <input type="text" id="userInput" placeholder="Enter Captcha" required>
            <button type="button" class="refresh-captcha" onclick="initCaptcha()">
                <i class="fas fa-redo"></i>
            </button>
        </div>
        <button type="submit">Login</button>
        <%@ include file = 'errmessage.jsp' %>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
            <h3><%= message %></h3>
        <% } %>
    </form>
</body>
</html>
