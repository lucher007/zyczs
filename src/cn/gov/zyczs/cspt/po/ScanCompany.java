package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
/**
 * @Title ScanCompany.java
 * @Package com.po
 * @version 1.0 
 * 手持机扫描企业历史
 */
public class ScanCompany implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer  id;//主键
	private Integer userid;//手持机用户id
	private String cpccorp;//扫描的企业cpc
	private String scandate;//扫描记录时间
	
	////////////////数据库辅助字段/////////////////////
	private String returninfo;	//返回消息
	private int pager_count;	//总记录数
	private int pager_offset;	//分页量
	private int pager_openset;	//每页显示量
	private List<ScanCompany> list;//集合
	private Integer querytype;//查询类型
	private String startscandate;//查询开始时间
	private String endscandate;//查询结束时间
	
	public String getStartscandate() {
		return startscandate;
	}
	public void setStartscandate(String startscandate) {
		this.startscandate = startscandate;
	}
	public String getEndscandate() {
		return endscandate;
	}
	public void setEndscandate(String endscandate) {
		this.endscandate = endscandate;
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
	public List<ScanCompany> getList() {
		return list;
	}
	public void setList(List<ScanCompany> list) {
		this.list = list;
	}
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
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public String getScandate() {
		return scandate;
	}
	public void setScandate(String scandate) {
		this.scandate = scandate;
	}
	public Integer getQuerytype() {
		return querytype;
	}
	public void setQuerytype(Integer querytype) {
		this.querytype = querytype;
	}
}
