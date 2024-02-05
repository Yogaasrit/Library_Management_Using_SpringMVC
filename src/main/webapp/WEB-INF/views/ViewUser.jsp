
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
            margin: 0;
            padding: 0;
             background: url('/LibraryManagement/resources/images/adminimg9.jpg') center center fixed;
            background-size: cover;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            background-color:transparent;
    		border: none;
        }

        .card {
            width: 350px;
            color:black;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 10px;
            padding: 15px;
            box-sizing: border-box;
            background-color: rgba(255, 255, 255, 0.3);
    		border: none;
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
        .outer-container{
        	 background-color: transparent;
    		border: none;
    		padding:100px;
        }
        

        .tooltip {
            visibility: hidden;
            position: absolute;
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 5px;
            border-radius: 6px;
            z-index: 1;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .delete-button:hover + .tooltip {
            visibility: visible;
            opacity: 1;
        }
    </style>
</head>

<body>
<header>
        <jsp:include page="admin-header.jsp" />
    </header>
    
    <div class="outer-container">
    <h1>LIST OF USERS</h1>
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
                <p><strong >User Name:</strong> <%= user.getUserName() %></p>
                <p><strong>Email:</strong> <%= user.getUserEmailId() %></p>
                <p><strong>Total Ordered Books:</strong> <%= user.getTotalOrderedBooks() %></p>
                <p><strong>Total Borrowed Books:</strong> <%= user.getTotalBorrowedBooks() %></p>
                <p><strong>Total Fine:</strong> <%= user.getTotalFine() %></p>
                <% if (canDelete) { %>
                    <button class="delete-button" onclick="confirmDelete('<%= user.getUserId() %>')">Delete</button>
                <% }else{ %>
				 <button class="delete-button" disabled>Delete</button>
				    <div class="tooltip">This user cannot be deleted, has borrowed book</div>
                <%} %>
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

<jsp:include page="footer.jsp" />
</html>

 
 