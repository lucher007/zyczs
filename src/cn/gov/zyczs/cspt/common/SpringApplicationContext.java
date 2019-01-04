package cn.gov.zyczs.cspt.common;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

public class SpringApplicationContext {
	private static Logger logger = Logger
			.getLogger(SpringApplicationContext.class);

	private static SpringApplicationContext instance = null;

	private SpringApplicationContext() {
		super();
	}

	public static SpringApplicationContext getInstance() {
		if (instance == null) {
			return new SpringApplicationContext();
		} else {
			return instance;
		}
	}

	public Object getSessionFactory() {
		ApplicationContext appContext = WebApplicationContextUtils
				.getWebApplicationContext(flex.messaging.FlexContext
						.getServletConfig().getServletContext());
		return appContext.getBean("sqlMapClient");
	}
}
