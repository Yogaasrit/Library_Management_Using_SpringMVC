
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APJ Abdul Kalam Library</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<style>
body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
    background-size: cover;
    display: flex;
    justify-content: center;
}

.left-div {
	background: url('/LibraryManagement/resources/images/Kalam.png');
    background-size: contain;
    background-repeat: no-repeat;
   	margin-left:100px;
    flex: 1;
}

.right-div {
    
   flex:1;
    width: 1100px;
    background-color: #f4f4f4;
    border-radius: 8px;
    margin: 20px;
    padding: 20px;
    margin-right:150px;
    height:400px;
    background-color:rgba(255,255,255,0.2);
    color:#fff;
    font-size:18px;
}

header {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 20px;
}

header img {
    max-width: 100%;
    height: auto;
    border-radius: 50%;
    margin-top: 20px;
}

.quote-section {
    text-align: center;
    padding: 20px;
}

blockquote {
    font-style: italic;
    margin-bottom: 10px;
}

</style>
<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>

    <div class="left-div">
    
    </div>

    <div class="right-div">
        <section class="quote-section">
            <blockquote>
                "Dream, dream, dream. Dreams transform into thoughts, and thoughts result in action."
            </blockquote>
        </section>
		<span></span>
        <section class="library-info">
            <h2>About Our Library</h2>
             <p>Welcome to the APJ Abdul Kalam Library, where dreams come to life through the world of books.</p>

            <p>The APJ Abdul Kalam Library is a haven for knowledge seekers. With a vast collection of books, we aim to inspire and nurture a love for reading and learning.</p>
            <p>Our collection includes a diverse range of books, covering various genres such as fiction, non-fiction, science, literature, and more.</p>
            <p>Explore the wonders of literature and embark on a journey of knowledge at our library.</p>
        </section>
    </div>
</body>
</html>
