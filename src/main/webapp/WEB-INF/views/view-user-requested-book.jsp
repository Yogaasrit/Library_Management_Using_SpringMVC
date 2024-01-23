<%@page import="java.util.Base64"%>
<%@page import="java.sql.Blob"%>
<%@page import="library.management.entities.RequestBookHistory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Requested Books</title>
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
    <h1>User Requested Books</h1>
    <% List<RequestBookHistory> list = (List<RequestBookHistory>)request.getAttribute("list"); %>

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
            <% for (RequestBookHistory requestBook : list) { 
            String bookCover = Base64.getEncoder().encodeToString(
			(requestBook.getBookCover())
			.getBytes(1, (int) 
			(requestBook.getBookCover()
					.length()))); %>
                <tr>
                    <td><%= requestBook.getUserName() %></td>
                    <td><%= requestBook.getUserId() %></td>
                    <td><%= requestBook.getBookId() %></td>
                    <td><%= requestBook.getBookName() %></td>
                    <td><%= requestBook.getAuthorName() %></td>
                    <td>
                        <img class="book-image" src="data:image/png;base64, <%= bookCover %>" alt="<%= requestBook.getBookName() %>" />
                    </td>
                    <td><%= requestBook.getCount() %></td>
                    <td><a href="book/edit-book?bookId=<%=requestBook.getBookId()%>" >update</a></td>
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
