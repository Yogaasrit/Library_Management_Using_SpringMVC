package library.management.entities;

import java.sql.Blob;
import java.sql.Date;

public class BorrowBook {
	private int borrowedId;
	private String bookName;
	private Date borrowDate;
	private Date returnDate;
	private int fine;
	private Blob bookCover;
	public int getBorrowedId() {
		return borrowedId;
	}
	public void setBorrowedId(int borrowedId) {
		this.borrowedId = borrowedId;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public Date getBorrowDate() {
		return borrowDate;
	}
	public void setBorrowDate(Date borrowDate) {
		this.borrowDate = borrowDate;
	}
	public Date getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}
	public int getFine() {
		return fine;
	}
	public void setFine(int fine) {
		this.fine = fine;
	}
	public Blob getBookCover() {
		return bookCover;
	}
	public void setBookCover(Blob bookCover) {
		this.bookCover = bookCover;
	}
	
	
}
