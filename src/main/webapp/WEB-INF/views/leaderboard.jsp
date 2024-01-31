<!DOCTYPE html>
<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.LeaderBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            font-family: Arial, sans-serif;
            background: url('/LibraryManagement/resources/images/userimg27.avif') center center fixed;
            background-size: 100% 100%;
            background-repeat: no-repeat;
            text-align: center;
        }

        h2 {
            color: black;
            text-align: center;
            margin-top: 40px;
        }

        .leaderboard {
            display: flex;
            flex-wrap: wrap; /* Added to allow items to wrap to the next line */
            justify-content: center; /* Center the items horizontally */
            margin-top: 20px;
        }

        .leaderboard-item {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            background-color: rgba(255,255,255,0.3);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center; /* Center the content inside each item */
        }

        .profile-pic {
            max-width: 100%;
            height: auto;
            border-radius: 50%;
        }
    </style>
</head>
<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>
    <h2>Leaderboard</h2>
    <% List<LeaderBoard> list = (List<LeaderBoard>)request.getAttribute("list"); %>
    <% int badgeCount = (Integer)request.getAttribute("badgeCount"); %>
	<% int rank = 1; %>
    <div class="leaderboard-item">
        <h1>🎖️Your badges🎖️</h1>
        <p>BadgeCount: <%= badgeCount %></p>
    </div>

    <div class="leaderboard">
        <% for (LeaderBoard leader : list) { %>
            <div class="leaderboard-item">
            <p><strong>🏆 Rank: <%= rank %></strong></p>
            <% rank= rank+1; %>
                <p><strong>Username: <%= leader.getUserName() %></strong></p>
                <p><strong>Badge Count: <%= leader.getBadgeCount() %></strong></p>
                <% String profile = Base64.getEncoder().encodeToString(
                    (leader.getUserProfile())
                    .getBytes(1, (int) (leader.getUserProfile().length()))); %>
                <% if (profile != null) { %>
                    <img class="profile-pic" src="data:image/png;base64, <%= profile %>" width="50" />
                <% } else { %>
                    <i class="fas fa-user-circle fa-5x"></i> <!-- Font Awesome user icon -->
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>
