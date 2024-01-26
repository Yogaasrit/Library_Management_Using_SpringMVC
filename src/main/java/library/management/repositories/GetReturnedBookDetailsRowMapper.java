package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.ReturnedBook;


public class GetReturnedBookDetailsRowMapper implements RowMapper<ReturnedBook>{

	@Override
	public ReturnedBook mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReturnedBook books = new ReturnedBook();
		books.setBookId(rs.getInt("bookId"));
		books.setBookCover(rs.getBlob("bookCover"));
		books.setReturnStatus(rs.getBoolean("returnStatus"));
		books.setBorrowedId(rs.getInt("borrowedId"));
		return books;
	}

	
}
