<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <style>
        

        h1 {
            color: #3498db; /* Blue heading color */
            margin-top: 40px;
        }

        a.button {
            display: inline-block;
            padding: 15px 30px;
            margin: 10px;
            text-decoration: none;
            color: #ecf0f1;
            background-color: #3498db;
            border: 2px solid #2980b9;
            border-radius: 5px;
            transition: background-color 0.3s;
            font-size: 16px;
        }

        a.button:hover {
            background-color: #2980b9;
        }

        header {
            background-color: #333;
            color: #fff;
            padding: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        nav {
            display: flex;
            align-items: center;
        }

        nav a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
        }

        .profile-icon {
            background-color: #fff;
            color: #333;
            border-radius: 50%;
            padding: 10px;
            margin-right: 40px;
            cursor: pointer;
        }

        .logout-btn {
            background-color: #d9534f;
            color: #fff;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .logout-btn:hover {
            background-color: #c9302c;
        }
   		body {
    font-family: 'Arial', sans-serif;
    background-color: #2c3e50; /* Dark blue background color */
    margin: 0;
    padding: 0;
    text-align: center;
    color: #ecf0f1; /* Light gray text color */
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* 100% of the viewport height */
}

footer {
    margin-top: auto; /* Push the footer to the bottom */
    background-color: #333;
    color: #fff;
    padding: 20px;
    text-align: center;
}
   		
    </style>
</head>
<body>

	<jsp:include page="Header.jsp" />
	


    <h1>LIBRARY MANAGEMENT SYSTEM</h1>
    <a href="book/view-books" class="button">View Books</a>
   <!--  <a href="book/view-author" class="button">View Authors</a>
    <a href="book/view-genre" class="button">View Genres</a> -->
    <!-- <a href="book/filter-bookname" class="button">Filter by Book Name</a>
    <a href="book/filter-bookauthor" class="button">Filter by Author</a>
    <a href="book/filter-bookgenre" class="button">Filter by Genre</a> -->
<!--     <a href="place-order" class="button">Place Order</a>
 -->    <a href="view-your-books" class="button">View Bought Books</a>
    <a href="view-borrowed-books" class="button">View Borrowed Books</a>
    <footer>
        <div style="background-color: #333; color: #fff; padding: 20px; text-align: center;">
            &copy; 2024 Library Management System. All Rights Reserved.
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
    
</body>
</html>
