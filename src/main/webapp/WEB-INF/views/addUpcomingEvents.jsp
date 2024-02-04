<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Management</title>
     <style>
        body {
           font-family: Arial, sans-serif;
            background: url('/LibraryManagement/resources/images/adminimg18.avif') center center fixed;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
        }

        .form-container {
            width: 50%;
            margin: auto;
            padding: 20px;
            background-color: rgba(255,255,255,0.3);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }

        button {
            background-color: #28a745;
            color: #fff;
            padding: 10px;
            border: none;
            cursor: pointer;
        }
        
        .center-container {
        text-align: center;
    }
        h2{
text-align: center;
margin-top : 80px;}
    </style>

    <script>
        function validateEventDate() {
            var eventDateInput = document.getElementById('eventDate');
            var eventDate = new Date(eventDateInput.value);
            var today = new Date();

            if (eventDate < today) {
                alert('Event date cannot be in the past.');
                eventDateInput.value = ''; // Clear the input value
                return false;
            }

            return true;
        }
    </script>
</head>
<body>
<header>
        <jsp:include page="admin-header.jsp" />
    </header>
    <h2>Add Events</h2>

    <div class="form-container">
        <form action="upcoming-events-detail" method="post" onsubmit="return validateEventDate()">
            <div class="form-group">
                <label for="eventDetails">Event Details:</label>
                <input type="text" id="eventDetails" name="eventDetails" required>
            </div>

            <div class="form-group">
                <label for="eventDate">Event Date:</label>
                <input type="date" id="eventDate" name="eventDate" required>
            </div>
			
			<div class="center-container">
			<button type="submit" onclick="return window.confirm('Are you sure you want to add event?')">Submit</button>
			</div>     
        </form>
    </div>
</body>
<jsp:include page="footer.jsp" />

</html>
