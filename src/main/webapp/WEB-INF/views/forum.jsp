<%@page import="library.management.entities.ForumHistory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forum Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        .forum-entry {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
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
    </style>
</head>
<body>

    <h2>Forum</h2>

    <% List<ForumHistory> list = (List<ForumHistory>)request.getAttribute("list"); %>

    <div id="forum-history">
        <% for (ForumHistory entry : list) { %>
            <div class="forum-entry">
                <p><strong><%= entry.getUserName() %>:</strong> <%= entry.getContent() %></p>
                <p><em><%= entry.getDate() %></em></p>
            </div>
        <% } %>
    </div>

    <form action="add-forum" method="post">
        <textarea name="content" placeholder="Type your message here..." required></textarea>
        <br>
        <button type="submit">Submit Chat</button>
    </form>

</body>
</html>
