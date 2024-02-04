package library.management.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import library.management.entities.Admin;
import library.management.entities.Book;
import library.management.entities.BookApproval;
import library.management.entities.BorrowBook;
import library.management.entities.FeedBack;
import library.management.entities.FineDetails;
import library.management.entities.ForumHistory;
import library.management.entities.FreeBook;
import library.management.entities.LeaderBoard;
import library.management.entities.PurchasedBook;
import library.management.entities.RequestBook;
import library.management.entities.RequestBookHistory;
import library.management.entities.ReserveBook;
import library.management.entities.ReturnBookRemainder;
import library.management.entities.ReturnedBook;
import library.management.entities.User;
import library.management.entities.ViewUserDetails;
import library.management.repositories.AdminLoginDAO;
import library.management.repositories.BookDAO;
import library.management.repositories.UserDAO;
import library.management.utilities.EmailSender;
import library.management.utilities.MultipartFileToBlobPropertyEditor;


@Controller
@RequestMapping("User")

public class UserController {
	@Autowired
	UserDAO userDAO;

	@Autowired
	BookDAO bookDAO;

	@Autowired
	AdminLoginDAO adminLoginDAO;

	@GetMapping("/UserDashboard")
	public String showUserDashboard() {
		return "UserDashboard";
	}

	@GetMapping("/about-us")
	public String showAboutUs() {
		return "about-us";
	}

	@GetMapping("/Gallery")
	public String showGallery() {
		return "Gallery";
	}

	@GetMapping("/contact-us")
	public String showContactUs() {
		return "contact-us";
	}

	@GetMapping("/AdminLogin")
	public String showAdminLoginPage() {
		return "AdminLogin";
	}

	@GetMapping("/UserLogin")
	public String showUserLoginPage() {
		return "UserLogin";
	}

	@GetMapping("/UserRegister")
	public String showUserRegisterForm() {
		return "UserRegister";
	}

	@PostMapping("/addFreeBook")
	public String addFreeBook(@RequestParam("pdfName") String pdfName,
			@RequestParam("pdfAuthorName") String pdfAuthorName, @RequestParam("pdf") MultipartFile pdf,
			@RequestParam("pdfCover") MultipartFile pdfCover, Model model) {
		byte[] pdfCoverArr;
		Blob pdfCoverBlob = null;
		try {
			pdfCoverArr = pdfCover.getBytes();
			pdfCoverBlob = new SerialBlob(pdfCoverArr);
		} catch (IOException | SQLException e) {
			e.printStackTrace();
		}
		byte[] pdfArr;
		Blob pdfBlob = null;
		try {
			pdfArr = pdfCover.getBytes();
			pdfBlob = new SerialBlob(pdfArr);
		} catch (IOException | SQLException e) {
			e.printStackTrace();
		}
		FreeBook freebook;
		freebook = new FreeBook(pdfName, pdfAuthorName, pdfBlob, pdfCoverBlob);
		int status = bookDAO.addFreeBook(freebook);
		if (status == 1) {
			model.addAttribute("message", "Free Book Added Successfully!");
		} else {
			model.addAttribute("message", "No Free Book Added, Try again correctly!");
		}

		return "add-freebook";
	}

	@GetMapping("/admin-view-profile")
	public String viewAdminProfile(Model model) {
		String password = adminLoginDAO.getPassword();
		model.addAttribute("password", password);
		return "view-admin-profile";
	}

	@PostMapping("/admin-changePassword")
	public String openDashboard(Model model, @RequestParam("confirmPassword") String confirmPassword) {
		int status = adminLoginDAO.updateAdminPassWord(confirmPassword);
		return "AdminLogin";
	}

	@PostMapping("/handle-register")
	public String showUserRegisterPage(@RequestParam("emailId") String emailId,
			@RequestParam("userName") String userName, @RequestParam("phoneNo") String phoneNo,
			@RequestParam("dob") Date dob, @RequestParam("address") String address,
			@RequestParam("gender") String gender, @RequestParam("password") String password, Model model) {
		int result = userDAO.userRegister(emailId, userName, phoneNo, dob, address, gender, password);
		if (result == 1) {
			return "UserLogin";
		} else {
			model.addAttribute("message", "You are already registered user");
			return "UserRegister";
		}
	}

	@GetMapping("/AdminDashboard")
	public String adminHomePage(Model model, HttpSession session) {
		int totalUserCount = adminLoginDAO.totalUser();
		int totalBookCount = adminLoginDAO.totalBooks();
		int totalBooksBorrowed = adminLoginDAO.totalBooksBorrowed();
		int totalPendingApproval = adminLoginDAO.totalBooksApproval();
		int totalBooksBought = adminLoginDAO.totalBooksBought();
		int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
		int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
		int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();

		model.addAttribute("totalUserCount", totalUserCount);
		model.addAttribute("totalBookCount", totalBookCount);
		model.addAttribute("totalBooksBorrowed", totalBooksBorrowed);
		model.addAttribute("totalBooksBought", totalBooksBought);
		model.addAttribute("totalPendingApproval", totalPendingApproval);
		model.addAttribute("totalBooksBorrowedToday", totalBooksBorrowedToday);
		model.addAttribute("totalBooksBoughtToday", totalBooksBoughtToday);
		model.addAttribute("totalUserOverDueCount", totalUserOverDueCount);
		
		model.addAttribute("adminSession", session.getAttribute("adminSession"));
	
		return "AdminDashboard";
	}
	
	@PostMapping("/validate-admin")
	public String showAdminDashboard(@RequestParam("adminEmailId") String adminEmailId,
			@RequestParam("adminPassword") String adminPassword, HttpServletRequest request, Model model) {
		// Creating admin session
		HttpSession session = request.getSession();
		Admin admin = new Admin();
		// Checking if list is empty,
		// if empty, then no record is fetched,
		// then, admin details is incorrect.
		if (adminLoginDAO.validateAdmin(adminEmailId, adminPassword).isEmpty()) {
			model.addAttribute("message", "Invalid login credentials");
			return "AdminLogin";
		}
		// If not null, validated,
		// Dashboard page is shown to admin
		else {

			// add more data for admin dashboard
			int totalUserCount = adminLoginDAO.totalUser();
			int totalBookCount = adminLoginDAO.totalBooks();
			int totalBooksBorrowed = adminLoginDAO.totalBooksBorrowed();
			int totalPendingApproval = adminLoginDAO.totalBooksApproval();
			int totalBooksBought = adminLoginDAO.totalBooksBought();
			int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
			int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
			int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();

			model.addAttribute("totalUserCount", totalUserCount);
			model.addAttribute("totalBookCount", totalBookCount);
			model.addAttribute("totalBooksBorrowed", totalBooksBorrowed);
			model.addAttribute("totalBooksBought", totalBooksBought);
			model.addAttribute("totalPendingApproval", totalPendingApproval);
			model.addAttribute("totalBooksBorrowedToday", totalBooksBorrowedToday);
			model.addAttribute("totalBooksBoughtToday", totalBooksBoughtToday);
			model.addAttribute("totalUserOverDueCount", totalUserOverDueCount);

			admin = adminLoginDAO.validateAdmin(adminEmailId, adminPassword).get(0);
			session.setAttribute("adminSession", admin);
			return "AdminDashboard";
		}
	}

	@PostMapping("/validate-user")
	public String showUserDashboard(@RequestParam("emailId") String userEmailId,
			@RequestParam("passWord") String userPassword, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		User user;
		if (userDAO.userLogin(userEmailId, userPassword).isEmpty()) {
			model.addAttribute("message", "Invalid Login credentials");
			return "UserLogin";
		} else {
			user = userDAO.userLogin(userEmailId, userPassword).get(0);
			session.setAttribute("User", user);
			return "UserDashboard";
		}
	}

	@GetMapping("/handle-view-user")
	public String handleViewUser(Model model) {
		List<ViewUserDetails> list = userDAO.viewUser();
		model.addAttribute("userList", list);
		return "ViewUser";
	}

	@GetMapping("/forget-password")
	public String openPage() {
		return "forget-password";
	}

	@PostMapping("/verify-email")
	public String verifyEmail(@RequestParam("email") String email, HttpServletRequest request, Model model) {
		if (userDAO.isEmailInDatabase(email)) {
			String generatedOTP = generateOTP(6);
			HttpSession session = request.getSession();
			session.setAttribute("otp", generatedOTP);
			User user = userDAO.getUser(email);
			session.setAttribute("user-update", user);
			session.setAttribute("emailId", email);
			sendOTPEmail(email, generatedOTP);
			return "otp-page";
		} else {
			model.addAttribute("message", "User Email not found! check email");
			return "forget-password";
		}
	}

	// Method to generate OTP
	private String generateOTP(int length) {
		// Range of characters to generate the OTP from
		String numbers = "0123456789";

		StringBuilder otp = new StringBuilder();
		for (int i = 0; i < length; i++) {
			int index = (int) (Math.random() * numbers.length());
			otp.append(numbers.charAt(index));
		}

		return otp.toString();
	}

	// Method to send OTP via email
	private void sendOTPEmail(String email, String otp) {

		EmailSender emailSender = new EmailSender();
		emailSender.sendEmail(email, otp);

	}

	@PostMapping("verify-otp")
	public String openOTPPage(@RequestParam("otp") String otp, HttpSession session, Model model) {
		String emailId = (String) session.getAttribute("emailId");
		session.setAttribute("emailId", emailId);
//		System.out.println("In otp page"+emailId);
		String sentOTP = (String) session.getAttribute("otp");
		if (sentOTP.equals(otp)) {
			User user = (User) session.getAttribute("user-update");
			model.addAttribute("user", user);
			return "reset-password";
		}
		model.addAttribute("message", "Incorrect otp");
		return "otp-page";
	}

	@GetMapping("/reset-password")
	public String updatePassword(@RequestParam("confirmPassword") String userPassword, HttpSession session) {
		String emailId = (String) session.getAttribute("emailId");
		System.out.println("Reset page" + emailId);
		int status = userDAO.updatePassword(userPassword, emailId);
		return "UserLogin";
	}

	@GetMapping("/resend-otp")
	public String resendOTP(HttpSession session) {
		String otp = generateOTP(6);
		String emailId = (String) session.getAttribute("emailId");
		sendOTPEmail(emailId, otp);
		return "otp-page";
	}

	@GetMapping("/add-books")
	public String addBooks() {
		return "add-books";
	}

	@PostMapping("/handle-add-books")
	public String handleAddBooks(@RequestParam("bookName") String bookName, @RequestParam("bookPrice") String bookPrice,
			@RequestParam("bookGenre") String bookGenre, @RequestParam("bookPublication") String bookPublication,
			@RequestParam("bookPublishDate") String bookPublishDate, @RequestParam("bookEdition") String bookEdition,
			@RequestParam("bookQuantity") String bookQuantity, @RequestParam("authorName") String authorName,
			@RequestParam("bookCover") MultipartFile bookCover, Model model, HttpSession session) {

		byte[] bookCoverArr;
		Blob bookCoverBlob = null;
		try {
			bookCoverArr = bookCover.getBytes();
			bookCoverBlob = new SerialBlob(bookCoverArr);
		} catch (IOException | SQLException e) {
			e.printStackTrace();
		}

		Book book;

		book = new Book(bookName, Integer.parseInt(bookPrice), bookGenre, bookPublication,
				Integer.parseInt(bookEdition), Integer.parseInt(bookQuantity), Date.valueOf(bookPublishDate),
				authorName, true, bookCoverBlob);
		int status = userDAO.addBooks(book);
		model.addAttribute("status", status);

		Admin admin = new Admin();

		int totalUserCount = adminLoginDAO.totalUser();
		int totalBookCount = adminLoginDAO.totalBooks();
		int totalBooksBorrowed = adminLoginDAO.totalBooksBorrowed();
		int totalPendingApproval = adminLoginDAO.totalBooksApproval();
		int totalBooksBought = adminLoginDAO.totalBooksBought();
		int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
		int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
		int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();

		model.addAttribute("totalUserCount", totalUserCount);
		model.addAttribute("totalBookCount", totalBookCount);
		model.addAttribute("totalBooksBorrowed", totalBooksBorrowed);
		model.addAttribute("totalBooksBought", totalBooksBought);
		model.addAttribute("totalPendingApproval", totalPendingApproval);
		model.addAttribute("totalBooksBorrowedToday", totalBooksBorrowedToday);
		model.addAttribute("totalBooksBoughtToday", totalBooksBoughtToday);
		model.addAttribute("totalUserOverDueCount", totalUserOverDueCount);

		admin = (Admin) session.getAttribute("adminSession");
		adminLoginDAO.validateAdmin(admin.getAdminEmailId(), admin.getAdminPassword()).get(0);
		session.setAttribute("adminSession", admin);

		return "AdminDashboard";
	}

	@GetMapping("/place-order")
	public String placeOrder(Model model) {
		List<Book> books = bookDAO.viewAllBooks();
		model.addAttribute("books", books);
		return "place-order";
	}

	@GetMapping("/handlePlaceOrder")
	public String handlePlaceOrder(@RequestParam("bookId") String bookId, Model model) {
		System.out.println("Running");
		
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		model.addAttribute("book", book);
		return "book-details";
	}

	@GetMapping("/add-freebook")
	public String addFreeBooks() {
		return "add-freebook";
	}

	@GetMapping("/free-books")
	public String showFreeBooks(Model model) {
	    List<FreeBook> freeBooks = bookDAO.displayFreeBooks();
	    System.out.println(freeBooks.size());
	    model.addAttribute("freeBooks", freeBooks);
	    return "free-books";
	}
	
	@GetMapping("/free-books-pdf")
	public ResponseEntity<byte[]> showFreeBooks(@RequestParam("id") int id) {
	    List<FreeBook> freeBooks = bookDAO.displayFreeBooks();

	    // Assuming the first free book contains the PDF content
	    byte[] pdfContent = null;
		try {
			pdfContent = freeBooks.isEmpty() ? new byte[0] : freeBooks.get(id-1).getPdf().getBytes(1,
					(int)freeBooks.get(id-1).getPdf().length());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_PDF);
	    headers.setContentDisposition(ContentDisposition.builder("inline").filename("book.pdf").build());

	    return new ResponseEntity<>(pdfContent, headers, HttpStatus.OK);
	}
	
	
	@GetMapping("/add-to-cart")
	public String addToCart(@RequestParam("bookId") String bookId,
			@RequestParam("count") String bookCount, Model model,
			HttpSession session) {

		System.out.println("Adding to cart: " + bookId + "-" + bookCount);

     // Get the current user from the session
		User user = (User) session.getAttribute("User");

     // Get the user's cart from the session
		Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");

     // If the cart doesn't exist, create a new one
		if (cart == null) {
			cart = new HashMap<>();
		}

     // Update the cart with the selected book and quantity
		if (cart.containsKey(bookId)) {
     // Book already exists in the cart, add the new count to the existing count
			int existingCount = cart.get(bookId);
			int newCount = existingCount + Integer.parseInt(bookCount);
			cart.put(bookId, newCount);
		} else {
      // Book doesn't exist in the cart, add it with the provided count
			cart.put(bookId, Integer.parseInt(bookCount));
		}

      // Update the session with the modified cart
		session.setAttribute("cart", cart);
		System.out.println(cart);
		
		int countStatus = userDAO.updateBookQuantityAddToCart(bookId,bookCount);
		
     // Redirect back to the view books page or wherever you want
		List<Book> bookList = bookDAO.viewAllBooks();
		System.out.println(bookList);
		model.addAttribute("bookList", bookList);
		List<Book> filteredGenres = bookDAO.filterByBookGenre();
		model.addAttribute("filteredGenres", filteredGenres);
		
		return "view-books";
	}
	
	@GetMapping("/view-books")
	public String viewAllBooks(
			Model model
			) {
		List<Book> bookList= bookDAO.viewAllBooks();
		model.addAttribute("bookList",bookList);
		List<Book> filteredGenres = bookDAO.filterByBookGenre();
		model.addAttribute("filteredGenres",filteredGenres);

		return "view-books";
	}
	
	@GetMapping("/handleViewBooks")
	public String handleViewBooks(@RequestParam("bookId") String bookId,Model model)
	{	
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		List<FeedBack> list = bookDAO.getBookFeedback(Integer.parseInt(bookId));
		System.out.println("List: "+list);
		model.addAttribute("book",book);
		model.addAttribute("list",list);
		return "show-book-details";
	}
	
	@GetMapping("/your-cart")
	public String openCart(HttpSession session, Model model) {
		
		Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
		List<Book> book = bookDAO.viewAllBooks();
		model.addAttribute("cart", cart);
		model.addAttribute("books", book);
		return "add-to-cart";
	}
	
	
	
	@PostMapping("/confirm-order")
	public String confirmOrder(@RequestParam("cartData") String cartData,
			Model model, HttpSession session) {
		 Map<String, Integer> updatedCart = null;
	    // Convert the JSON string to a Java Map
	    ObjectMapper objectMapper = new ObjectMapper();
	    try {
	        updatedCart = objectMapper.readValue(cartData, new TypeReference<Map<String, Integer>>() {});
	        
	        // Now you have the updated cart map, you can use it as needed
	        System.out.println("Updated Cart: " + updatedCart);

	        // Do further processing, such as confirming the order
	        // ...

	    } catch (IOException e) {
	        e.printStackTrace();
	        // Handle JSON parsing exception
	    }
	    
		Map<String, Integer> cart = (Map<String, Integer>) session.getAttribute("cart");
		cart = null;
		session.setAttribute("cart", cart);
	    
	    // Redirect or return the appropriate view
	    List<Book> books = bookDAO.viewAllBooks();
	    model.addAttribute("books",books);
	    model.addAttribute("updatedCart",updatedCart);
	    session.setAttribute("updatedCart", updatedCart);
	    return "billing-details";
	}
	
	
	@PostMapping("/view-your-books")
	public String viewYourBooks(HttpSession session,Model model) {
		 Map<String, Integer> updatedCart = ( Map<String, Integer>) session.getAttribute("updatedCart");
		 User user = (User)session.getAttribute("User");
		  
		 for(Entry<String, Integer> entry : updatedCart.entrySet()) {
			 int status = userDAO.placeOrder(user.getUserId(), Integer.parseInt(entry.getKey()),
					 entry.getValue(), Date.valueOf(LocalDate.now()));
		 }
	 
		  List<PurchasedBook> bookList = userDAO.viewPurchasedBooks(user.getUserId());
		  model.addAttribute("bookList", bookList);
		  return "view-your-books";
	}
	
	

	@PostMapping("/removeFromCart")
	public void removeFromcart(@RequestParam("bookId") String bookId,
			@RequestParam("quantity") String quantity) {
		int status = userDAO.updateBookCount(bookId,quantity);
		
	}
	
	@GetMapping("payment-page")
	public String proceedToPayment(@RequestParam("grandTotal")String grandTotal, Model model ) {
		model.addAttribute("grandTotal",grandTotal);
		return "payment-page";
	}
	@GetMapping("/view-your-books")
	public String openOrder(Model model, HttpSession session) {
		User user = (User) session.getAttribute("User");
		List<PurchasedBook> bookList = userDAO.viewPurchasedBooks(user.getUserId());
		model.addAttribute("bookList", bookList);

		return "view-your-books";
	}

//	@GetMapping("/handleViewBooks")
//	public String handleViewBooks(@RequestParam("bookId") String bookId) {
//		return "book-details";
//	}

	@GetMapping("/handleBorrowBook")
	public String handleBorrowBooks(@RequestParam("bookId") String bookId, Model model) {
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		model.addAttribute("book", book);
		return "borrow-book-details";
	}

	// handleReserveBorrowBook
	// --------------------------------------------------------------
	@GetMapping("/handleReserveBorrowBook")
	public String handleReserveBorrowBook(@RequestParam("bookId") String bookId,
			@RequestParam("reserveId") String reserveId, Model model) {
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		int status = bookDAO.updateReserveStatus(reserveId);// add reserve id in query and in rowmapper
		model.addAttribute("book", book);
		return "borrow-book-details";
	}

	@GetMapping("/confirm-borrowbook")
	public String confirmBorrowBook(@RequestParam("bookId") String bookId,
			@RequestParam("count") String bookCount,
			Model model, HttpSession session) {

		User user = (User) session.getAttribute("User");
		int status = bookDAO.updateBorrowBookCount(user.getUserId(), Integer.parseInt(bookId),
				Date.valueOf(LocalDate.now()), Date.valueOf(LocalDate.now().plusWeeks(2)));

		
		//------------------------fine
		
		
		List<BorrowBook> borrowBooks = userDAO.viewBorrowedBooks(user.getUserId());

		model.addAttribute("borrowedBooks", borrowBooks);
		return "view-borrowed-books";
	}

	@GetMapping("/view-borrowed-books")
	public String showBorrowedBooks(HttpSession session, Model model) {
		User user = (User) session.getAttribute("User");
		List<BorrowBook> borrowedBooks = userDAO.viewBorrowedBooks(user.getUserId());
		// 
		model.addAttribute("borrowedBooks", borrowedBooks);
		return "view-borrowed-books";
	}

	@GetMapping("/return-book")
	public String handleReturnBook(@RequestParam("borrowedId") String borrowedId, Model model,HttpSession session) {
		User user = (User) session.getAttribute("User");

		int fineStatus = userDAO.calcFine(Integer.parseInt(borrowedId),user.getUserId());
		int status = userDAO.updateApproveStatus(Integer.parseInt(borrowedId));
//		int status = userDAO.updateBorrowedBook(Integer.parseInt(borrowedId));
		if(fineStatus == 0) {
			model.addAttribute("status", status);
			return "redirect:view-borrowed-books";	
		}
		else {
			return "view-fine";
		}
		
	}

	@GetMapping("/pay-fine")
	public String handlePayfine(@RequestParam("borrowedId") String borrowedId, Model model) {
		FineDetails fine = userDAO.getFineDetails(Integer.parseInt(borrowedId));
		model.addAttribute("finedetails", fine);
		return "view-fine";
	}

	@GetMapping("pay-fine-form")
	public String handlePayement(@RequestParam("borrowedId") String borrowedId, Model model) {
		int status = userDAO.updateFine(Integer.parseInt(borrowedId));
		return "redirect:view-borrowed-books";
	}

	@GetMapping("update-paid-fine")
	public String UpdatePaidFine(@RequestParam("borrowedId") String borrowedId,
			HttpSession session, Model model) {
		int status = userDAO.updatePaidFine(Integer.parseInt(borrowedId));
		User user = (User) session.getAttribute("User");
		List<BorrowBook> borrowedBooks = userDAO.viewBorrowedBooks(user.getUserId());
		// 
		model.addAttribute("borrowedBooks", borrowedBooks);
		return "view-borrowed-books";
	}
	// -------------------wasim-------------

	// open delete-user.jsp file using getMapping annotation

	@GetMapping("/delete-user")
	public String deleteuser(@RequestParam("userId") String userId, Model model, HttpSession session) {

//		User status = userDAO.checkUser(Integer.parseInt(userId));
//		System.out.println(status+" :status");

//		System.out.println(status.getUserId());
//		if (status != null) {// delete user
//			System.out.println(status);
		int deleteStatus = userDAO.deleteUser(Integer.parseInt(userId));// 0 -> return (""
		System.out.println(deleteStatus);

		model.addAttribute("message", deleteStatus);

//		 }else {
//			model.addAttribute("message", "No user found!");
//		}

		List<ViewUserDetails> list = userDAO.viewUser();
		model.addAttribute("userList", list);
		return "ViewUser";
	}

	@PostMapping("delete-user-form")
	public String openDeletePage(@RequestParam("userId") String userId, Model model) {

		int deleteStatus = userDAO.deleteUser(Integer.parseInt(userId));

		model.addAttribute("status", deleteStatus + "");
		List<ViewUserDetails> list = userDAO.viewUser();
		model.addAttribute("userList", list);
		return "ViewUser";
	}

	@GetMapping("/delete-books")
	public String openDeletebook() {
		return "delete-book";
	}

	@GetMapping("/deletebook")
	public String deletebook(@RequestParam("bookid") String bookId, Model model, HttpSession session) {

		Book status = userDAO.checkBook(Integer.parseInt(bookId));

		if (status != null) {// delete user
			int deleteStatus = userDAO.deleteBook(Integer.parseInt(bookId));// 0 -> return (""

			if (deleteStatus == 0) {
				model.addAttribute("message", "This book has already borrowed by some user!");
			} else {
				model.addAttribute("message", "Book Deleted successfully!");
			}
		} else {
			model.addAttribute("message", "No Book found!");
		}

		return "delete-book";
	}

	@GetMapping("/view-particular-user")
	public String openviewparticularuser() {
		return "view-particular-user";
	}

	@GetMapping("/viewParticularUser")
	public String viewparticularuser(@RequestParam("userid") String userId, Model model, HttpSession session) {
		User userDetails = userDAO.checkUser(Integer.parseInt(userId));
		model.addAttribute("userInfo", userDetails);
		return "view-particular-user";
	}

	@GetMapping("/user-profile")
	public String openProfile(HttpSession session, Model model) {

		User user = (User) session.getAttribute("User");
		User userProfile = userDAO.getUser(user.getUserEmailId());
		model.addAttribute("userProfile", userProfile);

		return "user-profile";
	}

	@GetMapping("/update-profile")
	public String openUpdate(HttpSession session, Model model) {

		User user = (User) session.getAttribute("User");
		User userProfile = userDAO.getUser(user.getUserEmailId());
		System.out.println(userProfile);
		model.addAttribute("user", userProfile);
//		model.addAttribute("profileImage", user.getProfilePic());
		return "update-profile-page";
	}

	@InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Blob.class, new MultipartFileToBlobPropertyEditor());
    }
	
	@PostMapping("/userForm")
	public String updateProfile(@ModelAttribute User user, HttpSession session, Model model) {
		
		
		User userSession = (User) session.getAttribute("User");
		int status = userDAO.updateProfile(user, userSession.getUserId());
		model.addAttribute("userProfile", user);
		return "user-profile";
	}

	@GetMapping("/change-password")
	public String openChangePasswordPage(HttpSession session, Model model) {

		String password = ((User) session.getAttribute("User")).getUserPassword();
		model.addAttribute("password", password);
		return "change-password";
	}

	@PostMapping("/changePassword")
	public String changePassword(@RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword, Model model, HttpSession session) {
		
//		System.out.println("test");
		User user = (User) session.getAttribute("User");
		String emailId = user.getUserEmailId();
		int changePassword = userDAO.updatePassword(newPassword, emailId);
		System.out.println(changePassword);
		
//		User userSession = (User) session.getAttribute("User");
//		User userProfile = userDAO.getUser(emailId);
//		model.addAttribute("userProfile", userProfile);
		return "UserLogin"; 
	} 

	@GetMapping("/approve-return-book")
	public String approveBooks(Model model) {
		List<BookApproval> list = userDAO.viewApprovalList();
		model.addAttribute("list", list);
		return "approve-return-books";
	}

	@PostMapping("/process-return-approval")
	public String processReturnApproval(@RequestParam("borrowedId") String borrowedId) {
		int status = userDAO.updateBookApproveStatus(Integer.parseInt(borrowedId));
		return "redirect:approve-return-book";
	}

	@GetMapping("/handle-reject")
	public String handleReject(@RequestParam("borrowedId") String borrowedId,
			@RequestParam("userEmailId") String userEmailId, @RequestParam("bookName") String bookName, Model model) {
		model.addAttribute("bookName", bookName);
		model.addAttribute("borrowedId", borrowedId);
		model.addAttribute("userEmailId", userEmailId);
		return "handle-reject";
	}

	@GetMapping("/process-reject-return")
	public String sendRejectEmail(@RequestParam("rejectReason") String message,
			@RequestParam("borrowedId") String borrowedId, @RequestParam("bookName") String bookName,
			@RequestParam("userEmailId") String userEmailId, Model model) {
		EmailSender sender = new EmailSender();
		sender.sendRejectResponse(userEmailId, message, borrowedId, bookName);
		int status = userDAO.updateFineAmount(borrowedId);
		List<BookApproval> list = userDAO.viewApprovalList();
		model.addAttribute("list", list);
		return "approve-return-books";
	}

	// -------------------------------------
	@PostMapping("/profile-pic")
	public String updateProfilePic(Model model, HttpSession session,
			@RequestParam("profile-pic") MultipartFile profilePic) {

		byte[] profilePicArr;
		Blob profilePicBlob = null;
		try {
			profilePicArr = profilePic.getBytes();
			profilePicBlob = new SerialBlob(profilePicArr);
		} catch (IOException | SQLException e) {
			e.printStackTrace();
		}
		User userSession = (User) session.getAttribute("User");
		userSession.setProfilePic(profilePicBlob);
		int dpInsertStatus = userDAO.insertImage(profilePicBlob, userSession.getUserEmailId());
		User userProfile = userDAO.getUser(userSession.getUserEmailId());
		model.addAttribute("userProfile", userProfile);
		return "user-profile";
	}

	@GetMapping("/handleRequest")
	public String handleRequestBook(@RequestParam("bookId") String bookId, Model model) {
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		model.addAttribute("book", book);

		return "request-book-details";
	}

	@GetMapping("/request-book-handle")
	public String requestBookHandle(@RequestParam("bookId") String bookId, @RequestParam("count") String count,
			HttpSession session, Model model) {
		User userSession = (User) session.getAttribute("User");
		int status = userDAO.handleRequestBooks(userSession.getUserId(), Integer.parseInt(bookId),
				Integer.parseInt(count));
		List<RequestBook> requestBooks = userDAO.viewRequestedBooks(userSession.getUserId());
		System.out.println(requestBooks.get(0).getBookName());
		List<RequestBook> list = userDAO.getRequestedBookById(userSession.getUserId());
//		model.addAttribute("requestBooks", requestBooks);
		model.addAttribute("list", list);
		return "view-requested-book";
	}

	@GetMapping("/handleRequestPlaceOrder")
	public String handleRequestPlaceOrder(@RequestParam("bookId") String bookId,
			@RequestParam("requestId") String requestId, Model model) {
		System.out.println("Running");
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		int status = userDAO.updateRequestStatus(Integer.parseInt(requestId));
		model.addAttribute("book", book);
		return "book-details";
	}

	@GetMapping("/view-requested-book")
	public String openRequestBook(Model model, HttpSession session) {
		User userSession = (User) session.getAttribute("User");

		List<RequestBook> list = userDAO.getRequestedBookById(userSession.getUserId());

//		model.addAttribute("requestBooks", requestBooks);
		model.addAttribute("list", list);
		return "view-requested-book";
	}

	@GetMapping("/view-user-requested-book")
	public String viewUserRequestedBook(Model model) {
		List<RequestBookHistory> list = userDAO.viewUserRequestedBook();
		model.addAttribute("list", list);
		return "view-user-requested-book";
	}

	@GetMapping("/handleReserve")
	public String handleReserve(@RequestParam("bookId") String bookId, HttpSession session, Model model) {
		User user = (User) session.getAttribute("User");
		int status = userDAO.insertHandleReserve(user.getUserId(), Integer.parseInt(bookId));
		// ----------------------------------
		List<ReserveBook> list = userDAO.getReserveBookByUserId(user.getUserId());
		model.addAttribute("list", list);
		return "view-reserve-page";
	}

	@GetMapping("/view-reserve-page")
	public String openReservePage(Model model, HttpSession session) {
		User user = (User) session.getAttribute("User");
		// ----------------------------------
		List<ReserveBook> list = userDAO.getReserveBookByUserId(user.getUserId());
		model.addAttribute("list", list);
		return "view-reserve-page";
	}

	@GetMapping("/view-user-reserved-book")
	public String viewUserReservedBook(Model model) {
		List<ReserveBook> list = userDAO.viewUserReservedBook();
		model.addAttribute("list", list);
		return "view-user-reserved-book";
	}

	@GetMapping("/add-upcoming-events")
	public String addUpcomingEvents() {
		return "addUpcomingEvents";
	}

	@PostMapping("/upcoming-events-detail")
	public String upcomingEventDetails(@RequestParam("eventDetails") String eventDetails,
			@RequestParam("eventDate") String eventDate, Model model, HttpSession session) {

		Admin admin = new Admin();

		int status = userDAO.addUpcomingEvents(eventDetails, eventDate);
		int totalUserCount = adminLoginDAO.totalUser();
		int totalBookCount = adminLoginDAO.totalBooks();
		int totalBooksBorrowed = adminLoginDAO.totalBooksBorrowed();
		int totalPendingApproval = adminLoginDAO.totalBooksApproval();
		int totalBooksBought = adminLoginDAO.totalBooksBought();
		int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
		int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
		int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();

		model.addAttribute("totalUserCount", totalUserCount);
		model.addAttribute("totalBookCount", totalBookCount);
		model.addAttribute("totalBooksBorrowed", totalBooksBorrowed);
		model.addAttribute("totalBooksBought", totalBooksBought);
		model.addAttribute("totalPendingApproval", totalPendingApproval);
		model.addAttribute("totalBooksBorrowedToday", totalBooksBorrowedToday);
		model.addAttribute("totalBooksBoughtToday", totalBooksBoughtToday);
		model.addAttribute("totalUserOverDueCount", totalUserOverDueCount);

		admin = (Admin) session.getAttribute("adminSession");
		adminLoginDAO.validateAdmin(admin.getAdminEmailId(), admin.getAdminPassword()).get(0);
		session.setAttribute("adminSession", admin);
		return "AdminDashboard";
	}

	@GetMapping("/write-feedback-page")
	public String writeFeedbackPage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("User");
		List<ReturnedBook> returnedBook = userDAO.getReturnedBookDetails(user.getUserId());
		model.addAttribute("returnedBook", returnedBook);
		return "write-feedback";
	}

	@GetMapping("/feedback")
	public String getFeedback(Model model, @RequestParam("rating") String rating, @RequestParam("bookId") String bookId,
			@RequestParam("comments") String comment, @RequestParam("borrowedId") String borrowedId,
			HttpSession session) {
		User user = (User) session.getAttribute("User");
		int status = userDAO.addFeedBack(Integer.parseInt(bookId), rating, comment, borrowedId, user.getUserId());
		return "redirect:write-feedback-page";
	}

	@GetMapping("/leaderboard")
	public String showLeaderboard(Model model, HttpSession session) {
		User user = (User) session.getAttribute("User");
		List<LeaderBoard> list = userDAO.leaderboard();
		model.addAttribute("list", list);
		int badgeCount = userDAO.getBadgeCount(user.getUserId());
		model.addAttribute("badgeCount", badgeCount);
		return "leaderboard";
	}
	
	@GetMapping("/send-return-book-remainder")
	public String showNotReturnedBooks(Model model) {
		List<ReturnBookRemainder> list = userDAO.showNotReturnedBooks();
		model.addAttribute("list",list);
		return "return-book-remainder";
	}
	
	@PostMapping("/send-email-remainder")
	public String sendEmailRemainder(
			@RequestParam("emailId") String emailId,
			@RequestParam("borrowedId") int borrowedId,
			@RequestParam("bookName") String bookName,
			HttpSession session,
			Model model) {
			sendRemainderEmail(emailId,borrowedId,bookName);
		return "redirect:send-return-book-remainder";
	}

	private void sendRemainderEmail(String emailId, int borrowedId, String bookName) {
		EmailSender emailSender = new EmailSender();
		emailSender.sendRemainder(emailId, borrowedId,bookName);	
	}
	
	@GetMapping("/forum")
	public String openForumPage(Model model) {
		List<ForumHistory> list = userDAO.getForumHistory();
		model.addAttribute("list",list);
		return "forum";
	}
	
	@PostMapping("/add-forum")
	public String addForum(@RequestParam("content") String content,
			HttpSession session) {
		User user = (User) session.getAttribute("User");
		int status = userDAO.addForum(user.getUserId(),user.getUserName(),content);
		return "redirect:forum";
	}
	
	
	
}
