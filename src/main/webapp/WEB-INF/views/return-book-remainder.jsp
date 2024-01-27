<%@page import="library.management.entities.ReturnBookRemainder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Return Book Remainders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h2 {
            color: #333;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
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

    <h2>Return Book Remainders</h2>

    <% List<ReturnBookRemainder> list = (List<ReturnBookRemainder>)request.getAttribute("list"); %>

    <table>
        <thead>
            <tr>
                <th>User ID</th>
                <th>Book ID</th>
                <th>Borrowed ID</th>
                <th>Book Name</th>
                <th>Borrowed Date</th>
                <th>Return Date</th>
                <th>Book Fine</th>
                <th>Email ID</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (ReturnBookRemainder item : list) { %>
                <tr>
                    <td><%= item.getUserId() %></td>
                    <td><%= item.getBookId() %></td>
                    <td><%= item.getBorrowedId() %></td>
                    <td><%= item.getBookName() %></td>
                    <td><%= item.getBorrowedDate() %></td>
                    <td><%= item.getReturnDate() %></td>
                    <td><%= item.getBookFine() %></td>
                    <td><%= item.getEmailId() %></td>
                    <td>
                        <form action="send-email-remainder" method="post">
                            <input type="hidden" name="emailId" value="<%= item.getEmailId() %>">
                            <input type="hidden" name="borrowedId" value="<%= item.getBorrowedId() %>">
                            <input type="hidden" name="bookName" value="<%= item.getBookName() %>">
                            <button type="submit">Send Notification</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>
