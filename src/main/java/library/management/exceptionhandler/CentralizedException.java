//package library.management.exceptionhandler;
//
//import org.springframework.dao.DataIntegrityViolationException;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//
//@ControllerAdvice
//public class CentralizedException {
//	
//	
//	@ExceptionHandler(value=UserSessionExpired.class)
//	public String UserSessionExceptionHandler(Model model)
//	{
//		model.addAttribute("message", "User Session Expired, Login Again to Continue");
//		return "login_user";
//	}
//	
//	@ExceptionHandler(value=AdminSessionExpired.class)
//	public String AdminSessionExceptionHandler(Model model)
//	{
//		model.addAttribute("message", "Admin Session Expired, Login Again to Continue");
//		return "login_admin";
//	}
//	
//    @ExceptionHandler(value=Exception.class)
//    public String ExceptionClass(Model model)
//    {
//    	model.addAttribute("message", "Some exception occured. Contact Admin");
//    	return "exception-message";
//    }
//
//}
