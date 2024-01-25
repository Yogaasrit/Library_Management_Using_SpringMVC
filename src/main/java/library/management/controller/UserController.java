package library.management.controller;

import java.io.IOException;
import java.sql.Blob;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import library.management.entities.Admin;
import library.management.entities.Book;
import library.management.entities.BookApproval;
import library.management.entities.BorrowBook;
import library.management.entities.FreeBook;
import library.management.entities.PurchasedBook;
import library.management.entities.RequestBook;
import library.management.entities.RequestBookHistory;
import library.management.entities.ReserveBook;
import library.management.entities.User;
import library.management.entities.ViewUserDetails;
import library.management.repositories.AdminLoginDAO;
import library.management.repositories.BookDAO;
import library.management.repositories.UserDAO;
import library.management.utilities.EmailSender;

@Controller
@RequestMapping("User")

public class UserController {
	@Autowired
	UserDAO userDAO;

	@Autowired
	BookDAO bookDAO;

	@Autowired
	AdminLoginDAO adminLoginDAO;
	@GetMapping("/add-freebook")
	public String addFreeBooks() {
		return "add-freebook";
	}
	@GetMapping("/free-books")
	public String showFreeBooks(Model model) {
		List<FreeBook> freeBooks = bookDAO.displayFreeBooks();
		model.addAttribute("freeBooks",freeBooks);
		return "free-books";
	}
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
			@RequestParam("pdfAuthorName") String pdfAuthorName,
			@RequestParam("pdf") MultipartFile pdf,
			@RequestParam("pdfCover") MultipartFile pdfCover,
			Model model) {
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
		freebook=new FreeBook(pdfName,pdfAuthorName,pdfBlob,pdfCoverBlob);
		int status=bookDAO.addFreeBook(freebook);
		if(status==1) {
			model.addAttribute("message", "Free Book Added Successfully!");
		}
		else {
			model.addAttribute("message", "No Free Book Added, Try again correctly!");
		}
		
		return "add-freebook";
	}
	
	
	@GetMapping("/admin-view-profile")
	public String viewAdminProfile( Model model) {
		String password = adminLoginDAO.getPassword();
		model.addAttribute("password",password);
		return "view-admin-profile";
	}
	
	
	@PostMapping("/admin-changePassword")
	public String openDashboard(Model model, 
			@RequestParam("confirmPassword") String confirmPassword) {
		int status = adminLoginDAO.updateAdminPassWord(confirmPassword);
		
		int totalUserCount = adminLoginDAO.totalUser();
		int totalBookCount = adminLoginDAO.totalBooks();
		int totalBooksBorrowed = adminLoginDAO.totalBooksBorrowed();
		int totalPendingApproval=adminLoginDAO.totalBooksApproval();
		int totalBooksBought = adminLoginDAO.totalBooksBought();
		int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
		int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
		int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();
		
		model.addAttribute("totalUserCount",totalUserCount);
		model.addAttribute("totalBookCount",totalBookCount);
		model.addAttribute("totalBooksBorrowed",totalBooksBorrowed);
		model.addAttribute("totalBooksBought",totalBooksBought);
		model.addAttribute("totalPendingApproval",totalPendingApproval);
		model.addAttribute("totalBooksBorrowedToday",totalBooksBorrowedToday);
		model.addAttribute("totalBooksBoughtToday",totalBooksBoughtToday);
		model.addAttribute("totalUserOverDueCount",totalUserOverDueCount);
		return "AdminDashboard";
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
			
			
			//add more data for admin dashboard
			int totalUserCount = adminLoginDAO.totalUser();
			int totalBookCount = adminLoginDAO.totalBooks();
			int totalBooksBorrowed = adminLoginDAO.totalBooksBorrowed();
			int totalPendingApproval=adminLoginDAO.totalBooksApproval();
			int totalBooksBought = adminLoginDAO.totalBooksBought();
			int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
			int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
			int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();
			
			model.addAttribute("totalUserCount",totalUserCount);
			model.addAttribute("totalBookCount",totalBookCount);
			model.addAttribute("totalBooksBorrowed",totalBooksBorrowed);
			model.addAttribute("totalBooksBought",totalBooksBought);
			model.addAttribute("totalPendingApproval",totalPendingApproval);
			model.addAttribute("totalBooksBorrowedToday",totalBooksBorrowedToday);
			model.addAttribute("totalBooksBoughtToday",totalBooksBoughtToday);
			model.addAttribute("totalUserOverDueCount",totalUserOverDueCount);
			
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
			@RequestParam("bookCover") MultipartFile bookCover, Model model,HttpSession session) {

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
		int totalPendingApproval=adminLoginDAO.totalBooksApproval();
		int totalBooksBought = adminLoginDAO.totalBooksBought();
		int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
		int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
		int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();
		
		model.addAttribute("totalUserCount",totalUserCount);
		model.addAttribute("totalBookCount",totalBookCount);
		model.addAttribute("totalBooksBorrowed",totalBooksBorrowed);
		model.addAttribute("totalBooksBought",totalBooksBought);
		model.addAttribute("totalPendingApproval",totalPendingApproval);
		model.addAttribute("totalBooksBorrowedToday",totalBooksBorrowedToday);
		model.addAttribute("totalBooksBoughtToday",totalBooksBoughtToday);
		model.addAttribute("totalUserOverDueCount",totalUserOverDueCount);
		
		admin = (Admin)session.getAttribute("adminSession");
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

	@GetMapping("/confirm-placeorder")
	public String confirmPlaceOrder(@RequestParam("bookId") String bookId, @RequestParam("count") String bookCount,
			Model model, HttpSession session) {

		System.out.println(bookId + "-" + bookCount);
		User user = (User) session.getAttribute("User");
		int status = userDAO.placeOrder(user.getUserId(), Integer.parseInt(bookId), Integer.parseInt(bookCount),
				Date.valueOf(LocalDate.now()));

		List<PurchasedBook> bookList = userDAO.viewPurchasedBooks(user.getUserId());
		bookDAO.updateBookCount(Integer.parseInt(bookCount), Integer.parseInt(bookId));
		model.addAttribute("bookList", bookList);
		return "view-your-books";
	}

	@GetMapping("/view-your-books")
	public String openOrder(Model model, HttpSession session) {
		User user = (User) session.getAttribute("User");
		List<PurchasedBook> bookList = userDAO.viewPurchasedBooks(user.getUserId());
		model.addAttribute("bookList", bookList);

		return "view-your-books";
	}

	@GetMapping("/handleViewBooks")
	public String handleViewBooks(@RequestParam("bookId") String bookId) {
		return "book-details";
	}

	@GetMapping("/handleBorrowBook")
	public String handleBorrowBooks(@RequestParam("bookId") String bookId, Model model) {
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		model.addAttribute("book", book);
		return "borrow-book-details";
	}
	
	//handleReserveBorrowBook --------------------------------------------------------------
	@GetMapping("/handleReserveBorrowBook")
	public String handleReserveBorrowBook(@RequestParam("bookId") String bookId,
			@RequestParam("reserveId") String reserveId,
			Model model) {
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		int status = bookDAO.updateReserveStatus(reserveId);// add reserve id in query and in rowmapper
		model.addAttribute("book", book);
		return "borrow-book-details";
	}

	@GetMapping("/confirm-borrowbook")
	public String confirmBorrowBook(@RequestParam("bookId") String bookId, @RequestParam("count") String bookCount,
			Model model, HttpSession session) {

		User user = (User) session.getAttribute("User");
		int status = bookDAO.updateBorrowBookCount(user.getUserId(), Integer.parseInt(bookId),
				Date.valueOf(LocalDate.now()), Date.valueOf(LocalDate.now().plusWeeks(2)));

		List<BorrowBook> borrowBooks = userDAO.viewBorrowedBooks(user.getUserId());

		model.addAttribute("borrowedBooks", borrowBooks);

		return "view-borrowed-books";
	}

	@GetMapping("/view-borrowed-books")
	public String showBorrowedBooks(HttpSession session, Model model) {
		User user = (User) session.getAttribute("User");
		List<BorrowBook> borrowedBooks = userDAO.viewBorrowedBooks(user.getUserId());
		model.addAttribute("borrowedBooks", borrowedBooks);
		return "view-borrowed-books";
	}

	@GetMapping("/return-book")
	public String handleReturnBook(@RequestParam("borrowedId") String borrowedId, Model model) {
		int status = userDAO.updateApproveStatus(Integer.parseInt(borrowedId));
//		int status = userDAO.updateBorrowedBook(Integer.parseInt(borrowedId));
		model.addAttribute("status", status);
		return "redirect:view-borrowed-books";
	}

	
	
	@GetMapping("/pay-fine")
	public String handlePayfine(@RequestParam("borrowedId") String borrowedId, Model model) {

		model.addAttribute("borrowedId", borrowedId);
		return "view-fine";
	}

	@GetMapping("pay-fine-form")
	public String handlePayement(@RequestParam("borrowedId") String borrowedId, Model model) {
		int status = userDAO.updateFine(Integer.parseInt(borrowedId));
		return "redirect:view-borrowed-books";
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
	public String openDeletePage(@RequestParam("userId") String userId,Model model) {
		
		int deleteStatus = userDAO.deleteUser(Integer.parseInt(userId));
		
		model.addAttribute("status", deleteStatus+"");
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
		return "update-profile-page";
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
		String emailId = ((User) session.getAttribute("User")).getUserEmailId();
		int changePassword = userDAO.updatePassword(newPassword, emailId);
		User userSession = (User) session.getAttribute("User");
		User userProfile = userDAO.getUser(emailId);
		model.addAttribute("userProfile", userProfile);
		return "user-profile";
	}

	@GetMapping("/approve-return-book")
	public String approveBooks(Model model) {
		List<BookApproval> list = userDAO.viewApprovalList();
		model.addAttribute("list",list);
		return "approve-return-books";
	}
	
	@PostMapping("/process-return-approval")
	public String processReturnApproval(
			@RequestParam("borrowedId") String borrowedId
			) {
			int status = userDAO.updateBookApproveStatus(Integer.parseInt(borrowedId));
			return "redirect:approve-return-book";
	}
	
	@GetMapping("/handle-reject")
	public String handleReject(
			@RequestParam("borrowedId") String borrowedId,
			@RequestParam("userEmailId") String userEmailId,
			@RequestParam("bookName") String bookName,
			Model model
			) {
		model.addAttribute("bookName", bookName);
		model.addAttribute("borrowedId", borrowedId);
		model.addAttribute("userEmailId", userEmailId);
		return "handle-reject";
	}
	
	@GetMapping("/process-reject-return")
	public String sendRejectEmail(
			@RequestParam("rejectReason") String message,
			@RequestParam("borrowedId") String borrowedId,
			@RequestParam("bookName") String bookName,
			@RequestParam("userEmailId") String userEmailId,
			Model model
			) {
		
		EmailSender sender = new EmailSender();
		sender.sendRejectResponse(userEmailId, message, borrowedId, bookName);
		List<BookApproval> list = userDAO.viewApprovalList();
		model.addAttribute("list",list);
		return "approve-return-books";
	}
	
	//-------------------------------------
	@PostMapping("/profile-pic")
	public String updateProfilePic(Model model,
						HttpSession session,
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
	public String handleRequestBook(
			@RequestParam("bookId") String bookId, Model model) {
		Book book = bookDAO.displayByBookId(Integer.parseInt(bookId));
		model.addAttribute("book",book);
		
		return "request-book-details";
	}
	
	@GetMapping("/request-book-handle")
	public String requestBookHandle(
			@RequestParam("bookId") String bookId,
			@RequestParam("count") String count,
			HttpSession session,Model model) {
		User userSession = (User) session.getAttribute("User");
		int status = userDAO.handleRequestBooks(userSession.getUserId(),Integer.parseInt(bookId),Integer.parseInt(count));
		List<RequestBook> requestBooks = userDAO.viewRequestedBooks(userSession.getUserId());
		System.out.println(requestBooks.get(0).getBookName());
		List<RequestBook> list = userDAO.getRequestedBookById(userSession.getUserId());
//		model.addAttribute("requestBooks", requestBooks);
		model.addAttribute("list",list);
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
	public String openRequestBook(Model model,HttpSession session) {
		User userSession = (User) session.getAttribute("User");

		List<RequestBook> list = userDAO.getRequestedBookById(userSession.getUserId());
		
//		model.addAttribute("requestBooks", requestBooks);
		model.addAttribute("list",list);
		return "view-requested-book";
	}
	
	@GetMapping("/view-user-requested-book")
	public String viewUserRequestedBook(Model model) {
		List<RequestBookHistory>list=  userDAO.viewUserRequestedBook();
		model.addAttribute("list",list);	
		return "view-user-requested-book";
	}
	
	@GetMapping("/handleReserve")
	public String handleReserve(@RequestParam("bookId") String bookId,HttpSession session) {
		User user = (User)session.getAttribute("User");
		int status = userDAO.insertHandleReserve(user.getUserId(),Integer.parseInt(bookId));
		return "UserDashboard";
	}
	
	@GetMapping("/view-reserve-page")
	public String openReservePage(Model model, HttpSession session) {
		User user = (User)session.getAttribute("User");
		//----------------------------------
		List<ReserveBook> list = userDAO.getReserveBookByUserId(user.getUserId());
		model.addAttribute("list",list);
		return "view-reserve-page";
	}
	
	@GetMapping("/view-user-reserved-book")
	public String viewUserReservedBook(Model model) {
		List<ReserveBook> list = userDAO.viewUserReservedBook();
		model.addAttribute("list",list);
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
		
		int status = userDAO.addUpcomingEvents(eventDetails,eventDate);
		int totalUserCount = adminLoginDAO.totalUser();
		int totalBookCount = adminLoginDAO.totalBooks();
		int totalBooksBorrowed = adminLoginDAO.totalBooksBorrowed();
		int totalPendingApproval=adminLoginDAO.totalBooksApproval();
		int totalBooksBought = adminLoginDAO.totalBooksBought();
		int totalBooksBorrowedToday = adminLoginDAO.totalBooksBorrowedToday();
		int totalBooksBoughtToday = adminLoginDAO.totalBooksBoughtToday();
		int totalUserOverDueCount = adminLoginDAO.totalUserOverDueCount();
		
		model.addAttribute("totalUserCount",totalUserCount);
		model.addAttribute("totalBookCount",totalBookCount);
		model.addAttribute("totalBooksBorrowed",totalBooksBorrowed);
		model.addAttribute("totalBooksBought",totalBooksBought);
		model.addAttribute("totalPendingApproval",totalPendingApproval);
		model.addAttribute("totalBooksBorrowedToday",totalBooksBorrowedToday);
		model.addAttribute("totalBooksBoughtToday",totalBooksBoughtToday);
		model.addAttribute("totalUserOverDueCount",totalUserOverDueCount);
		
		admin = (Admin)session.getAttribute("adminSession");
		adminLoginDAO.validateAdmin(admin.getAdminEmailId(), admin.getAdminPassword()).get(0);
		session.setAttribute("adminSession", admin);
		return "AdminDashboard";
	}
}
