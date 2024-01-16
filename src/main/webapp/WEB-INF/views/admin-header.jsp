<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    <link rel="stylesheet" href="/LibraryManagement/resources/css/admin-header.css">
    <title>Admin Dashboard</title>
</head>
<body>
    <header class="admin-header">
        <div class="brand">
            <span class="brand-name">Admin Dashboard</span>
        </div>
        <div class="profile-section">
            <div class="actions-dropdown">
                <button class="dropdown-btn">Admin Operations</button>
                <div class="dropdown-content">
                    <a href="book/admin-book-operation" onclick="performAction('viewBook')">View Book</a>
                    <a href="add-books" onclick="performAction('addBook')">Add Book</a>
                    <a href="handle-view-user" onclick="performAction('viewUser')">View User</a>
                    <a href="approve-return-book" onclick="performAction('approveReturnedBooks')">Approve Returned Books</a>
                </div>
            </div>
            <a href="#" class="user-icon" onclick="performAction('viewProfile')"><i class="fas fa-user"></i></a>
            <span class="logout"><a href="#" onclick="performAction('logout')">Logout</a></span>
        </div>
    </header>
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var dropdownBtn = document.querySelector(".dropdown-btn");
        var dropdownContent = document.querySelector(".dropdown-content");

        dropdownBtn.addEventListener("click", function () {
            dropdownContent.style.display = (dropdownContent.style.display === "block") ? "none" : "block";
        });

        // Close the dropdown when clicking outside of it
        window.addEventListener("click", function (event) {
            if (!event.target.matches('.dropdown-btn')) {
                if (dropdownContent.style.display === "block") {
                    dropdownContent.style.display = "none";
                }
            }
        });
    });

    function performAction(action) {
        // Call your Java controller with the specified action
        console.log("Performing action: " + action);
        // Add your logic to handle the action in the Java controller
    }
</script>
</body>
</html>


    <!-- Add this script tag to your HTML file -->


</body>
</html>
