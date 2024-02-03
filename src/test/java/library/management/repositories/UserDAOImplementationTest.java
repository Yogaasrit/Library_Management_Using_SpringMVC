package library.management.repositories;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.sql.Blob;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import library.management.entities.Book;
import library.management.entities.User;

public class UserDAOImplementationTest {

	@Test
    public void testUserLogin() throws SQLException {
        // Arrange
        JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
        UserDAOImplementation userDAO = new UserDAOImplementation();
        userDAO.setJdbcTemplate(jdbcTemplate);

        String userEmailId = "user@example.com";
        String userPassword = "password";

        // Create a list of users to return as a result
        List<User> expectedResult = new ArrayList<>();
        expectedResult.add(new User(/* user details here */));

        // Mocking behavior
        when(jdbcTemplate.query(any(String.class), any(UserLoginRowMapper.class), any(Object.class), any(Object.class)))
                .thenReturn(expectedResult);

        // Act
        List<User> result = userDAO.userLogin(userEmailId, userPassword);

        // Assert
        assertEquals(expectedResult, result);
        // Verify that the query method was called with the correct parameters
        verify(jdbcTemplate).query(any(String.class), any(UserLoginRowMapper.class), any(Object.class), any(Object.class));
    }

    // Additional test for RowMapper
    @Test
    public void testUserLoginRowMapper() throws SQLException {
        // Arrange
        ResultSet resultSet = mock(ResultSet.class);
        when(resultSet.getInt("userId")).thenReturn(1);
        when(resultSet.getString("userEmailId")).thenReturn("user@example.com");
        when(resultSet.getString("userPassword")).thenReturn("password");
        when(resultSet.getString("userName")).thenReturn("John Doe");

        UserLoginRowMapper rowMapper = new UserLoginRowMapper();

        // Act
        User user = rowMapper.mapRow(resultSet, 1);

        // Assert
        assertEquals(1, user.getUserId());
        assertEquals("user@example.com", user.getUserEmailId());
        assertEquals("password", user.getUserPassword());
        assertEquals("John Doe", user.getUserName());
    }
    
    
}
