package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * 溯源秤 快捷键
 * SScalefck entity. @author MyEclipse Persistence Tools
 */

public class Scalefck implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String scalecode;    //溯源秤编号
	private String fckcode;      //快捷键编号
	private String plucodes;     //3个plu编号，用“,”分割,格式：0001,0002,0003
	private String medname;      //3个plu编号，所对应的药材名称
	
	private String columnname;   //列位数
	private String rowsname;     //行位数
	
	private Integer scaleid;      //溯源秤配置表ID
	private String confvale;      //溯源秤配置表ID
	
	private List<MedBase> medBaseList;      //植物集合
	
	/**
	 * 
	 */
	public Scalefck() {
		super();
	}
	/**
	 * @param fckcode
	 * @param plucodes
	 * @param scalecode
	 */
	public Scalefck(String fckcode, String plucodes, String scalecode) {
		super();
		this.fckcode = fckcode;
		this.plucodes = plucodes;
		this.scalecode = scalecode;
	}
	
	public String getScalecode() {
		return scalecode;
	}
	public void setScalecode(String scalecode) {
		this.scalecode = scalecode;
	}
	public String getFckcode() {
		return fckcode;
	}
	public void setFckcode(String fckcode) {
		this.fckcode = fckcode;
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
	public List<MedBase> getMedBaseList() {
		return medBaseList;
	}
	public void setMedBaseList(List<MedBase> medBaseList) {
		this.medBaseList = medBaseList;
	}
	public Integer getScaleid() {
		return scaleid;
	}
	public void setScaleid(Integer scaleid) {
		this.scaleid = scaleid;
	}
	public String getConfvale() {
		return confvale;
	}
	public void setConfvale(String confvale) {
		this.confvale = confvale;
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
}