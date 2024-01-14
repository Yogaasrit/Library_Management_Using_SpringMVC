<%-- <%@page import="library.management.entities.User"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .card {
            width: 300px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 15px;
            display: inline-block;
            vertical-align: top;
            box-sizing: border-box;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .delete-button {
            background-color: #ff0000;
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
    
</head>
<body>
    <h1>USER LIST</h1>
    <%  
    List<User> list = (List<User>) request.getAttribute("userList");
    if (list.isEmpty()) {
        out.print("No users found from the list!!");
    } else {
        for (User user : list) {
    %>
    <div class="card">
        <p><strong>User ID:</strong> <%= user.getUserId() %></p>
        <p><strong>User Name:</strong> <%= user.getUserName() %></p>
        <p><strong>Email:</strong> <%= user.getUserEmailId() %></p>
        <button class="delete-button" onclick="deleteUser(<%= user.getUserId() %>)"><a href = "delete-user?userId=<%= user.getUserId() %>">Delete</a></button>
    </div>
    <%  
        }
    }   
    %>
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }

        function deleteUser(userId) {
            // Implement the logic to delete the user with the specified userId
            alert("Delete user with ID: " + userId);
        }
    </script>
</body>
</html>
 --%>
 
<%-- <%@page import="library.management.entities.ViewUserDetails"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .card {
            width: 300px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 15px;
            box-sizing: border-box;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .delete-button {
            background-color: #ff0000;
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        #errorMessage {
            color: red;
            text-align: center;
        }
    </style>
</head>

<body>
    <h1>USER LIST</h1>
    <div id="errorMessage"></div> <!-- Container for error message -->
    <div class="card-container">
        <%
        List<ViewUserDetails> list = (List<ViewUserDetails>) request.getAttribute("userList");
    	String deleteStatus = (String)request.getAttribute("status");
        if (list.isEmpty()) {
            out.print("No users found from the list!!");
        } else {
            for (ViewUserDetails user : list) {
        %>
        <div class="card">
            <form id="deleteForm<%= user.getUserId() %>" action="delete-user-form" method="post">
                <p><strong>User ID:</strong> <%= user.getUserId() %></p>
                <p><strong>User Name:</strong> <%= user.getUserName() %></p>
                <p><strong>Email:</strong> <%= user.getUserEmailId() %></p>
                <p><strong>Total Ordered Books:</strong> <%= user.getTotalOrderedBooks() %></p>
                <p><strong>Total Borrowed Books:</strong> <%= user.getTotalBorrowedBooks() %></p>
                <p><strong>Total Fine:</strong> <%= user.getTotalFine() %></p>
                <button class="delete-button" 
                onclick="deleteUser('<%= user.getUserId() %>')">Delete</button>
                <!-- Hidden input to pass user ID to the server -->
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                <%= deleteStatus %>
            </form>
        </div>
        <%
            }
        }
        %>
    </div>
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button>
    </div>

    <script>
        function goBack() {
            window.history.back();
        }

        function deleteUser(userId) {
            var errorMessageContainer = document.getElementById("errorMessage");

            // Display an alert before submitting the form
            var confirmDelete = confirm("Are you sure you want to delete this user?");
            
            if (confirmDelete) {
                errorMessageContainer.innerHTML = ""; // Clear any previous error message
                // Submit the corresponding form
                document.getElementById("deleteForm" + userId).submit();
            } else {
                errorMessageContainer.innerHTML = "Delete operation canceled.";
            }
        }
    </script>
</body>

</html> --%>

<%@page import="library.management.entities.ViewUserDetails"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .card {
            width: 300px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 15px;
            box-sizing: border-box;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .delete-button {
            background-color: #ff0000;
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        #errorMessage {
            color: red;
            text-align: center;
        }

        #statusMessage {
            color: green; /* You can use a different color for success messages */
            text-align: center;
        }
    </style>
</head>

<body>
    <h1>USER LIST</h1>
    <div class="card-container">
        <%
        List<ViewUserDetails> list = (List<ViewUserDetails>) request.getAttribute("userList");
        String deleteStatus = (String)request.getAttribute("status");

        if (list.isEmpty()) {
            out.print("No users found from the list!!");
        } else {
            for (ViewUserDetails user : list) {
                // Check if all conditions are met to display the Delete button
                boolean canDelete = user.getTotalOrderedBooks() == 0 &&
                                    user.getTotalBorrowedBooks() == 0 &&
                                    user.getTotalFine() == 0;
        %>
        <div class="card">
            <form id="deleteForm<%= user.getUserId() %>" action="delete-user-form" method="post">
                <p><strong>User ID:</strong> <%= user.getUserId() %></p>
                <p><strong>User Name:</strong> <%= user.getUserName() %></p>
                <p><strong>Email:</strong> <%= user.getUserEmailId() %></p>
                <p><strong>Total Ordered Books:</strong> <%= user.getTotalOrderedBooks() %></p>
                <p><strong>Total Borrowed Books:</strong> <%= user.getTotalBorrowedBooks() %></p>
                <p><strong>Total Fine:</strong> <%= user.getTotalFine() %></p>
                <% if (canDelete) { %>
                    <button class="delete-button" onclick="confirmDelete('<%= user.getUserId() %>')">Delete</button>
                <% } %>
                <!-- Hidden input to pass user ID to the server -->
                <input type="hidden" name="userId" value="<%= user.getUserId() %>">
               
            </form>
        </div>
        <%
            }
        }
        %>
    </div>
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button>
    </div>

    <script>
        function confirmDelete(userId) {
            var confirmDelete = confirm("Are you sure you want to delete user with ID " + userId + "?");

            if (confirmDelete) {
                // User confirmed, submit the form
                document.getElementById("deleteForm" + userId).submit();
            } else {
                // User canceled, do nothing
            	event.preventDefault();
            }
        }
    </script>
</body>


</html>

 
 