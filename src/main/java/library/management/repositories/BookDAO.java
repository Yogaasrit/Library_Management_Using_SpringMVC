package library.management.repositories;

import java.util.List;
import library.management.entities.Book;

public interface BookDAO {
	List<Book> viewAllBooks();
	List<Book> viewAllAuthors();
	List<Book> viewAllGenre();
	List<Book> filterByBookName(String bookName);
	List<Book> filterByBookAuthor(String authorName);
	List<Book> filterByBookGenre(String bookGenre);
	Book displayByBookId(int bookId);
	int updateBookCount(int bookCount);
}
