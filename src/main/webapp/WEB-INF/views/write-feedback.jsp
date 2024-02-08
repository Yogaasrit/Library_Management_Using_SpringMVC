<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.ReturnedBook"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Feedback Page</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background: url('/LibraryManagement/resources/images/userimg37.avif') center center fixed;
             background-size: 100% 100%;
            background-repeat: no-repeat;
            justify-content: center; 
            align-items: center; 
            
        }

        .container {
            max-width: 800px;
            margin-top:50px;
            margin-left:350px;
            align-items:center;
            text-align:center;
        }

        .bookContainer {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-left: 10px;
            margin-bottom: 100px;
        }

        .bookItem {
            border: 1px solid #ddd;
            padding: 10px;
            background-color: rgba(255, 255, 255, 0.3);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            width: 200px;
            text-align: center;
        }

        .bookCover {
            max-width: 100%;
            height: auto;
            border: 1px solid #ddd;
        }

        .starRating {
            margin-top: 10px;
        }

        .star {
            font-size: 24px;
            color: white;
            cursor: pointer;
        }

        .star:hover,
        .star.checked {
            color: #ffbf00;
        }

        .feedbackForm {
            text-align: center;
            margin-top: 10px;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 10px;
        }

        .commentsInput {
            width: 100%;
            height: 40px; /* Adjust the height as needed */
            padding: 5px;
            box-sizing: border-box;
        }

        .submitBtn {
            background-color: #4caf50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
        }
        h2{
        	margin-top: 60px;
        	text-align: center;
        }
    </style>
</head>
<body>
<header>
        <jsp:include page="Header.jsp" />
    </header>
    <% List<ReturnedBook> returnedBooks = (List<ReturnedBook>) request.getAttribute("returnedBook"); %>
<div class="container">
    <h2>Feedback Page</h2>
    <br><br>

    <% if (returnedBooks != null && !returnedBooks.isEmpty()) { %>
        <div class="bookContainer">
            <% for (ReturnedBook book : returnedBooks) { String bookCover = Base64.getEncoder().encodeToString(
                        (book.getBookCover())
                                .getBytes(1, (int) 
                                (book.getBookCover()
                                        .length()))); %>
                <div class="bookItem">
                    <img class="book-cover" src="data:image/png;base64, <%=bookCover%>" width="200" />
                    <div class="starRating" data-book-id="<%= book.getBookId() %>">
                        <span class="star" onclick="setRating(<%= book.getBookId() %>, 1)">&#9733;</span>
                        <span class="star" onclick="setRating(<%= book.getBookId() %>, 2)">&#9733;</span>
                        <span class="star" onclick="setRating(<%= book.getBookId() %>, 3)">&#9733;</span>
                        <span class="star" onclick="setRating(<%= book.getBookId() %>, 4)">&#9733;</span>
                        <span class="star" onclick="setRating(<%= book.getBookId() %>, 5)">&#9733;</span>
                    </div>
                    <div class="feedbackForm">
                        <label for="comments<%= book.getBookId() %>">Comments:</label>
                        <textarea id="comments<%= book.getBookId() %>" name="comments" class="commentsInput"></textarea>
                        <br>
                        <button class="submitBtn" onclick="submitFeedback(<%= book.getBookId() %>, <%= book.getBorrowedId() %>)">Submit Feedback</button>
                    </div>
                </div>
            <% } %>
        </div>
    <% } else { %>
        <p>You haven't returned any books. Please borrow a book to provide feedback.</p>
    <% } %>

</div>
    <script>
        function setRating(bookId, rating) {
            const stars = document.querySelectorAll(`.starRating[data-book-id="${bookId}"] .star`);

            stars.forEach((star, index) => {
                if (index < rating) {
                    star.classList.add('checked');
                } else {
                    star.classList.remove('checked');
                }
            });
        }

        function submitFeedback(bookId, borrowedId) {
            const stars = document.querySelectorAll(`.starRating[data-book-id="${bookId}"] .star`);
            const comments = document.getElementById(`comments${bookId}`).value;

            let rating = 0;
            stars.forEach((star, index) => {
                if (star.classList.contains('checked')) {
                    rating = index + 1;
                }
            });

            // Construct the URL with parameters
            const url = "feedback?rating=" + rating + "&bookId=" + bookId + "&borrowedId=" + borrowedId + "&comments=" + encodeURIComponent(comments === undefined ? '' : comments);

            // Redirect to the URL
            window.location.href = url;
        }
    </script>
</body>

</html>