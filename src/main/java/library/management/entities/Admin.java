package library.management.entities;

public class Admin {
	private String adminEmailId;
	private String adminName;
	private String adminPassword;
	public Admin() {
		super();
	}
	public Admin(String adminName, String adminPassword) {
		super();
		this.adminName = adminName;
		this.adminPassword = adminPassword;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminPassword() {
		return adminPassword;
	}
	public void setAdminPassword(String adminPassword) {
		this.adminPassword = adminPassword;
	}
	public String getAdminEmailId() {
		return adminEmailId;
	}
	public void setAdminEmailId(String adminEmailId) {
		this.adminEmailId = adminEmailId;
	}
	public Admin(String adminEmailId, String adminName, String adminPassword) {
		super();
		this.adminEmailId = adminEmailId;
		this.adminName = adminName;
		this.adminPassword = adminPassword;
	}
	@Override
	public String toString() {
		return "Admin [adminEmailId=" + adminEmailId + ", adminName=" + adminName + ", adminPassword=" + adminPassword
				+ "]";
	}
	
}
