package library.management.repositories;

import java.sql.Date;
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
		String displayAllAuthorsQuery = "select distinct authorName from books ";
		return jdbcTemplate.query(displayAllAuthorsQuery, new ViewAuthorRowMapper());
	}

	@Override
	public List<Book> viewAllGenre() {
		String displayAllGenreQuery = "select distinct bookGenre from books";
		return jdbcTemplate.query(displayAllGenreQuery, new ViewGenreRowMapper());
	}

	@Override
	public List<Book> filterByBookAuthor(String authorName) {
		String searchAuthorQuery = "select * from books where authorName like CONCAT( '%',?,'%')";
		return jdbcTemplate.query(searchAuthorQuery, new BookRowMapper(), authorName);
	}

	@Override
	public List<Book> filterByBookGenre(String bookGenre) {
		String searchGenreQuery = "select * from books where bookGenre like CONCAT( '%',?,'%')";
		return jdbcTemplate.query(searchGenreQuery, new BookRowMapper(), bookGenre);
	}

	@Override
	public Book displayByBookId(int bookId) {
		String displayByBookIdQuery = "select * from books where bookId = ?";
		return jdbcTemplate.queryForObject(displayByBookIdQuery, new BookRowMapper(), bookId);
	}

	@Override
	public int updateBookCount(int bookQuantity) {
		String updateBookCountQuery = "update books set bookQuantity = bookQuantity - ?";
		return jdbcTemplate.update(updateBookCountQuery,bookQuantity);
	}

	@Override
	public int updateBorrowBookCount(int userId, int bookId, Date borrowedDate,Date returnDate) {
		//`borrowedId`, `userId`, `borrowedDate`, `bookFine`, `bookId`, `returnStatus`
		
		String insertBorrowBookQuery = "INSERT INTO borrowbook "
				+ " (`userId`, `borrowedDate`, `bookFine`, `bookId`, `returnStatus`,`returnDate`) "
				+ " VALUES "
				+ " (?,?,?,?,?,?) ";
	
		int status = 0;
		if(jdbcTemplate.update(insertBorrowBookQuery,
								userId,
								borrowedDate,
								0,
								bookId,
								0,
								returnDate
								) == 1) {
			
			String updateBorrowBookCount = "UPDATE books SET bookQuantity = bookQuantity - 1";
			status = jdbcTemplate.update(updateBorrowBookCount);
		}
		return status;
	}

}
