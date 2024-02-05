package library.management.utilities;


import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailSender {

	public void sendEmail(String recipientEmail,String OTP) {

		final String username = "apjabdulkalamlibrary15@gmail.com"; // Your email
		final String password = "veqdriezruqlfzyr"; // Your password

		Properties props = new Properties();
		 	props.put("mail.smtp.auth", "true");// Simple mail
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", "smtp.gmail.com"); // Gmail's SMTP host name
	        props.put("mail.smtp.port", "587"); // Gmail's SMTP port

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
			message.setSubject("Verification Email");
			message.setText("Dear User," + "\n\n Please Enter the OTP to verify your email."
					+ "Your one time password id : " + OTP);

			Transport.send(message);

			System.out.println("Email sent successfully!");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	public void sendRejectResponse(String recipientEmail,String rejectMessage,String borrowedId, String bookName) {

		final String username = "apjabdulkalamlibrary15@gmail.com"; // Your email
		final String password = "veqdriezruqlfzyr"; // Your password

		Properties props = new Properties();
		 props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", "smtp.gmail.com"); // Gmail's SMTP host
	        props.put("mail.smtp.port", "587"); // Gmail's SMTP port

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
			message.setSubject("Reason for rejection of book " + bookName);
			message.setText("Borrowed ID" + borrowedId + "\n" + rejectMessage);

			Transport.send(message);

			System.out.println("Email sent successfully!");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}


	public void sendRemainder(String emailId, int borrowedId, String bookName) {
		final String username = "apjabdulkalamlibrary15@gmail.com"; // Your email
		final String password = "veqdriezruqlfzyr"; // Your password

		Properties props = new Properties();
		 props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", "smtp.gmail.com"); // Gmail's SMTP host
	        props.put("mail.smtp.port", "587"); // Gmail's SMTP port

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailId));
			message.setSubject("Remainder for book Return: " + bookName);
			
			message.setText("Dear user,\r\n"
					+ "\r\n"
					+ "We hope this message finds you well. This is a friendly reminder regarding the library book with the following details:\r\n"
					+ "\r\n"
					+ "Book Title: "+bookName+"\r\n"
					+ "Borrowed ID: "+borrowedId+"\r\n"
					+ "The due date for returning the book is approaching, "
					+ "and we kindly request you to return it to the library on or "
					+ "before the specified due date."
					+ "Failure to return the book by the due date may result in late fees."
					+ "Thank you for your cooperation, and we appreciate your prompt attention to this matter.\r\n"
					+ "\r\n"
					+ "Best regards,\r\n"
					+ "Admin \r\n"
					+ "APJ Abdul Kalam Library");

			Transport.send(message);

			System.out.println("Email sent successfully!");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}		
	}
	
	
	

}