package library.management.repositories;

import java.sql.Blob;
import java.sql.Date;
import java.util.List;

import library.management.entities.Book;
import library.management.entities.BookApproval;
import library.management.entities.BorrowBook;
import library.management.entities.PurchasedBook;
import library.management.entities.RequestBook;
import library.management.entities.RequestBookHistory;
import library.management.entities.ReserveBook;
import library.management.entities.User;
import library.management.entities.ViewUserDetails;

public interface UserDAO {

	public int userRegister(String emailId, String userName, String phoneNo,Date dob, String address,String gender, String password);
	public List<User> userLogin(String userEmailId, String userPassword);
	public List<ViewUserDetails> viewUser();
	public int addBooks(Book book);
	public int placeOrder(int userId,int bookId,int bookCount,Date orderDate);
	public List<PurchasedBook> viewPurchasedBooks(int userId);
	public List<BorrowBook> viewBorrowedBooks(int userId);
	public int updateBorrowedBook(int borrowedId);
	public int updateFine(int borrowedId);
	public User checkUser(int userId);
	public int deleteUser(int userId);
	public Book checkBook(int bookId);
	public int deleteBook(int bookId);
	public boolean isEmailInDatabase(String email);
	public User getUser(String userEmailId);
	public int updatePassword(String userPassword,String emailId);
	int updateProfile(User user,int userId);
	int updateApproveStatus(int borroweId);
	public List<BookApproval>viewApprovalList();
	public int updateBookApproveStatus(int borrowedId);
	public int insertImage(Blob profilePicBlob,String emailId);
	public int handleRequestBooks(int userId, int bookId, int count);
	public List<RequestBook> viewRequestedBooks(int userId);
	public List<RequestBookHistory> viewUserRequestedBook();
	public List<RequestBook> getRequestedBookById(int userId);
	public int insertHandleReserve(int userId,int bookId);
	//----------------------------------
	public List<ReserveBook> getReserveBookByUserId(int userId);
	public List<ReserveBook> viewUserReservedBook();
}
