package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * 溯源秤 快捷键
 * SScalefck entity. @author MyEclipse Persistence Tools
 */

public class ChengFckTmp implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer tmpid;        //模板ID
	private String keyvalue;      //键值
	private String plucodes;      //3个plu编号，用“,”分割,格式：0001,0002,0003
	private String medname;       //3个plu编号，所对应的药材名称
	private Integer rowsnum;      //行位数
	private Integer columnnum;    //列位数
	private Integer confid;       //配置规格ID
	
	//分页参数
	private int pager_count;                   //总数目
	private int pager_offset;                  //当页第一行的序号
	private int pager_openset;                 //当页显示个数
	private List<ChengFckTmp> fcktmplist;      //快捷键模板列表
	private ChengFckTmp fcktmp;		           //溯源秤快捷键模板
	private String returninfo;                 //页面返回消息
	
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
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Integer getTmpid() {
		return tmpid;
	}
	public void setTmpid(Integer tmpid) {
		this.tmpid = tmpid;
	}
	public List<ChengFckTmp> getFcktmplist() {
		return fcktmplist;
	}
	public void setFcktmplist(List<ChengFckTmp> fcktmplist) {
		this.fcktmplist = fcktmplist;
	}
	public ChengFckTmp getFcktmp() {
		return fcktmp;
	}
	public void setFcktmp(ChengFckTmp fcktmp) {
		this.fcktmp = fcktmp;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public Integer getConfid() {
		return confid;
	}
	public void setConfid(Integer confid) {
		this.confid = confid;
	}
}