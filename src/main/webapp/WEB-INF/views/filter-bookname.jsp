<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
	 <h2>Filter book name</h2>
    <form action="handle-bookname">
        <label>Enter bookName :</label> <input type="text" name="bookName">
        <button type="submit">Search</button>
    </form>

    <% List<Book> filteredBooks = (List<Book>)request.getAttribute("filteredBook"); %>
    
    <% if(filteredBooks != null && !filteredBooks.isEmpty()) { %>
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
                <% for (Book book : filteredBooks) { %>
                    <tr>
                        <td><%= book.getBookId() %></td>
                        <td><%= book.getBookName() %></td>
                        <td><%= book.getBookGenre() %></td>
                        <td><%= book.getBookPrice() %></td>
                        <td><%= book.getBookEdition() %></td>
                        <td><%= book.getBookQuantity() %></td>
                        <td><%= book.getPublishDate()%></td>
                        <td><%= book.getBookPublication() %></td>
                        <td><%= book.getAuthorName() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% }  %>
	
</body>
</html>