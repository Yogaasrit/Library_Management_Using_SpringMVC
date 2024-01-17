<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - APJ Abdul Kalam E-Library</title>

    <!-- Favicon -->
    <link rel="icon" href="path/to/favicon.ico" type="image/x-icon">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
             background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
            text-align: center;
        }

        header {
            padding: 20px;
        }

        .gallery-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: auto;
        }

        .gallery-item {
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .gallery-item img {
            width: 400px;
            height: 250px;
            cursor: pointer;
        }

        .gallery-item:hover {
            transform: scale(1.05);
        }
    </style>
</head>

<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>

    <h2 style="color:#fff">Gallery</h2>

    <div class="gallery-container">
        <!-- Replace the following image URLs with your actual image URLs -->
        <div class="gallery-item">
            <img src="/LibraryManagement/resources/images/image1.jpg" alt="Library Image 1">
        </div>
        <div class="gallery-item">
            <img src="/LibraryManagement/resources/images/image2.jpg" alt="Library Image 2">
        </div>
        <div class="gallery-item">
            <img src="/LibraryManagement/resources/images/image3.jpg" alt="Library Image 3">
        </div>
        <div class="gallery-item">
            <img src="/LibraryManagement/resources/images/image8.jpg" alt="Library Image 8">
        </div>
        <div class="gallery-item">
            <img src="/LibraryManagement/resources/images/image5.jpg" alt="Library Image 5">
        </div>
        <div class="gallery-item">
            <img src="/LibraryManagement/resources/images/image4.jpg" alt="Library Image 4">
        </div>
        
    </div>
</body>

</html>
