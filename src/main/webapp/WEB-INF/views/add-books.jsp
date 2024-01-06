<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Book Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 600px; /* Adjust the maximum width as needed */
        }

        label {
            display: inline-block;
            width: 40%;
            margin-bottom: 8px;
        }

        input {
            width: 55%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
        }

        input[type="file"] {
            width: 55%;
            margin-top: 5px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <form action="handle-add-books" method = "post" enctype="multipart/form-data">

        <label for="bookName">Book Name:</label>
        <input type="text" id="bookName" name="bookName" required><br>

        <label for="bookPrice">Book Price:</label>
        <input type="text" id="bookPrice" name="bookPrice" required><br>

        <label for="bookGenre">Book Genre:</label>
        <input type="text" id="bookGenre" name="bookGenre" required><br>

        <label for="bookPublication">Book Publication:</label>
        <input type="text" id="bookPublication" name="bookPublication" required><br>

        <label for="bookPublishDate">Book Publish Date:</label>
        <input type="date" id="bookPublishDate" name="bookPublishDate" required><br>

        <label for="bookEdition">Book Edition:</label>
        <input type="text" id="bookEdition" name="bookEdition" required><br>

        <label for="bookQuantity">Book Quantity:</label>
        <input type="text" id="bookQuantity" name="bookQuantity" required><br>

        <label for="authorName">Author Name:</label>
        <input type="text" id="authorName" name="authorName" required><br>

        <!-- <label for="bookCover">Book Cover:</label>
        <input type="file" id="bookCover" name="bookCover" required><br> -->
        
        <label for="bookCover"><b>Book Cover : </b></label>
            <input type="file" placeholder="Choose cover" 
            name="bookCover" id="bookCover"  required>
            <br><br>

        <input type="submit">
    </form>
<%--     <%String status =  (String)request.getAttribute("status"); %>
 --%>  
  	 <!-- <script>
        // JavaScript code to display an alert based on the status value
        window.onload = function() {
            var status = ${status}; // Assuming "status" is the name of the variable passed from the controller

            // Check if the status is not null
            if (status !== null) {
                if (status === "1") {
                    alert("Book added successfully!");
                } else if (status === "0") {
                    alert("Book not added. Please try again.");
                } else {
                    alert("Unexpected status value: " + status);
                }
            }
        };
    </script> -->
  
</body>
</html>

