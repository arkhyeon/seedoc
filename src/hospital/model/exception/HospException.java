package hospital.model.exception;

public class HospException extends RuntimeException {

	public HospException() {
		super();
	}

	public HospException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public HospException(String message, Throwable cause) {
		super(message, cause);
	}

	public HospException(String message) {
		super(message);
	}

	public HospException(Throwable cause) {
		super(cause);
	}
	
}
