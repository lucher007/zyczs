package cn.gov.zyczs.cspt.common;

import com.opensymphony.xwork2.ActionInvocation;

public class ExceptionHandler extends RuntimeException {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String message;
	
	public ExceptionHandler(String message) {
		super(message);
		this.message = message;
	}

}
