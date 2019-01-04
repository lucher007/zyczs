package cn.gov.zyczs.cspt.po;

import java.util.List;

public class RoleMenu {
	private Integer id;
	private Integer menuid;
	private Integer roldid;
	private List<RoleMenu> rolemenulist;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getMenuid() {
		return menuid;
	}
	public void setMenuid(Integer menuid) {
		this.menuid = menuid;
	}
	public Integer getRoldid() {
		return roldid;
	}
	public void setRoldid(Integer roldid) {
		this.roldid = roldid;
	}
	public List<RoleMenu> getRolemenulist() {
		return rolemenulist;
	}
	public void setRolemenulist(List<RoleMenu> rolemenulist) {
		this.rolemenulist = rolemenulist;
	}
}
