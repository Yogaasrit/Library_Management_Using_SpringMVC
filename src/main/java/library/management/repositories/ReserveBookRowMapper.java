package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.RequestBook;
import library.management.entities.ReserveBook;

public class ReserveBookRowMapper implements RowMapper<ReserveBook>{

	@Override
	public ReserveBook mapRow(ResultSet rs, int rowNum) throws SQLException {
		// TODO Auto-generated method stub
		ReserveBook book =new ReserveBook();
		book.setUserId(rs.getInt("userId"));
		book.setUserName(rs.getString("userName"));
		book.setBookId(rs.getInt("bookId"));
		book.setBookName(rs.getString("bookName"));
		book.setBookCover(rs.getBlob("bookCover"));
		book.setAuthorName(rs.getString("authorName"));
		book.setBookQuantity(rs.getInt("bookQuantity"));
		return book;
	}

	

}
