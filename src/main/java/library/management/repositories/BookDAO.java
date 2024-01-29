package library.management.repositories;

import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;

import library.management.entities.Book;
import library.management.entities.FeedBack;
import library.management.entities.FreeBook;

public interface BookDAO {
	List<Book> viewAllBooks();
	List<Book> viewAllAuthors();
	List<Book> viewAllGenre();
	List<Book> filterByBookName(String bookName);
	List<Book> filterByBookAuthor(String authorName);
	List<Book> filterByBookGenre();
	List<Book> filterByBookGenre(String genre);
	Book displayByBookId(int bookId);
	int updateBookCount(int bookCount,int bookId);
	int updateBorrowBookCount(int userId,int bookId,Date borrowedDate,Date returnDate);
	List<Book> getAllAuthor();
	int editBookDetails(int bookId,Book book) throws DataAccessException, SQLException;
	int deleteBook(int bookId);
	int addFreeBook(FreeBook freebook);
	List<FreeBook> displayFreeBooks();
	int updateReserveStatus(String reserveId);
	int calculateFine(int userId);
	List<FeedBack> getBookFeedback(int bookId);
	
}
