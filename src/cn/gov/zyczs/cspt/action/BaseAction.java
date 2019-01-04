package cn.gov.zyczs.cspt.action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport {
	public HttpSession getSession() {
		getRequest().getSession().setMaxInactiveInterval(3600);
		return getRequest().getSession();
	}
	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}
	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}
	public ServletContext getServletContext() {
		return ServletActionContext.getServletContext();
	}
}
