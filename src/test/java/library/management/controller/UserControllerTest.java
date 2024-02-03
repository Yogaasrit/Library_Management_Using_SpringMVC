package library.management.controller;




import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.isNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.ui.Model;
import org.springframework.validation.support.BindingAwareModelMap;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import library.management.entities.Book;
import library.management.entities.BookApproval;
import library.management.entities.BorrowBook;
import library.management.entities.FeedBack;
import library.management.entities.ForumHistory;
import library.management.entities.FreeBook;
import library.management.entities.LeaderBoard;
import library.management.entities.RequestBookHistory;
import library.management.entities.ReturnedBook;
import library.management.entities.User;
import library.management.entities.ViewUserDetails;
import library.management.repositories.AdminLoginDAO;
import library.management.repositories.BookDAO;
import library.management.repositories.UserDAO;
import library.management.utilities.EmailSender;

@RunWith(MockitoJUnitRunner.class)
public class UserControllerTest {

    @InjectMocks
    private UserController yourController;
    
    @Mock
    private BookDAO bookDAO;

    @Mock
    private AdminLoginDAO adminLoginDAO;
    
    @Mock
    private UserDAO userDAO;
    
    @Mock
    private Model model;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpSession session;

    @Before
    public void setUp() {
        // You can perform any setup actions here if needed.
    }
    
    @Mock
    private EmailSender emailSender;

    @Test
    public void testShowAdminDashboardInvalidCredentials() {
        // Mocking the AdminLoginDAO response for invalid credentials
        when(adminLoginDAO.validateAdmin(anyString(), anyString())).thenReturn(Collections.emptyList());

        // Create a Model instance for assertions
        Model model = new BindingAwareModelMap();

        // Perform the controller method call
        String result = yourController.showAdminDashboard("invalidEmail", "invalidPassword", request, model);

        // Assertions
        assertEquals("AdminLogin", result); // Check if the view name is correct
        assertEquals("Invalid login credentials", model.getAttribute("message"));

        // Verify that the AdminLoginDAO methods were called
        verify(adminLoginDAO).validateAdmin("invalidEmail", "invalidPassword");

        // Resetting mocks (especially important if this test class is reused for multiple test methods)
        reset(adminLoginDAO, request, session);
    }
    
    @Test
    public void testHandleViewUser() {
        // Mocking the behavior of userDAO
        List<ViewUserDetails> mockUserList = Arrays.asList(new ViewUserDetails(), new ViewUserDetails());
        when(userDAO.viewUser()).thenReturn(mockUserList);

        // Call the controller method
        String result = yourController.handleViewUser(model);

        // Verify that the expected methods were called
        verify(userDAO, times(1)).viewUser();
        verify(model, times(1)).addAttribute(eq("userList"), eq(mockUserList));

        // Verify the result
        assertEquals("ViewUser", result);
    }
    
    
    @Test
    public void testViewAllBooks() {
        // Mocking the behavior of bookDAO
        List<Book> mockBookList = Arrays.asList(new Book(), new Book());
        when(bookDAO.viewAllBooks()).thenReturn(mockBookList);

        List<Book> mockFilteredGenres = Arrays.asList(new Book(), new Book());
        when(bookDAO.filterByBookGenre()).thenReturn(mockFilteredGenres);

        // Call the controller method
        String result = yourController.viewAllBooks(model);

        // Verify that the expected methods were called
        verify(bookDAO, times(1)).viewAllBooks();
        verify(bookDAO, times(1)).filterByBookGenre();
        verify(model, times(1)).addAttribute(eq("bookList"), eq(mockBookList));
        verify(model, times(1)).addAttribute(eq("filteredGenres"), eq(mockFilteredGenres));

        // Verify the result
        assertEquals("view-books", result);
    }
    
    
    @Test
    public void testOpenDeletebook() {
        // Call the controller method
        String result = yourController.openDeletebook();

        // Verify the result
        assertEquals("delete-book", result);
    }
    
    
    @Test
    public void testOpenViewParticularUser() {
        // Call the controller method
        String result = yourController.openviewparticularuser();

        // Verify the result
        assertEquals("view-particular-user", result);
    }
    
    @Test
    public void testApproveBooks() {
        // Mocking the behavior of userDAO
        List<BookApproval> mockApprovalList = Arrays.asList(new BookApproval(), new BookApproval());
        when(userDAO.viewApprovalList()).thenReturn(mockApprovalList);

        // Call the controller method
        String result = yourController.approveBooks(model);

        // Verify that the expected methods were called
        verify(userDAO, times(1)).viewApprovalList();
        verify(model, times(1)).addAttribute(eq("list"), eq(mockApprovalList));

        // Verify the result
        assertEquals("approve-return-books", result);
    }
    
    @Test
    public void testViewUserRequestedBook() {
        // Mocking the behavior of userDAO
        List<RequestBookHistory> mockRequestHistoryList = Arrays.asList(new RequestBookHistory(), new RequestBookHistory());
        when(userDAO.viewUserRequestedBook()).thenReturn(mockRequestHistoryList);

        // Call the controller method
        String result = yourController.viewUserRequestedBook(model);

        // Verify that the expected methods were called
        verify(userDAO, times(1)).viewUserRequestedBook();
        verify(model, times(1)).addAttribute(eq("list"), eq(mockRequestHistoryList));

        // Verify the result
        assertEquals("view-user-requested-book", result);
    }
    
    @Test
    public void testAddUpcomingEvents() {
        // Call the controller method
        String result = yourController.addUpcomingEvents();

        // Verify the result
        assertEquals("addUpcomingEvents", result);
    }
    
    @Test
    public void testWriteFeedbackPage() {
        // Mocking the behavior of HttpSession
        when(session.getAttribute("User")).thenReturn(new User()); // assuming User is your user class

        // Mocking the behavior of userDAO
        List<ReturnedBook> mockReturnedBookList = Arrays.asList(new ReturnedBook(), new ReturnedBook());
        when(userDAO.getReturnedBookDetails(anyInt())).thenReturn(mockReturnedBookList);

        // Call the controller method
        String result = yourController.writeFeedbackPage(session, model);

        // Verify that the expected methods were called
        verify(session, times(1)).getAttribute("User");
        verify(userDAO, times(1)).getReturnedBookDetails(anyInt());
        verify(model, times(1)).addAttribute(eq("returnedBook"), eq(mockReturnedBookList));

        // Verify the result
        assertEquals("write-feedback", result);
    }
    
    @Test
    public void testHandleReject() {
        // Call the controller method
        String borrowedId = "123";
        String userEmailId = "user@example.com";
        String bookName = "Sample Book";
        String result = yourController.handleReject(borrowedId, userEmailId, bookName, model);

        // Verify that the expected methods were called with the correct parameters
        verify(model, times(1)).addAttribute("bookName", bookName);
        verify(model, times(1)).addAttribute("borrowedId", borrowedId);
        verify(model, times(1)).addAttribute("userEmailId", userEmailId);

        // Verify the result
        assertEquals("handle-reject", result);
    }
    
    @Test
    public void testShowLeaderboard() {
        // Mocking the behavior of HttpSession
        when(session.getAttribute("User")).thenReturn(new User()); // assuming User is your user class

        // Mocking the behavior of userDAO
        List<LeaderBoard> mockLeaderboardList = Arrays.asList(new LeaderBoard(), new LeaderBoard());
        when(userDAO.leaderboard()).thenReturn(mockLeaderboardList);

        // Mocking the behavior of userDAO for badge count
        when(userDAO.getBadgeCount(anyInt())).thenReturn(5); // or the expected badge count

        // Call the controller method
        String result = yourController.showLeaderboard(model, session);

        // Verify that the expected methods were called
        verify(session, times(1)).getAttribute("User");
        verify(userDAO, times(1)).leaderboard();
        verify(userDAO, times(1)).getBadgeCount(anyInt());
        verify(model, times(1)).addAttribute(eq("list"), eq(mockLeaderboardList));
        verify(model, times(1)).addAttribute(eq("badgeCount"), eq(5)); // Adjust to the expected badge count

        // Verify the result
        assertEquals("leaderboard", result);
    }
    
    @Test
    public void testOpenForumPage() {
        // Mocking the behavior of userDAO
        List<ForumHistory> mockForumHistoryList = Arrays.asList(new ForumHistory(), new ForumHistory());
        when(userDAO.getForumHistory()).thenReturn(mockForumHistoryList);

        // Call the controller method
        String result = yourController.openForumPage(model);

        // Verify that the expected methods were called
        verify(userDAO, times(1)).getForumHistory();
        verify(model, times(1)).addAttribute(eq("list"), eq(mockForumHistoryList));

        // Verify the result
        assertEquals("forum", result);
    }
    
    @Test
    public void testHandleRequestPlaceOrder() {
        // Mocking the behavior of bookDAO
        Book mockBook = new Book(); // Assuming Book is your book class
        when(bookDAO.displayByBookId(anyInt())).thenReturn(mockBook);

        // Mocking the behavior of userDAO
        when(userDAO.updateRequestStatus(anyInt())).thenReturn(1); // Adjust to the expected status

        // Call the controller method
        String result = yourController.handleRequestPlaceOrder("1", "2", model);

        // Verify that the expected methods were called
        verify(bookDAO, times(1)).displayByBookId(anyInt());
        verify(userDAO, times(1)).updateRequestStatus(anyInt());
        verify(model, times(1)).addAttribute(eq("book"), eq(mockBook));

        // Verify the result
        assertEquals("book-details", result);
    }
    
    @Test
    public void testUpdatePaidFine() {
        // Mocking the behavior of HttpSession
        User mockUser = new User(); // Assuming User is your user class
        when(session.getAttribute("User")).thenReturn(mockUser);

        // Mocking the behavior of userDAO
        when(userDAO.updatePaidFine(anyInt())).thenReturn(1); // Adjust to the expected status

        // Call the controller method
        String result = yourController.UpdatePaidFine("1", session, model);

        // Verify that the expected methods were called
        verify(session, times(1)).getAttribute("User");
        verify(userDAO, times(1)).updatePaidFine(anyInt());

        // Verify the result
        assertEquals("view-borrowed-books", result);
    }
    @Test
    public void testShowBorrowedBooks() {
        // Mocking the behavior of HttpSession
        User mockUser = new User(); // Assuming User is your user class
        when(session.getAttribute("User")).thenReturn(mockUser);

        // Mocking the behavior of userDAO
        List<BorrowBook> mockBorrowedBooks = // create mock data
                Arrays.asList(new BorrowBook(), new BorrowBook());
        when(userDAO.viewBorrowedBooks(anyInt())).thenReturn(mockBorrowedBooks);

        // Call the controller method
        String result = yourController.showBorrowedBooks(session, model);

        // Verify that the expected methods were called
        verify(session, times(1)).getAttribute("User");
        verify(userDAO, times(1)).viewBorrowedBooks(anyInt());
        verify(model, times(1)).addAttribute(eq("borrowedBooks"), eq(mockBorrowedBooks));

        // Verify the result
        assertEquals("view-borrowed-books", result);
    }
    
    @Test
    public void testProceedToPayment() {
        // Call the controller method
        String grandTotal = "100.00"; // Adjust to the expected value
        String result = yourController.proceedToPayment(grandTotal, model);

        // Verify that the expected methods were called
        verify(model, times(1)).addAttribute(eq("grandTotal"), eq(grandTotal));

        // Verify the result
        assertEquals("payment-page", result);
    }
    
    @Test
    public void testRemoveFromCart() {
        // Mocking the behavior of userDAO
        when(userDAO.updateBookCount(anyString(), anyString())).thenReturn(1); // Adjust to the expected status

        // Call the controller method
        String bookId = "123"; // Replace with your actual bookId
        String quantity = "2"; // Replace with your actual quantity
        yourController.removeFromcart(bookId, quantity);

        // Verify that the expected method was called with the correct parameters
        verify(userDAO, times(1)).updateBookCount(eq(bookId), eq(quantity));
    }
    
    @Test
    public void testShowUserRegisterForm() {
        // Create an instance of the UserController
        UserController userController = new UserController();

        // Mock the Model
        Model model = mock(Model.class);

        // Call the controller method
        String result = userController.showUserRegisterForm();

        // Verify that the expected view name was returned
        assertEquals("UserRegister", result);       
    }
    
    @Test
    public void testShowUserLoginPage() {
        // Create an instance of the UserController
        UserController userController = new UserController();

        // Call the controller method
        String result = userController.showUserLoginPage();

        // Verify that the expected view name was returned
        assertEquals("UserLogin", result);
    }
    
    @Test
    public void testViewAdminProfile() {
        // Mock the behavior of adminLoginDAO
        when(adminLoginDAO.getPassword()).thenReturn("adminPassword123"); // Adjust to the expected password

        // Call the controller method
        String result = yourController.viewAdminProfile(model);

        // Verify that the expected methods were called
        verify(adminLoginDAO, times(1)).getPassword();
        verify(model, times(1)).addAttribute(eq("password"), eq("adminPassword123"));

        // Verify the result
        assertEquals("view-admin-profile", result);
    }
    
    @Test
    public void testShowAdminLoginPage() {
        // Arrange
        UserController userController = new UserController();
        Model model = null; // You can use a mocking framework to create a mock Model

        // Act
        String result = userController.showAdminLoginPage();

        // Assert
        assertEquals("AdminLogin", result);
    }
    
}

