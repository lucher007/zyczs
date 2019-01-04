package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

public class CompanyOther implements Serializable{
	private static final long serialVersionUID = 1L;
	// Fields

	private Integer companyotherid;//非溯源企业序列号
	private String corpnameother;//非溯源企业全名
	private String mobileother;//非溯源企业联系电话
	private String addressother;//非溯源详细地址
	private Integer orgid;
	
	private String opersystime; //入库系统时间
	
	public String getOpersystime() {
		return opersystime;
	}
	public void setOpersystime(String opersystime) {
		this.opersystime = opersystime;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public Integer getCompanyotherid() {
		return companyotherid;
	}
	public void setCompanyotherid(Integer companyotherid) {
		this.companyotherid = companyotherid;
	}
	public String getCorpnameother() {
		return corpnameother;
	}
	public void setCorpnameother(String corpnameother) {
		this.corpnameother = corpnameother;
	}
	public String getMobileother() {
		return mobileother;
	}
	public void setMobileother(String mobileother) {
		this.mobileother = mobileother;
	}
	public String getAddressother() {
		return addressother;
	}
	public void setAddressother(String addressother) {
		this.addressother = addressother;
	}

}
