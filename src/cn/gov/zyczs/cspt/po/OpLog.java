package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.common.Tools;


/**
 * @Title OpLog.java
 * @Package com.po
 * @version 1.0 平台操作日志表
 */
public class OpLog implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private Integer sysid;
	private String method; 
	private String loginName;
	private String userName;
	private String clientIp;
	private String addTime;
	private String content;
	

	
	private List<OpLog> list;
	
	//分页参数
	private int pager_count;      //总数目
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示个数
	private String endTime;
	
	
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSysid() {
		return sysid;
	}
	public void setSysid(Integer sysid) {
		this.sysid = sysid;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public List<OpLog> getList() {
		return list;
	}
	public void setList(List<OpLog> list) {
		this.list = list;
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
	public String getClientIp() {
		return clientIp;
	}
	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}
	
	
	

}
