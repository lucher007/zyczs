package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title ScaleConf.java
 * @Package com.po
 * @version 1.0
 * 溯源秤配置表  
 */
public class ScaleConf implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5706080795431381671L;
	private Integer scaleid;           //
	private String companyname;        //厂商名称
	private String modelnumber;        //型号
	private String rowsnum;            //行数
	private String columnnum;          //列数
	private String keynum;             //键数
	
	private List<String> strList;
	private List<ScaleKeyConf> keyConfList;
    
	//分页参数
	private int pager_count;           //总数目
	private int pager_offset;          //当页第一行的序号
	private int pager_openset;         //当页显示个数
	private List<ScaleConf> scaleList; //溯源秤配置列表
	private ScaleConf scale;		   //溯源秤配置对象
	/**
	 * 
	 */
	public ScaleConf() {
		super();
	}
	
	/**
	 * @param columnnum
	 * @param companyname
	 * @param keynum
	 * @param modelnumber
	 * @param pager_count
	 * @param pager_offset
	 * @param pager_openset
	 * @param rowsnum
	 * @param scale
	 * @param scaleList
	 * @param scaleid
	 */
	public ScaleConf(String columnnum, String companyname, String keynum,
			String modelnumber, int pager_count, int pager_offset,
			int pager_openset, String rowsnum, ScaleConf scale,
			List<ScaleConf> scaleList, Integer scaleid) {
		super();
		this.columnnum = columnnum;
		this.companyname = companyname;
		this.keynum = keynum;
		this.modelnumber = modelnumber;
		this.pager_count = pager_count;
		this.pager_offset = pager_offset;
		this.pager_openset = pager_openset;
		this.rowsnum = rowsnum;
		this.scale = scale;
		this.scaleList = scaleList;
		this.scaleid = scaleid;
	}

	public List<String> getStrList() {
		return strList;
	}

	public void setStrList(List<String> strList) {
		this.strList = strList;
	}

	public String getRowsnum() {
		return rowsnum;
	}

	public void setRowsnum(String rowsnum) {
		this.rowsnum = rowsnum;
	}

	public Integer getScaleid() {
		return scaleid;
	}
	public void setScaleid(Integer scaleid) {
		this.scaleid = scaleid;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getModelnumber() {
		return modelnumber;
	}
	public void setModelnumber(String modelnumber) {
		this.modelnumber = modelnumber;
	}
	public String getColumnnum() {
		return columnnum;
	}
	public void setColumnnum(String columnnum) {
		this.columnnum = columnnum;
	}
	public String getKeynum() {
		return keynum;
	}
	public void setKeynum(String keynum) {
		this.keynum = keynum;
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
	public List<ScaleConf> getScaleList() {
		return scaleList;
	}
	public void setScaleList(List<ScaleConf> scaleList) {
		this.scaleList = scaleList;
	}
	public ScaleConf getScale() {
		return scale;
	}
	public void setScale(ScaleConf scale) {
		this.scale = scale;
	}

	public List<ScaleKeyConf> getKeyConfList() {
		return keyConfList;
	}

	public void setKeyConfList(List<ScaleKeyConf> keyConfList) {
		this.keyConfList = keyConfList;
	}
}
