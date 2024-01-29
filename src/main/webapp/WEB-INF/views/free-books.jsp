<!DOCTYPE html>
<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.FreeBook"%>
<%@page import="java.util.List"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Free Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: rgba(255,255,255,0.1);
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.9);
            border-radius: 5px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-top: 80px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid black; /* Border color set to black */
            margin: 8px 0;
            font-weight: bold; /* Text made bold */
            color: black; /* Text color set to black */
        }

        th {
            background-color: rgba(255,255,255,0.1);
        }

        td {
            background-color: rgba(255,255,255,0.3);
        }

        .book-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .book-details {
            flex: 1;
        }

        .book-image {
            max-width: 100px;
            margin-left: 20px;
        }
        h2{
text-align: center;
margin-top : 40px;}
    </style>
</head>
<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>
    <h2>Free Books</h2>
<div class = "container">
    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Cover</th>
            </tr>
        </thead>
        <tbody>
            <% List<FreeBook> freeBooks = (List<FreeBook>) request.getAttribute("freeBooks"); %>
            <% for (FreeBook freeBook : freeBooks) { 
                String bookCover = Base64.getEncoder().encodeToString(
                    (freeBook.getPdfCover())
                        .getBytes(1, (int) 
                            (freeBook.getPdfCover()
                                .length())));
            %>
            <tr>
                <td><%= freeBook.getPdfName() %></td>
                <td><%= freeBook.getPdfAuthorName() %></td>
                <td>
                    <a href="free-books-pdf?id=<%= freeBook.getPdfId() %>" target="_blank">
                        <img class="book-image" src="data:image/png;base64, <%= bookCover %>" 
                        alt="<%= freeBook.getPdfName() %>" />
                    </a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
