<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script >
function goBack() {
    window.history.back();
}
</script>
</head>
<body>
	<h1>List of books</h1>
	<% List<Book> books1 = (List<Book>)request.getAttribute("bookList"); 
	
	%>
	
	<%
		if(books.isEmpty()){ 
	%>
		No books found!!
	<%} 
	else{
		for(Book book : books)
		{
			
			String bookCover = Base64.getEncoder().encodeToString(
					(book.getBookCover())
							.getBytes(1, (int) 
							(book.getBookCover()
									.length())));
			
			
		%>	
			<!-- print all columns in table -->
			<% if(book.getBookQuantity()>0 || book.isBookStatus()){ %>
			<h3><%= book.getBookName()%></h3>
			
			 <a href = "handleViewBooks?bookId=<%=book.getBookId()%>"><img src="data:image/png;base64, 
			 <%=bookCover%>"
				width="100" /></a>
			
		<%}
	} %>
	<%} %>
	<div class="button-container">
        <button class="button" onclick="goBack()">Back</button></div> 
	
</body>
</html> --%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>List of Books</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            text-align: center;
        }

        h1 {
            color: #333;
            margin: 20px 0;
        }

        .book-container {
            width: 250px;
            margin: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            display: inline-block;
            vertical-align: top;
            text-align: left;
        }

        .book-container:hover {
            transform: scale(1.05);
        }

        .book-title {
            font-size: 18px;
            margin-bottom: 10px;
        }

        .author,
        .genre {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .button {
            padding: 10px 20px;
            background-color: #ff0000;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .button:hover {
            background-color: #cc0000;
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

    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button>
    </div>

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
            <div class="book-container">
                <h3 class="book-title"><%= book.getBookName()%></h3>
                <p class="author"><strong>Author:</strong> <%= book.getAuthorName() %></p>
                <p class="genre"><strong>Genre:</strong> <%= book.getBookGenre() %></p>
                <a href="handleViewBooks?bookId=<%= book.getBookId()%>">
                    <img src="data:image/png;base64,<%= bookCover %>" width="100" />
                </a>
            </div>
    <% } } %>

</body>
</html>




