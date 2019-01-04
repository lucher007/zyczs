package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

public class CodeArea implements Serializable {

	private static final long serialVersionUID = 1L;

	private String code;
	private String name;
	private String pcode;

	private List<CodeArea> codeAreaList;
	
	/***********数据库辅助字段**********************/
	private String province; // 省
	private String city; // 市
	private String area; // 区
	private String shortname;//省市区简称
	public String getShortname() {
		return shortname;
	}

	public void setShortname(String shortname) {
		this.shortname = shortname;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public List<CodeArea> getCodeAreaList() {
		return codeAreaList;
	}

	public void setCodeAreaList(List<CodeArea> codeAreaList) {
		this.codeAreaList = codeAreaList;
	}
}
