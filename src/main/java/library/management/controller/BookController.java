package library.management.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import library.management.entities.Book;
import library.management.repositories.BookDAO;


@Controller
@RequestMapping("User/book")
public class BookController {
	@Autowired
	BookDAO bookDao;
	
	@GetMapping("/view-books")
	public String viewAllBooks(
			Model model
			) {
		List<Book> bookList= bookDao.viewAllBooks();
		model.addAttribute("bookList",bookList);
		return "view-books";
	}
	
	@GetMapping("/view-author")
		public String viewAllAuthor(
				Model model) {
		List<Book> authorList = bookDao.viewAllAuthors();
		model.addAttribute("authorList",authorList);
			return "view-author";
		}
	
	@GetMapping("/view-genre")
	public String viewGenre(
			Model model
			) {
		List<Book> genreList = bookDao.viewAllGenre();
		model.addAttribute("genreList",genreList);
		return "view-genre";
	}
	
	@GetMapping("/filter-bookname")
	public String filterBookName() {
		return "filter-bookname";
	}
	
	@GetMapping("/handle-bookname")
	public String handleBookName(
			@RequestParam("bookName") String bookName,
			Model model
			) {
		List<Book> filteredBook = bookDao.filterByBookName(bookName);
		model.addAttribute("filteredBook",filteredBook);
		return "filter-bookname";
	}
	
	@GetMapping("/filter-bookauthor")
	public String filterAuthorName() {
		return "filter-bookauthor";
	}
	
	@GetMapping("/handle-authorname")
	public String handleBookAuthor(
			@RequestParam("authorName") String authorName,
			Model model
			) {
		List<Book> filteredAuthors = bookDao.filterByBookAuthor(authorName);
		model.addAttribute("filteredAuthors",filteredAuthors);
		return "filter-bookauthor";
	}
	
	@GetMapping("/filter-bookgenre")
	public String filterGenreName() {
		return "filter-bookgenre";
	}
	
	@GetMapping("/handle-bookGenre")
	public String handleBookGenre(
			@RequestParam("genreName") String genreName,
			Model model
			) {
		List<Book> filteredGenres = bookDao.filterByBookGenre(genreName);
		model.addAttribute("filteredGenres",filteredGenres);
		return "filter-bookgenre";
	}
	
	
	
}
