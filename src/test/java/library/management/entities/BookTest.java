package library.management.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.SQLException;
import java.sql.Date;

import javax.sql.rowset.serial.SerialBlob;

import org.junit.jupiter.api.Test;

class BookTest {

    @Test
    void testBookEntity() throws SQLException, IOException {
        // Create a byte array for testing Blob
        byte[] bookCoverBytes = "MockedBookCover".getBytes();
        Blob mockBookCover = new SerialBlob(bookCoverBytes);

        // Create a Book object for testing
        Book book = new Book(1, "Test Book", 20, "Fiction", "Publisher", 1, 50,
                Date.valueOf("2022-01-01"), "Author", true, mockBookCover);

        // Test getters
        assertEquals(1, book.getBookId());
        assertEquals("Test Book", book.getBookName());
        assertEquals(20, book.getBookPrice());
        assertEquals("Fiction", book.getBookGenre());
        assertEquals("Publisher", book.getBookPublication());
        assertEquals(1, book.getBookEdition());
        assertEquals(50, book.getBookQuantity());
        assertEquals(Date.valueOf("2022-01-01"), book.getBookPublishDate());
        assertEquals("Author", book.getAuthorName());
        assertEquals(true, book.isBookStatus());
        assertNotNull(book.getBookCover());

        // Test toString method
        assertNotNull(book.toString());

        // Verify Blob interactions
        InputStream bookCoverStream = book.getBookCover().getBinaryStream();
        byte[] retrievedBytes = new byte[bookCoverStream.available()];
        bookCoverStream.read(retrievedBytes);
        assertEquals("MockedBookCover", new String(retrievedBytes));
    }
}
