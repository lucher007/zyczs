package cn.gov.zyczs.cspt.po;

import java.util.List;

public class Role {
	private Integer roleid;
	private String rolename;
	private Integer orgid;
	private List<Role> rolelist;
	private Role role;
	
	private String useriddel;
	private String useridadd;
	private String useridtype;
	
	private List<User> userlistchoose;
	private List<User> userlist;
	
	private List<Menu> menulist;
	private List<RoleMenu> rolemenulist;
	
	private Integer menusys;
	private String menustr;
	private String menustrchild;
	
	private String returninfo;
	private int returncode;
	private int pager_count;
	private int pager_offset;
	public Integer getRoleid() {
		return roleid;
	}
	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public List<Role> getRolelist() {
		return rolelist;
	}
	public void setRolelist(List<Role> rolelist) {
		this.rolelist = rolelist;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public int getReturncode() {
		return returncode;
	}
	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}
	public int getPager_count() {
		return pager_count;
	}
	public void setPager_count(int pager_count) {
		this.pager_count = pager_count;
	}
	public int getPager_offset() {
		return pager_offset;
	}
	public void setPager_offset(int pager_offset) {
		this.pager_offset = pager_offset;
	}
	public String getUseriddel() {
		return useriddel;
	}
	public void setUseriddel(String useriddel) {
		this.useriddel = useriddel;
	}
	public String getUseridadd() {
		return useridadd;
	}
	public void setUseridadd(String useridadd) {
		this.useridadd = useridadd;
	}
	public String getUseridtype() {
		return useridtype;
	}
	public void setUseridtype(String useridtype) {
		this.useridtype = useridtype;
	}	
	public List<User> getUserlistchoose() {
		return userlistchoose;
	}
	public void setUserlistchoose(List<User> userlistchoose) {
		this.userlistchoose = userlistchoose;
	}
	public List<User> getUserlist() {
		return userlist;
	}
	public void setUserlist(List<User> userlist) {
		this.userlist = userlist;
	}
	public List<Menu> getMenulist() {
		return menulist;
	}
	public void setMenulist(List<Menu> menulist) {
		this.menulist = menulist;
	}
	public List<RoleMenu> getRolemenulist() {
		return rolemenulist;
	}
	public void setRolemenulist(List<RoleMenu> rolemenulist) {
		this.rolemenulist = rolemenulist;
	}
	public String getMenustr() {
		return menustr;
	}
	public void setMenustr(String menustr) {
		this.menustr = menustr;
	}
	public String getMenustrchild() {
		return menustrchild;
	}
	public void setMenustrchild(String menustrchild) {
		this.menustrchild = menustrchild;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public Integer getMenusys() {
		return menusys;
	}
	public void setMenusys(Integer menusys) {
		this.menusys = menusys;
	}
	
}
