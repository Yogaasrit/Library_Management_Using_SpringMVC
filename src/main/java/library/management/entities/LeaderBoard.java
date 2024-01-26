package library.management.entities;

import java.sql.Blob;

public class LeaderBoard {
	private String userName;
	private Blob userProfile;
	private int badgeCount;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Blob getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(Blob userProfile) {
		this.userProfile = userProfile;
	}
	public int getBadgeCount() {
		return badgeCount;
	}
	public void setBadgeCount(int badgeCount) {
		this.badgeCount = badgeCount;
	}
	
	
}
