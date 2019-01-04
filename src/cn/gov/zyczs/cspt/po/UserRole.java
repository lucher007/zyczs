package cn.gov.zyczs.cspt.po;

import java.util.List;

public class UserRole {
	private Integer id;
	private Integer userid;
	private Integer roleid;
	private List<UserRole> userrolelist;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Integer getRoleid() {
		return roleid;
	}
	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}
	public List<UserRole> getUserrolelist() {
		return userrolelist;
	}
	public void setUserrolelist(List<UserRole> userrolelist) {
		this.userrolelist = userrolelist;
	}
	
}
