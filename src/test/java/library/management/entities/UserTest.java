package library.management.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;

import java.sql.Blob;
import java.sql.Date;

import org.junit.jupiter.api.Test;
import static org.mockito.Mockito.when;

class UserTest {

    @Test
    void testUserEntity() {
        // Create a mock Blob for testing
        Blob mockProfilePic = mock(Blob.class);
        when(mockProfilePic.toString()).thenReturn("MockedBlob");

        // Create a User object
        User user = new User(1, "user@example.com", "UserName", "1234567890",
                Date.valueOf("1990-01-01"), "Address", "Male", "Password", mockProfilePic);

        // Test getters
        assertEquals(1, user.getUserId());
        assertEquals("user@example.com", user.getUserEmailId());
        assertEquals("UserName", user.getUserName());
        assertEquals("1234567890", user.getPhoneNo());
        assertEquals(Date.valueOf("1990-01-01"), user.getDob());
        assertEquals("Address", user.getAddress());
        assertEquals("Male", user.getGender());
        assertEquals("Password", user.getUserPassword());
        assertNotNull(user.getProfilePic());

        // Test toString method
        assertNotNull(user.toString());
        assertEquals("User [userId=1, userEmailId=user@example.com, userName=UserName, phoneNo=1234567890, dob=1990-01-01, address=Address, gender=Male, userPassword=Password]",
                user.toString());

        // Verify mock interactions
        assertNotNull(user.getProfilePic());
        assertEquals("MockedBlob", user.getProfilePic().toString());
    }
}
