<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Arial', sans-serif;
    padding-top: 60px; /* Adjusted top padding for fixed header */
}

header {
    background-color: transparent;
    border: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    color: #fff;
    padding: 10px 20px; /* Adjusted padding for a smaller header */
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 1000; /* Ensure the header is above other elements */
}

nav a {
margin-left: 30px;
    color: #fff;
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

nav a {
    color: #fff;
    text-decoration: none;
    margin-right: 20px;
}

nav a:hover {
    text-decoration: underline;
}

div {
    display: flex;
    align-items: center;
}

.profile-icon {
    margin-right: 10px;
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
     background-color: transparent;
    border: none;
}

.dropdown a {
    color: #333;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
     background-color: transparent;
    border: none;
}

.dropdown a:hover {
    background-color: #2980b9;
}

.button {
    padding: 10px; /* Adjusted padding for the button */
}


</style>
</head>
<body>
<header>
    <nav>
        <a href="UserDashboard">Home</a>
        <a href="about-us">About Us</a>
        <a href="#">Contact Us</a>
        <a href="#">Gallery</a>
    </nav>
    
    <div>
        <div class="dropdown">
            <span class="button">User Operations</span>
            <div class="dropdown-content">
                <a href="book/view-books">View Books</a>
                <a href="view-your-books">Your Book orders</a>
                <a href="view-borrowed-books">Borrowed Books</a>
                <a href="#">Your Borrow history</a>
            </div>
        </div>
        <span class="profile-icon"><a href="user-profile"><i class="fas fa-user"></i></a></span>
        <button class="logout-btn">Logout</button>
    </div>
</header>
</body>
</html>
