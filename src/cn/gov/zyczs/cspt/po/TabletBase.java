package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title TabletBase.java
 * @Package com.po
 * @version 1.0 
 * 饮片基础表，用来名称自动补全
 */
public class TabletBase implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private String name;//饮片中文名称
	private String keyword; //饮片英文名称
	private String sourceid;//饮片编码
	private String lasttime;//最近更新时间
	private Integer enabled;//1=可用,非1=不可用
	
	/*****************数据库辅助字段********************/
	private String returnInfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	
	private String mcontent;
	private Integer orgid_in;
	private Integer orgid_un;
	private String chkid;
	
	private TabletBase vo;
	private List<TabletBase> list;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSourceid() {
		return sourceid;
	}
	public void setSourceid(String sourceid) {
		this.sourceid = sourceid;
	}
	public String getLasttime() {
		return lasttime;
	}
	public void setLasttime(String lasttime) {
		this.lasttime = lasttime;
	}
	public Integer getEnabled() {
		return enabled;
	}
	public void setEnabled(Integer enabled) {
		this.enabled = enabled;
	}
	public TabletBase getVo() {
		return vo;
	}
	public void setVo(TabletBase vo) {
		this.vo = vo;
	}
	public List<TabletBase> getList() {
		return list;
	}
	public void setList(List<TabletBase> list) {
		this.list = list;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
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
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public String getReturnInfo() {
		return returnInfo;
	}
	public void setReturnInfo(String returnInfo) {
		this.returnInfo = returnInfo;
	}
	public Integer getOrgid_in() {
		return orgid_in;
	}
	public void setOrgid_in(Integer orgid_in) {
		this.orgid_in = orgid_in;
	}
	public Integer getOrgid_un() {
		return orgid_un;
	}
	public void setOrgid_un(Integer orgid_un) {
		this.orgid_un = orgid_un;
	}
	public String getChkid() {
		return chkid;
	}
	public void setChkid(String chkid) {
		this.chkid = chkid;
	}
	
	
}
