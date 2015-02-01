package demo;

import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.http.HttpStatus;

@ResponseStatus(value=HttpStatus.BAD_REQUEST, reason="COB Date Format is not valid") 
public class CobFormatException extends RuntimeException
{
	private static final long serialVersionUID = 1L;

	public CobFormatException(String msg) {
		super(msg);
	}

}
