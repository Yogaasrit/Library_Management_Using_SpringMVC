package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.ReserveBook;

public class InsertHandleRowMapper implements RowMapper<ReserveBook>{

	@Override
	public ReserveBook mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReserveBook book = new ReserveBook();
		
		book.setUserId(rs.getInt("userId"));
		book.setReserveStatus(rs.getBoolean("reserveStatus"));
		book.setBookId(rs.getInt("bookId"));
		
		return book;
	}

}
