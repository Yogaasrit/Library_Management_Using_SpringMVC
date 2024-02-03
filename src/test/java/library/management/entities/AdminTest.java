package library.management.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;

class AdminTest {

    @Test
    void testAdminEntity() {
        // Create an Admin object
        Admin admin = new Admin("admin@example.com", "AdminName", "AdminPassword");

        // Test getters
        assertEquals("admin@example.com", admin.getAdminEmailId());
        assertEquals("AdminName", admin.getAdminName());
        assertEquals("AdminPassword", admin.getAdminPassword());

        // Test setters
        admin.setAdminEmailId("newadmin@example.com");
        admin.setAdminName("NewAdminName");
        admin.setAdminPassword("NewAdminPassword");

        assertEquals("newadmin@example.com", admin.getAdminEmailId());
        assertEquals("NewAdminName", admin.getAdminName());
        assertEquals("NewAdminPassword", admin.getAdminPassword());

        // Test toString method
        assertNotNull(admin.toString());
    }
}

