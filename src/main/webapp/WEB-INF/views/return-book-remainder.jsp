<%@page import="library.management.entities.ReturnBookRemainder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Return Book Remainders</title>
<style>
        /* Add your CSS styles for the table here */
        body {
            font-family: Arial, sans-serif;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
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
.send-notification-btn {
	background-color: #4CAF50;
	color: white;
	padding: 8px 16px;
	border: none;
	cursor: pointer;
}

.send-notification-btn:hover {
	background-color: #45a049;
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
	<h2>Return Book Remainders</h2>

	<%
	List<ReturnBookRemainder> list = (List<ReturnBookRemainder>) request.getAttribute("list");
	%>

	<table>
		<thead>
			<tr>
				<th>User ID</th>
				<th>Book ID</th>
				<th>Borrowed ID</th>
				<th>Book Name</th>
				<th>Borrowed Date</th>
				<th>Return Date</th>
				<th>Book Fine</th>
				<th>Email ID</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (ReturnBookRemainder item : list) {
			%>
			<tr>
				<td><%=item.getUserId()%></td>
				<td><%=item.getBookId()%></td>
				<td><%=item.getBorrowedId()%></td>
				<td><%=item.getBookName()%></td>
				<td><%=item.getBorrowedDate()%></td>
				<td><%=item.getReturnDate()%></td>
				<td><%=item.getBookFine()%></td>
				<td><%=item.getEmailId()%></td>
				<td>
					  <form action="send-email-remainder" method="post">
                            <input type="hidden" name="emailId" value="<%= item.getEmailId() %>">
                            <input type="hidden" name="borrowedId" value="<%= item.getBorrowedId() %>">
                            <input type="hidden" name="bookName" value="<%= item.getBookName() %>">
                            <button type="submit" class="send-notification-btn">Send Notification</button>
                            
                        </form> 
				</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>


<script>
    document.addEventListener('DOMContentLoaded', function() {
        var buttons = document.querySelectorAll('.send-notification-btn');

        buttons.forEach(function(button) {
            button.addEventListener('click', function(event) {
                // Display the toast (alert in this case)
                alert('Email has been sent!');

                // Manually submit the form associated with the clicked button
                var form = button.closest('form');
                form.submit();
            });
        });
    });
</script>


</body>
</html>
