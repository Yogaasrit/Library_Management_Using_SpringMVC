<%-- <%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
     /* Optional: Add styling for the search bar */
        label {
            display: inline-block;
            margin-right: 10px;
            font-size: 16px;
        }

        input, select {
            padding: 8px;
            font-size: 14px;
            margin-bottom: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #555;
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
    
    function searchBooks() {
        var bookName = document.getElementById('bookName').value.toLowerCase();
        var authorName = document.getElementById('authorName').value.toLowerCase();
        var bookGenre = document.getElementById('genreFilter').value.toLowerCase();

        var bookContainers = document.querySelectorAll('.book-container');

        for (var i = 0; i < bookContainers.length; i++) {
            var container = bookContainers[i];
            var bookTitle = container.querySelector('.book-title').textContent.toLowerCase();
            var author = container.querySelector('.author').textContent.toLowerCase();
            var genre = container.querySelector('.genre').textContent.toLowerCase();

            var matchName = bookTitle.indexOf(bookName) !== -1;
            var matchAuthor = author.indexOf(authorName) !== -1;
            var matchGenre = genre.indexOf(bookGenre) !== -1;

            if (matchName && matchAuthor && matchGenre) {
                container.style.display = 'block';
            } else {
                container.style.display = 'none';
            }
        }
    }
</script>
</head>
<body>
    <h1>List of Books</h1>
    <% List<Book> books = (List<Book>)request.getAttribute("bookList"); %>
    
     <label for="bookName">Search by Book Name:</label>
    <input type="text" id="bookName" placeholder="Enter book name">

    <label for="authorName">Search by Author:</label>
    <input type="text" id="authorName" placeholder="Enter author name">

    <!-- Dropdown for selecting genre -->
    <label for="genreFilter">Filter by Genre:</label>
    <select id="genreFilter">
        <option value="">All Genres</option>
        <% 
            List<Book> filteredGenres = (List<Book>) request.getAttribute("filteredGenres");
            Set<String> uniqueGenres = new HashSet<>();

            if(filteredGenres != null){
                for (Book book : filteredGenres) {
                    uniqueGenres.add(book.getBookGenre());
                }

                for (String genre : uniqueGenres) {
                    out.println("<option value='" + genre + "'>" + genre + "</option>");
                }
            }
        %>
    </select>

    <!-- Search button -->
    <button onclick="searchBooks()">Search</button>
    
    
    
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
</html> --%>





<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
     /* Optional: Add styling for the search bar */
        label {
            display: inline-block;
            margin-right: 10px;
            font-size: 16px;
        }

        input, select {
            padding: 8px;
            font-size: 14px;
            margin-bottom: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #555;
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

        function searchBooks() {
            var bookName = document.getElementById('bookName').value.toLowerCase();
            var authorName = document.getElementById('authorName').value.toLowerCase();
            var bookGenre = document.getElementById('genreFilter').value.toLowerCase();

            var bookContainers = document.querySelectorAll('.book-card');

            for (var i = 0; i < bookContainers.length; i++) {
                var container = bookContainers[i];
                var bookTitle = container.querySelector('h3').textContent.toLowerCase();
                var author = container.querySelector('.author').textContent.toLowerCase();
                var genre = container.querySelector('.genre').textContent.toLowerCase();

                var matchName = bookTitle.indexOf(bookName) !== -1;
                var matchAuthor = author.indexOf(authorName) !== -1;
                var matchGenre = genre.indexOf(bookGenre) !== -1;

                if (matchName && matchAuthor && matchGenre) {
                    container.style.display = 'inline-block';
                } else {
                    container.style.display = 'none';
                }
            }
        }
    </script>
</head>
<body>
    <h1>List of Books</h1>
    <% List<Book> books = (List<Book>)request.getAttribute("bookList"); %>
        
     <label for="bookName">Search by Book Name:</label>
    <input type="text" id="bookName" placeholder="Enter book name">

    <label for="authorName">Search by Author:</label>
    <input type="text" id="authorName" placeholder="Enter author name">

    <!-- Dropdown for selecting genre -->
    <label for="genreFilter">Filter by Genre:</label>
    <select id="genreFilter">
        <option value="">All Genres</option>
        <% 
            List<Book> filteredGenres = (List<Book>) request.getAttribute("filteredGenres");
            Set<String> uniqueGenres = new HashSet<>();

            if(filteredGenres != null){
                for (Book book : filteredGenres) {
                    uniqueGenres.add(book.getBookGenre());
                }

                for (String genre : uniqueGenres) {
                    out.println("<option value='" + genre + "'>" + genre + "</option>");
                }
            }
        %>
    </select>
    
    <button onclick="searchBooks()">Search</button>

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
                <p class="author">Author: <%= book.getAuthorName() %></p>
                <p class="genre">Genre: <%= book.getBookGenre() %></p>
            </div>
    <% }
    } else { %>
        <p>No books found!!</p>
    <% } %>
</body>
</html>

