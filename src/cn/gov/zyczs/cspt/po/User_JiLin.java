package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

public class User_JiLin implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer userid;
	private String loginname;	//登录用户名,长度1-50
	private String loginpass;	//登录密码,长度6-50
	private String cpccorp;		//企业编码(14位)
	private Org_JiLin org;			//组织机构实例
	private List<Org_JiLin> orglist;  //组织机构集合
	
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 每页显示几条
	
	public Org_JiLin getOrg() {
		return org;
	}
	public void setOrg(Org_JiLin org) {
		this.org = org;
	}
	public List<Org_JiLin> getOrglist() {
		return orglist;
	}
	public void setOrglist(List<Org_JiLin> orglist) {
		this.orglist = orglist;
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
	public int getPager_openset() {
		return pager_openset;
	}
	public void setPager_openset(int pager_openset) {
		this.pager_openset = pager_openset;
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
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
}	
