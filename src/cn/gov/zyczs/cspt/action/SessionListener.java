package cn.gov.zyczs.cspt.action;

import java.util.Hashtable;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cn.gov.zyczs.cspt.po.User;

public class SessionListener implements HttpSessionListener {

	private static Hashtable hUserName = new Hashtable();

	public void sessionCreated(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
		System.out.println("已创建新用户session -- " + arg0);
	}

	public void sessionDestroyed(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub

		if (arg0.getSession().getAttribute("User") != null) {
			User user = (User) arg0.getSession().getAttribute(
					"User");
			String sUserName=user.getLoginname();
			deleteUserName(arg0.getSession(), sUserName);
		}
		hUserName.remove(arg0.getSession());
		System.out.println("删除用户session -- " + arg0);
	}

	public synchronized static boolean deleteUserName(HttpSession session,
			String sUserName) {
		System.out.println("删除用户 - " + sUserName + " || session - " + session);
		hUserName.remove(sUserName); // 删除用户
		return true;
	}

	public synchronized static boolean isLogined(HttpSession session,
			String sUserName) {
		boolean flag = false;
		if (hUserName.containsKey(sUserName)) {
			flag = true;
			HttpSession vsession = (HttpSession) hUserName.get(sUserName);
			try {
				vsession.invalidate();
				System.out.println("用户 - " + sUserName + " || session 已存在 - "
						+ session);
				System.out.println("已设置 - " + sUserName + " || session 失效并移除");
			} catch (Exception ex) {
			}
		} else {
			flag = false;

		}
		hUserName.remove(sUserName);
		hUserName.put(sUserName, session);
		System.out.println("创建用户 - " + sUserName + " || session - " + session);

		return flag;
	}

	public synchronized static boolean isOnline(HttpSession session,
			String sUserName) {
		boolean flag = false;
		HttpSession vsession = null;
		try {
			vsession = (HttpSession) hUserName.get(sUserName);
		} catch (Exception e) {

		}
		if (vsession != null) {
			if (session.getId().equals(vsession.getId())) {
				flag = true;
			} else {
				flag = false;
			}
		}
		return flag;

	}
}
