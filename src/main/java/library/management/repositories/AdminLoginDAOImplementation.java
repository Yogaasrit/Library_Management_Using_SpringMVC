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

}
