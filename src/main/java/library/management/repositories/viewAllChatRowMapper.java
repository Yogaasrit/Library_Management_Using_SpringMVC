package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.Chat;

public class viewAllChatRowMapper implements RowMapper<Chat> {

	@Override
	public Chat mapRow(ResultSet rs, int rowNum) throws SQLException {
		Chat list = new Chat();
		list.setChatId(rs.getInt("chatId"));
		list.setUserId(rs.getInt("userId"));
		list.setUserName(rs.getString("userName"));
		list.setMessage(rs.getString("chatMessage"));
		list.setReplyMessage(rs.getString("chatReply"));
		return list;
	}

	

}
