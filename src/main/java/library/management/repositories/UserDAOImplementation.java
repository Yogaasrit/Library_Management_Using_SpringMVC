package library.management.repositories;

import java.sql.Blob;
import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import library.management.entities.Book;
import library.management.entities.BookApproval;
import library.management.entities.BorrowBook;
import library.management.entities.FineDetails;
import library.management.entities.ForumHistory;
import library.management.entities.LeaderBoard;
import library.management.entities.PurchasedBook;
import library.management.entities.RequestBook;
import library.management.entities.RequestBookHistory;
import library.management.entities.ReserveBook;
import library.management.entities.ReturnBookRemainder;
import library.management.entities.ReturnedBook;
import library.management.entities.UpcomingEvent;
import library.management.entities.User;
import library.management.entities.ViewUserDetails;

public class UserDAOImplementation implements UserDAO{

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}



	@Override
	public List<User> userLogin(String userEmailId, String userPassword) {
		String userLoginQuery = "SELECT * FROM user WHERE userEmailId = ? and userPassword = ?";
		return jdbcTemplate.query(userLoginQuery, new UserLoginRowMapper(),userEmailId,userPassword);
	}

	@Override
	public List<ViewUserDetails> viewUser() {
		String viewUserQuery = "SELECT\r\n"
				+ "    u.userId,\r\n"
				+ "    u.userEmailId,\r\n"
				+ "    u.userName,\r\n"
				+ "    u.phoneNo,\r\n"
				+ "    u.dob,\r\n"
				+ "    u.address,\r\n"
				+ "    u.gender,\r\n"
				+ "    COUNT(DISTINCT ob.bookId) AS totalOrderedBooks,\r\n"
				+ "    COUNT(DISTINCT bb.bookId) AS totalBorrowedBooks,\r\n"
				+ "    COALESCE(SUM(bb.bookFine), 0) AS totalFine\r\n"
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "LEFT JOIN\r\n"
				+ "    orderedbooks ob ON u.userId = ob.userId\r\n"
				+ "LEFT JOIN\r\n"
				+ "    borrowbook bb ON u.userId = bb.userId\r\n"
				+ "WHERE u.status = 1\r\n"
				+ "GROUP BY\r\n"
				+ "    u.userId, u.userEmailId, u.userName, u.phoneNo, u.dob, u.address, u.gender";
		return jdbcTemplate.query(viewUserQuery, new ViewAllUserDetailRowMapper());
	}

	@Override
	public int addBooks(Book book) {

		 String insertQuery = "INSERT INTO books " +
	                "(bookName, bookPrice, bookGenre, bookPublication, " +
	                "bookPublishDate, bookEdition, bookQuantity, authorName, bookCover, bookStatus) " +
	                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		 
		 return jdbcTemplate.update(insertQuery,
				 				book.getBookName(),
				 				book.getBookPrice(),
				 				book.getBookGenre(),
				 				book.getBookPublication(),
				 				book.getBookPublishDate(),
				 				book.getBookEdition(),
				 				book.getBookQuantity(),
				 				book.getAuthorName(),
				 				book.getBookCover(),
				 				book.isBookStatus());
		
	}

	@Override
	public int placeOrder(int userId,int bookId, int bookCount,Date orderDate) {
		int status = 0;
		String placeOrderQuery = "insert into orderedbooks values (?,?,?,?)";
		status = jdbcTemplate.update(placeOrderQuery,userId,bookId,bookCount,orderDate);
		String updateBadgeCount = "Update user set badgeCount = badgeCount + 25 where userId = ?";
		jdbcTemplate.update(updateBadgeCount,userId);
		return status;
	}

	@Override
	public List<PurchasedBook> viewPurchasedBooks(int userId) {
		String viewPurchasedBookQuery = "select books.bookName,books.bookPrice, books.bookCover, "
				+ "orderedbooks.orderDate,orderedbooks.bookCount from books "
				+ " inner join orderedbooks \r\n"
				+ "on books.bookId = orderedbooks.bookId\r\n"
				+ "where orderedbooks.userId = ?;";
			return jdbcTemplate.query(viewPurchasedBookQuery, new OrderedBookRowMapper(), userId);
	}

	@Override
	public List<BorrowBook> viewBorrowedBooks(int userId) {
		String viewBorrowedBooksQuery = " select books.bookCover,\r\n"
				+ "books.bookName,\r\n"
				+ "borrowbook.borrowedDate,\r\n"
				+ "borrowbook.returnDate,\r\n"
				+ "borrowbook.bookfine,\r\n"
				+ "borrowbook.approveStatus,\r\n"
				+ "borrowbook.borrowedId from books inner join borrowbook\r\n"
				+ "on \r\n"
				+ "books.bookId = borrowbook.bookId\r\n"
				+ "where\r\n"
				+ "borrowbook.userId = ? and returnStatus = 0";
		
		return jdbcTemplate.query(viewBorrowedBooksQuery, new BorrowRowMapper(), userId);
	}

	@Override
	public int updateBorrowedBook(int borrowedId) {
		String updateBorrowedBookQuery = "update borrowbook set returnStatus = 1 where borrowedId = ?";
		int status = 0;
		if(jdbcTemplate.update(updateBorrowedBookQuery,borrowedId) == 1)
		{
			String updateBookQuery = "UPDATE books b\r\n"
					+ "JOIN borrowbook bb ON b.bookId = bb.bookId\r\n"
					+ "SET b.bookQuantity = b.bookQuantity + 1\r\n"
					+ "WHERE bb.borrowedId = ?";
			status = jdbcTemplate.update(updateBookQuery,borrowedId);
		}
		return status;
	}

	@Override
	public int updateFine(int borrowedId) {
		String updateFineQuery = "update borrowbook set bookFine = 0 where borrowedId = ?";
		return jdbcTemplate.update(updateFineQuery,borrowedId);
	}
	
	
	@Override
	public User checkUser(int userId) {
		String checkAvailableUser = "select * from user where userId = ? and status = 1";
		
		return jdbcTemplate.queryForObject(checkAvailableUser, new UserLoginRowMapper(),userId);
		
		
	}
	@Override
	public int deleteUser(int userId) {
		String deleteQuery = "UPDATE user\n"
				+ "SET status = 0\n"
				+ "WHERE userId = ? -- specify the user ID\n"
				+ "  AND userId NOT IN (SELECT userId FROM borrowbook WHERE bookFine > 0)\n"
				+ "  AND userId NOT IN (SELECT userId FROM borrowbook WHERE returnStatus = 1)";
		return jdbcTemplate.update(deleteQuery, userId);
	}
	@Override
	public Book checkBook(int bookId) {
		String checkAvailableBook = "select * from books where bookId = ? and bookStatus = 1";
		
		return jdbcTemplate.queryForObject(checkAvailableBook, new BookRowMapper(),bookId);
		
		
	}
	@Override
	public int deleteBook(int bookId) {
		String deleteQuery = "UPDATE books\n"
				+ "SET bookStatus = 0\n"
				+ "WHERE bookId = ? -- specify the user ID\n"
				+ "  AND bookId NOT IN (SELECT bookId FROM borrowbook)";
		return jdbcTemplate.update(deleteQuery, bookId);
		
		
	}

	@Override
	public int userRegister(String userEmailId, String userName, String phoneNo, Date dob, String address, String gender,
			String userPassword) {
		String userRegisterQuery = "INSERT IGNORE INTO user (userEmailId, userName, phoneNo, dob, address, gender, userPassword, status, badgeCount)\r\n"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, 1, 10)";
		return jdbcTemplate.update(userRegisterQuery,userEmailId,userName,phoneNo,dob,address, gender, userPassword);
	}

	@Override
	public boolean isEmailInDatabase(String email) {
		String CheckQuery="Select * from user where userEmailId=?";
		return jdbcTemplate.query(CheckQuery, new UserLoginRowMapper(),email)
				.size() == 1 ? true : false;
	}

	@Override
	public User getUser(String userEmailId) {
		String getUserQuery = "select * from user where userEmailId = ?";
		return jdbcTemplate.queryForObject(getUserQuery,new GetUserRowMapper(),userEmailId);
	}

	@Override
	public int updatePassword(String userPassword,String userEmailId) {
		String updatePasswordQUery = "update user set userPassword = ? where userEmailId = ?";
		return jdbcTemplate.update(updatePasswordQUery,userPassword,userEmailId);
	}

	@Override
	public int updateProfile(User user,int userId) {
		System.out.println(user);
		String updateProfileQuery = "update user set "
				+ "userEmailId = ?, userName = ?, "
				+ "phoneNo = ?, dob = ?, address=?, "
				+ "gender=? where userId = ?";
				
		return jdbcTemplate.update(updateProfileQuery,user.getUserEmailId(),user.getUserName(),user.getPhoneNo(),
				user.getDob(),user.getAddress(),user.getGender(),userId);
	}

	@Override
	public int updateApproveStatus(int borroweId) {
		String updateApproveStatus = "update borrowBook set approveStatus = 1 where borrowedId = ?";
		return jdbcTemplate.update(updateApproveStatus,borroweId);
		
	}

	@Override
	public List<BookApproval> viewApprovalList() {
		String approvalQuery = "SELECT\r\n"
				+ "    u.userName,\r\n"
				+ "    u.userEmailId,\r\n"
				+ "    u.userId,\r\n"
				+ "    b.bookId,\r\n"
				+ "    b.bookName,\r\n"
				+ "    b.bookCover,\r\n"
				+ "    bb.borrowedId,\r\n"
				+ "    bb.borrowedDate,\r\n"
				+ "    bb.returnDate\r\n"
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    borrowbook bb ON u.userId = bb.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON bb.bookId = b.bookId"
				+ " WHERE bb.approveStatus = 1";
		return jdbcTemplate.query(approvalQuery, new viewApprovalRowMapper());
	}

	@Override
	public int updateBookApproveStatus(int borrowedId) {
		String updateBookApproveStatusQuery = "update borrowBook set approveStatus = 0, returnStatus = 1 where borrowedId = ?";		
		return jdbcTemplate.update(updateBookApproveStatusQuery,borrowedId);
	}

	@Override
	public int insertImage(Blob profilePicBlob, String emailId) {
		
		String insertImage = "UPDATE user SET profilePic = ? WHERE userEmailId = ?";
		return jdbcTemplate.update(insertImage,profilePicBlob,emailId);
	}

	@Override
	public int handleRequestBooks(int userId, int bookId,int count) {
		String handleRequestBooksQuery = "Insert into requestbook(userId,bookId,requestStatus,orderCount) values(?,?,?,?)";
		return jdbcTemplate.update(handleRequestBooksQuery,userId,bookId,0,count);
	}

	@Override
	public List<RequestBook> viewRequestedBooks(int userId) {
		String viewRequestedBooks="SELECT b.bookId, b.bookName, b.bookPrice, b.bookGenre,b.bookQuantity, b.bookPublication, b.bookPublishDate, b.bookEdition, b.authorName, b.bookCover,rb.orderCount\r\n"
				+ "FROM requestbook rb\r\n"
				+ "JOIN books b ON rb.bookId = b.bookId\r\n"
				+ "WHERE rb.userId = ? AND rb.requestStatus = 0";
		return jdbcTemplate.query(viewRequestedBooks, new RequestBookRowMapper(),userId);
	}

	@Override
	public List<RequestBookHistory> viewUserRequestedBook() {
		String viewUserRequestedBookQuery = "SELECT\r\n"
				+ "    u.userName,\r\n"
				+ "    r.userId,\r\n"
				+ "    r.bookId,\r\n"
				+ "    b.bookName,\r\n"
				+ "    b.bookCover,\r\n"
				+ "    r.orderCount,\r\n"
				+"     b.authorName "
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    requestbook r ON u.userId = r.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON r.bookId = b.bookId;\r\n"
				+ "";
		return jdbcTemplate.query(viewUserRequestedBookQuery, new RequestBookHistoryRowMapper());
	}

	@Override
	public List<RequestBook> getRequestedBookById(int userId) {
		String getRequestedBookByIdQuery = "SELECT\r\n"
				+ "    u.userName,\r\n"
				+ "    r.userId,\r\n"
				+ "    r.bookId,\r\n"
				+ "    b.bookName,\r\n"
				+ "    b.bookCover,\r\n"
				+ "    r.orderCount,\r\n"
				+ "    b.authorName,\r\n"
				+ "    b.bookQuantity,  "	
				+"	   r.requestId "	
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    requestbook r ON u.userId = r.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON r.bookId = b.bookId\r\n"
				+ "where u.userId = ? and requestStatus = 0";				
		return jdbcTemplate.query(getRequestedBookByIdQuery,new RequestBookByIdRowMapper(), userId);
	}

	@Override
	public int insertHandleReserve(int userId,int bookId) {
		String insertHandleReserveQuery = "insert into reservebook (`userId`, `bookId`, `reserveStatus`) values (?,?,?)";
		return jdbcTemplate.update(insertHandleReserveQuery,userId,bookId,0);
	}
	
	//----------------------------------

	@Override
	public List<ReserveBook> getReserveBookByUserId(int userId) {
		String getReserveBookByUserId = "SELECT\r\n"
				+ "    u.userName,\r\n"
				+ "    r.userId,\r\n"
				+ "    r.bookId,\r\n"
				+ "    b.bookName,\r\n"
				+ "    b.bookCover,\r\n"
				+ "    b.authorName,\r\n"
				+ "    b.bookQuantity,"
				+ "    r.reserveId "	
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    reservebook r ON u.userId = r.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON r.bookId = b.bookId\r\n"
				+ "where u.userId = ? and reserveStatus = 0";	
		return jdbcTemplate.query(getReserveBookByUserId, new ReserveBookRowMapper(), userId);
	}

	@Override
	public List<ReserveBook> viewUserReservedBook() {
		String viewUserRequestedBookQuery = "SELECT\r\n"
				+ "    u.userName,\r\n"
				+ "    r.userId,\r\n"
				+ "    r.bookId,\r\n"
				+ "    b.bookName,\r\n"
				+ "    b.bookCover,\r\n"
				+"     b.authorName,\r\n "
				+"     b.bookQuantity,"
				+ "	   r.reserveId "	
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    reservebook r ON u.userId = r.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON r.bookId = b.bookId;\r\n"
				+ "";
		return jdbcTemplate.query(viewUserRequestedBookQuery, new ReserveBookRowMapper());
	}

	@Override
	public int updateRequestStatus(int requestId) {
		String updatRequestStatus = "Update requestbook set requestStatus = 1 where requestId = ?";
		return jdbcTemplate.update(updatRequestStatus, requestId);
	}

	@Override
	public int addUpcomingEvents(String eventDetails, String eventDate) {
		String addUpcomingEventsQuery = "insert into upcomingevents (eventDetail,eventDate) values (?,?)";
		return jdbcTemplate.update(addUpcomingEventsQuery,eventDetails,eventDate );
	}

	@Override
	public List<UpcomingEvent> getUpComingEvent() {
		String getUpComingEventQuery = "select * from upcomingevents";
		return jdbcTemplate.query(getUpComingEventQuery, new UpcomingEventRowMapper());
	}

	@Override
	public List<ReturnedBook> getReturnedBookDetails(int userId) {
		String getReturnedBookDetailsQuery = "select b.bookId, b.bookCover,bb.returnStatus,bb.borrowedId from books as b left join\r\n"
				+ " borrowbook as bb on bb.bookId = b.bookId where bb.returnStatus = 1 and bb.userId = ? and bb.feedBackStatus=0";
		return jdbcTemplate.query(getReturnedBookDetailsQuery, new GetReturnedBookDetailsRowMapper(),userId);
	}

	@Override
	public int addFeedBack(int bookId, String rating, String comment, String borrowedId, int userId) {
		int status = 0;
		String addFeedBackQuery = "Insert into feedback (bookId, star, comment) values(?,?,?)";
		if(jdbcTemplate.update(addFeedBackQuery, bookId, Integer.parseInt(rating), comment) == 1) {
			String updateFeedBackStatusInBorrowBook = "update borrowbook set feedBackStatus = 1 where borrowedId = ?";
			status=  jdbcTemplate.update(updateFeedBackStatusInBorrowBook,borrowedId);
			
			String updateBadgeCount = "Update user set badgeCount = badgeCount + 5 where userId = ?";
			jdbcTemplate.update(updateBadgeCount,userId);
		}
		return status;
	}

	@Override
	public List<LeaderBoard> leaderboard() {
		String viewLeaderBoardQuery = "SELECT userName, profilePic, badgeCount\r\n"
				+ "FROM user\r\n"
				+ "ORDER BY badgeCount DESC\r\n"
				+ "LIMIT 3";
		return jdbcTemplate.query(viewLeaderBoardQuery, new LeaderBoardRowMapper());
	}

	@Override
	public int getBadgeCount(int userId) {
		String getBadgeCountQuery = "select userName, profilePic, badgeCount from user where userId = ?";
		return jdbcTemplate.query(getBadgeCountQuery, new LeaderBoardRowMapper(), userId).get(0).getBadgeCount();
	}

	@Override
	public int updateBookQuantityAddToCart(String bookId,String bookQuantity) {
		String updateBookQuantityAddToCartQuery = "UPDATE books "
				+ "SET bookQuantity = bookQuantity - ? where bookId = ?";
		
		return jdbcTemplate.update(updateBookQuantityAddToCartQuery,
				Integer.parseInt(bookQuantity),
				Integer.parseInt(bookId));
	}

	@Override
	public int updateBookCount(String bookId, String quantity) {
		String updateBookCount = "UPDATE books "
				+ "SET bookQuantity = bookQuantity + ? where bookId = ?";
		
		return jdbcTemplate.update(updateBookCount,
				Integer.parseInt(quantity),
				Integer.parseInt(bookId));
	}

	@Override
	public List<ReturnBookRemainder> showNotReturnedBooks() {
		String returnBookRemainder = "SELECT bb.userId,u.userEmailId, bb.bookId, bb.borrowedId, b.bookName,\r\n"
				+ "       bb.borrowedDate, bb.returnDate, bb.bookFine, bb.returnStatus\r\n"
				+ "FROM borrowbook bb\r\n"
				+ "JOIN user u ON bb.userId = u.userId\r\n"
				+ "JOIN books b ON bb.bookId = b.bookId\r\n"
				+ "WHERE (bb.returnDate <= CURRENT_DATE() OR bb.returnDate = DATE_ADD(CURRENT_DATE(), INTERVAL 2 DAY))\r\n"
				+ "      AND bb.returnStatus = 0;\r\n"
				+ "";
				
		return jdbcTemplate.query(returnBookRemainder, new ReturnBookRemainderRowMapper());
	}

	@Override
	public List<ForumHistory> getForumHistory() {
		String getForumHistoryQuery = "select * from forum";
		return jdbcTemplate.query(getForumHistoryQuery, new ForumHistoryRowMapper());
	}

	@Override
	public int addForum(int userId, String userName, String content) {
		String addForumQuery = "INSERT INTO forum (userId, userName, content, date)\r\n"
				+ "VALUES (?, ?, ?, CURRENT_DATE());";
		return jdbcTemplate.update(addForumQuery,userId,userName,content);
	}

	@Override
	public int calcFine(int borrowedId, int userId) {

		String calcFineQuery = "update borrowbook SET "
				+ "bookFine =  DATEDIFF(CURRENT_DATE, returnDate) * 10 "
				+ "where userId = ? and borrowedId = ? and returnDate < curdate(); \r\n";
		return jdbcTemplate.update(calcFineQuery,userId,borrowedId);
	}

	@Override
	public int updateFineAmount(String borrowedId) {
		String updateFineAmountQuery = "UPDATE borrowbook\r\n"
				+ "SET bookFine = (SELECT bookPrice FROM books WHERE books.bookId = borrowbook.bookId)\r\n"
				+ "WHERE borrowedId = ?";
		return jdbcTemplate.update(updateFineAmountQuery,borrowedId );
	}

	@Override
	public FineDetails getFineDetails(int borrowedId) {
		String getFineDetails = "SELECT borrowedId,bookFine from borrowbook where borrowedId = ?";
		return jdbcTemplate.queryForObject(getFineDetails, new FineDetailsRowMapper(), borrowedId);
	}

	@Override
	public int updatePaidFine(int borrowedId) {
		String updatePaidFineQuery = "update borrowbook set bookFine = 0 where borrowedId = ?";
		return jdbcTemplate.update(updatePaidFineQuery, borrowedId);
	}
}
