package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Company.java
 * @Package com.po
 * @version 1.0 
 * 用户表
 */
public class User implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer userid; 	//用户序列号
	private String loginname;	//登录用户名,长度1-50
	private String loginpass;	//登录密码,长度6-50
	private Integer orgid;		//组织编码
	private String addtime;		//添加时间
	private Integer state;		//状态,0-禁用,1-可用
	private Integer usertype;	//用户类型,0超级管理员,1企业管理员,2操作人员
	private String auth;		//用户权限
	private String username; 	//用户姓名
	private String cpccorp;		//企业编码(14位)
	private User user;			//用户类
	private List<User> userlist;//用户列表
	
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	
	private int returncode;		//登录返回状态0成功，1失败
	private String authcode;	//验证码
	private Company company;	//企业类
	private Org org;			//组织类
	private String lasttime;//登录时间
	private String ipaddress;//登录ip
	
	private List<Role> rolelist;//用户角色
	private String userrolestr; //用户角色集
	private List<UserRole> userrolelist;//用户已经有的角色
	private List<Menu> menulist;//菜单
	private String partion;//市场内商铺所在的市场分区
	private String coordinate;//市场内的商铺所在市场的具体位置用坐标表示
	private String areafloor;
	private String orgname;//商铺名称
	private Integer cstate;//称的状态
	private Integer opertype;//企业点击用户管理0,组织点击用户管理1
	private String supercpccode;
	private List<Org> orglist;  
	
	public List<Org> getOrglist() {
		return orglist;
	}
	public void setOrglist(List<Org> orglist) {
		this.orglist = orglist;
	}
	public Integer getOpertype() {
		return opertype;
	}
	public void setOpertype(Integer opertype) {
		this.opertype = opertype;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getPartion() {
		return partion;
	}
	public void setPartion(String partion) {
		this.partion = partion;
	}
	public String getCoordinate() {
		return coordinate;
	}
	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}
	public String getLasttime() {
		return lasttime;
	}
	public void setLasttime(String lasttime) {
		this.lasttime = lasttime;
	}
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getLoginpass() {
		
		return loginpass;
	}
	public void setLoginpass(String loginpass) {
		this.loginpass = loginpass;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getAddtime() {
		if(addtime==null||addtime.length()<10){
			addtime=null;
		}else{
			addtime=addtime.substring(0,10);
		}
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getUsertype() {
		return usertype;
	}
	public void setUsertype(Integer usertype) {
		this.usertype = usertype;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<User> getUserlist() {
		return userlist;
	}
	public void setUserlist(List<User> userlist) {
		this.userlist = userlist;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public int getPager_count() {
		return pager_count;
	}
	public void setPager_count(int pagerCount) {
		pager_count = pagerCount;
	}
	public int getPager_offset() {
		return pager_offset;
	}
	public void setPager_offset(int pagerOffset) {
		pager_offset = pagerOffset;
	}
	public int getPager_openset() {
		return pager_openset;
	}
	public void setPager_openset(int pagerOpenset) {
		pager_openset = pagerOpenset;
	}
	public int getReturncode() {
		return returncode;
	}
	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}
	public String getAuthcode() {
		return authcode;
	}
	public void setAuthcode(String authcode) {
		this.authcode = authcode;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public List<Role> getRolelist() {
		return rolelist;
	}
	public void setRolelist(List<Role> rolelist) {
		this.rolelist = rolelist;
	}
	public String getUserrolestr() {
		return userrolestr;
	}
	public void setUserrolestr(String userrolestr) {
		this.userrolestr = userrolestr;
	}
	public List<UserRole> getUserrolelist() {
		return userrolelist;
	}
	public void setUserrolelist(List<UserRole> userrolelist) {
		this.userrolelist = userrolelist;
	}
	public List<Menu> getMenulist() {
		return menulist;
	}
	public void setMenulist(List<Menu> menulist) {
		this.menulist = menulist;
	}
	public String getAreafloor() {
		return areafloor;
	}
	public void setAreafloor(String areafloor) {
		this.areafloor = areafloor;
	}
	public Integer getCstate() {
		return cstate;
	}
	public void setCstate(Integer cstate) {
		this.cstate = cstate;
	}
	public String getSupercpccode() {
		return supercpccode;
	}
	public void setSupercpccode(String supercpccode) {
		this.supercpccode = supercpccode;
	}
	
}
