package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

/**
 * @Title TabletAssist.java
 * @Package com.po
 * @version 1.0
 * 辅料  
 */
public class TabletAssist  implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer assistid;
	private String assistplantname;//辅料品名
	private String assistgpcode;//辅料编号
	private String assistweight;//辅料重量
	private String assistcity;//辅料产地
	private String assistusecount;//辅料使用比列
	private String assistmaterial;//辅料净药材
	private String cpctablet;//生产系统批次号	
	private Integer tabletid;
	public Integer getAssistid() {
		return assistid;
	}
	public void setAssistid(Integer assistid) {
		this.assistid = assistid;
	}
	public String getAssistplantname() {
		return assistplantname;
	}
	public void setAssistplantname(String assistplantname) {
		this.assistplantname = assistplantname;
	}
	public String getAssistgpcode() {
		return assistgpcode;
	}
	public void setAssistgpcode(String assistgpcode) {
		this.assistgpcode = assistgpcode;
	}
	public String getAssistweight() {
		return assistweight;
	}
	public void setAssistweight(String assistweight) {
		this.assistweight = assistweight;
	}
	public String getAssistcity() {
		return assistcity;
	}
	public void setAssistcity(String assistcity) {
		this.assistcity = assistcity;
	}
	public String getAssistusecount() {
		return assistusecount;
	}
	public void setAssistusecount(String assistusecount) {
		this.assistusecount = assistusecount;
	}
	public String getAssistmaterial() {
		return assistmaterial;
	}
	public void setAssistmaterial(String assistmaterial) {
		this.assistmaterial = assistmaterial;
	}
	public Integer getTabletid() {
		return tabletid;
	}
	public void setTabletid(Integer tabletid) {
		this.tabletid = tabletid;
	}
	public String getCpctablet() {
		return cpctablet;
	}
	public void setCpctablet(String cpctablet) {
		this.cpctablet = cpctablet;
	}
	

}
