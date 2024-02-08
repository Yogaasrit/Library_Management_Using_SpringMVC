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
            background: url('/LibraryManagement/resources/images/adminimg14.avif') center center fixed;
            background-size: 100% 100%;
            background-repeat: no-repeat;
        margin: 0;
        padding: 0;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border:none;
        margin-top: 20px;
        
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align:center;
    }

    th {
        background-color: rgba(255,255,255,0.3);
    }

    .book-image {
        width: 100px; 
        height: 150px; 
        object-fit: cover; 
    } 
    a.update {
    display: inline-block;
    padding: 8px 16px;
    text-decoration: none;
    background-color: #28a745; 
    color: #fff; 
    border:none;
    border-radius: 4px; 
    transition: background-color 0.3s ease;

}

a.update:hover {
    background-color: #c82333; 
    border-color: #c82333; 
}  
h2{
text-align: center;
margin-top : 80px;}
    </style>
</head>

<body>
<header>
        <jsp:include page="admin-header.jsp" />
    </header>
    <h2>User Requested Books</h2>
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
                <th>Action</th>
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
                    <td><a class ="update" href="book/edit-book?bookId=<%=requestBook.getBookId()%>"  >update</a></td>
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
