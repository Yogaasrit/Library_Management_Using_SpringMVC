package library.management.entities;

public class AdminDashboardStats {
	
	private int totalUser;
	private int totalBookCount;
	private int totalBorrowedBook;
	private int totalBoughtBooks;
	private int totalPendingApproval;
	private int totalBooksBorrowedToday;
	private int totalBooksBoughtToday;
	private int totalUserOverDueCount;
	
	public int getTotalUserOverDueCount() {
		return totalUserOverDueCount;
	}

	public void setTotalUserOverDueCount(int totalUserOverDueCount) {
		this.totalUserOverDueCount = totalUserOverDueCount;
	}

	public int getTotalBooksBoughtToday() {
		return totalBooksBoughtToday;
	}

	public void setTotalBooksBoughtToday(int totalBooksBoughtToday) {
		this.totalBooksBoughtToday = totalBooksBoughtToday;
	}

	public int getTotalBooksBorrowedToday() {
		return totalBooksBorrowedToday;
	}

	public void setTotalBooksBorrowedToday(int totalBooksBorrowedToday) {
		this.totalBooksBorrowedToday = totalBooksBorrowedToday;
	}

	public int getTotalPendingApproval() {
		return totalPendingApproval;
	}

	public void setTotalPendingApproval(int totalPendingApproval) {
		this.totalPendingApproval = totalPendingApproval;
	}

	public int getTotalBoughtBooks() {
		return totalBoughtBooks;
	}

	public void setTotalBoughtBooks(int totalBoughtBooks) {
		this.totalBoughtBooks = totalBoughtBooks;
	}

	public int getTotalBorrowedBook() {
		return totalBorrowedBook;
	}

	public void setTotalBorrowedBook(int totalBorrowedBook) {
		this.totalBorrowedBook = totalBorrowedBook;
	}

	public AdminDashboardStats() {
		super();
	}

	public int getTotalUser() {
		return totalUser;
	}

	public void setTotalUser(int totalUser) {
		this.totalUser = totalUser;
	}

	public int getTotalBookCount() {
		return totalBookCount;
	}

	public void setTotalBookCount(int totalBookCount) {
		this.totalBookCount = totalBookCount;
	}
	
	
	
	

}
