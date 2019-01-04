package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * 溯源秤 快捷键
 * SScalefck entity. @author MyEclipse Persistence Tools
 */

public class ChengFck implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	
	private String chengcode;     //溯源秤编号
	private String keyvalue;      //键值
	private String plucodes;      //3个plu编号，用“,”分割,格式：0001,0002,0003
	private String medname;       //3个plu编号，所对应的药材名称
	
	private Integer chengid;     //溯源秤编号
	private Integer rowsnum;       //行位数
	private Integer columnnum;      //列位数
	private Integer confid;        //溯源秤配置表ID
	
	//分页参数
	private int pager_count;                   //总数目
	private int pager_offset;                  //当页第一行的序号
	private int pager_openset;                 //当页显示个数
	private List<ChengFck> chengfcklist;       //溯源秤键值配置列表
	private ChengKey chengfck;		           //溯源秤键值配置
	
	
	public String getChengcode() {
		return chengcode;
	}
	public void setChengcode(String chengcode) {
		this.chengcode = chengcode;
	}
	public String getKeyvalue() {
		return keyvalue;
	}
	public void setKeyvalue(String keyvalue) {
		this.keyvalue = keyvalue;
	}
	public String getPlucodes() {
		return plucodes;
	}
	public void setPlucodes(String plucodes) {
		this.plucodes = plucodes;
	}
	public String getMedname() {
		return medname;
	}
	public void setMedname(String medname) {
		this.medname = medname;
	}
	public Integer getRowsnum() {
		return rowsnum;
	}
	public void setRowsnum(Integer rowsnum) {
		this.rowsnum = rowsnum;
	}
	public Integer getColumnnum() {
		return columnnum;
	}
	public void setColumnnum(Integer columnnum) {
		this.columnnum = columnnum;
	}
	public Integer getConfid() {
		return confid;
	}
	public void setConfid(Integer confid) {
		this.confid = confid;
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
	public List<ChengFck> getChengfcklist() {
		return chengfcklist;
	}
	public void setChengfcklist(List<ChengFck> chengfcklist) {
		this.chengfcklist = chengfcklist;
	}
	public ChengKey getChengfck() {
		return chengfck;
	}
	public void setChengfck(ChengKey chengfck) {
		this.chengfck = chengfck;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Integer getChengid() {
		return chengid;
	}
	public void setChengid(Integer chengid) {
		this.chengid = chengid;
	}
}