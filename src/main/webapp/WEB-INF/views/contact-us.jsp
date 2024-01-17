<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - APJ Abdul Kalam E-Library</title>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Add any additional CSS styles if needed -->
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            text-align: center;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }

        header {
            padding: 20px;
        }

        .contact-container {
            max-width: 600px;
            margin: auto;
            background-color: rgba(255,255,255,0.5);
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display:block;
        }

        form {
            text-align: left;
        }

        label {
            display: block;
            margin: 10px 0;
        }

        input,
        textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
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

        .contact-details {
            margin-top: 10px;
            display:block;
        }

        .contact-details p {
            margin: 5px 0;
            
            
        }
        input{
        background-color: rgba(255,255,255,0.8);
        }
        textarea{
        background-color: rgba(255,255,255,0.8);
        }
    </style>
</head>

<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>

    <div class="contact-container">
        <h2>Contact Us</h2>
        <form action="process_contact_form.jsp" method="post">
            <label for="name">Your Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Your Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="message">Your Message:</label>
            <textarea id="message" name="message" rows="4" required></textarea>

            <button type="submit">Submit</button>
        </form>

        <div class="contact-details">
            <h3>Additional Contact Details</h3><br>
            <i class="fa fa-envelope"></i><p>apjabdulkalamlibrary15@gmail.com</p><br>
            <i class="fa fa-phone"></i><p>+91 123 456 7890</p><br>
            <i class="fas fa-map-marker-alt"></i><p>123 Library Street, Cityville, Country</p>
        </div>
    </div>
</body>

</html>
