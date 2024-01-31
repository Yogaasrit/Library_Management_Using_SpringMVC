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
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }

        h2 {
            color: black;
            margin-top: 20px;
        }

        form {
            max-width: 400px;
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top : 100px;
            background-color:rgba(255,255,255,0.5);
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
        input{
        	background-color:rgba(255,255,255,0.5);
        }
    </style>
</head>
<body>
<header>
        <jsp:include page="admin-header.jsp" />
    </header>
    
    <%
    
    Blob bookCover = (Blob)request.getAttribute("bookCover");
    
    String bookCoverStr = Base64.getEncoder().encodeToString(
			(bookCover
					.getBytes(1, (int) 
					(bookCover
							.length()))));	
    
    %>
	<script>
    function validateForm() {
        var authorName = document.getElementById('authorName').value;
        var bookEdition = document.getElementById('bookEdition').value;
        var bookPrice = document.getElementById('bookPrice').value;
        var bookQuantity = document.getElementById('bookQuantity').value;
        var bookPublishDate = document.getElementById('bookPublishDate').value;

        // Validation for Author Name
        if (authorName.trim() === "") {
            alert('Author Name is required.');
            return false;
        }

        // Validation for Book Edition
        if (isNaN(bookEdition) || parseInt(bookEdition) <= 0) {
            alert('Book Edition must be a positive integer.');
            return false;
        }

        // Validation for Book Price
        if (isNaN(bookPrice) || parseInt(bookPrice) <= 0) {
            alert('Book Price must be a positive number.');
            return false;
        }

        // Validation for Book Quantity
        if (isNaN(bookQuantity) || parseInt(bookQuantity) <= 0) {
            alert('Book Quantity must be a positive integer.');
            return false;
        }

        // Validation for Book Publish Date
        var currentDate = new Date();
        var publishDate = new Date(bookPublishDate);

        if (isNaN(publishDate.getTime()) || publishDate > currentDate) {
            alert('Book Publish Date must be a valid date in the past.');
            return false;
        }

        // If all validations pass, return true to allow form submission
        return true;
    }
</script>
    <form:form action="edit-book-details" onsubmit="return validateForm()" method="post" modelAttribute="book" enctype="multipart/form-data">
	<h2>Edit Book</h2>
        <label for="bookName">Book Name:</label>
        <form:input path="bookName" id="bookName" />

        <label for="bookGenre">Book Genre:</label>
        <form:input path="bookGenre" id="bookGenre" />

        <label for="authorName">Author Name:</label>
    <form:input path="authorName" id="authorName" />
    <form:errors path="authorName" cssClass="error" />
    
	<label for="bookPublication">Book Publication:</label>
        <form:input path="bookPublication" id="bookPublication" />
        
    <label for="bookEdition">Book Edition:</label>
    <form:input path="bookEdition" id="bookEdition" />
    <form:errors path="bookEdition" cssClass="error" />

    <label for="bookPrice">Book Price:</label>
    <form:input path="bookPrice" id="bookPrice" />
    <form:errors path="bookPrice" cssClass="error" />

    <label for="bookQuantity">Book Quantity:</label>
    <form:input path="bookQuantity" id="bookQuantity" />
    <form:errors path="bookQuantity" cssClass="error" />

    <label for="bookPublishDate">Book Publish Date:</label>
    <form:input path="bookPublishDate" id="bookPublishDate" type="date" />
    <form:errors path="bookPublishDate" cssClass="error" />
		
        <label for="bookCover">Book Cover (Base64):</label>
        <form:input path="bookCover" type = "file" id="bookCover" />
        
		 <img class="book-image" src="data:image/png;base64, <%= bookCoverStr %>" alt="image %>" width=200 />
        <button type="submit">Submit</button>

    </form:form>

</body>
</html>
