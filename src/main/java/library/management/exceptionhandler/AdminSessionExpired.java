package library.management.exceptionhandler;

public class AdminSessionExpired extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public AdminSessionExpired() {
		super();
		
	}

	public AdminSessionExpired(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
		
	}

	public AdminSessionExpired(String message, Throwable cause) {
		super(message, cause);
		
	}

	public AdminSessionExpired(String message) {
		super(message);
		
	}

	public AdminSessionExpired(Throwable cause) {
		super(cause);
		
	}
}
