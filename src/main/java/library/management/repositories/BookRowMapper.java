package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import org.springframework.jdbc.core.RowMapper;
import library.management.entities.Book;

public class BookRowMapper implements RowMapper<Book> {
	@Override
	public Book mapRow(ResultSet rs, int rowNum) throws SQLException {
		Book book = new Book();
		book.setBookId(rs.getInt("bookId"));
		book.setBookName(rs.getString("bookName"));
		book.setBookPrice(rs.getInt("bookPrice"));
		book.setBookGenre(rs.getString("bookGenre"));
		book.setBookPublication(rs.getString("bookPublication"));
		book.setPublishDate(rs.getDate("bookPublishDate"));
		book.setBookEdition(rs.getInt("bookEdition"));
		book.setBookQuantity(rs.getInt("bookQuantity"));
		book.setAuthorName(rs.getString("authorName"));
		book.setBookStatus(rs.getBoolean("bookStatus"));
		return book;
	}

}
