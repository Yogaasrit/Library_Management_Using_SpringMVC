<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Filtered By Author</title>
<script>
    function goBack() {
        window.history.back();
    }
</script>
<style>
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

    tbody tr:hover {
        background-color: #f5f5f5;
    }

    p {
        margin-top: 20px;
    }
</style>
</head>
<body>
    <h2>Filter by book author</h2>
    <form action="handle-authorname">
        <label>Enter author name :</label> <input type="text" name="authorName">
        <button type="submit">Search</button>
    </form>
    <% List<Book> filteredAuthors = (List<Book>) request.getAttribute("filteredAuthors"); %>
    <% if (filteredAuthors != null) { %>
        <% if (!filteredAuthors.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Book ID</th>
                        <th>Author Name</th>
                        <th>Book Name</th>
                        <th>Book Genre</th>
                        <th>Book Price</th>
                        <th>Book Edition</th>
                        <th>Book Quantity</th>
                        <th>Published Date</th>
                        <th>Book Publisher</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <% for (Book book : filteredAuthors) { %>
                        <tr>
                            <td><%= book.getBookId() %></td>
                            <td><%= book.getAuthorName() %></td>
                            <td><%= book.getBookName() %></td>
                            <td><%= book.getBookGenre() %></td>
                            <td><%= book.getBookPrice() %></td>
                            <td><%= book.getBookEdition() %></td>
                            <td><%= book.getBookQuantity() %></td>
                            <td><%= book.getBookPublishDate() %></td>
                            <td><%= book.getBookPublication() %></td>
                            
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <h3>No Book Found</h3>
        <% } %>
    <% } %>
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button>
    </div>
</body>
</html>

