<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>User Register</title>
    <style>
        body {
            background: url('/LibraryManagement/resources/images/userimg42.avif') center center fixed;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        header h1 {
            color: #fff;
        }

        form {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.3);
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 1;
        }

        form p {
            margin: 10px 0;
        }

        input,
        select {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px;
            display: inline-block;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: rgba(255, 255, 255, 0.5);
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 150px;
        }

        button:hover {
            background-color: #45a049;
        }

        h1,
        h2 {
            text-align: center;
            color: #333;
        }

        a {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #333;
        }

        .error-message {
            color: red;
            margin-top: -10px;
            margin-bottom: 10px;
        }

        .mandatory {
            color: red;
            margin-right: 5px;
        }

        .password-constraint {
            font-size: 12px;
            color: #555;
        }
    </style>
    <script>
        function validateForm() {
            // Reset error messages
            document.getElementById("emailError").innerHTML = "";
            document.getElementById("userNameError").innerHTML = "";
            document.getElementById("phoneNoError").innerHTML = "";
            document.getElementById("dobError").innerHTML = "";
            document.getElementById("addressError").innerHTML = "";
            document.getElementById("genderError").innerHTML = "";
            document.getElementById("passwordError").innerHTML = "";
            document.getElementById("confirmPasswordError").innerHTML = "";

            var isValid = true;

            var emailId = document.forms["registerForm"]["emailId"].value;
            var userName = document.forms["registerForm"]["userName"].value;
            var phoneNo = document.forms["registerForm"]["phoneNo"].value;
            var dob = document.forms["registerForm"]["dob"].value;
            var address = document.forms["registerForm"]["address"].value;
            var gender = document.forms["registerForm"]["gender"].value;
            var password = document.forms["registerForm"]["password"].value;
            var confirmPassword = document.forms["registerForm"]["confirmPassword"].value;

            // Validate presence of values
            if (emailId === "") {
                document.getElementById("emailError").innerHTML = "Email is required.";
                isValid = false;
            } else {
                // Validate email format
                var emailRegex = /^\S+@\S+\.\S+$/;
                if (!emailRegex.test(emailId)) {
                    document.getElementById("emailError").innerHTML = "Invalid email format.";
                    isValid = false;
                }
            }

            if (userName === "") {
                document.getElementById("userNameError").innerHTML = "User Name is required.";
                isValid = false;
            }

            if (phoneNo === "") {
                document.getElementById("phoneNoError").innerHTML = "Phone No is required.";
                isValid = false;
            } else {
                // Validate phone number format
                var phoneRegex = /^[6-9]\d{9}$/;
                if (!phoneRegex.test(phoneNo)) {
                    document.getElementById("phoneNoError").innerHTML = "Invalid phone number.";
                    isValid = false;
                }
            }

            if (dob === "") {
                document.getElementById("dobError").innerHTML = "Date of Birth is required.";
                isValid = false;
            } else {
                // Validate date of birth
                var currentDate = new Date();
                var minDate = new Date();
                minDate.setFullYear(minDate.getFullYear() - 15);

                var selectedDate = new Date(dob);

                if (selectedDate > currentDate || selectedDate > minDate) {
                    document.getElementById("dobError").innerHTML = "Minimum age to register is 15.";
                    isValid = false;
                }
            }

            if (address === "") {
                document.getElementById("addressError").innerHTML = "Address is required.";
                isValid = false;
            }

            if (gender === "") {
                document.getElementById("genderError").innerHTML = "Gender is required.";
                isValid = false;
            }

            if (password === "") {
                document.getElementById("passwordError").innerHTML = "Password is required.";
                isValid = false;
            } else {
                // Validate password format
                var passwordRegex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]{8,}$/;
                if (!passwordRegex.test(password)) {
                    document.getElementById("passwordError").innerHTML = "Invalid password format.";
                    isValid = false;
                }
            }

            if (confirmPassword === "") {
                document.getElementById("confirmPasswordError").innerHTML = "Confirm Password is required.";
                isValid = false;
            } else {
                // Validate password match
                if (password !== confirmPassword) {
                    document.getElementById("confirmPasswordError").innerHTML = "Passwords do not match.";
                    isValid = false;
                }
            }

            return isValid;
        }
    </script>
</head>

<body>
    <header>
        <jsp:include page="user-header.jsp" />
    </header>
    <form name="registerForm" action="handle-register" method="post" onsubmit="return validateForm()">
        <h2>Register</h2>
        <p><span class="mandatory">*</span>Email Id:</p>
        <input type="text" name="emailId">
        <div class="error-message" id="emailError"></div>

        <p><span class="mandatory">*</span>User Name:</p>
        <input type="text" name="userName">
        <div class="error-message" id="userNameError"></div>

        <p><span class="mandatory">*</span>Phone No:</p>
        <input type="text" name="phoneNo">
        <div class="error-message" id="phoneNoError"></div>

        <p><span class="mandatory">*</span>Date of Birth:</p>
        <input type="date" name="dob" required>
        <div class="error-message" id="dobError"></div>

        <p><span class="mandatory">*</span>Address:</p>
        <input type="text" name="address">
        <div class="error-message" id="addressError"></div>

        <p><span class="mandatory">*</span>Gender:</p>
        <select name="gender">
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">others</option>
        </select>
        <div class="error-message" id="genderError"></div>

        <p><span class="mandatory">*</span>Password:</p>
        <input type="password" name="password">
        <div class="error-message" id="passwordError"></div>
        <p class="password-constraint">Password should have 1 upper case, 1 lower case, 1 digit, 1 special character, and at least 8 characters.</p>

        <p><span class="mandatory">*</span>Confirm Password:</p>
        <input type="password" name="confirmPassword">
        <div class="error-message" id="confirmPasswordError"></div>

        <button type="submit">Register</button>

        <% String message =(String) request.getAttribute("message"); 
        if(message!=null){ %>
        <h1><%=message %></h1>
        <a href="UserLogin">Login</a>
        <%} %>
    </form>
</body>

</html>
