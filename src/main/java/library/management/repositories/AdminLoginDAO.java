package library.management.repositories;
import java.util.List;
import library.management.entities.Admin;

public interface AdminLoginDAO{
	public List<Admin> validateAdmin(String adminEmailId,String adminPassword);
	public int totalUser();
	public int totalBooks();
	public int totalBooksBorrowed();
	public int totalBooksBought();
	public int totalBooksBorrowedToday();
	public int totalBooksBoughtToday();
	public int totalBooksApproval();
	public int totalUserOverDueCount();
	public String getPassword();
	public int updateAdminPassWord(String confirmPassword);
		
	
}
