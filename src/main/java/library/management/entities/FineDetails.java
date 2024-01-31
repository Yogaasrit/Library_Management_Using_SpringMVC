package library.management.entities;

public class FineDetails {

	private int fineAmount;
	private int borrowedId;

	public int getFineAmount() {
		return fineAmount;
	}

	public void setFineAmount(int fineAmount) {
		this.fineAmount = fineAmount;
	}

	public int getBorrowedId() {
		return borrowedId;
	}

	public void setBorrowedId(int borrowedId) {
		this.borrowedId = borrowedId;
	}

}
