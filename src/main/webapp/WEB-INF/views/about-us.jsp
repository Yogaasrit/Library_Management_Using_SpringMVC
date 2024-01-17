<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About APJ Abdul Kalam Library</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
         
            background: url('/LibraryManagement/resources/images/bg-image1.avif') center center fixed;
            background-size: cover;
        }

        header {
            padding: 20px;
        }

	
        .content-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            
            max-width: 800px;
            margin: auto;
        }

        .carousel-container {
            max-width: 800px;
            margin: 20px auto;
            position: relative;
            overflow: hidden;
        }

        .carousel {
            display: flex;
            transition: transform 0.5s ease-in-out;
        }

        .carousel img {
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: pointer; /* Add cursor pointer */
        }

        .quote {
            font-style: italic;
            color: #555;
            margin-top: 20px;
        }

        .text-section {
            background-color: rgba(255, 255, 255, 0.5);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            text-align: center;
            display:block;
            word-spacing:2px; 
            line-height: 30px;
        }

        .text-section h2,
        .text-section p {
            margin: 0;
        }
    </style>
</head>

<body>
    <header>
        <jsp:include page="Header.jsp" />
    </header>

    <div class="content-container">
        <div class="carousel-container">
            <div class="carousel">
                <img src="/LibraryManagement/resources/images/image4.jpg" alt="Library Image 1">
                <img src="/LibraryManagement/resources/images/image10.jpg" alt="Library Image 2">
                <img src="/LibraryManagement/resources/images/image5.jpg" alt="Library Image 1">
                <img src="/LibraryManagement/resources/images/image6.jpg" alt="Library Image 2">
                <img src="/LibraryManagement/resources/images/image7.jpg" alt="Library Image 1">
                <img src="/LibraryManagement/resources/images/image8.jpg" alt="Library Image 2">
                <img src="/LibraryManagement/resources/images/image9.jpg" alt="Library Image 1">
            </div>
        </div>

        <div class="text-section">
            <h2>Welcome to Our Library</h2>

            <p>The APJ Abdul Kalam Library is a place of knowledge, inspiration, and innovation. Named after the
                renowned scientist and former President of India, Dr. APJ Abdul Kalam, our library is committed to
                fostering a love for learning and empowering individuals through access to a diverse collection of
                books, journals, and digital resources.</p>

            <p>Our state-of-the-art facility provides a conducive environment for reading, research, and collaborative
                study. With a focus on promoting education and research, we strive to be a hub of intellectual
                exploration for students, researchers, and the community.</p>

            <p>At APJ Abdul Kalam Library, we believe in the power of knowledge to transform lives. Our dedicated team
                of librarians and staff are here to assist you in your academic journey. Whether you're a student,
                faculty member, or a curious mind, we welcome you to explore the vast world of information within our
                walls.</p>

            <p>Join us on a journey of discovery, innovation, and enlightenment. Let the APJ Abdul Kalam Library be
                your gateway to a world of possibilities.</p>
        </div>

        <div class="quote">"Dream, dream, dream. Dreams transform into thoughts and thoughts result in action." - Dr.
            APJ Abdul Kalam</div>
    </div>

    <script>
        const carousel = document.querySelector('.carousel');
        const images = document.querySelectorAll('.carousel img');

        // Counter for image index
        let counter = 0;

        // Set interval for automatic image change
        setInterval(() => {
            counter = (counter + 1) % images.length;
            updateCarousel();
        }, 3000); // Change image every 3 seconds

        // Add event listener for mouseover to change image
        carousel.addEventListener('mouseover', () => {
            counter = (counter + 1) % images.length;
            updateCarousel();
        });

        // Function to update carousel position
        function updateCarousel() {
            const size = images[0].clientWidth;
            carousel.style.transform = `translateX(${-size * counter}px)`;
        }
    </script>
</body>

</html>
