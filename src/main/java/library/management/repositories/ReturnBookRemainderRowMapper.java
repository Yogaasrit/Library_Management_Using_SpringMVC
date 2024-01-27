package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.ReturnBookRemainder;

public class ReturnBookRemainderRowMapper implements RowMapper<ReturnBookRemainder>{

	@Override
	public ReturnBookRemainder mapRow(ResultSet rs, int rowNum) throws SQLException {
	ReturnBookRemainder books = new ReturnBookRemainder();
	books.setUserId(rs.getInt("userId"));
	books.setBookId(rs.getInt("bookId"));
	books.setBookName(rs.getString("bookName"));
	books.setBorrowedId(rs.getInt("borrowedId"));
	books.setBorrowedDate(rs.getDate("borrowedDate"));
	books.setReturnDate(rs.getDate("returnDate"));
	books.setBookFine(rs.getInt("bookFine"));
	books.setReturnStatus(rs.getBoolean("returnStatus"));
	books.setEmailId(rs.getString("userEmailId"));
		return books;
	}

}
