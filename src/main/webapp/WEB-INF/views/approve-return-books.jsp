<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.BookApproval"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Blob" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<html>
<head>
    <title>Return Book Approval</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }

        h1 {
            text-align: center;
            margin-top : 100px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: rgba(255,255,255,0.5);
        }

        img {
            max-width: 50px;
            max-height: 50px;
        }

        form {
            display: inline;
        }

       /* Style for the "Approve" button */
button[name="action"][value="approve"] {
    padding: 8px 16px; /* Adjust the padding as needed */
    background-color: #28a745; /* Button background color */
    color: #fff; /* Button text color */
    border: 1px solid #28a745; /* Button border color */
    border-radius: 4px; /* Optional: Rounded corners */
    cursor: pointer;
    transition: background-color 0.3s ease; /* Optional: Smooth hover effect */
}

/* Hover effect for the "Approve" button */
button[name="action"][value="approve"]:hover {
    background-color: #218838; /* Change the background color on hover */
    border-color: #218838; /* Change the border color on hover */
}

a.reject {
    display: inline-block;
    padding: 8px 16px; /* Adjust the padding as needed */
    text-decoration: none;
    background-color: #dc3545; /* Button background color */
    color: #fff; /* Button text color */
    border: 1px solid #dc3545; /* Button border color */
    border-radius: 4px; /* Optional: Rounded corners */
    transition: background-color 0.3s ease; /* Optional: Smooth hover effect */

}

a.reject:hover {
    background-color: #c82333; /* Change the background color on hover */
    border-color: #c82333; /* Change the border color on hover */
}

        button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
<header>
        <jsp:include page="admin-header.jsp" />
    </header>
<h1>Return Book Approval</h1>

<%
    List<BookApproval> list = (List<BookApproval>) request.getAttribute("list");
    if (list != null && !list.isEmpty()) {
    	
%>
    <table>
        <thead>
            <tr>
                <th>User Name</th>
                <th>User Email</th>
                <th>Book Name</th>
                <th>Borrowed Date</th>
                <th>Return Date</th>
                <th>Book Cover</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% for (BookApproval bookApproval : list) { 
            String bookCover = Base64.getEncoder().encodeToString(
                        (bookApproval.getBookCover())
                                .getBytes(1, (int) 
                                (bookApproval.getBookCover()
                                        .length())));%>
                <tr>
                    <td><%= bookApproval.getUserName() %></td>
                    <td><%= bookApproval.getUserEmailId() %></td>
                    <td><%= bookApproval.getBookName() %></td>
                    <td><%= bookApproval.getBorrowedDate() %></td>
                    <td><%= bookApproval.getReturnDate() %></td>
                    
                    <td><img src="data:image/jpeg;base64,<%= bookCover %>" alt="<%= bookApproval.getBookName() %>" width = "100"></td>
                    <td>
                        <form action="process-return-approval" method="post">
                            <input type="hidden" name="borrowedId" value="<%= bookApproval.getBorrowedId() %>">
                            <button type="submit" name="action" value="approve">Approve</button>
                            
                            <a class ="reject" href = "handle-reject?borrowedId=<%=bookApproval.getBorrowedId()%>&userEmailId=<%=bookApproval.getUserEmailId()%>&bookName=<%=bookApproval.getBookName()%>">
                            Reject</a>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
<%
    } else {
%>
    <p>No book approvals available.</p>
<%
    }
%>

</body>
</html>
