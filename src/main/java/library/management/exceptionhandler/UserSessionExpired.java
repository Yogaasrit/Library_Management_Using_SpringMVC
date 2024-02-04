package library.management.exceptionhandler;

public class UserSessionExpired extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public UserSessionExpired() {
		super();
	}

	public UserSessionExpired(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public UserSessionExpired(String message, Throwable cause) {
		super(message, cause);
	}

	public UserSessionExpired(String message) {
		super(message);
	}

	public UserSessionExpired(Throwable cause) {
		super(cause);
	}
	
	

}
