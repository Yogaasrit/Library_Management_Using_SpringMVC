<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
    <title>User Form</title>

    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        form {
            margin-bottom: 20px;
        }

        div {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        h2 {
            color: #007bff;
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin: 15px 0 10px;
        }

        input, select {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 15px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .error-message {
            color: #ff0000;
            margin-top: 5px;
        }
    </style>

    <script>
        function validateForm() {
            var userEmailId = document.getElementById('userEmailId').value;
            var phoneNo = document.getElementById('phoneNo').value;
            var dob = document.getElementById('dob').value;

            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            var phonePattern = /^[6-9]\d{9}$/;

            if (!emailPattern.test(userEmailId)) {
                document.getElementById('emailError').innerText = 'Enter a valid email address';
                return false;
            } else {
                document.getElementById('emailError').innerText = '';
            }

            if (!phonePattern.test(phoneNo)) {
                document.getElementById('phoneError').innerText = 'Enter a valid 10-digit phone number starting from 6 to 9';
                return false;
            } else {
                document.getElementById('phoneError').innerText = '';
            }

            var today = new Date();
            var dobDate = new Date(dob);

            var age = today.getFullYear() - dobDate.getFullYear();

            if (age < 15) {
                document.getElementById('dobError').innerText = 'You must be at least 15 years old';
                return false;
            } else {
                document.getElementById('dobError').innerText = '';
            }

            return true;
        }
    </script>
</head>
<body>
	
    <form:form modelAttribute="user" method="post" action="userForm" onsubmit="return validateForm();">

        <!-- Profile Update -->
        <div>
            <h2>Profile Update</h2>

            <label for="userName">User Name:</label>
            <form:input path="userName" required="true" />

            <label for="userEmailId">Email:</label>
            <form:input path="userEmailId" id="userEmailId" required="true" />
            <span class="error-message" id="emailError"></span>

            <label for="phoneNo">Phone Number:</label>
            <form:input path="phoneNo" id="phoneNo" />
            <span class="error-message" id="phoneError"></span>
            
             <label for="address">Address:</label>
        	<form:input path="address" />

            <label for="dob">Date of Birth:</label>
            <form:input path="dob" id="dob" />
            <span class="error-message" id="dobError"></span>
            
            <label for="gender">Gender:</label>
        <form:select path="gender">
            <form:option value="Male" label="Male" />
            <form:option value="Female" label="Female" />
            <!-- Add more options as needed -->
        </form:select>
        </div>

        <!-- Profile Photo Update -->
        

        <!-- Add other form fields as needed -->

        <input type="submit" value="Submit" />

    </form:form>
    
    
    
    <div>
            <h2>Profile Photo Update</h2>

            <form action="profile-pic" method="post" enctype="multipart/form-data">
                <label for="profile-pic"><b>Profile pic : </b></label>
                <input type="file" placeholder="Choose cover" 
                name="profile-pic" id="profile-pic">
                <br><br>
                <input type="submit" />
            </form>
        </div>

</body>
</html>
