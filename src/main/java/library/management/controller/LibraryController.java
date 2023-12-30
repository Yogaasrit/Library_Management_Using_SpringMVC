package library.management.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import library.management.entities.Admin;
import library.management.entities.User;
import library.management.repositories.AdminLoginDAO;
import library.management.repositories.UserDAO;

@Controller
public class LibraryController {
	@Autowired
	AdminLoginDAO adminLoginDAO;
	@Autowired
	UserDAO userDAO;
	
	@GetMapping("/")
	public String showWelcomePage() {
		return "WelcomePage";
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
	
	@PostMapping("/handle-register")
	public String showUserRegisterPage(
			@RequestParam("emailId") String emailId,
			@RequestParam("userName") String userName,
			@RequestParam("passWord") String passWord
			) {
			int result = userDAO.userRegister(userName, emailId, passWord);
			if(result == 1) {
				return "UserLogin";
			}else {
				return "UserRegister";
			}		
	}
	
	@PostMapping("/validate-admin")
	public String showAdminDashboard(
			@RequestParam("adminEmailId") String adminEmailId,
			@RequestParam("adminPassword") String adminPassword,
			HttpServletRequest request
			) {		
			// Creating admin session
			HttpSession session = request.getSession();
			Admin admin = new Admin();
			// Checking if list is empty,
			// if empty, then no record is fetched,
			// then, admin details is incorrect.
			if(adminLoginDAO.validateAdmin(adminEmailId, adminPassword).isEmpty()) {
				System.out.println("NO user found!");			
				return "AdminLogin";
			}
			// If not null, validated,
			// Dashboard page is shown to admin
			else {
				admin = adminLoginDAO.validateAdmin(adminEmailId, adminPassword).get(0);
				session.setAttribute("adminSession", admin);
				return "AdminDashboard";
			}
	}
	
	@PostMapping("/validate-user")
	public String showUserDashboard(
			@RequestParam("emailId") String userEmailId,
			@RequestParam("passWord") String userPassword,
			HttpServletRequest request
			) {
			HttpSession session = request.getSession();
			User user;
			if(userDAO.userLogin(userEmailId, userPassword).isEmpty()) {
				System.out.println("Invalid Id");
				return "UserLogin";
			}
			else {
				user = userDAO.userLogin(userEmailId, userPassword).get(0);
				return "UserDashboard";
			}
	}
}
