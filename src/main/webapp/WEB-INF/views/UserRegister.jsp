<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Register</title>
    <style>
        body {
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }
        header h1{
        color:#fff;
        }

        form {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.3); /* Adjust alpha value for transparency */
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }

        form p {
            margin: 10px 0;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px;
            display: inline-block;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: rgba(255,255,255,0.5);
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left : 150px;
        }

        button:hover {
            background-color: #45a049;
        }

        h1,h2 {
            text-align: center;
            color: #333;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #333;
        }
    </style>
     <script>
        function validateForm() {
            var emailId = document.forms["registerForm"]["emailId"].value;
            var userName = document.forms["registerForm"]["userName"].value;
            var phoneNo = document.forms["registerForm"]["phoneNo"].value;
            var dob = document.forms["registerForm"]["dob"].value;
            var address = document.forms["registerForm"]["address"].value;
            var gender = document.forms["registerForm"]["gender"].value;
            var password = document.forms["registerForm"]["password"].value; // Corrected here
            var confirmPassword = document.forms["registerForm"]["confirmPassword"].value;

            if (emailId === "" || userName === "" || phoneNo === "" || dob === "" || address === "" || gender === "" || password === "" || confirmPassword === "") {
                alert("All fields must be filled out");
                return false;
            }

            // Validate email format
            var emailRegex = /^\S+@\S+\.\S+$/;
            if (!emailRegex.test(emailId)) {
                alert("Invalid email format");
                return false;
            }

            // Validate phone number
            var phoneRegex = /^[6-9]\d{9}$/;
            if (!phoneRegex.test(phoneNo)) {
                alert("Invalid phone number");
                return false;
            }

            // Validate date of birth
            var currentDate = new Date();
            var minDate = new Date();
            minDate.setFullYear(minDate.getFullYear() - 15);

            var selectedDate = new Date(dob);

            if (selectedDate > currentDate || selectedDate > minDate) {
                alert("Minimum age to register is 15");
                return false;
            }

            // Validate password format
            var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$/;
            if (!passwordRegex.test(password)) {
                alert("Invalid password format");
                return false;
            }

            // Validate password match
            if (password !== confirmPassword) {
                alert("Passwords do not match");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<header><jsp:include page="user-header.jsp" /></header>
    <form name="registerForm" action="handle-register" method="post" onsubmit="return validateForm()">
    <h2>Register</h2>
        <p>Email Id:</p>
        <input type="text" name="emailId">
        <p>User Name:</p>
        <input type="text" name="userName">
        <p>Phone No:</p>
        <input type="text" name="phoneNo">
        <p>Date of Birth:</p>
        <input type="date" name="dob" required>
        <p>Address:</p>
        <input type="text" name="address">
        <p>Gender:</p>
        <select name="gender">
            <option value="male">Male</option>
            <option value="female">Female</option>
            <!-- Add more options as needed -->
        </select>
        <p>Password:</p>
        <input type="password" name="password">
        <p>Confirm Password:</p>
        <input type="password" name="confirmPassword">
        <button type="submit">Register</button>
        
        <% String message =(String) request.getAttribute("message"); 
        if(message!=null){ %>
    <h1><%=message %></h1> 
    <a href="UserLogin">Login</a>
    <%} %>
    
    
    </form>
    
</body>
</html>
