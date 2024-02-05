package library.management.exceptionhandler;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class CentralizedException {
	
	
	@ExceptionHandler(value=UserSessionExpired.class)
	public String UserSessionExceptionHandler(Model model)
	{
		model.addAttribute("SessionMessage", "User Session Expired, Login Again to Continue");
		return "UserLogin";
	}
	
	@ExceptionHandler(value=AdminSessionExpired.class)
	public String AdminSessionExceptionHandler(Model model)
	{
		model.addAttribute("SessionMessage", "Admin Session Expired, Login Again to Continue");
		return "AdminLogin";
	}
	
	@ExceptionHandler(value=NullPointerException.class)
    public String NullPointerExceptionClass(Model model)
    {
    	model.addAttribute("SessionMessage", "Some exception occured. Contact Admin");
    	return "ExceptionPage";
    }
	
    @ExceptionHandler(value=Exception.class)
    public String ExceptionClass(Model model)
    {
    	model.addAttribute("SessionMessage", "Some exception occured. Contact Admin");
    	return "ExceptionPage";
    }
    
    

}
