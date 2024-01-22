<%@page import="library.management.entities.FreeBook"%>
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
</html>
