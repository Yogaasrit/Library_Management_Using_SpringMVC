package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.ForumHistory;

public class ForumHistoryRowMapper implements RowMapper<ForumHistory>{

	@Override
	public ForumHistory mapRow(ResultSet rs, int rowNum) throws SQLException {
		ForumHistory list = new ForumHistory();
		list.setForumId(rs.getInt("forumId"));
		list.setUserId(rs.getInt("userId"));
		list.setUserName(rs.getString("userName"));
		list.setContent(rs.getString("content"));
		list.setDate(rs.getDate("date"));
		return list;
	}
}
