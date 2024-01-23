package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.RequestBookHistory;

public class RequestBookHistoryRowMapper implements RowMapper<RequestBookHistory>{

	@Override
	public RequestBookHistory mapRow(ResultSet rs, int rowNum) throws SQLException {
		// TODO Auto-generated method stub
		RequestBookHistory list = new RequestBookHistory();
		list.setUserId(rs.getInt("userId"));
		list.setUserName(rs.getString("userName"));
		list.setBookId(rs.getInt("bookId"));
		list.setBookName(rs.getString("bookName"));
		list.setBookCover(rs.getBlob("bookCover"));
		list.setCount(rs.getInt("orderCount"));
		list.setAuthorName(rs.getString("authorName"));
		return list;
	}

}
