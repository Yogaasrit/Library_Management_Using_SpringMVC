package library.management.repositories;

import java.sql.Date;
import java.util.List;

import library.management.entities.Book;
import library.management.entities.PurchasedBook;
import library.management.entities.User;

public interface UserDAO {
	public int userRegister(String userName, String userEmailId, String userPassword);
	public List<User> userLogin(String userEmailId, String userPassword);
	public List<User> viewUser();
	public int addBooks(Book book);
	public int placeOrder(int userId,int bookId,int bookCount,Date orderDate);
	public List<PurchasedBook> viewPurchasedBooks(int userId); 
}
