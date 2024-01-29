<!DOCTYPE html>
<%@page import="library.management.entities.ForumHistory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forum Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        .container {
            max-width: 800px;
            margin: 0 auto; /* Center the container */
        }

        .forum-entry {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            background-color: rgba(255,255,255,0.2);
        }

        form {
            margin-top: 20px;
        }

        textarea {
            width: 100%;
            height: 80px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 16px;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }
        .content {
            color: black;
            font-size: 20px;
        }
        
        .text-area{
        background-color: rgba(255,255,255,0.7);
        }
        h2{
        color: black;}
    </style>
</head>
<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>
    <div class="container">
        <h2>Forum</h2>

        <% List<ForumHistory> list = (List<ForumHistory>)request.getAttribute("list"); %>

        <div id="forum-history">
            <% for (ForumHistory entry : list) { %>
                <div class="forum-entry">
                    <p class="content"><strong><%= entry.getUserName() %>:</strong> <%= entry.getContent() %></p>
                    <p><em><%= entry.getDate() %></em></p>
                </div>
            <% } %>
        </div>

        <form action="add-forum" method="post">
            <textarea class = "text-area" name="content" placeholder="Type your message here..." required></textarea>
            <br>
            <button type="submit">Submit Chat</button>
        </form>
    </div>
</body>
</html>
