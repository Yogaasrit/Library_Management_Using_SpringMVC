package library.management.controller;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.ui.Model;

import library.management.entities.UpcomingEvent;
import library.management.repositories.UserDAO;

import java.util.Arrays;
import java.util.List;

import static org.mockito.Mockito.*;

public class LibraryControllerTest {

    @InjectMocks
    private LibraryController welcomeController;

    @Mock
    private UserDAO userDAO;

    @Mock
    private Model model;

	@Test
    public void testShowWelcomePage() {
        // Arrange
        MockitoAnnotations.initMocks(this);

        UpcomingEvent event1 = new UpcomingEvent();
        UpcomingEvent event2 = new UpcomingEvent();
        List<UpcomingEvent> mockEventList = Arrays.asList(event1, event2);
        when(userDAO.getUpComingEvent()).thenReturn(mockEventList);

        // Act
        String result = welcomeController.showWelcomePage(model);

        // Assert
        assertEquals("WelcomePage", result);

        // Verify that the expected methods were called
        verify(userDAO, times(1)).getUpComingEvent();
        verify(model, times(1)).addAttribute(eq("list"), eq(mockEventList));
    }
}
