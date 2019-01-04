package cn.gov.zyczs.cspt.action;


import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsValid;
import cn.gov.zyczs.cspt.dao.ICompanyDao;
import cn.gov.zyczs.cspt.dao.IFreezeDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IRoleDao;
import cn.gov.zyczs.cspt.dao.IUserDao;
import cn.gov.zyczs.cspt.dao.impl.UserDao;
import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Menu;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.Role;
import cn.gov.zyczs.cspt.po.User;
import com.opensymphony.xwork2.ModelDriven;


public class UserAction extends BaseAction implements ModelDriven<User> {
	private static final long serialVersionUID = 1L;
	
	User form = new User();
	public User getModel() {
		return form;
	}
	private IUserDao userDao;
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}
	private IOrgDao orgDao;
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	private ICompanyDao companyDao;
	public void setCompanyDao(ICompanyDao companyDao) {
		this.companyDao = companyDao;
	}
	private IFreezeDao freezeDao;
	public void setFreezeDao(IFreezeDao freezeDao) {
		this.freezeDao = freezeDao;
	}

	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}

	private IRoleDao roleDao;
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}


	/**
	 * 用户登录
	 * @Title: login
	 *
	 */
	public String login() {
		String authcode = (String) getSession().getAttribute("AUTH_CODE");
		if (authcode == null || "".equals(authcode)) {
			form.setReturninfo("验证码不正确");
			form.setReturncode(0);
			return SUCCESS;
		}
		if (form.getAuthcode() != null&& form.getAuthcode().toUpperCase().equals(authcode.toUpperCase())) {
			System.out.println(form.getLoginname());
			System.out.println(form.getLoginpass());
			User user = userDao.login(form);
			if (user != null) {
				if(!user.getLoginpass().equals(form.getLoginpass())){
					form.setReturninfo("密码不正确！");
					form.setReturncode(0);
					return SUCCESS;
				}
				if(user.getUsertype()==2){
					Org org = new Org();
					org.setOrgid(user.getOrgid());
					org = orgDao.findById(org);
					if(org==null||org.getCpccorp()==null||org.getOrgname()==null){
						form.setReturninfo("用户名或密码不正确！");
						form.setReturncode(0);
						return SUCCESS;
					}
					Freeze freeze= new Freeze();
					freeze.setCpccode(org.getCpccorp());
					freeze = freezeDao.findByExist(freeze);
					if(freeze!=null){
						form.setReturninfo("用户企业被锁定！");
						form.setReturncode(0);
						return SUCCESS;
					}
					user.setOrg(org);
					Company company = new Company();
					company.setCpccorp(user.getOrg().getSupercpccode());
					company = companyDao.findByCpccorp(company);
					if(company==null||company.getCompanyid()==null||company.getCorpname()==null){
						form.setReturninfo("用户名或密码不正确！");
						form.setReturncode(0);
						return SUCCESS;
					}
					user.setCompany(company);
				}
				getSession().setAttribute("User", user);
				
				String single_login=ServletActionContext.getServletContext().getInitParameter("single_login");
				if(single_login.equals("1")){
					SessionListener.isLogined(getSession(), form.getLoginname());
				}
				form.setReturncode(1);
				return SUCCESS;
			} else {
				form.setReturninfo("用户名或密码不正确！");
				form.setReturncode(0);
				return SUCCESS;
			}
		} else {
			form.setReturninfo("验证码不正确！");
			form.setReturncode(0);
			return SUCCESS;
		}
	}

	/**
	 * 用户登录后判断权限
	 * @Title: logined 
	 * 药材种植平台-10000000,药材经销商-01000000,饮片生产-00100000,饮片经销商-00010000,市场-00001000,医院-00000100,管理机构-00000010,其他-00000001
	 */
	public String logined(){
		User user = (User) getSession().getAttribute("User");
						
		/******************/
		if(user.getUsertype()==0){
			saveOpLog(user, 7,"用户登录","");
			return "government";
		}else{
			List<Menu> menulist =userDao.findRoleMenu(user);
			List<Menu> menus = new ArrayList<Menu>();
			
			if(user.getOrg().getZyctype().equals("00010000")){
				if(menulist == null || menulist.size() == 0){
					form.setReturninfo("该用户没有权限!");
					return "error";
				}else{
					for(Menu menu : menulist){
						if(menu.getMenusys() == 3){
							menus.add(menu);
						}
					}
					form.setMenulist(menus);
					saveOpLog(user, 5,"用户登录","");
					return "tabletsell";
				}
			}
			
			if(menulist != null && menulist.size() > 0){
				form.setMenulist(userDao.findRoleMenu(user));
			}else{
				form.setReturninfo("该用户没有权限!");
				return "error";
			}
		}
		
		if(user.getOrg().getZyctype().equals("10000000")){
			saveOpLog(user, 1,"用户登录","");
			return "med";
		}else if(user.getOrg().getZyctype().equals("01000000")){
			saveOpLog(user, 2,"用户登录","");
			return "medsell";
		}else if(user.getOrg().getZyctype().equals("00100000")){
			saveOpLog(user, 4,"用户登录","");
			return "tablet";
		}else if(user.getOrg().getZyctype().equals("00001000")){
			saveOpLog(user, 3,"用户登录","");
			return "market";
		}else if(user.getOrg().getZyctype().equals("00000100")){
			saveOpLog(user, 6,"用户登录","");
			return "hospital";
		}else if(user.getOrg().getZyctype().equals("00000010")){
			saveOpLog(user, 7,"用户登录","");
			return "government";
		}else if(user.getOrg().getZyctype().equals("00000001")){
			form.setReturninfo("此用户功能暂时未开放!");
			return "error";
		}else{
			return "error";
		}
		
	}
	
	/**
	 * 饮片经销和药材经销平台的切换
	 * @return
	 */
	public String loginedChange(){
		User user = (User) getSession().getAttribute("User");
						
		
		List<Menu> menulist =userDao.findRoleMenu(user);
		List<Menu> menus = new ArrayList<Menu>();
		//0代表从饮片经销切换药材经销  1代表药材经销切换饮片经销
		if(form.getReturncode() == 0){
			for(Menu menu : menulist){
				if(menu.getMenusys() == 1){
					menus.add(menu);
				}
			}
		}else{
			for(Menu menu : menulist){
				if(menu.getMenusys() == 3){
					menus.add(menu);
				}
			}
		}
		
		if(menus != null && menus.size() > 0){
			form.setMenulist(menus);
		}else{
			form.setReturninfo("该用户没有权限!");
			return "error";
		}
		
		
		if(form.getReturncode() == 0){
			form.setReturncode(1);
			return "medsell";
		}else if(form.getReturncode() == 1){
			form.setReturncode(0);
			return "tabletsell";
		}else{
			return "error";
		}
		
	}
	
	
	public void saveOpLog(User user,Integer sysid,String method,String content){
		//记录操作日志
		OpLog opLog=new OpLog();
		opLog.setSysid(sysid);
		opLog.setMethod(method);
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent(content);
		opLogDao.saveOjbect(opLog);
	}
	/**
	 * 用户退出
	 */
	public String logout(){
		User user = (User) getSession().getAttribute("User");
		String zyctype="";
		if(user.getUsertype()==2){
			zyctype=user.getOrg().getZyctype();
		}else{
			zyctype="00000010";
		}
		
		getSession().removeAttribute("User");
		getSession().removeAttribute("comuser");
		
		form.setReturncode(111);
		if(zyctype.equals("10000000")){
			saveOpLog(user, 1,"用户退出","");
			return "medlogout";
		}else if(zyctype.equals("01000000")){
			saveOpLog(user, 2,"用户退出","");
			return "medselllogout";
		}else if(zyctype.equals("00100000")){
			saveOpLog(user, 4,"用户退出","");
			return "tabletlogout";
		}else if(zyctype.equals("00010000")){
			saveOpLog(user, 5,"用户退出","");
			return "tabletselllogout";
		}else if(zyctype.equals("00001000")){
			saveOpLog(user, 3,"用户退出","");
			return "marketlogout";
		}else if(zyctype.equals("00000100")){
			saveOpLog(user, 6,"用户退出","");
			return "hospitallogout";
		}else if(zyctype.equals("00000010")){
			saveOpLog(user, 7,"用户退出","");
			return "governmentlogout";
		}
		return "logout";
	}
		
	/**
	 * 查询用户
	 */
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(userDao.findByCount(form));
		List<User> userlist= userDao.findByList(form);
		if(userlist!=null&&userlist.size()>0){
			for(User u :userlist){
				Org org = new Org();
				org.setOrgid(u.getOrgid());
				u.setOrg(orgDao.findById(org));
			}
		}
		form.setUserlist(userlist);
		return SUCCESS;
	}
	/**
	 * 添加用户初始化
	 */
	public String saveInit(){
		System.out.println("1111"+form.getSupercpccode());
		Org org = new Org();
		org.setOrgid(form.getOrgid());
		form.setOrg(orgDao.findById(org));
		
		Role role = new Role();
		role.setOrgid(form.getOrgid());
		form.setRolelist(roleDao.findByAll(role));
		System.out.println("2222"+form.getSupercpccode());
		return "saveinit";
	}
	/**
	 * 添加用户
	 */
	public String save(){
		User _user = (User) getSession().getAttribute("User");
		List<User> userlist = userDao.findByExist(form);
		if (userlist != null && userlist.size() > 0) {
			form.setReturninfo("用户已存在,请重新添加");
			saveInit();
			return "saveinit";
		}
		form.setUsertype(2);
		Integer userid = userDao.save(form);
		if(userid!=0){
			String[] rolestr = form.getUserrolestr().split(",");
			for(String roleid :rolestr){
				Map useridmap = new HashMap();
				useridmap.put("userid", userid);
				useridmap.put("roleid", roleid);
				roleDao.saveByIdRoleUserOne(useridmap);
			}
			saveOpLog(_user, 7,"新建用户","用户ID:"+userid);
			form.setReturninfo("添加用户成功!");
		}else{
			form.setReturninfo("添加用户失败!");
		}
		return "save";
	}
	/**
	 * 更新用户初始化
	 */
	public String updateInit(){
		form.setUser(userDao.findById(form));
		Org org = new Org();
		org.setOrgid(form.getOrgid());
		form.setOrg(orgDao.findById(org));
		
		Role role = new Role();
		role.setOrgid(form.getOrgid());
		form.setRolelist(roleDao.findByAll(role));
		form.setUserrolelist(roleDao.findByExistUserRole(form.getUserid()));
		
		return "update";
	}
	/**
	 * 更新用户
	 */
	public String update(){
		User _user = (User) getSession().getAttribute("User");
		if(userDao.updateById(form)!=0){
			roleDao.deleteByIdUserRole_userid(form.getUserid());
			String[] rolestr = form.getUserrolestr().split(",");
			for(String roleid :rolestr){
				Map useridmap = new HashMap();
				useridmap.put("userid", form.getUserid());
				useridmap.put("roleid", roleid);
				roleDao.saveByIdRoleUserOne(useridmap);
			}
			form.setReturninfo("更新用户成功!");
			
			saveOpLog(_user, 7,"修改资料","用户ID"+form.getUserid());
			
		}else{
			form.setReturninfo("更新用户失败!");
		}
		updateInit();
		return "update";
	}
	
	/**
	 * 查询个人信息
	 */
	public String findByPerson(){
		return "person";
	}
	/**
	 * 更新个人信息
	 */
	public String updatePerson(){
		List<User> userlist = userDao.findByExist(form);
		if (userlist != null && userlist.size() > 0) {
			form.setReturninfo("用户已存在,请重新添加");
			findByPerson();
			return "person";
		}
		if(userDao.updateById(form)!=0){
			form.setReturninfo("更新用户成功!");
		}else{
			form.setReturninfo("更新用户失败!");
		}
		findByPerson();
		return "person";
	}
	
	///////////市场的刷卡商户信息///////////////
	//获取商户信息
	public String loginComuser(){
		User _user = (User) getSession().getAttribute("User");
		String cpccorp = form.getCpccorp();
		if("".equals(cpccorp) || cpccorp == null){
			form.setReturninfo("0");
			return SUCCESS;
		}
		Org org = new Org();
		org.setCpccorp(cpccorp);
		String supercpccorp = ((Org)orgDao.findByCpccorp(org).get(0)).getSupercpccode();
		Company c = new Company();
		c.setCpccorp(supercpccorp);
		Company company = companyDao.findByCpccorp(c);
		if(company != null && !"".equals(company)){
			
			Org o = new Org();
			o.setSupercpccode(supercpccorp);
			List<Org> orglist = orgDao.findByCpccorp(o);
			
			if(orglist == null || orglist.size() != 1){
				form.setReturninfo("0");
				return SUCCESS;
			}else {
				if(!orglist.get(0).getMarketcode().equals(_user.getCpccorp())){
					form.setReturninfo("0");
					return SUCCESS;
				}
			}
			if(!company.getZyctype().equals("01000000")){
				form.setReturninfo("0");
				return SUCCESS;
			}
			
			User user = new User();
			user.setCpccorp(cpccorp);
			user = userDao.findByCpccorp(user);
			user.setCompany(company);
			user.setOrg(orglist.get(0));
			/*******记录用户的登录时间和ip地址***********/
			user.setIpaddress(this.getRequest().getRemoteAddr());
			user.setLasttime(Tools.getCurrentTime());
			userDao.updateById(user);
			/******************/
			getSession().setAttribute("comuser", user);
		}else{
			form.setReturninfo("0");
		}
		return SUCCESS;
	}
	/**
	 * 清除刷卡使用的参数
	 * @return
	 */
	public String clearFlag(){
		getSession().removeAttribute("flag");
		return SUCCESS;
	}
	
	/**
	 * 更新发卡成功后的数据库记录
	 * @return
	 * @throws IOException 
	 * @throws DocumentException 
	 */
	public String updateSendCard() throws IOException, DocumentException{
		String cpccorp = getRequest().getParameter("cpccorp");
		String orgid = getRequest().getParameter("orgid");
		Org org = new Org();
		org.setOrgid(Integer.valueOf(orgid));
		org = orgDao.findById(org);
		
		Company company = new Company();
		company.setCpccorp(cpccorp);
		company = companyDao.findByCpccorp(company);
		
		String method="";
    	method+="<?xml version=\"1.0\" encoding=\"utf-8\"?>"; 
		method += "<cpc>";
		method += "<operatetype>corpinfo</operatetype>";
		method += "<operatecode>update</operatecode>";
		method += "<operatename>"+ServletActionContext.getServletContext().getInitParameter("operatename")+"</operatename>";
		method += "<operatepwd>"+ServletActionContext.getServletContext().getInitParameter("operatepwd")+"</operatepwd>";
		method += "<operadata>";
		
		method += "<corpcpccode>"+company.getCpccorp()+"</corpcpccode>";
		method += "<zyctype>"+company.getZyctype()+"</zyctype>";
		
		method += "<corpname>"+company.getCorpname()+"</corpname>";
		method += "<corpshortname>"+company.getCorpname()+"</corpshortname>";
		
		method += "<linkman>"+company.getLinkman()+"</linkman>";
		method += "<master>"+company.getMasterman()+"</master>";
		method += "<identitycard>"+company.getIdentitycard()+"</identitycard>";
		
		method += "<orgcode>"+company.getOrgcode()+"</orgcode>";
		method += "<businesscode>"+company.getBusinesscode()+"</businesscode>";		
		method += "<mobile>"+company.getMobile()+"</mobile>";
		method += "<telephone>"+company.getTelephone()+"</telephone>";
		method += "<officephone>"+company.getOfficephone()+"</officephone>";
		method += "<email>"+company.getEmail()+"</email>";
		method += "<postcode>"+company.getPostcode()+"</postcode>";
		
		method += "<gapcode>"+company.getGapcode()+"</gapcode>";
		method += "<gmpcode>"+company.getGmpcode()+"</gmpcode>";
		method += "<gspcode>"+company.getGspcode()+"</gspcode>";
		method += "<sendcard>"+cpccorp+"</sendcard>";
		method += "<marketcode>"+org.getMarketcode()+"</marketcode>";
		method += "<businessnumber></businessnumber>";
		method += "<zscnumber></zscnumber>";
		method += "<area>"+company.getAreacode()+"</area>";
		method += "<registeraddress>"+company.getRegisteraddress()+"</registeraddress>";	
		method += "</operadata>";
		method += "</cpc>";
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			form.setReturninfo("更新失败,请求中央接口超时!");
			return SUCCESS;
		}
		

		System.out.println(method);
		if(xmlstr==null||xmlstr.equals("")){
			form.setReturninfo("更新失败!");
			return SUCCESS;
		}
		String respcode ="";
		String cpccorptemp ="";	
		if(xmlstr!=null&&!xmlstr.equals("")){
			Document document = DocumentHelper.parseText(xmlstr); 
			respcode =document.selectSingleNode("cpc/respcode").getText();
			cpccorptemp =document.selectSingleNode("cpc/operadata/corpcpccode").getText();
			if(respcode==null||!respcode.equals("0000")||cpccorptemp==null||"".equals(cpccorptemp)||cpccorptemp.length()!=14){
				form.setReturninfo("更新失败!");
				return SUCCESS;
			}	
		}
		
		Map< String, Object> map = new ConcurrentHashMap<String, Object>();
		map.put("cpccorp", cpccorp);
		map.put("orgid", orgid);
		Integer resultOrgid = orgDao.updateByMap(map);
		if(resultOrgid > 0 && resultOrgid != null){
			form.setOrgid(resultOrgid); 
			form.setReturninfo("更新成功!");
						
		}else{
			form.setReturninfo("更新失败!");
		}
		
		return SUCCESS;
	}
	
	/**
	 * ajax判断用户名是否注册
	 * @return
	 */
	public String findByExist(){
		List<User> users = new ArrayList<User>();
		users = userDao.findByExist(form);
		if(users.size()>0){
			form.setReturncode(1);
		}else{
			form.setReturncode(0);
		}
		return SUCCESS;
	}
	
	public String findByExist_password(){
		User user = userDao.findById(form);
		if(user.getLoginpass().equals(form.getLoginpass())){
			form.setReturncode(1);
		}else{
			form.setReturncode(0);
		}
		return SUCCESS;
	}
	
	/**
	 * 重置用户密码12345678
	 * @return
	 */
	public String updatePassword(){
		
		form.setLoginpass("12345678");
		Integer result = userDao.updatePassword(form);
		
		if(result > 0){
			form.setReturncode(1);
		}else{
			form.setReturncode(0);
		}
		return SUCCESS;
	}
	
	/*******************除监管平台外所有平台共用的用户管理后台方法************************/
	
	/**
	 * 系统管理中查询该组织下的用户
	 */
	public String findByList_sys(){
		User _user = (User) getSession().getAttribute("User");
		
		form.setCpccorp(_user.getCpccorp());
		form.setOrgid(_user.getOrgid());
		
		form.setPager_openset(10);
		form.setPager_count(userDao.findByCount(form));
		List<User> userlist= userDao.findByList(form);
		if(userlist!=null&&userlist.size()>0){
			for(User u :userlist){
				Org org = new Org();
				org.setOrgid(u.getOrgid());
				u.setOrg(orgDao.findById(org));
			}
		}
		form.setUserlist(userlist);
		return "findByList_sys";
	}
	
	/**
	 * 更新用户初始化
	 */
	public String updateInit_sys(){
		form.setUser(userDao.findById(form));
		Org org = new Org();
		org.setOrgid(form.getOrgid());
		form.setOrg(orgDao.findById(org));
		return "update_sys";
	}
	/**
	 * 更新用户
	 */
	public String update_sys(){
		if(userDao.updateById(form)!=0){
			form.setReturninfo("更新用户成功!");
		}else{
			form.setReturninfo("更新用户失败!");
		}
		updateInit_sys();
		return "update_sys";
	}
	
	/**
	 * 添加用户初始化
	 */
	public String saveInit_sys(){
		Org org = new Org();
		org.setOrgid(form.getOrgid());
		form.setOrg(orgDao.findById(org));
		return "saveinit_sys";
	}
	/**
	 * 添加用户
	 */
	public String save_sys(){
		User _user = (User) getSession().getAttribute("User");
		
		List<User> userlist = userDao.findByExist(form);
		if (userlist != null && userlist.size() > 0) {
			form.setReturninfo("用户已存在,请重新添加");
			saveInit();
			return "saveinit_sys";
		}
		form.setUsertype(2);
		Integer userid=userDao.save(form);
		if(userid!=0){			
			saveOpLog(_user, 7,"新建用户","用户ID:"+userid);
			
			form.setReturninfo("添加用户成功!");
		}else{
			form.setReturninfo("添加用户失败!");
		}
		return "save_sys";
	}
	/**
	 * 根据cpc和partion查询已经存在的coordinate
	 * @return
	 */
	public String findParAndCoor(){
		form.setUserlist(userDao.findParAndCoor(form));
		return SUCCESS;
	}
}
