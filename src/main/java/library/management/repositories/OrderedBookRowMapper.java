package library.management.repositories;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import library.management.entities.PurchasedBook;

public class OrderedBookRowMapper implements RowMapper<PurchasedBook>{

	@Override
	public PurchasedBook mapRow(ResultSet rs, int rowNum) throws SQLException {
		PurchasedBook book = new PurchasedBook();
		book.setBookName(rs.getString("bookName"));
		book.setBookPrice(rs.getInt("bookPrice"));
		book.setOrderDate(rs.getDate("orderDate"));
		book.setBookCount(rs.getInt("bookCount"));
		book.setBookCover(rs.getBlob("bookCover"));
		return book;
	}

}
