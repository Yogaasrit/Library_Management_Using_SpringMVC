<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reject Return Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }

        form {
            display: inline-block;
            text-align: left;
            border: 1px solid #dddddd;
            padding: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        textarea {
            width: 100%;
            height: 100px;
            resize: none;
            margin-bottom: 20px;
        }

        button {
            padding: 10px 20px;
            background-color: #ff0000;
            color: #fff;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form action="process-reject-return">
        <h2>Reject Return Book</h2>
       <!--  <label for="borrowedId">Borrowed ID:</label>
        <input type="text" id="borrowedId" name="borrowedId" required> -->
        
        <label for="rejectReason">Rejection Reason:</label>
        <textarea id="rejectReason" name="rejectReason" required></textarea>
         <input type = "text" name = "bookName" 
         value = "<%=request.getAttribute("bookName") %>" readonly/>
         <input type = "text" name = "borrowedId" 
         value = "<%=request.getAttribute("borrowedId") %>" readonly/>
         <input type = "text" name = "userEmailId" 
         value = "<%=request.getAttribute("userEmailId") %>" readonly/>
        <button type="submit" name="action" value="sendEmail">Send Email</button>
    </form>
</body>
</html>
