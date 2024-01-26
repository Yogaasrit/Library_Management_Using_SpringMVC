<%@page import="library.management.entities.LeaderBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaderboard</title>
    <link rel="icon" type="image/png" href="/LibraryManagement/resources/images/favicon.png">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
            text-align: center;
        }

        h1 {
            color: #333;
        }

        .leaderboard {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }

        .leaderboard-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        .profile-pic {
            max-width: 100%;
            height: auto;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    <h1>Leaderboard</h1>
<%List<LeaderBoard> list = (List<LeaderBoard>)request.getAttribute("list"); %>
    <div class="leaderboard">
        <% for (LeaderBoard leader : list) { %>
            <div class="leaderboard-item">
                <img class="profile-pic" src="<%= leader.getUserProfile() %>" alt="Profile Photo">
                <p>Username: <%= leader.getUserName() %></p>
                <p>Badge Count: <%= leader.getBadgeCount() %></p>
            </div>
        <% } %>
    </div>
</body>
</html>
