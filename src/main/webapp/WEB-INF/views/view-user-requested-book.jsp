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
        width: 100px; /* Set your preferred width */
        height: 150px; /* Set your preferred height */
        object-fit: cover; /* This ensures the image maintains its aspect ratio */
    } 
    a.update {
    display: inline-block;
    padding: 8px 16px; /* Adjust the padding as needed */
    text-decoration: none;
    background-color: #28a745; /* Button background color */
    color: #fff; /* Button text color */
    border:none; /* Button border color */
    border-radius: 4px; /* Optional: Rounded corners */
    transition: background-color 0.3s ease; /* Optional: Smooth hover effect */

}

a.update:hover {
    background-color: #c82333; /* Change the background color on hover */
    border-color: #c82333; /* Change the border color on hover */
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
