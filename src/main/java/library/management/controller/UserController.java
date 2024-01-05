package library.management.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import library.management.entities.User;
import library.management.repositories.UserDAO;

@Controller
@RequestMapping("/User")

public class UserController {
	@Autowired
	UserDAO userDAO;
	
	@GetMapping("/handle-view-user")
	public String handleViewUser(
			Model model
			) {
			List<User> list = userDAO.viewUser();
			model.addAttribute("userList",list);
			return "ViewUser";
	}
	
	
}
