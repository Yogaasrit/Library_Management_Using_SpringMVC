<%@page import="library.management.entities.ReserveBook"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Reserved Books</title>
    <style>
        /* Add your CSS styles for the table here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>User Reserved Books</h1>
    <% List<ReserveBook> list = (List<ReserveBook>)request.getAttribute("list"); %>

    <table>
        <thead>
            <tr>
                <th>User Name</th>
                <th>User ID</th>
                <th>Book ID</th>
                <th>Book Name</th>
                <th>Author Name</th>
                <th>Book Cover</th>
                <th>Count</th>
            </tr>
        </thead>
        <tbody>
            <% for (ReserveBook reserveBook : list) { 
            String bookCover = Base64.getEncoder().encodeToString(
			(reserveBook.getBookCover())
			.getBytes(1, (int) 
			(reserveBook.getBookCover()
					.length()))); %>
                <tr>
                    <td><%= reserveBook.getUserName() %></td>
                    <td><%= reserveBook.getUserId() %></td>
                    <td><%= reserveBook.getBookId() %></td>
                    <td><%= reserveBook.getBookName() %></td>
                    <td><%= reserveBook.getAuthorName() %></td>
                    <td>
                        <img class="book-image" src="data:image/png;base64, <%= bookCover %>" alt="<%= reserveBook.getBookName() %>" />
                    </td>
                    
                    <td><a href="book/edit-book?bookId=<%=reserveBook.getBookId()%>" >update</a></td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <%-- Method to convert Blob to Base64 --%>
    <%!
        private String blobToBase64(Blob blob) {
            try {
                byte[] bytes = blob.getBytes(1, (int) blob.length());
                return java.util.Base64.getEncoder().encodeToString(bytes);
            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }
    %>
</body>
</html>
