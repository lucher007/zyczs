package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title ScaleConf.java
 * @Package com.po
 * @version 1.0
 * 溯源秤配置表  
 */
public class ChengConf implements Serializable{
	
	private static final long serialVersionUID = -5706080795431381671L;
	private Integer confid;            //配置ID
	private String companyname;        //厂商名称
	private String normname;           //规格名称
	private Integer rowsnum;           //总行数
	private Integer columnnum;         //总列数
	private Integer keynum;            //总键数
    
	//分页参数
	private int pager_count;           //总数目
	private int pager_offset;          //当页第一行的序号
	private int pager_openset;         //当页显示个数
	private List<ChengConf> chengconflist; //溯源秤配置列表
	private ChengConf chengconf;	   //溯源秤配置对象
	private List<ChengKey> chengkeylist; //溯源秤规格键列表
	private ChengKey chengkey;	   //溯源秤规格键对象
	private List<String> strList;
	private String returninfo;
	
	public Integer getConfid() {
		return confid;
	}
	public void setConfid(Integer confid) {
		this.confid = confid;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getNormname() {
		return normname;
	}
	public void setNormname(String normname) {
		this.normname = normname;
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
	public Integer getKeynum() {
		return keynum;
	}
	public void setKeynum(Integer keynum) {
		this.keynum = keynum;
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
	public List<ChengConf> getChengconflist() {
		return chengconflist;
	}
	public void setChengconflist(List<ChengConf> chengconflist) {
		this.chengconflist = chengconflist;
	}
	public ChengConf getChengconf() {
		return chengconf;
	}
	public void setChengconf(ChengConf chengconf) {
		this.chengconf = chengconf;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public List<String> getStrList() {
		return strList;
	}
	public void setStrList(List<String> strList) {
		this.strList = strList;
	}
	public List<ChengKey> getChengkeylist() {
		return chengkeylist;
	}
	public void setChengkeylist(List<ChengKey> chengkeylist) {
		this.chengkeylist = chengkeylist;
	}
	public ChengKey getChengkey() {
		return chengkey;
	}
	public void setChengkey(ChengKey chengkey) {
		this.chengkey = chengkey;
	}
	
}
