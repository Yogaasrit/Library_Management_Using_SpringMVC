package library.management.repositories;

import java.sql.Date;
import java.util.List;

import library.management.entities.Book;

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
	int editBookDetails(int bookId,Book book);
	
}
