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
            background-color: #f4f4f4;
        }

        .bookContainer {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .bookItem {
            border: 1px solid #ddd;
            padding: 10px;
            background-color: #fff;
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
            color: #ddd; /* Default star color */
            cursor: pointer;
        }

        .star:hover,
        .star.checked {
            color: #ffbf00; /* Color for hovered and checked stars */
        }

        .feedbackForm {
            text-align: center;
            margin-top: 10px;
        }

        .commentsInput {
            width: 100%;
            height: 60px;
        }

        .submitBtn {
            background-color: #4caf50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <% List<ReturnedBook> returnedBooks = (List<ReturnedBook>) request.getAttribute("returnedBook"); %>

    <h2>This is the Feedback Page</h2>

    <div class="bookContainer">
        <% for (ReturnedBook book : returnedBooks) { %>
            <div class="bookItem">
                <img class="bookCover" src="<%= book.getBookCover() %>" alt="Book Cover">
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
