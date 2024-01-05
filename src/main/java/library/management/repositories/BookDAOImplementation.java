package library.management.repositories;

import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;
import library.management.entities.Book;

public class BookDAOImplementation implements BookDAO {
	JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public List<Book> viewAllBooks() {
		String displayAllBooksQuery = "select * from books where bookStatus = 1";
		return jdbcTemplate.query(displayAllBooksQuery, new BookRowMapper());
	}

	@Override
	public List<Book> filterByBookName(String bookName) {
		String searchBookQuery = "select * from books where bookName like CONCAT( '%',?,'%')";
		return jdbcTemplate.query(searchBookQuery, new BookRowMapper(),bookName);
	}

	@Override
	public List<Book> viewAllAuthors() {
		String displayAllAuthorsQuery = "select * from books ";
		return jdbcTemplate.query(displayAllAuthorsQuery, new BookRowMapper());
	}

	@Override
	public List<Book> viewAllGenre() {
		String displayAllGenreQuery = "select * from books";
		return jdbcTemplate.query(displayAllGenreQuery, new BookRowMapper());
	}

}
