package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.User;

public class GetUserRowMapper implements RowMapper<User>{

	@Override
	public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		User user = new User();
		user.setUserEmailId(rs.getString("userEmailId"));
		user.setUserName(rs.getString("userName"));
		user.setUserId(rs.getInt("userId"));
		user.setDob(rs.getDate("dob"));
		user.setAddress(rs.getString("address"));
		user.setGender(rs.getString("gender"));
		user.setPhoneNo(rs.getString("phoneNo"));
		user.setProfilePic(rs.getBlob("profilePic"));
		return user;
	}

}
