package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title ScaleConf.java
 * @Package com.po
 * @version 1.0
 * 溯源秤键配置表  
 */
public class ChengKey implements Serializable{
	private static final long serialVersionUID = -5706080795431381670L;
	
	private Integer keyid;                     //主键ID
	private Integer confid;                    //秤配置Id
	private Integer rowsnum;                    //行位数
	private Integer columnnum;                  //列位数
	private String keyvalue;                   //键值
    
	//分页参数
	private int pager_count;                   //总数目
	private int pager_offset;                  //当页第一行的序号
	private int pager_openset;                 //当页显示个数
	private List<ChengKey> chengkeylist;       //溯源秤键值配置列表
	private ChengKey chengKey;		           //溯源秤键值配置
	
	public Integer getKeyid() {
		return keyid;
	}
	public void setKeyid(Integer keyid) {
		this.keyid = keyid;
	}
	public Integer getConfid() {
		return confid;
	}
	public void setConfid(Integer confid) {
		this.confid = confid;
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
	public String getKeyvalue() {
		return keyvalue;
	}
	public void setKeyvalue(String keyvalue) {
		this.keyvalue = keyvalue;
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
	public List<ChengKey> getChengkeylist() {
		return chengkeylist;
	}
	public void setChengkeylist(List<ChengKey> chengkeylist) {
		this.chengkeylist = chengkeylist;
	}
	public ChengKey getChengKey() {
		return chengKey;
	}
	public void setChengKey(ChengKey chengKey) {
		this.chengKey = chengKey;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
