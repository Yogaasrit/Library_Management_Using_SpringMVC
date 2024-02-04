<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - APJ Abdul Kalam E-Library</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            text-align: center;
            background: url('/LibraryManagement/resources/images/userimg21.jpg') center center fixed;
             background-size: 100% 100%;
            background-repeat: no-repeat;
        }

        header {
            padding: 20px;
        }

        .contact-container {
            max-width: 600px;
            margin: auto;
            background-color: rgba(255, 255, 255, 0.5);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: block;
            margin-top:100px;
            margin-bottom:100px;
            
        }

        .contact-container h2 {
            color: black;
        }

        .contact-details {
            margin-top: 10px;
            display: block;
        }

        .contact-details h3 {
            color: black;
        }

        .contact-details i {
            color: black;
        }

        .contact-details p {
            margin: 5px 0;
            color: black;
        }

        input {
            background-color: rgba(255, 255, 255, 0.8);
            margin-bottom: 10px;
        }

        textarea {
            background-color: rgba(255, 255, 255, 0.8);
            margin-bottom: 20px;
        }
		.contact-container p {
		    color: black;
		    margin: 10px 0; /* Adjust margin as needed */
		    font-size: 16px; /* Adjust font size as needed */
		    line-height: 1.5; /* Adjust line height as needed */
		}
        button {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>

    <div class="contact-container">
        <h2>Contact Us</h2>
        <div class="contact-details">
            <h3>Additional Contact Details</h3>
            <i class="fa fa-envelope"></i>
            <p>apjabdulkalamlibrary15@gmail.com</p>
            <i class="fa fa-phone"></i>
            <p>+91 123 456 7890</p>
            <i class="fab fa-instagram"></i>
            <p>Follow us on Instagram: apjabdulkalamlibrary</p>
            <i class="fas fa-map-marker-alt"></i>
            <p>123 Library Street, New Delhi, 110001, India</p>

            <h3>Feel Free to Reach Out!</h3>
            <p>We are delighted to assist you with any questions or support you might need. Connect with us via email, phone, or follow our Instagram for the latest updates.</p>
            <p>Our dedicated team is committed to delivering an exceptional library experience. Your satisfaction is our top priority!</p>
            <p>Thank you for choosing APJ Abdul Kalam E-Library.</p>
        </div>
    </div>
</body>
<jsp:include page="footer.jsp" />
</html>
