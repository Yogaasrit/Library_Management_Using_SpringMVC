package library.management.entities;

import java.sql.Date;

public class ViewUserDetails {
	
	private int userId;
	private String userEmailId;
	private String userName;
	private String phoneNo;
	private Date dob;
	private String address;
	private String gender;
	private int totalOrderedBooks;
	private int totalBorrowedBooks;
	private int totalFine;
	
	public ViewUserDetails(int userId, String userEmailId, 
			String userName, String phoneNo, Date dob, String address,
			String gender, int totalOrderedBooks, int totalBorrowedBooks, int totalFine) {
		super();
		this.userId = userId;
		this.userEmailId = userEmailId;
		this.userName = userName;
		this.phoneNo = phoneNo;
		this.dob = dob;
		this.address = address;
		this.gender = gender;
		this.totalOrderedBooks = totalOrderedBooks;
		this.totalBorrowedBooks = totalBorrowedBooks;
		this.totalFine = totalFine;
	}

	public ViewUserDetails() {
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserEmailId() {
		return userEmailId;
	}

	public void setUserEmailId(String userEmailId) {
		this.userEmailId = userEmailId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getTotalOrderedBooks() {
		return totalOrderedBooks;
	}

	public void setTotalOrderedBooks(int totalOrderedBooks) {
		this.totalOrderedBooks = totalOrderedBooks;
	}

	public int getTotalBorrowedBooks() {
		return totalBorrowedBooks;
	}

	public void setTotalBorrowedBooks(int totalBorrowedBooks) {
		this.totalBorrowedBooks = totalBorrowedBooks;
	}

	public int getTotalFine() {
		return totalFine;
	}

	public void setTotalFine(int totalFine) {
		this.totalFine = totalFine;
	}

	@Override
	public String toString() {
		return "ViewUserDetails [userId=" + userId + ", userEmailId=" + userEmailId + ", userName=" + userName
				+ ", phoneNo=" + phoneNo + ", dob=" + dob + ", address=" + address + ", gender=" + gender
				+ ", totalOrderedBooks=" + totalOrderedBooks + ", totalBorrowedBooks=" + totalBorrowedBooks
				+ ", totalFine=" + totalFine + "]";
	}
	
	

}
