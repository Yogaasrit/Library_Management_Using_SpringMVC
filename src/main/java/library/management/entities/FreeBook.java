package library.management.entities;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;

public class FreeBook {
	private int pdfId;
	private String pdfName;
	private String pdfAuthorName;
	private Blob pdf;
	private Blob pdfCover;
	
	public FreeBook(String pdfName, String pdfAuthorName, Blob pdfBlob, Blob pdfCoverBlob) {
		// TODO Auto-generated constructor stub
		super();
		this.pdfName=pdfName;
		this.pdfAuthorName=pdfAuthorName;
		this.pdf=pdfBlob;
		this.pdfCover=pdfCoverBlob;
	}
	public FreeBook() {
		// TODO Auto-generated constructor stub
	}
	public int getPdfId() {
		return pdfId;
	}
	public void setPdfId(int pdfId) {
		this.pdfId = pdfId;
	}
	public String getPdfName() {
		return pdfName;
	}
	public void setPdfName(String pdfName) {
		this.pdfName = pdfName;
	}
	public String getPdfAuthorName() {
		return pdfAuthorName;
	}
	public void setPdfAuthorName(String pdfAuthorName) {
		this.pdfAuthorName = pdfAuthorName;
	}
	public Blob getPdf() {
		return pdf;
	}
	public void setPdf(Blob pdf) {
		this.pdf = pdf;
	}
	public Blob getPdfCover() {
		return pdfCover;
	}
	public void setPdfCover(Blob pdfCover) {
		this.pdfCover = pdfCover;
	}
	
	
	
	 public byte[] getPdfAsBytes() throws SQLException {
	        // Check if the Blob is not null
	        if (pdf == null) {
	            return null;
	        }

	        // Convert the Blob to a byte array
	        try (InputStream inputStream = pdf.getBinaryStream()) {
	            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
	            byte[] buffer = new byte[4096];
	            int bytesRead;

	            while ((bytesRead = inputStream.read(buffer)) != -1) {
	                outputStream.write(buffer, 0, bytesRead);
	            }

	            return outputStream.toByteArray();
	        } catch (IOException e) {
	            // Handle IOException if necessary
	            e.printStackTrace();
	        }

	        return null;
	    }
	
	
}
