package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;
import library.management.entities.Admin;

public class AdminLoginRowMapper implements RowMapper<Admin>{

	@Override
	public Admin mapRow(ResultSet rs, int rowNum) throws SQLException {
		Admin admin = new Admin();
		admin.setAdminEmailId(rs.getString("adminEmailId"));
		admin.setAdminPassword(rs.getString("adminPassword"));
		admin.setAdminName(rs.getString("adminName"));
		return admin;
	}
}
