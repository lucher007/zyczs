package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

/**
 * 各企业下表示打印配置实体
 * @author Administrator
 *
 */
public class LabelPrint implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private Integer orgid;
	private String printcol;
	
	///////////////数据库辅助字段///////////////
	private String returninfo;
	private LabelPrint labelprint;
	private String address;
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public LabelPrint getLabelprint() {
		return labelprint;
	}
	public void setLabelprint(LabelPrint labelprint) {
		this.labelprint = labelprint;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getPrintcol() {
		return printcol;
	}
	public void setPrintcol(String printcol) {
		this.printcol = printcol;
	}
}
