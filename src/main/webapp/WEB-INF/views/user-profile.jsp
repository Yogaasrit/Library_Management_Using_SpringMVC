<%@page import="java.util.Base64"%>
<%@page import="library.management.entities.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Profile</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" />

<style>
        body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 20px;
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
}

header {
    background-color: #007bff;
    color: #fff;
    padding: 5px; /* Adjust the padding to control the height */
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1000;
    text-align: center;
}


.logo {
    font-size: 24px;
    font-weight: bold;
    text-decoration: none;
    color: #fff;
}

footer {
    background-color: #007bff;
    color: #fff;
    text-align: center;
    padding: 10px;
    position: fixed;
    bottom: 0;
    width: 100%;
}

.home-button {
    position: fixed;
    top: 20px;
    left: 30px;
    background-color: white;
    color: #007bff;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    z-index: 1000;
}

.home-button:hover {
    background-color: silver;
}

.profile-container {
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
    padding: 40px;
    width: 400px;
    text-align: center;
    display: flex;
    flex-direction: column; /* Make it a vertical container */
    align-items: center;
    margin-top: 150px; /* Adjust the margin-top value to create space */
    z-index: 999; /* Ensure profile container is above the header */
}


.profile-icon {
    font-size: 48px;
    margin-bottom: 20px;
}

.profile-image {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    margin-bottom: 20px;
}

h1 {
    font-size: 24px;
    margin-bottom: 30px;
}

label {
    display: block;
    margin: 15px 0 10px;
}

.user-info {
    margin-bottom: 30px;
    text-align: left;
    display: grid;
    grid-template-columns: 1fr 1fr; /* Two columns with equal width */
    gap: 10px; /* Adjust the gap between columns */
}

p {
    font-size: 18px;
    margin: 10px 0;
}

p.bold {
    font-weight: bold;
}

a {
    color: #007bff;
    text-decoration: none;
    display: block;
    margin-top: 20px;
}
.edit-profile-button,
.change-password-button {
    background-color: #0056b3;
    color: #fff;
    padding: 15px 20px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 18px;
    text-decoration: none; /* Remove default link underline */
    display: inline-block; /* Ensure links are displayed in a line */
    margin-top: 10px; /* Adjust margin as needed */
    transition: background-color 0.3s ease;
}

.edit-profile-button:hover,
.change-password-button:hover {
    background-color: #003366; /* Adjust color on hover as needed */
}

button {
    background-color: #007bff;
    color: #fff;
    padding: 15px 20px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s ease;
    margin-right: 10px;
}

button:hover {
    background-color: #0056b3;
}

.card-details-button {
    background-color: #007bff;
}

.edit-profile-button {
    background-color: #0056b3;
}
        
    </style>
</head>
<body>
<jsp:include page="Header.jsp" />
<%
	User user = (User) request.getAttribute("userProfile");

	String profileImage = null;
	if (user.getProfilePic() != null) {
	    profileImage = Base64.getEncoder().encodeToString(user.getProfilePic().getBytes(1, (int) user.getProfilePic().length()));
	}

	
%>

    <div class="profile-container">
     	<% if (profileImage != null) { %>
        <img class="profile-image" src="data:image/png;base64, <%=profileImage%>" width="200" />
    <% } else { %>
        <!-- Display fallback favicon or default image -->
        <span class="profile-icon"><a href="user-profile"><i class="fas fa-user"></i></a></span>
    <% } %>

        
        
        <h1>User Profile</h1>
        
        <div class="user-info">
            <label for="fullName">Full Name:</label>
            <p class="bold"><%= user.getUserName() %></p>

            <label for="dob">Date of Birth:</label>
            <p class="bold"> <%= user.getDob() %></p>

            <label for="email">Email:</label>
            <p class="bold"><%= user.getUserEmailId() %></p>

            <label for="mobile">Mobile Number:</label>
            <p class="bold"> <%= user.getPhoneNo() %></p>

            <label for="gender">Gender:</label>
            <p class="bold"><%= user.getGender() %></p>
        </div>

        <a href = "update-profile" class = "edit-profile-button"> Edit Profile </a>
			<a href = "change-password" class = "edit-profile-button">Change Password </a>

		
</body>
</html>