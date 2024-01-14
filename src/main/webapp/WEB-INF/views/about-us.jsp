<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>About Us - APJ Abdul Kalam Library</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+Wy9ad6XZ5uqU5CG6Qpx2m3Jh2lQzI5e3eC" crossorigin="anonymous">
    <style>
        body {
            font-family: 'Raleway', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            margin: 0;
            padding: 0;
        }

        nav {
            background-color: #343a40 !important;
        }

        nav a {
            color: #fff !important;
        }

        .carousel-item img {
            height: 500px;
            object-fit: cover;
        }

        .about-content {
            max-width: 800px;
            margin: 20px auto;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #343a40;
        }

        .additional-images {
            margin-top: 20px;
            text-align: center;
        }

        .additional-images img {
            max-width: 100%;
            height: auto;
            margin: 10px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .additional-images img:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
	<jsp:include page="Header.jsp" />

<!-- Image Carousel -->
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="/LibraryManagement/resources/images/image1.jpg" class="d-block w-100" alt="Image 1">
        </div>
        <div class="carousel-item">
            <img src="/LibraryManagement/resources/images/image2.jpg" class="d-block w-100" alt="Image 2">
        </div>
        <div class="carousel-item">
            <img src="/LibraryManagement/resources/images/image3.jpg" class="d-block w-100" alt="Image 3">
        </div>
        <!-- Add more carousel items as needed -->
    </div>
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

<!-- About Us Content -->
<div class="container about-content">
    <h2>About APJ Abdul Kalam Library</h2>
    <p>
        Welcome to APJ Abdul Kalam Library! We are dedicated to providing a vast collection of books,
        resources, and a comfortable reading environment for our patrons. Our library is committed to
        fostering a love for learning and knowledge.
    </p>
    <p>
        Feel free to explore our diverse collection and make the most of the resources we offer.
        Whether you are a student, researcher, or an avid reader, we have something for everyone.
    </p>
</div>

<!-- Additional Images -->
<div class="container additional-images">
    <h3>Explore More</h3>
    <div class="row">
        <div class="col-md-4">
            <img src="/LibraryManagement/resources/images/image1.jpg" class="img-fluid" alt="Additional Image 1">
        </div>
        <div class="col-md-4">
            <img src="/LibraryManagement/resources/images/image2.jpg" class="img-fluid" alt="Additional Image 2">
        </div>
        <div class="col-md-4">
            <img src="/LibraryManagement/resources/images/image3.jpg" class="img-fluid" alt="Additional Image 3">
        </div>
    </div>
</div>

<!-- Bootstrap JS and jQuery (make sure to include them at the end of the body) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
        integrity="sha384-pzjw8Y+JcdwGzAAwxAP1n0qACQ5/5fLlD/1CPKIjwNf/fqC1Lr5aF93vIzp+Ms"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
        integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+Wy9ad6XZ5uqU5CG6Qpx2m3Jh2lQzI5e3eC"
        crossorigin="anonymous"></script>

</body>
</html>
