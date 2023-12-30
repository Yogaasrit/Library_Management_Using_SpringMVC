package library.management.entities;

public class User {
	private int userId;
	private String userName;
	private String userEmailId;
	private String userPassword;
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
	@Override
	public String toString() {
		return "User [userName=" + userName + ", userEmailId=" + userEmailId + ", userPassword=" + userPassword + "]";
	}
	
}
