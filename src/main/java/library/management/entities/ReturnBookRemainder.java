package library.management.entities;

import java.sql.Date;

public class ReturnBookRemainder {
	private int userId;
	private String emailId;
	private int bookId;
	private int borrowedId;
	private String bookName;
	private Date borrowedDate;
	private Date returnDate;
	private int bookFine;
	private boolean returnStatus;
	
	
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
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
	public Date getBorrowedDate() {
		return borrowedDate;
	}
	public void setBorrowedDate(Date borrowedDate) {
		this.borrowedDate = borrowedDate;
	}
	public Date getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}
	public int getBookFine() {
		return bookFine;
	}
	public void setBookFine(int bookFine) {
		this.bookFine = bookFine;
	}
	public boolean isReturnStatus() {
		return returnStatus;
	}
	public void setReturnStatus(boolean returnStatus) {
		this.returnStatus = returnStatus;
	}
	
	
	
}
