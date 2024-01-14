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
}

header {
    background-color: #333;
    color: #fff;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

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
        	<a href="book/view-books" class="button">View Books</a>
            <span class="profile-icon"><a href = "user-profile"><i class="fas fa-user"></a></i></span>
            <button class="logout-btn">Logout</button>
        </div>
    </header>
</body>
</html>