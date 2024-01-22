package library.management.entities;

import java.sql.Blob;

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
}
