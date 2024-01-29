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
        background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
        background-size: cover;
    }

    h1 {
        color: #fff;
        margin-top: 70px;
    }

    .book-card {
        background-color: rgba(255,255,255,0.2);
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
            background-color : rgba(255,255,255,0.5);
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
    function searchBooks() {
        var bookName = document.getElementById('bookName').value.toLowerCase();
        var authorName = document.getElementById('authorName').value.toLowerCase();
        var bookGenre = document.getElementById('genreFilter').value.toLowerCase();

        var bookCards = document.querySelectorAll('.book-card');

        for (var i = 0; i < bookCards.length; i++) {
            var card = bookCards[i];
            var bookTitle = card.querySelector('h3').textContent.toLowerCase();
            var author = card.querySelector('.author').textContent.toLowerCase();
            var genre = card.querySelector('.genre').textContent.toLowerCase();
            var booksFound = false;

            var matchName = bookTitle.indexOf(bookName) !== -1;
            var matchAuthor = author.indexOf(authorName) !== -1;
            var matchGenre = genre.indexOf(bookGenre) !== -1;

            if (matchName && matchAuthor && matchGenre) {
                card.style.display = 'block';
                booksFound = true;

            } else {
                card.style.display = 'none';
            }
        }
        
     // Show or hide the "No books found" message
        if (booksFound) {
            noBooksFoundMessage.style.display = 'none';
        } else {
            noBooksFoundMessage.style.display = 'block';
        }
    }
</script>

</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
    <h1>List of books</h1>

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
    <br><br>

    <!-- Book rows container -->
    <!-- <div class="book-row"> -->
        <% 
            List<Book> books = (List<Book>)request.getAttribute("bookList"); 
            if (books.isEmpty()) { 
        %>
            No books found!!
        <% } else { 
            for (Book book : books) {
            	
                String bookCover = Base64.getEncoder().encodeToString(
                        (book.getBookCover())
                                .getBytes(1, (int) 
                                (book.getBookCover()
                                        .length()))); 
        %>
             <%--    <div class="book-container">
                    <h3 class="book-title"><%= book.getBookName()%></h3>
                    <p class="author"><strong>Author:</strong> <%= book.getAuthorName() %></p>
                    <p class="genre"><strong>Genre:</strong> <%= book.getBookGenre() %></p>
                    <a href="handleViewBooks?bookId=<%= book.getBookId()%>">
                        <img class="book-cover" src="data:image/png;base64,<%= bookCover %>" alt="<%= book.getBookName()%> Cover" />
                    </a>
                </div> --%>
                
                <div class="book-card">
                <h3><%= book.getBookName()%></h3>
                <a href="handleViewBooks?bookId=<%=book.getBookId()%>">
                    <img class="book-cover" src="data:image/png;base64, <%=bookCover%>" width="200" />
                </a>
                
                <p class="author">Author: <%= book.getAuthorName() %></p>
                <p class="genre">Genre: <%= book.getBookGenre() %></p>
            </div>
  
                
        <% } } %>
            <p id="noBooksFoundMessage" style="display:none;">No books found!!</p>
        
    <!-- </div> -->
</body>
</html>
