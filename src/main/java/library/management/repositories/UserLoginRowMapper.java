package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

import library.management.entities.User;

public class UserLoginRowMapper implements RowMapper<User>{

	@Override
	public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		User user = new User();
		user.setUserId(rs.getInt("userId"));
		user.setUserEmailId(rs.getString("userEmailId"));
		user.setUserPassword(rs.getString("userPassword"));
		user.setUserName(rs.getString("userName"));
		return user;
	}

	

}
