<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html>
<head>
    <title>User Form</title>
</head>
<body>

    <form:form modelAttribute="user" method="post" action="userForm">


        <label for="userName">User Name:</label>
        <form:input path="userName" required="true" />

        <label for="userEmailId">Email:</label>
        <form:input path="userEmailId" required="true" />

        <label for="phoneNo">Phone Number:</label>
        <form:input path="phoneNo" />

        <label for="dob">Date of Birth:</label>
        <form:input path="dob" />

        <label for="address">Address:</label>
        <form:input path="address" />

        <label for="gender">Gender:</label>
        <form:select path="gender">
            <form:option value="Male" label="Male" />
            <form:option value="Female" label="Female" />
            <!-- Add more options as needed -->
        </form:select>

        <!-- Add other form fields as needed -->

        <input type="submit" value="Submit" />

    </form:form>

</body>
</html>
