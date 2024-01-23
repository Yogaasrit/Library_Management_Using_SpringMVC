package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.RowMapper;

import library.management.entities.RequestBook;

public class RequestBookByIdRowMapper implements RowMapper<RequestBook> {

	@Override
	public RequestBook mapRow(ResultSet rs, int rowNum) throws SQLException {
		RequestBook requestBook = new RequestBook();
		requestBook.setBookName(rs.getString("bookName"));
		requestBook.setBookCover(rs.getBlob("bookCover"));
		requestBook.setBookQuantity(rs.getInt("orderCount"));
		requestBook.setBookId(rs.getInt("bookId"));
		requestBook.setUserId(rs.getInt("userId"));
		requestBook.setAuthorName(rs.getString("authorName"));
		requestBook.setCount(rs.getInt("bookQuantity"));
		
		return requestBook;
	}

}
