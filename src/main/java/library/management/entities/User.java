package library.management.entities;

import java.sql.Blob;
import java.sql.Date;

public class User {
	private int userId;	
	private String userEmailId;
	private String userName;
	private String phoneNo;
	private Date dob;
	private String address;
	private String gender;
	private String userPassword;
	private Blob profilePic;
	
	public User(int userId, String userEmailId, String userName, String phoneNo, Date dob, String address,
			String gender, String userPassword,Blob profilePic) {
		super();
		this.userId = userId;
		this.userEmailId = userEmailId;
		this.userName = userName;
		this.phoneNo = phoneNo;
		this.dob = dob;
		this.address = address;
		this.gender = gender;
		this.userPassword = userPassword;
		this.profilePic = profilePic;
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
	 
	
	// Add more details ???
	public User() {
		super();
	}
	public User(String userName, String userEmailId, String userPassword) {
		super();
		this.userName = userName;
		this.userEmailId = userEmailId;
		this.userPassword = userPassword;
	}
	public User(int userId, String userName, String userEmailId, String userPassword) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userEmailId = userEmailId;
		this.userPassword = userPassword;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
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
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	
	public Blob getProfilePic() {
		return profilePic;
	}
	public void setProfilePic(Blob profilePic) {
		this.profilePic = profilePic;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", userEmailId=" + userEmailId + ", userName=" + userName + ", phoneNo="
				+ phoneNo + ", dob=" + dob + ", address=" + address + ", gender=" + gender + ", userPassword="
				+ userPassword + "]";
	}
	
	
	
}
