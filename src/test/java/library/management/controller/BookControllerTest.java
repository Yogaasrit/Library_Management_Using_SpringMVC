package library.management.controller;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

import library.management.entities.Book;
import library.management.entities.FeedBack;
import library.management.repositories.BookDAO;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpSession;

import static org.mockito.Mockito.*;

public class BookControllerTest {

    @InjectMocks
    private BookController bookController;

    @Mock
    private BookDAO bookDao;

    @Mock
    private Model model;

    @Mock
    private HttpSession session;

    @Test
    public void testBookOperation() {
        // Arrange
        MockitoAnnotations.initMocks(this);

        Book book1 = new Book();
        Book book2 = new Book();
        List<Book> mockBookList = Arrays.asList(book1, book2);
        when(bookDao.viewAllBooks()).thenReturn(mockBookList);
        List<Book> mockFilteredGenres = Arrays.asList(book1, book2);  // Replace this with your actual filtered genres
        when(bookDao.filterByBookGenre()).thenReturn(mockFilteredGenres);

        // Act
        String result = bookController.bookOperation(model);

        // Assert
        assertEquals("admin-book-operation", result);  // Assuming it redirects to admin-book-operation

        // Verify that the expected methods were called
        verify(bookDao, times(1)).viewAllBooks();
        verify(bookDao, times(1)).filterByBookGenre();
        verify(model, times(1)).addAttribute(eq("bookList"), eq(mockBookList));
        verify(model, times(1)).addAttribute(eq("filteredGenres"), eq(mockFilteredGenres));
    }
    
    @Test
    public void testOpenDeleteBook() {
        // Arrange
        MockitoAnnotations.initMocks(this);

        String bookId = "1";
        int deletedResult = 1;  // Assuming the deletion is successful
        when(bookDao.deleteBook(Integer.parseInt(bookId))).thenReturn(deletedResult);

        Book book1 = new Book();
        Book book2 = new Book();
        List<Book> mockBookList = Arrays.asList(book1, book2);
        when(bookDao.viewAllBooks()).thenReturn(mockBookList);
        List<Book> mockFilteredGenres = Arrays.asList(book1, book2);  // Replace this with your actual filtered genres
        when(bookDao.filterByBookGenre()).thenReturn(mockFilteredGenres);

        // Act
        String result = bookController.openDeleteBook(bookId, model);

        // Assert
        assertEquals("admin-book-operation", result);  // Assuming it redirects to admin-book-operation

        // Verify that the expected methods were called
        verify(bookDao, times(1)).deleteBook(Integer.parseInt(bookId));
        verify(bookDao, times(1)).viewAllBooks();
        verify(bookDao, times(1)).filterByBookGenre();
        verify(model, times(1)).addAttribute(eq("bookList"), eq(mockBookList));
        verify(model, times(1)).addAttribute(eq("filteredGenres"), eq(mockFilteredGenres));
    }
    @Test
    public void testHandleViewBooks() {
        // Arrange
        MockitoAnnotations.initMocks(this);

        String bookId = "1";
        Book mockBook = new Book();
        when(bookDao.displayByBookId(Integer.parseInt(bookId))).thenReturn(mockBook);

        FeedBack feedback1 = new FeedBack("User1", "Great book!");
        FeedBack feedback2 = new FeedBack("User2", "Awesome read!");
        List<FeedBack> mockFeedbackList = Arrays.asList(feedback1, feedback2);
        when(bookDao.getBookFeedback(Integer.parseInt(bookId))).thenReturn(mockFeedbackList);

        // Act
        String result = bookController.handleViewBooks(bookId, model);

        // Assert
        assertEquals("show-book-details", result);  // Assuming it redirects to show-book-details

        // Verify that the expected methods were called
        verify(bookDao, times(1)).displayByBookId(Integer.parseInt(bookId));
        verify(bookDao, times(1)).getBookFeedback(Integer.parseInt(bookId));
        verify(model, times(1)).addAttribute(eq("list"), eq(mockFeedbackList));
        verify(model, times(1)).addAttribute(eq("book"), eq(mockBook));
    }
    
    @Test
    public void testOpenEditBook() {
        // Arrange
        MockitoAnnotations.initMocks(this);

        String bookId = "1";
        Book mockBook = new Book();
        when(bookDao.displayByBookId(Integer.parseInt(bookId))).thenReturn(mockBook);

        // Act
        String result = bookController.openEditBook(bookId, session, model);

        // Assert
        assertEquals("edit-book", result);  // Assuming it redirects to edit-book

        // Verify that the expected methods were called
        verify(bookDao, times(1)).displayByBookId(Integer.parseInt(bookId));
        verify(model, times(1)).addAttribute(eq("book"), eq(mockBook));
        verify(model, times(1)).addAttribute(eq("bookCover"), eq(mockBook.getBookCover()));
        verify(session, times(1)).setAttribute(eq("bookId"), eq(bookId));
    }
    
    @Test
    public void testHandleUpdate() throws DataAccessException, NumberFormatException, SQLException {
        // Arrange
        MockitoAnnotations.initMocks(this);

        String bookId = "1";
        Book mockBook = new Book();

        // Mocking the session attribute
        when(session.getAttribute("bookId")).thenReturn(bookId);

        // Mocking the DAO method
        try {
            when(bookDao.editBookDetails(Integer.parseInt(bookId), mockBook)).thenReturn(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Act
        String result = bookController.handleUpdate(session, mockBook);

        // Assert
        assertEquals("redirect:admin-book-operation", result);  // Assuming it redirects to admin-book-operation

        // Verify that the expected methods were called
        verify(session, times(1)).getAttribute("bookId");
        verify(bookDao, times(1)).editBookDetails(Integer.parseInt(bookId), mockBook);
    }
    @Test
    public void testHandleAdminViewBookDetails() {
        // Arrange
        MockitoAnnotations.initMocks(this);

        String bookId = "1";
        Book mockBook = new Book();
        List<FeedBack> mockFeedbackList = Arrays.asList(new FeedBack(), new FeedBack());

        // Mocking the DAO methods
        when(bookDao.displayByBookId(Integer.parseInt(bookId))).thenReturn(mockBook);
        when(bookDao.getBookFeedback(Integer.parseInt(bookId))).thenReturn(mockFeedbackList);

        // Act
        String result = bookController.handleAdminViewBookDetails(bookId, model);

        // Assert
        assertEquals("handle-admin-view-book-details", result);  // Assuming it returns "handle-admin-view-book-details"

        // Verify that the expected methods were called
        verify(bookDao, times(1)).displayByBookId(Integer.parseInt(bookId));
        verify(bookDao, times(1)).getBookFeedback(Integer.parseInt(bookId));
        verify(model, times(1)).addAttribute("book", mockBook);
        verify(model, times(1)).addAttribute("list", mockFeedbackList);
    }
}
