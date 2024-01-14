package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.BookApproval;

public class viewApprovalRowMapper implements RowMapper<BookApproval> {

	@Override
	public BookApproval mapRow(ResultSet rs, int rowNum) throws SQLException {
		BookApproval list = new BookApproval();
//		userName, userEmailId, userId, bookId, bookName, bookCover, borrowedId, borrowedDate, returnDate
		list.setUserId(rs.getInt("userId"));
		list.setUserEmailId(rs.getString("userEmailId"));
		list.setUserName(rs.getString("userName"));
		list.setBookId(rs.getInt("bookId"));
		list.setBookName(rs.getString("bookName"));
		list.setBookCover(rs.getBlob("bookCover"));
		list.setBorrowedDate(rs.getDate("borrowedDate"));
		list.setBorrowedId(rs.getInt("borrowedId"));
		list.setReturnDate(rs.getDate("returnDate"));
		return list;
	}

}
