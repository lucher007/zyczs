package cn.gov.zyczs.cspt.common;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginFilter implements Filter {
    
    public void destroy() {
    }
    
    public void init(FilterConfig arg0) throws ServletException {
    }
    
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain fc) throws IOException,
            ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        req.setCharacterEncoding("utf-8");
        if (req.getSession() == null || req.getSession().getAttribute("User") == null) {
        	res.sendRedirect(req.getContextPath()+"/login.jsp");
        }
        fc.doFilter(request, response);
    }
}
