<%@page import="library.management.entities.Chat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat History</title>
    <style>
        /* Add your custom CSS styles here */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .chat-message {
            background-color: #f2f2f2;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <% List<Chat> list = (List<Chat>) request.getAttribute("list"); %>

    <h1>Chat History</h1>

    <div>
        <% for (Chat chat : list) { %>
            <div class="chat-message">
                <strong><%= chat.getUserName() %>:</strong> <%= chat.getMessage() %>
            </div>
        <% } %>
    </div>
</body>
</html>
