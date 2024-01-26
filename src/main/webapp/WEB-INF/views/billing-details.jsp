<%@page import="java.util.Map"%>
<%@page import="library.management.entities.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Invoice</title>
    <style>
        /* Add your CSS styles here */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .total-amount {
            font-weight: bold;
            margin-top: 20px;
        }
        .proceed-to-pay-btn {
            background-color: #4caf50;
            color: #fff;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
    </style>
</head>
<body>
    <h1>Bill Invoice</h1>
    <p>Billing Date: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></p>

    <table>
        <thead>
            <tr>
                <th>Book Name</th>
                <th>Quantity</th>
                <th>Price per unit</th>
                <th>Total Amount</th>
            </tr>
        </thead>
        <tbody>
            <% List<Book> books = (List<Book>) request.getAttribute("books"); %>
            <% Map<String, Integer> updatedCart = (Map<String, Integer>) request.getAttribute("updatedCart"); %>

            <% double grandTotal = 0; %>
            <% for (Map.Entry<String, Integer> entry : updatedCart.entrySet()) { %>
                <% String bookId = entry.getKey(); %>
                <% int count = entry.getValue(); %>
                <% for (Book book : books) { %>
                    <% if ((book.getBookId()+"").equals(bookId)) { %>
                        <tr>
                            <td><%= book.getBookName() %></td>
                            <td><%= count %></td>
                            <td><%= book.getBookPrice() %></td>
                            <td><%= count * book.getBookPrice() %></td>
                        </tr>
                        <% grandTotal += count * book.getBookPrice(); %>
                    <% } %>
                <% } %>
            <% } %>
        </tbody>
    </table>

    <p class="total-amount">Grand Total: <%= grandTotal %></p>

    <a href="payment-page?grandTotal=<%=grandTotal %>" class="proceed-to-pay-btn">Proceed to Pay</a>
</body>
</html>
