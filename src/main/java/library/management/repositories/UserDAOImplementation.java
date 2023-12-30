package library.management.repositories;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import library.management.entities.User;

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
	public int userRegister(String userName, String userEmailId, String userPassword) {
		String userRegisterQuery = "INSERT INTO user (userName, userEmailId, userPassword) VALUES (?,?,?)";
		return jdbcTemplate.update(userRegisterQuery,userName,userEmailId,userPassword);
	}

	@Override
	public List<User> userLogin(String userEmailId, String userPassword) {
		String userLoginQuery = "SELECT * FROM user WHERE userEmailId = ? and userPassword = ?";
		return jdbcTemplate.query(userLoginQuery, new UserLoginRowMapper(),userEmailId,userPassword);
	}

	@Override
	public List<User> viewUser() {
		String viewUserQuery = "SELECT * FROM user";
		return jdbcTemplate.query(viewUserQuery, new ViewUserRowMapper());
	}

}
