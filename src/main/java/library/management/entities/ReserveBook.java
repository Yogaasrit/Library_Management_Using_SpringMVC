package library.management.entities;

import java.sql.Blob;

public class ReserveBook {
	
	private int reserveId;
	private int userId;
	private String userName;
	private int bookId;
	private String bookName;
	private boolean reserveStatus;
	private Blob bookCover;
	private String authorName;
	private int bookQuantity;
	
	public int getBookQuantity() {
		return bookQuantity;
	}
	public void setBookQuantity(int bookQuantity) {
		this.bookQuantity = bookQuantity;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public int getReserveId() {
		return reserveId;
	}
	public void setReserveId(int reserveId) {
		this.reserveId = reserveId;
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
	public boolean isReserveStatus() {
		return reserveStatus;
	}
	public void setReserveStatus(boolean reserveStatus) {
		this.reserveStatus = reserveStatus;
	}
	@Override
	public String toString() {
		return "ReserveBook [reserveId=" + reserveId + ", userId=" + userId + ", bookId=" + bookId + ", reserveStatus="
				+ reserveStatus + "]";
	}
	
	
	
	
	

}
