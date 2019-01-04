package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title ScaleConf.java
 * @Package com.po
 * @version 1.0
 * 溯源秤键配置表  
 */
public class ScaleKeyConf implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5706080795431381670L;
	private Integer scalekeyid;                //
	private String columnname;                 //列位数
	private String rowsname;                   //行位数
	private String confvale;                   //配置值
	private Integer scaleid;                   //配置秤Id
    
	//分页参数
	private int pager_count;                   //总数目
	private int pager_offset;                  //当页第一行的序号
	private int pager_openset;                 //当页显示个数
	private List<ScaleKeyConf> scaleKeyList;   //溯源秤配置列表
	private ScaleKeyConf scaleKey;		       //溯源秤配置对象
	
	
	/**
	 * 
	 */
	public ScaleKeyConf() {
		super();
	}
	/**
	 * @param columnname
	 * @param confvale
	 * @param pager_count
	 * @param pager_offset
	 * @param pager_openset
	 * @param rowsname
	 * @param scaleKey
	 * @param scaleKeyList
	 * @param scaleid
	 * @param scalekeyid
	 */
	public ScaleKeyConf(String columnname, String confvale, int pager_count,
			int pager_offset, int pager_openset, String rowsname,
			ScaleKeyConf scaleKey, List<ScaleKeyConf> scaleKeyList,
			Integer scaleid, Integer scalekeyid) {
		super();
		this.columnname = columnname;
		this.confvale = confvale;
		this.pager_count = pager_count;
		this.pager_offset = pager_offset;
		this.pager_openset = pager_openset;
		this.rowsname = rowsname;
		this.scaleKey = scaleKey;
		this.scaleKeyList = scaleKeyList;
		this.scaleid = scaleid;
		this.scalekeyid = scalekeyid;
	}
	public Integer getScalekeyid() {
		return scalekeyid;
	}
	public void setScalekeyid(Integer scalekeyid) {
		this.scalekeyid = scalekeyid;
	}
	public String getColumnname() {
		return columnname;
	}
	public void setColumnname(String columnname) {
		this.columnname = columnname;
	}
	public String getRowsname() {
		return rowsname;
	}
	public void setRowsname(String rowsname) {
		this.rowsname = rowsname;
	}
	public String getConfvale() {
		return confvale;
	}
	public void setConfvale(String confvale) {
		this.confvale = confvale;
	}
	public Integer getScaleid() {
		return scaleid;
	}
	public void setScaleid(Integer scaleid) {
		this.scaleid = scaleid;
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
	public List<ScaleKeyConf> getScaleKeyList() {
		return scaleKeyList;
	}
	public void setScaleKeyList(List<ScaleKeyConf> scaleKeyList) {
		this.scaleKeyList = scaleKeyList;
	}
	public ScaleKeyConf getScaleKey() {
		return scaleKey;
	}
	public void setScaleKey(ScaleKeyConf scaleKey) {
		this.scaleKey = scaleKey;
	}
}
