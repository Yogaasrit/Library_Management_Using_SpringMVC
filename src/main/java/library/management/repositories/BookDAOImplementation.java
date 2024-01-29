package library.management.repositories;

import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import library.management.entities.Book;
import library.management.entities.FeedBack;
import library.management.entities.FreeBook;

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
		String searchBookQuery = "select * from books where bookName like CONCAT( '%',?,'%') and bookStatus = 1 and bookQuantity > 0 order by bookName";
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
		String searchAuthorQuery = "select * from books where authorName like CONCAT( '%',?,'%') order by authorName";
		return jdbcTemplate.query(searchAuthorQuery, new BookRowMapper(), authorName);
	}

	@Override
	public List<Book> filterByBookGenre() {
		String searchGenreQuery = "select distinct(bookGenre) from books";
		
		return jdbcTemplate.query(searchGenreQuery, new GenreRowMapper());
	}
	
	

	@Override
	public Book displayByBookId(int bookId) {
		String displayByBookIdQuery = "select * from books where bookId = ?";
		return jdbcTemplate.queryForObject(displayByBookIdQuery, new BookRowMapper(), bookId);
	}

	@Override
	public int updateBookCount(int bookQuantity, int bookId) {
		String updateBookCountQuery = "update books set bookQuantity = bookQuantity - ? where bookId = ?";
		return jdbcTemplate.update(updateBookCountQuery,bookQuantity,bookId);
	}

	@Override
	public int updateBorrowBookCount(int userId, int bookId, Date borrowedDate,Date returnDate) {
		//`borrowedId`, `userId`, `borrowedDate`, `bookFine`, `bookId`, `returnStatus`
		
		String insertBorrowBookQuery = "INSERT INTO borrowbook "
				+ " (`userId`, `borrowedDate`, `bookFine`, `bookId`, `returnStatus`,`returnDate`,`approveStatus`,`feedBackStatus`) "
				+ " VALUES "
				+ " (?,?,?,?,?,?,?,?) ";
	
		int status = 0;
		if(jdbcTemplate.update(insertBorrowBookQuery,
								userId,
								borrowedDate,
								0,
								bookId,
								0,
								returnDate,
								0,
								0
								) == 1) {
			
			String updateBorrowBookCount = "UPDATE books SET bookQuantity = bookQuantity - 1 where bookId = ?";
			status = jdbcTemplate.update(updateBorrowBookCount, bookId);
			String updateBadgeCount = "Update user set badgeCount = badgeCount + 15 where userId = ?";
			jdbcTemplate.update(updateBadgeCount,userId);
		}
		return status;
	}

	@Override
	public List<Book> filterByBookGenre(String genre) {
		
		String filterByBookGenre = "SELECT * FROM books where bookGenre = ? and bookStatus = 1 and bookQuantity > 0";
		
		return jdbcTemplate.query(filterByBookGenre, new BookRowMapper(),genre);
	}

	@Override
	public List<Book> getAllAuthor() {
		String getAllAuthorQuery = "SELECT distinct(authorName) FROM books";
		return jdbcTemplate.query(getAllAuthorQuery, new AuthorRowMapper());
	}

	@Override
	public int editBookDetails(int bookId, Book book) throws DataAccessException, SQLException {
		
		String editBookQuery= "UPDATE books SET bookName = ?, bookPrice = ?,bookGenre=?,bookPublication=?,bookEdition=?,bookQuantity=?,authorName=?, bookCover = ? WHERE bookId = ?";
		return jdbcTemplate.update(editBookQuery,
				book.getBookName(),book.getBookPrice(),book.getBookGenre(),book.getBookPublication(),
				book.getBookEdition(),book.getBookQuantity(),
				book.getAuthorName(),book.getBookCover().getBytes(1,(int)book.getBookCover().length() ),bookId);
	}

	@Override
	public int deleteBook(int bookId) {
		String deleteBook = "UPDATE books SET bookStatus = 0 where bookId = ?";
		return jdbcTemplate.update(deleteBook,bookId);
	}

	@Override
	public int addFreeBook(FreeBook freebook) {
		// TODO Auto-generated method stub
		String insertFreeBookQuery = "INSERT INTO freebook "
				+ " ( `pdfName`, `pdfAuthorName`, `pdf`, `pdfCover`) "
				+ " VALUES "
				+ " (?,?,?,?) ";
		return jdbcTemplate.update(insertFreeBookQuery,
				freebook.getPdfName(),
				freebook.getPdfAuthorName(),
				freebook.getPdf(),
				freebook.getPdfCover());
	}

	@Override
	public List<FreeBook> displayFreeBooks() {
		String displayFreeBooks = "select * from freebook";
		return jdbcTemplate.query(displayFreeBooks, new displayFreeBookRowMapper());
	}

	@Override
	public int updateReserveStatus(String reserveId) {
		
		String updateReserveStatus = "UPDATE reservebook SET reserveStatus = 1 WHERE reserveId = ?";
		return jdbcTemplate.update(updateReserveStatus,Integer.parseInt(reserveId));
	}

	@Override
	public int calculateFine(int userId) {
		String calculateFineQuery = "";
		return 0;
	}

	@Override
	public List<FeedBack> getBookFeedback(int bookId) {
		String getBookFeedbackQuery = "Select star, comment from feedback where bookId = ?";
		return jdbcTemplate.query(getBookFeedbackQuery, new FeedBackRowMapper(),bookId);
	}

}
