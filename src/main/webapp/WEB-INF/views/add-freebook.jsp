<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Free Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 0;
            display: flex;
            height: 100vh;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }
        .form h2{
        text-align: center;
        color:black;
        }

        .form {
            background-color: rgba(255,255,255,0.3);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            height:50%;
            margin-left: 380px;
            margin-top: 100px;
            max-width: 600px; /* Adjust the maximum width as needed */
            justify-content: center;
            margin-bottom:120px;
            padding:50px;
            
             
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
            background-color: rgba(255, 255, 255, 0.5);
        }

        input[type="file"] {
            width: 55%;
            margin-top: 5px;
            background-color: rgba(255, 255, 255, 0.5);
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left:120px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
            
        }
        .button{
        background-color: #4caf50;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left:120px;
        }
    </style>
    <script>
    // This function will be called when the page loads
    window.onload = function () {
        var message = '<%= request.getAttribute("message") %>';

        // Check if the message is not null and not empty
        if (message !== "null" && message.trim() !== '') {
            alert(message);
        }
    };
    
    function goBack() {
        window.history.back();
    }
    </script>
</head>
<body>

<header>
<jsp:include page="admin-header.jsp" />
</header>
    
<div class="form"><h2>Add Free Book</h2>
    <form action="addFreeBook" method="post" enctype="multipart/form-data">
        <label for="pdfName">PDF Name:</label>
        <input type="text" id="pdfName" name="pdfName" required>

        <label for="pdfAuthorName">Author Name:</label>
        <input type="text" id="pdfAuthorName" name="pdfAuthorName" required>

        <label for="pdf">PDF:</label>
        <input type="file" id="pdf" name="pdf" accept=".pdf" required>

        <label for="pdfCover">PDF Cover:</label>
        <input type="file" id="pdfCover" name="pdfCover" accept=".jpg, .png" required>

        <input type="submit" value="Add Book">
        
    </form>
    <div class="button-container">
    <button class="button" onclick="goBack()">Back</button></div> 
</div>
</body>
</html>
