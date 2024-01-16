package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.AdminDashboardStats;

public class totalBooksBoughtRowMapper implements RowMapper<AdminDashboardStats>
{

	@Override
	public AdminDashboardStats mapRow(ResultSet rs, int rowNum) throws SQLException {
		AdminDashboardStats stats = new AdminDashboardStats();
		stats.setTotalBoughtBooks(rs.getInt("orderedbooks"));
		return stats;
		
	}

}
