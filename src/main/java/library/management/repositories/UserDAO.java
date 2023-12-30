package library.management.repositories;

import java.util.List;
import library.management.entities.User;

public interface UserDAO {
	public int userRegister(String userName, String userEmailId, String userPassword);
	public List<User> userLogin(String userEmailId, String userPassword);
	public List<User> viewUser();
}
