package demo;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class ExceptionController
{
	@ResponseStatus(value=HttpStatus.BAD_REQUEST)
    @ExceptionHandler(Exception.class)
	@ResponseBody
	Exception handle(HttpServletRequest req, Exception exception)
	{
        return exception;
	}
}