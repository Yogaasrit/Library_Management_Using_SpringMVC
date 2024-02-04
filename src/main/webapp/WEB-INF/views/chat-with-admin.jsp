<%@page import="library.management.entities.Chat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat With Admin</title>
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
            background: url('/LibraryManagement/resources/images/userimg47.avif') center center fixed;
            background-size: cover;
        }
        #message {
            width: 200px;
            padding: 5px;
            margin-right: 10px;
        }
        #submitBtn {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .chat-message {
            background-color: #f2f2f2;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
            width: 300px;
        }
        .user-message {
            background-color: #4CAF50;
            color: white;
        }
        .admin-message {
            background-color: #2196F3;
            color: white;
        }
    </style>
</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
<% List<Chat> list = (List<Chat>) request.getAttribute("list");%>
<h2>Chat with Admin</h2>

<div>
    <% for (Chat chat : list) { %>
        <div class="chat-message <%= chat.getReplyMessage() != null ? "admin-message" : "user-message" %>">
            <strong><%= chat.getUserName() %>:</strong> <%= chat.getMessage() %>
            <% if (chat.getReplyMessage() != null) { %>
                <br>
                <strong>Admin:</strong> <%= chat.getReplyMessage() %>
            <% } %>
        </div>
    <% } %>
</div>

<form id="chatForm" action="handle-chat" method="post">
    <input type="text" id="message" name="message" placeholder="Type your message...">
    <button id="submitBtn" type="submit">Submit</button>
</form>

</body>

</html>
