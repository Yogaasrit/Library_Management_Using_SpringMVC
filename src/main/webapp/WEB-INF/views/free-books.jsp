<%-- <%@page import="library.management.entities.FreeBook"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.io.ByteArrayInputStream"%>
<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="java.util.zip.Deflater"%>
<%@ page import="java.util.zip.Inflater"%>
<%@ page import="java.sql.*" %>

<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>

<%@ page import="java.io.IOException" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.zip.DeflaterOutputStream"%>
<%@ page import="java.util.zip.InflaterInputStream"%>

<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="java.io.ByteArrayInputStream"%>

<%@ page import="com.itextpdf.text.Document"%>
<%@ page import="com.itextpdf.text.DocumentException"%>
<%@ page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@ page import="com.itextpdf.text.pdf.PdfReader"%>
<%@ page import="com.itextpdf.text.pdf.parser.PdfTextExtractor"%>
<%@ page import="com.itextpdf.text.Image"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PDF Display Page</title>
    <style>
        #pdfViewer {
            width: 100%;
            height: 800px;
        }
    </style>
</head>
<body>
	<%  %>
    <h2>PDF Information</h2>
    <table border="1">
        <tr>
            <th>PDF ID</th>
            <th>PDF Name</th>
            <th>Author Name</th>
        </tr>
        <tr>
            <td><%= ((FreeBook)request.getAttribute("freeBooks")).getPdfId() %></td>
            <td><%= ((FreeBook)request.getAttribute("freeBooks")).getPdfName() %></td>
            <td><%= ((FreeBook)request.getAttribute("freeBooks")).getPdfAuthorName() %></td>
        </tr>
    </table>

    <h2>PDF Viewer</h2>
    <div id="pdfViewer"></div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.9.359/pdf.min.js"></script>
   <script>
    // Assuming the model has a Blob for PDF in the 'pdf' attribute
    var pdfBlob = new Blob([<%= ((FreeBook)request.getAttribute("freeBooks")).getPdf() %>], { type: 'application/pdf' });
    console.log('PDF Blob:', pdfBlob);

    var pdfViewer = document.getElementById("pdfViewer");

    // Create a data URL for the Blob
    var pdfDataUrl = URL.createObjectURL(pdfBlob);

    console.log('PDF Data URL:', pdfDataUrl);

    // Display PDF using pdf.js
    pdfjsLib.getDocument({ url: pdfDataUrl }).promise.then(function(pdfDoc) {
        for (var pageNum = 1; pageNum <= pdfDoc.numPages; pageNum++) {
            pdfDoc.getPage(pageNum).then(function(page) {
                var canvas = document.createElement("canvas");
                var context = canvas.getContext("2d");

                var viewport = page.getViewport({ scale: 1.5 });
                canvas.width = viewport.width;
                canvas.height = viewport.height;

                var renderContext = {
                    canvasContext: context,
                    viewport: viewport
                };

                page.render(renderContext).promise.then(function() {
                    pdfViewer.appendChild(canvas);
                });
            });
        }
    });
</script>

</body>
</html> --%>
<%-- <%@page import="java.util.Base64"%>
<%@page import="library.management.entities.FreeBook"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Free Books</title>
</head>
<body>

<h2>Free Books</h2>

<%
    // Loop through the list of free books
    List<FreeBook> freeBooks = (List<FreeBook>) request.getAttribute("freeBooks");
    for (FreeBook book : freeBooks) {
        // Convert Blob to base64 encoded string
        byte[] pdfBytes = book.getPdfAsBytes();
        // Implement this method in your FreeBook class
        out.println(pdfBytes.length);
        String base64Pdf = Base64.getEncoder().encodeToString(pdfBytes);
%>
    <div>
        <h3><%= book.getPdfName() %> by <%= book.getPdfAuthorName() %></h3>

        Display the PDF using an iframe
		<iframe src="data:application/pdf;base64, <%= base64Pdf %>" width="100%" height="600px"></iframe>

        <hr>
    </div>
<%
    }
%>

</body>
</html>











 --%>





<%--  <%@page import="java.util.Base64"%>
<%@page import="library.management.entities.FreeBook"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

 <html>
<head>
    <title>Free Books</title>
    <!-- Include PDF.js library -->
<script src="/LibraryManagement/static/js/pdf.mjs"></script>
<script src="/LibraryManagement/static/js/pdf.worker.mjs"></script>

</head>
<body>

<h2>Free Books</h2>

<%
    // Loop through the list of free books
    List<FreeBook> freeBooks = (List<FreeBook>) request.getAttribute("freeBooks");
    for (FreeBook book : freeBooks) {
    	
    	String bookCover = Base64.getEncoder().encodeToString(
    			(book.getPdfCover())
    					.getBytes(1, (int) 
    					(book.getPdfCover()
    							.length())));
    	
%>
    <div>
        <h3><%= book.getPdfName() %> by <%= book.getPdfAuthorName() %></h3>

        <canvas id="pdfCanvas_<%= book.getPdfId() %>"></canvas>

        <img src="data:image/jpeg;base64,<%= bookCover %>" alt="Cover Image" width="200" height="300">

        <hr>
    </div>

   <script>
        // Convert Blob to Uint8Array
        function blobToUint8Array(blob) {
            return new Promise((resolve) => {
                const reader = new FileReader();
                reader.onload = () => {
                    resolve(new Uint8Array(reader.result));
                };
                reader.readAsArrayBuffer(blob);
            });
        }

        // Initialize PDF.js for each book
        blobToUint8Array(<%= book.getPdf() %>).then(function (pdfData_<%= book.getPdfId() %>)) {
            var loadingTask_<%= book.getPdfId() %> = pdfjsLib.getDocument({ data: pdfData_<%= book.getPdfId() %> });

            loadingTask_<%= book.getPdfId() %>.promise.then(function(pdf_<%= book.getPdfId() %>) {
                // Fetch the first page
                pdf_<%= book.getPdfId() %>.getPage(1).then(function(page_<%= book.getPdfId() %>) {
                    var scale_<%= book.getPdfId() %> = 1;
                    var canvas_<%= book.getPdfId() %> = document.getElementById('pdfCanvas_<%= book.getPdfId() %>');
                    var context_<%= book.getPdfId() %> = canvas_<%= book.getPdfId() %>.getContext('2d');
                    var viewport_<%= book.getPdfId() %> = page_<%= book.getPdfId() %>.getViewport({ scale: scale_<%= book.getPdfId() %> });

                    // Set the canvas size to match the PDF page size
                    canvas_<%= book.getPdfId() %>.height = viewport_<%= book.getPdfId() %>.height;
                    canvas_<%= book.getPdfId() %>.width = viewport_<%= book.getPdfId() %>.width;

                    // Render the first page
                    var renderContext_<%= book.getPdfId() %> = {
                        canvasContext: context_<%= book.getPdfId() %>,
                        viewport: viewport_<%= book.getPdfId() %>
                    };
                    page_<%= book.getPdfId() %>.render(renderContext_<%= book.getPdfId() %>);
                });
            });
        });
    </script>
<%
    }
%>

</body>
</html>  --%>




<%-- <%@page import="java.util.List"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.util.Base64"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Free Books</title>
</head>
<body>

<h2>Free Books</h2>

<%
    // List of hardcoded paths to PDF files
    List<String> pdfPaths = List.of(
        "C:\\Users\\user\\Downloads\\Wings of Fire(Malayalam).pdf"
        
    );

    for (String pdfPath : pdfPaths) {
        // Read the content of the PDF file as bytes
        byte[] pdfBytes = Files.readAllBytes(Path.of(pdfPath));

        // Base64 encode the PDF content
        String base64Pdf = Base64.getEncoder().encodeToString(pdfBytes);
%>
    <div>
        <h3>PDF Title</h3>

        Display the PDF using an iframe
        <iframe src="data:application/pdf;base64, <%= base64Pdf %>" width="100%" height="600px"></iframe>

        <hr>
    </div>
<%
    }
%>

</body>
</html>



 
 
 
<%@page import="library.management.entities.FreeBook"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.List"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://example.com/utility" prefix="util" %>
<%@ page import="library.management.utilities.UtilityFunctions"%>


<html>
<head>
    <title>Free Books</title>
    <!-- Include PDF.js library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.9.359/pdf.min.js"></script>
    
</head>
<body>

<h2>Free Books</h2>

<%
List<FreeBook> freeBooks = (List<FreeBook>) request.getAttribute("freeBooks");
for (FreeBook book : freeBooks) {
    // Assuming getPdf() returns a Blob
    Blob pdfBlob = book.getPdf();

    // Convert Blob to byte array
     byte[] pdfBytes = util:blobToBytes(pdfBlob); */

    // Encode byte array to Base64
    String pdfBase64 = Base64.getEncoder().encodeToString(pdfBytes);
%>
    <div>
        <h3><%= book.getPdfName() %> by <%= book.getPdfAuthorName() %></h3>

        Display the PDF using PDF.js
        <canvas id="pdfCanvas_<%= book.getPdfId() %>"></canvas>

        <script>
            var pdfBase64_<%= book.getPdfId() %> = '<%= pdfBase64 %>';
            
            // Convert Base64 to Uint8Array
            var pdfData_<%= book.getPdfId() %> = new Uint8Array(atob(pdfBase64_<%= book.getPdfId() %>).split("").map(function(c) { return c.charCodeAt(0); }));

            // Convert Uint8Array to Blob
            var pdfBlob_<%= book.getPdfId() %> = new Blob([pdfData_<%= book.getPdfId() %>], { type: 'application/pdf' });

            pdfjsLib.getDocument({ url: URL.createObjectURL(pdfBlob_<%= book.getPdfId() %>) }).promise.then(function(pdf) {
                pdf.getPage(1).then(function(page) {
                    var scale = 1;
                    var viewport = page.getViewport({ scale: scale });
                    var canvas = document.getElementById('pdfCanvas_<%= book.getPdfId() %>');
                    var context = canvas.getContext('2d');
                    canvas.height = viewport.height;
                    canvas.width = viewport.width;
                    var renderContext = {
                        canvasContext: context,
                        viewport: viewport
                    };
                    page.render(renderContext);
                });
            });
        </script>

        <hr>
    </div>
<%
    }
%>
</body>
</html>

Book Donation Platform:

Create a feature for users to donate books to the library or to other users.


--%> 
 
 
 