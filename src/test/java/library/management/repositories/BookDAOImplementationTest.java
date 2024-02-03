package library.management.repositories;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.sql.Date;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import library.management.entities.Book;
import library.management.repositories.BookDAO;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import library.management.entities.FeedBack;
import library.management.repositories.BookDAO;

public class BookDAOImplementationTest {

	@Test
    public void testUpdateBookCount() {
        // Arrange
        JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
        BookDAOImplementation bookDAO = new BookDAOImplementation();
        bookDAO.setJdbcTemplate(jdbcTemplate);

        // Mocking behavior
        when(jdbcTemplate.update(any(String.class), any(Integer.class), any(Integer.class))).thenReturn(1);

        // Act
        int result = bookDAO.updateBookCount(5, 1);

        // Assert
        assertEquals(1, result);

        // Verify that the update method was called with the correct parameters
        verify(jdbcTemplate).update(any(String.class), any(Integer.class), any(Integer.class));
    }
	
	
	
	 @Test
	    public void testGetBookFeedback() throws SQLException {
	        // Arrange
	        JdbcTemplate jdbcTemplate = mock(JdbcTemplate.class);
	        BookDAOImplementation bookDAO = new BookDAOImplementation();
	        bookDAO.setJdbcTemplate(jdbcTemplate);

	        // Mocking behavior for the query method
	        when(jdbcTemplate.query(any(String.class), any(RowMapper.class), any(Integer.class)))
	                .thenReturn(createMockFeedbackList());

	        // Act
	        List<FeedBack> feedbackList = bookDAO.getBookFeedback(1);

	        // Assert
	        assertEquals(2, feedbackList.size()); // Assuming you expect two feedback items

	        // You can further assert the contents of the feedbackList if needed

	        // Verify that the query method was called with the correct parameters
	        when(jdbcTemplate.query(any(String.class), any(RowMapper.class), any(Integer.class)));
	    }

	    private List<FeedBack> createMockFeedbackList() {
	        List<FeedBack> feedbackList = new ArrayList<>();
	        feedbackList.add(new FeedBack(5, "Excellent"));
	        feedbackList.add(new FeedBack(4, "Good"));
	        return feedbackList;
	    }
}

