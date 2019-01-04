package cn.gov.zyczs.cspt.common;

import java.util.Map;

import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class LoginInterceptor extends MethodFilterInterceptor {

	public String doIntercept(ActionInvocation invocation) throws Exception {
		ActionContext ac = invocation.getInvocationContext();
		
		Map<String, Object> map=invocation.getInvocationContext().getParameters();
		System.out.println(map.size()+"========================");
		
		for(String str:map.keySet()){
			/*
			 * prodcontent为tablet
			 * harvestmedwei为plant
			 * checkthickmethod,othervalue为check
			 * packstr,leftmedweight为药材分包
			 * datastr为药材出库
			 * assistStr 为辅料
			 * processflow工艺流程
			 * chkid饮片品名管理
			 * email用户电子邮箱
			 * strList溯源称配置
			 * useriddel useridadd 角色用户管理 menustr menustrchild 角色菜单管理 userrolestr添加用户角色
			 */
			if("prodcontent".equals(str)||"harvestmedwei".equals(str)||"checkthickmethod".equals(str)||"othervalue".equals(str)||"packstr".equalsIgnoreCase(str)||"datastr".equals(str) || "coordinate".equals(str) || "partion".equals(str) || "gapcode".equals(str) || "gspcode".equals(str) || "gmpcode".equals(str) || "orgcode".equals(str) || "indexusername".equals(str)){
				continue;
			}
			if("assistStr".equals(str)||"processflow".equals(str)||"chkid".equals(str)||"email".equals(str) || "uploadids".equals(str) || "fertilizername".equals(str) || "pesticidename".equals(str) || "fieldcarename".equals(str) || "printcol".equals(str)  || "businesscode".equals(str) || "identitycard".equals(str) || "startindexweekdate".equals(str) || "endindexweekdate".equals(str)){
				continue;
			}
			//所有图片
			if("cpcplantimg".equals(str)||"cpctabletimg".equals(str)||"matcontent".equals(str)){
				continue;
			}
			//溯源称
			if(str.indexOf("strList")!=-1 || str.indexOf("strId")!=-1 || str.indexOf("scaleList")!=-1||str.indexOf("codeList")!=-1||str.indexOf("groupInfo")!=-1||str.indexOf("boxcodes")!=-1||str.indexOf("inOutStorList")!=-1){
				continue;
			}
			//角色用户管理
			if(str.indexOf("useriddel")!=-1||str.indexOf("useridadd")!=-1||str.indexOf("menustr")!=-1||str.indexOf("menustrchild")!=-1||str.indexOf("userrolestr")!=-1){
				continue;
			}
			if(ToolsValid.checkquotmarks(map.get(str))){
				System.out.println("--------"+str);
				return "charerror";
			}
		}
		
		
		Map session = ac.getSession();
		User _user = (User) session.get("User");
		if(_user!=null){
			String sul= invocation.invoke();
			return sul;
		}else{
			return "nologin";
		}
	}

}
