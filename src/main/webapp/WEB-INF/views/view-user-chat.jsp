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
            background-color: #f0f0f0;
             background: url('/LibraryManagement/resources/images/adminimg19.avif') center center fixed;
            background-size: cover;
        }
        h1 {
            color: #333;
        }
        .chat-message {
            background-color: #fff;
            padding: 15px; /* Add padding */
            margin: 10px 0; /* Adjust margin */
            border-radius: 10px; /* Adjust border-radius */
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            width : 800px;
            position: relative;
        }
        .chat-message strong {
            color: #333;
        }
        .chat-message button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 5px 10px;
            margin-top: 5px;
            cursor: pointer;
            position: absolute;
            top: 10px; /* Adjust the top position as needed */
            right: 10px; /* Adjust the right position as needed */
        }
        .reply-box {
            display: none;
            margin-top: 10px;
        }
        header{
        margin-right:1450px;
        }
        .reply-box textarea {
            width: 100%;
            padding: 5px;
            margin-top: 5px;
        }
        .reply-box button {
            background-color: #2196F3;
            color: white;
            border: none;
            padding: 5px 10px;
            margin-right: 60px;
            cursor: pointer;
        }
    </style>
    <script>
        function toggleReplyBox(chatId) {
            var replyBox = document.getElementById("reply-box-" + chatId);
            replyBox.style.display = (replyBox.style.display === 'none' || replyBox.style.display === '') ? 'block' : 'none';
        }

        function submitReply(chatId) {
            var replyMessage = document.getElementById("reply-message-" + chatId).value;
            // Construct the URL with parameters
            var url = "update-reply-chat?chatId=" + chatId + "&replyMessage=" + encodeURIComponent(replyMessage);
            
            // Redirect to the URL
            window.location.href = url;
        }
    </script>
</head>
<body>
<header>
    <jsp:include page="admin-header.jsp" />
</header>
    <% List<Chat> list = (List<Chat>) request.getAttribute("list"); %>

    <h1>Chat History</h1>

    <div>
        <% for (Chat chat : list) { %>
            <div class="chat-message">
                <strong><%= chat.getUserName() %> (User ID=<%=chat.getUserId() %>):</strong> <%= chat.getMessage() %>
                <div id="reply-box-<%= chat.getChatId() %>" class="reply-box">
                    <textarea id="reply-message-<%= chat.getChatId() %>" name="replyMessage" placeholder="Type your reply"></textarea>
                    <button onclick="submitReply('<%= chat.getChatId() %>')">Send</button>
                </div>
                <button onclick="toggleReplyBox('<%= chat.getChatId() %>')">Reply</button>
            </div>
        <% } %>
    </div>
</body>

</html>
