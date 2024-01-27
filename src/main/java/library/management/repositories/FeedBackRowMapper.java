package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.FeedBack;

public class FeedBackRowMapper implements RowMapper<FeedBack>{

	@Override
	public FeedBack mapRow(ResultSet rs, int rowNum) throws SQLException {
		FeedBack feedBack = new FeedBack();
		feedBack.setStar(rs.getInt("star"));
		feedBack.setComment(rs.getString("comment"));
		return feedBack;
	}

}
