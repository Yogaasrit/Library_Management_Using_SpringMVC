package library.management.entities;

import java.sql.Blob;
import java.sql.Date;

public class BookApproval {
	private String userName;
	private String userEmailId;
	private int userId;
	private int bookId;
	private String bookName;
	private Blob bookCover;
	private int borrowedId;
	private Date borrowedDate;
	private Date returnDate;
	
	
	public BookApproval() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmailId() {
		return userEmailId;
	}
	public void setUserEmailId(String userEmailId) {
		this.userEmailId = userEmailId;
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
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public Blob getBookCover() {
		return bookCover;
	}
	public void setBookCover(Blob bookCover) {
		this.bookCover = bookCover;
	}
	public int getBorrowedId() {
		return borrowedId;
	}
	public void setBorrowedId(int borrowedId) {
		this.borrowedId = borrowedId;
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
	
}
