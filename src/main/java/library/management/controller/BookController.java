package library.management.controller;

import java.sql.Blob;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import library.management.entities.Book;
import library.management.repositories.BookDAO;
import library.management.utilities.MultipartFileToBlobPropertyEditor;


@Controller
@RequestMapping("User/book")
public class BookController {
	@Autowired
	BookDAO bookDao;
	
	@GetMapping("/admin-book-operation")
	public String bookOperation(Model model) {
		List<Book> bookList= bookDao.viewAllBooks();
		model.addAttribute("bookList",bookList);
		return "admin-book-operation";
	}
	
	@GetMapping("/handleViewBooks")
	public String handleViewBooks(@RequestParam("bookId") String bookId,Model model)
	{	
		Book book = bookDao.displayByBookId(Integer.parseInt(bookId));
		model.addAttribute("book",book);
		return "show-book-details";
	}
	
	
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
	public String filterAuthorName(Model model) {
//		List<Book> authorList = bookDao.getAllAuthor();
//		model.addAttribute("authorList", authorList);
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
	public String filterGenreName(Model model) {
		List<Book> filteredGenres = bookDao.filterByBookGenre();
		model.addAttribute("filteredGenres",filteredGenres);

		return "filter-bookgenre";
	}
	
	@GetMapping("/handle-bookGenre")
	public String handleBookGenre(
			@RequestParam("genres") String genres,
			Model model
			) {
		List<Book> filteredbook = bookDao.filterByBookGenre(genres);
		model.addAttribute("books",filteredbook);
		List<Book> filteredGenres = bookDao.filterByBookGenre();
		model.addAttribute("filteredGenres",filteredGenres);
		return "filter-bookgenre";
	}
	
	
	@GetMapping("/edit-book")
	public String openEditBook(@RequestParam("bookId") String bookId,HttpSession session,
			Model model
			) {
		
		Book book = bookDao.displayByBookId(Integer.parseInt(bookId));
		model.addAttribute("book", book);
		session.setAttribute("bookId",bookId);
		return "edit-book";
	}
	
	@PostMapping("/edit-book-details")
	public String handleUpdate(HttpSession session, @ModelAttribute Book book) {
		System.out.println(book);
		
		String bookId=(String)session.getAttribute("bookId");
		System.out.println(bookId);
		int editBook=bookDao.editBookDetails(Integer.parseInt(bookId),book);
		return "redirect:view-books";
	}
	
	
	
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Blob.class, new MultipartFileToBlobPropertyEditor());
    }
	
	
}
