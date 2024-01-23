package library.management.repositories;

import java.sql.Blob;
import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import library.management.entities.Book;
import library.management.entities.BookApproval;
import library.management.entities.BorrowBook;
import library.management.entities.PurchasedBook;
import library.management.entities.RequestBook;
import library.management.entities.RequestBookHistory;
import library.management.entities.ReserveBook;
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
		String placeOrderQuery = "insert into orderedbooks values (?,?,?,?)";
		return jdbcTemplate.update(placeOrderQuery,userId,bookId,bookCount,orderDate);
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
		String userRegisterQuery = "INSERT IGNORE INTO user (userEmailId, userName, phoneNo, dob, address, gender, userPassword, status)\r\n"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
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
				+ "    b.bookQuantity "	
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    requestbook r ON u.userId = r.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON r.bookId = b.bookId\r\n"
				+ "where u.userId = ?";				
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
				+ "    b.bookQuantity "	
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    reservebook r ON u.userId = r.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON r.bookId = b.bookId\r\n"
				+ "where u.userId = ?";	
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
				+"     b.bookQuantity "	
				+ "FROM\r\n"
				+ "    user u\r\n"
				+ "JOIN\r\n"
				+ "    reservebook r ON u.userId = r.userId\r\n"
				+ "JOIN\r\n"
				+ "    books b ON r.bookId = b.bookId;\r\n"
				+ "";
		return jdbcTemplate.query(viewUserRequestedBookQuery, new ReserveBookRowMapper());
	}




}
