<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Add any additional CSS styles if needed -->
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Arial', sans-serif;
    padding-top: 60px; /* Adjusted top padding for fixed header */
    
}

header {
   background-color: rgba(255,255,255,0.3);
    border: none;
    position: fixed;
    top: 0;
    left: 0;
    height:8%;
    width: 100%;
    color:black;
    padding: 10px 20px; /* Adjusted padding for a smaller header */
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 1000; /* Ensure the header is above other elements */
}

nav a {
margin-left: 30px;
    color:black;
    text-decoration: none;
    margin-right: 20px;
}

.button {
margin-left: 30px;
    padding: 10px;
    margin-right: 20px; /* Adjusted margin for the dropdown button */
}

.profile-icon {
	
    margin-right: 30px; /* Adjusted margin for the profile icon */
	margin-left: 30px;
}

.logout-btn {
margin-left: 30px;
    margin-right: 30px; /* Adjusted margin for the logout button */
}

/* Rest of your existing styles */


nav {
    display: flex;
}
.button{
font-size:20px;
}
nav a {
   color:black;
    text-decoration: none;
    margin-right: 20px;
    padding: 8px 10px;
    font-size:19px;
}

nav a:hover {
    text-decoration: none;
    background-color:#FEDC56;
    
    
}


.profile-icon {
    margin-right: 10px;
     padding: 8px 10px;
     font-size:19px;
     
}
.cart-icon:hover {
  background-color:#FEDC56;
}

.cart-icon {
    margin-right: 10px;
     padding: 8px 10px;
     font-size:19px;
     
}
.profile-icon:hover {
  background-color:#FEDC56;
}
.logout-btn {
    padding: 8px 15px;
    background-color: #ff0000;
    color: #fff;
    border: none;
    cursor: pointer;
}

.logout-btn:hover {
    background-color: #cc0000;
}

/* Added styles for dropdown */
.dropdown {
    position: relative;
    display: inline-block;
     background-color: transparent;
    border: none;
}

.dropdown-content {
 background-color: transparent;
    border: none;
    display: none;
    position: absolute;
    min-width: 160px;
    box-shadow: 0 8px 16px rgba(0,0,0,0.2);
    z-index: 1;
    
}


.dropdown:hover .dropdown-content {
    display: block;
     background-color: #FCF4A3;
    border: none;
}

.header-div {
    display: flex;
    align-items: center;
}


.dropdown a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
     background-color: transparent;
    border: none;
}

.dropdown a:hover {
    background-color: #FEDC56;
}

.button {
    padding: 10px; /* Adjusted padding for the button */
}


</style>
</head>
<body>

<%String url = request.getContextPath(); %>

<header>
    <nav>
        <a href="<%= url %>/User/UserDashboard">Home</a>
        <a href="<%= url %>/User/about-us">About Us</a>
        <a href="<%= url %>/User/contact-us">Contact Us</a>
        <a href="<%= url %>/User/Gallery">Gallery</a>
        <a href="<%= url %>/User/leaderboard">Leaderboard</a>
        <a href="<%= url %>/User/forum">Forum</a>
    </nav>
    
    <div class="header-div">
    
        <div class="dropdown">
            <span class="button">User Operations</span>
            <div class="dropdown-content">
                <a href="<%= url %>/User/book/view-books">View books</a>
                <a href="<%= url %>/User/view-your-books">Ordered books</a>
                <a href="<%= url %>/User/view-borrowed-books">Borrowed books</a>
                <a href="<%= url %>/User/view-requested-book">Requested books</a>
                <a href="<%= url %>/User/view-reserve-page">Reserved books</a>
                <a href ="<%= url %>/User/free-books">Free books</a>
                <a href="<%= url %>/User/write-feedback-page">Write your feedback</a>
                <a href="<%= url %>/User/chat-with-admin">Chat with admin</a>
            </div>
        </div>
        <span class="profile-icon"><a href="<%= url %>/User/user-profile"><i class="fas fa-user"></i></a></span>
        <span class="cart-icon"><a href = "<%= url %>/User/your-cart"><i class="fa fa-shopping-cart" style="font-size:28px;"></i></a></span>
        <a href = "<%= url %>/User/user-logout"><button class="logout-btn">Logout</button></a>
    </div>
</header>
</body>
</html>
