<%@page import="library.management.entities.UpcomingEvent"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to APJ Abdul Kalam Library</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url("/LibraryManagement/resources/images/Welcome.jpg") center/cover no-repeat fixed;
            position: relative;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #fff;
            overflow: hidden; /* Ensure the blur effect doesn't extend beyond the viewport */
        }

        header {
            background-color: transparent;
            color: white;
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
            color: white;
            text-decoration: none;
            margin-right: 60px;
            margin-left:20px;
            font-size: 20px;
            display: inline-block;
            background-color: transparent;
            border: none;
        }

        header h1 {
            margin: 10px;
            font-size: 32px;
        }

        .container {
            position: relative;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            z-index: 1; /* Ensure quotes are above the background image */
        }

        .quotes {
            background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background for better readability */
            padding: 20px;
            box-sizing: border-box;
            background-color: transparent;
        }

        .quotes p {
            font-size: 22px;
            margin: 10px 0;
            color: white;
        }

        #newsContainer {
            overflow: hidden;
            white-space: nowrap;
            width: 100%; /* Ensure full-width marquee */
        }

        .newsItem {
            display: inline-block;
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.3); /* Semi-transparent background for better readability */
            margin-right: 20px;
            animation: scrollNews linear infinite;
        }
		.detail{
			color: black;
		}
        @keyframes scrollNews {
            0% {
                transform: translateX(100%);
            }
            100% {
                transform: translateX(-100%);
            }
        }

        footer {
            background-color: transparent;
            color: #fff;
            padding: 10px 20px;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
            z-index: 1000;
        }

        .quote-author {
            color: black;
        }
        
    </style>
</head>
<body>
<%List<UpcomingEvent> events = (List<UpcomingEvent>)request.getAttribute("list"); %>
<header>
    <h1>APJ Abdul Kalam Library</h1>
    <nav>
        <a href="User/AdminLogin">Admin</a>
        <a href="User/UserLogin">User</a>
    </nav>
</header>

<div class="container">
    <div class="quotes">
        <p>Welcome to the APJ Abdul Kalam Library. Our library is a place of knowledge, exploration, and learning. Dive into a world of books that will inspire, educate, and entertain you.</p>
        <p>“Learning gives creativity, creativity leads to thinking, thinking provides knowledge, and knowledge makes you great.”</p>
        <p class="quote-author">― APJ Abdul Kalam</p>
    </div>
</div>
<div id="newsContainer">
    <marquee behavior="scroll" direction="left" scrollamount="3">
        <% for (UpcomingEvent event : events) { %>
            <div class="newsItem">
                <p><strong><%= event.getUpcomingEventDate() %></strong></p>
                <p class = "detail"><Strong><%= event.getUpcomingEventDetail() %></Strong></p>
            </div>
            
        <% } %>
        
    </marquee>
</div>


<footer>
    <!-- Your footer content goes here -->
</footer>

</body>
</html>
