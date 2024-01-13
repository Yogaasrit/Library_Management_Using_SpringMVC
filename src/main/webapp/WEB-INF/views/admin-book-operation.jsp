<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List of Books</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        text-align: center;
    }

    h1 {
        color: #3498db;
        margin-top: 20px;
    }

    .book-card {
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 8px;
        margin: 20px;
        padding: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        display: inline-block;
        text-align: left;
    }

    .book-cover {
        max-width: 100%;
        height: auto;
        margin-bottom: 10px;
    }

    .button-container {
        margin-top: 20px;
    }

    .button {
        padding: 10px 20px;
        background-color: #3498db;
        color: #fff;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        margin-right: 10px;
    }

    .edit-button {
        background-color: #2ecc71; /* Green for edit button */
    }

    .delete-button {
        background-color: #e74c3c; /* Red for delete button */
    }
</style>

<script>
    function confirmAction(action, bookId) {
        var message = "Do you really want to " + action + " this book?";
        if (confirm(message)) {
            // Redirect to the appropriate action
            if (action === 'delete') {
                window.location.href = "delete-book?bookId=" + bookId;
            } else if (action === 'edit') {
                window.location.href = "edit-book?bookId=" + bookId;
            }
        }
    }

    function goBack() {
        window.history.back();
    }
</script>
</head>
<body>
    <h1>List of Books</h1>
    <% List<Book> books = (List<Book>)request.getAttribute("bookList"); %>
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button>
    </div>

    <% if (books != null && !books.isEmpty()) {
        for (Book book : books) {
            String bookCover = Base64.getEncoder().encodeToString(
                    book.getBookCover().getBytes(1, (int) book.getBookCover().length()));
    %>
            <div class="book-card">
                <h3><%= book.getBookName()%></h3>
                <a href="handleViewBooks?bookId=<%=book.getBookId()%>">
                    <img class="book-cover" src="data:image/png;base64, <%=bookCover%>" width="200" />
                </a>
                <div>
                    <!-- Edit Button -->
                    <button class="button edit-button" onclick="confirmAction('edit', <%=book.getBookId()%>)">Edit</button>
                    <!-- Delete Button -->
                    <button class="button delete-button" onclick="confirmAction('delete', <%=book.getBookId()%>)">Delete</button>
                </div>
            </div>
    <% }
    } else { %>
        <p>No books found!!</p>
    <% } %>
</body>
</html>
