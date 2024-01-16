package library.management.repositories;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import library.management.entities.Admin;

public class AdminLoginDAOImplementation implements AdminLoginDAO{

	@Autowired
	JdbcTemplate jdbcTemplate;	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public List<Admin> validateAdmin(String adminEmailId, String adminPassword) {
		String validateAdminQuery = "SELECT * FROM ADMIN WHERE adminEmailId = ? and adminPassword = ?";
		return jdbcTemplate.query(validateAdminQuery, new AdminLoginRowMapper() ,adminEmailId,adminPassword);
	}
	@Override
	public int totalUser() {
		String totalUserQuery = "SELECT COUNT(*) AS totalUsers FROM user where status = 1";
		return jdbcTemplate.query(totalUserQuery, new TotalUserCountRowMapper()).get(0).getTotalUser();
	}
	@Override
	public int totalBooks() {
		String totalUserQuery = "SELECT COUNT(*) AS totalBooks FROM books where bookStatus = 1";
		return jdbcTemplate.query(totalUserQuery, new TotalBookCountRowMapper()).get(0).getTotalBookCount();
	}
	@Override
	public int totalBooksBorrowed() {
		String totalBooksBorrowed = "SELECT COUNT(*) AS borrowedBooks FROM borrowbook WHERE returnStatus = 0";
		return jdbcTemplate.query(totalBooksBorrowed, new TotalBooksBorrowedRowMapper()).get(0).getTotalBorrowedBook();
	}
	@Override
	public int totalBooksBoughtToday() {
		String totalBooksBoughtToday = "SELECT SUM(bookCount) AS boughtBook FROM orderedbooks WHERE orderDate = CURDATE()";
		return jdbcTemplate.query(totalBooksBoughtToday, new totalBooksBoughtTodayRowMapper()).get(0).getTotalBooksBoughtToday();
	}
	@Override
	public int totalBooksBought() {
		String totalBooksBought = "select sum(bookCount) as orderedbooks from orderedbooks";
		return jdbcTemplate.query(totalBooksBought, new totalBooksBoughtRowMapper()).get(0).getTotalBoughtBooks();
	}
	@Override
	public int totalBooksBorrowedToday() {
		String totalBooksBorrowedToday = "SELECT COUNT(*) AS borrowedBook FROM borrowbook WHERE returnStatus = 0 and borrowedDate = CURDATE()";	
		return jdbcTemplate.query(totalBooksBorrowedToday, new totalBooksBorrowedTodayRowMapper()).get(0).getTotalBooksBorrowedToday();
	}
	
	@Override
	public int totalBooksApproval() {
		String totalBooksApproval= "select count(*) as pendingApproval from borrowbook where approveStatus=1";
		
		return jdbcTemplate.query(totalBooksApproval, new totalBooksApprovalRowMapper()).get(0).getTotalPendingApproval();
	}
	@Override
	public int totalUserOverDueCount() {
		String totalUserOverDueCountQuery = "SELECT COUNT(*) AS overdueBooks FROM borrowbook WHERE returnStatus = 0 AND returnDate < CURDATE()";
		
		return jdbcTemplate.query(totalUserOverDueCountQuery, new totalUserOverDueCountQueryRowMapper()).get(0).getTotalUserOverDueCount();
	}
	@Override
	public String getPassword() {
		String getPassword = "select * from admin";
		return jdbcTemplate.query(getPassword, new AdminLoginRowMapper()).get(0).getAdminPassword();
	}
	@Override
	public int updateAdminPassWord(String confirmPassword) {
		String updateAdminPassword = "update admin set adminPassword = ?";
		return jdbcTemplate.update(updateAdminPassword,confirmPassword);
	}

}
