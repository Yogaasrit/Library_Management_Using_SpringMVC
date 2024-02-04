<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat With Admin</title>
    <style>
        /* Add your custom CSS styles here */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        #message {
            width: 200px;
            padding: 5px;
            margin-right: 10px;
        }
        #submitBtn {
            padding: 5px 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="chatForm" action="handle-chat" method="post" onsubmit="return sendMessage();">
        <input type="text" id="message" name="message" placeholder="Type your message...">
        <button id="submitBtn" type="submit">Submit</button>
    </form>

    <script>
        function sendMessage() {
            var message = document.getElementById('message').value;
            if (message.trim() !== '') {
                // Encode the message for the URL
                var encodedMessage = encodeURIComponent(message);

                // Display an alert after submitting the form
                alert('Chat successfully submitted to admin!');

                // Optionally, you can perform additional actions here if needed

                // Return true to allow the form to be submitted
                return true;
            } else {
                // If the message is empty, prevent the form submission
                alert('Please enter a message!');
                return false;
            }
        }
    </script>
</body>
</html>
