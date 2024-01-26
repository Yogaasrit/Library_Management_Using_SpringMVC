package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.LeaderBoard;

public class LeaderBoardRowMapper implements RowMapper<LeaderBoard>{

	@Override
	public LeaderBoard mapRow(ResultSet rs, int rowNum) throws SQLException {
		LeaderBoard list = new LeaderBoard();
		list.setUserName(rs.getString("userName"));
		list.setUserProfile(rs.getBlob("profilePic"));
		list.setBadgeCount(rs.getInt("badgeCount"));
		return list;
	}

}
