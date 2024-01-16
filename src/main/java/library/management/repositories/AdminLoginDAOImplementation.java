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
		String totalUserQuery = "SELECT COUNT(*) AS totalBooks FROM user where bookStatus = 1";
		return jdbcTemplate.query(totalUserQuery, new TotalBookCountRowMapper()).get(0).getTotalBookCount();
	}
	@Override
	public int totalBooksBorrowedToday() {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int totalBooksBoughtToday() {
		// TODO Auto-generated method stub
		return 0;
	}

}
