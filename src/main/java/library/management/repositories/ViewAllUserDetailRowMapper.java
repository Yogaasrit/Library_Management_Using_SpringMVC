package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.ViewUserDetails;

public class ViewAllUserDetailRowMapper implements RowMapper<ViewUserDetails>{

	@Override
	public ViewUserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		ViewUserDetails user = new ViewUserDetails();
		user.setUserId(rs.getInt("userId"));
		user.setUserName(rs.getString("userName"));
		user.setUserEmailId(rs.getString("userEmailId"));
		user.setAddress(rs.getString("address"));
		user.setDob(rs.getDate("dob"));
		user.setGender(rs.getString("gender"));
		user.setPhoneNo(rs.getString("phoneNo"));
		user.setTotalBorrowedBooks(rs.getInt("totalBorrowedBooks"));
		user.setTotalOrderedBooks(rs.getInt("totalOrderedBooks"));
		user.setTotalFine(rs.getInt("totalFine"));
		return user;
	}

}
