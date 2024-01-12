<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Register</title>
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
    <form name="registerForm" action="handle-register" method="post" onsubmit="return validateForm()">
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
