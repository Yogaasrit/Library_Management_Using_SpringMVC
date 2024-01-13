<%@page import="java.sql.Blob"%>
<%@page import="java.util.Base64"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        h2 {
            color: #3498db;
            margin-top: 20px;
        }

        form {
            max-width: 400px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin: 10px 0 5px;
            text-align: left;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <h2>Book Form</h2>
    <%
    
    Blob bookCover = (Blob)request.getAttribute("bookCover");
    
    String bookCoverStr = Base64.getEncoder().encodeToString(
			(bookCover
					.getBytes(1, (int) 
					(bookCover
							.length()))));	
    
    %>

    <form:form action="edit-book-details" method="post" modelAttribute="book" enctype="multipart/form-data">

        <label for="bookName">Book Name:</label>
        <form:input path="bookName" id="bookName" />

        <label for="bookGenre">Book Genre:</label>
        <form:input path="bookGenre" id="bookGenre" />

        <label for="bookPrice">Book Price:</label>
        <form:input path="bookPrice" id="bookPrice" />

        <label for="bookPublication">Book Publication:</label>
        <form:input path="bookPublication" id="bookPublication" />

        <label for="bookPublishDate">Book Publish Date:</label>
        <form:input path="bookPublishDate" id="bookPublishDate" type="date" />

        <label for="bookEdition">Book Edition:</label>
        <form:input path="bookEdition" id="bookEdition" />

        <label for="bookQuantity">Book Quantity:</label>
        <form:input path="bookQuantity" id="bookQuantity" type="number" />
		
		<label for="authorName">Author Name:</label>
        <form:input path="authorName" id="authorName" />
        
        <label for="bookCover">Book Cover (Base64):</label>
        <form:input path="bookCover" type = "file" id="bookCover" />
        
		 <img class="book-image" src="data:image/png;base64, <%= bookCoverStr %>" alt="image %>" />
        <button type="submit">Submit</button>

    </form:form>

</body>
</html>
