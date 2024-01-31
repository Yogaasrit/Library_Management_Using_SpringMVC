
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
    background: url('/LibraryManagement/resources/images/userimg44.avif') center center fixed;
    background-size: 100% 100%;
            background-repeat: no-repeat;
    display: flex;
    justify-content: center;
}

.left-div {
	
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
    margin-right:690px;
    height:420px; 
    background-color:transparent;
    color:black;
    font-size:18px;
    text-align:justify;
    padding-top:30px;
    margin-left:40px;
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

.library-info{
	padding-bottom: 30px;
	
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
<!--             <h2>Welcome to the APJ Abdul Kalam Library, where dreams come to life through the world of books.</h2>
 -->        </section>
		<!-- 
        <section class="library-info">
            
             

            
        </section> -->
    </div>
</body>
</html>
