
<%@page import="java.util.List"%>
<%@page import="library.management.entities.Book"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Genre Filter</title>
</head>
<script >
function goBack() {
    window.history.back();
}
</script>
<body>

<%  List<Book> books = (List<Book>) request.getAttribute("books"); %>
    <form action="handle-bookGenre">
        <!-- Creating a dropdown list -->
        <label for="genres">Select Genre:</label>
        <select name="genres" id="genres" multiple>
            <% 
                // Get unique genres from the list
                List<Book> filteredGenres = (List<Book>) request.getAttribute("filteredGenres");
                Set<String> uniqueGenres = new HashSet<>();
                
                if(filteredGenres != null){

                for (Book book : filteredGenres) {
                    uniqueGenres.add(book.getBookGenre());
                }

                // Display unique genres in the dropdown
                for (String genre : uniqueGenres) {
                    out.println("<option value='" + genre + "'>" + genre + "</option>");
                }
                }
            %>
        </select>
        <br>
        <br>
                
        <input type="submit" value="Filter">
    </form>
    
        <% if(books != null && !books.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Book Name</th>
                    <th>Book Genre</th>
                    <th>Book Price</th>
                    <th>Book Edition</th>
                    <th>Book Quantity</th>
                    <th>Published Date</th>
                    <th>Book Publisher</th>
                    <th>Author Name</th>
                </tr>
            </thead>
            <tbody>
                <% for (Book book : books) { %>
                    <tr>
                        <td><%= book.getBookId() %></td>
                        <td><%= book.getBookName() %></td>
                        <td><%= book.getBookGenre() %></td>
                        <td><%= book.getBookPrice() %></td>
                        <td><%= book.getBookEdition() %></td>
                        <td><%= book.getBookQuantity() %></td>
                        <td><%= book.getBookPublishDate()%></td>
                        <td><%= book.getBookPublication() %></td>
                        <td><%= book.getAuthorName() %></td>
                    </tr>
                <% }
                }%>
            </tbody>
        </table>
    
    <div class="button-container">
        <button class="button" onclick="goBack()">Back</button></div> 
</body>
</html>



 