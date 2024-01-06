package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.BorrowBook;

public class BorrowRowMapper implements RowMapper<BorrowBook>{
	
	@Override
	public BorrowBook mapRow(ResultSet rs, int rowNum) throws SQLException {
		BorrowBook book = new BorrowBook();
		book.setBorrowedId(rs.getInt("borrowedId"));
		book.setBorrowDate(rs.getDate("borrowedDate"));
		book.setReturnDate(rs.getDate("returnDate"));
		book.setFine(rs.getInt("bookFine"));
		book.setBookCover(rs.getBlob("bookCover"));
		book.setBookName(rs.getString("bookName"));
		
		return book;
	}

}
