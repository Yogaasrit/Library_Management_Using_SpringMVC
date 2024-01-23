package library.management.entities;

import java.sql.Blob;

public class RequestBookHistory {
	private String userName;
	private int userId;
	private int bookId;
	private String bookName;
	private String authorName;
	private Blob bookCover;
	private int count;
	
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	
	public RequestBookHistory() {
		super();
		// TODO Auto-generated constructor stub
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
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
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
}
