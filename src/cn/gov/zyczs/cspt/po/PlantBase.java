package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title PlantBase.java
 * @Package com.po
 * @version 1.0 
 * 植物基础表
 */
public class PlantBase implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer id;		//ID
	private String name;	//植物中文名称
	private String keyword;	//植物拼音名称
	private String sourceid;//植物编码
	private String lasttime;//最近更新时间
	private String enabled;	//1=可用,非1=不可用
	
	
	private List<PlantBase> list;
	/*****************数据库辅助字段********************/
	private String returnInfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private String mcontent;
	
	public List<PlantBase> getList() {
		return list;
	}
	public void setList(List<PlantBase> list) {
		this.list = list;
	}
	public String getReturnInfo() {
		return returnInfo;
	}
	public void setReturnInfo(String returnInfo) {
		this.returnInfo = returnInfo;
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
	public String getEnabled() {
		return enabled;
	}
	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}
}

