package cn.gov.zyczs.cspt.po;

import java.util.List;

public class Menu {
	private Integer menuid;
	private String menutitle;
	private String menuurl;
	private Integer menuparentid;
	private Integer menutype;
	private Integer menusys;
	private Integer menumainid;
	private List<Menu> menulist;
	
	public Integer getMenuid() {
		return menuid;
	}
	public void setMenuid(Integer menuid) {
		this.menuid = menuid;
	}
	public String getMenutitle() {
		return menutitle;
	}
	public void setMenutitle(String menutitle) {
		this.menutitle = menutitle;
	}
	public String getMenuurl() {
		return menuurl;
	}
	public void setMenuurl(String menuurl) {
		this.menuurl = menuurl;
	}
	public Integer getMenuparentid() {
		return menuparentid;
	}
	public void setMenuparentid(Integer menuparentid) {
		this.menuparentid = menuparentid;
	}
	public Integer getMenutype() {
		return menutype;
	}
	public void setMenutype(Integer menutype) {
		this.menutype = menutype;
	}
	public List<Menu> getMenulist() {
		return menulist;
	}
	public void setMenulist(List<Menu> menulist) {
		this.menulist = menulist;
	}
	public Integer getMenusys() {
		return menusys;
	}
	public void setMenusys(Integer menusys) {
		this.menusys = menusys;
	}
	public Integer getMenumainid() {
		return menumainid;
	}
	public void setMenumainid(Integer menumainid) {
		this.menumainid = menumainid;
	}
	
}
