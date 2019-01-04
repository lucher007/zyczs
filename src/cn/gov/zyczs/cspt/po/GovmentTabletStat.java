package cn.gov.zyczs.cspt.po;

import java.util.List;

public class GovmentTabletStat {
	
	private String mon;
	private String area;
	private Integer orgid;
	private String orgname;
	private String tabletname;
	private String cpctablet;
	private String totaltabletweight;
	private Integer cpctabletCount;
	private Integer codeCount;
	
	private Integer outorderCount;
	private String outtotalweight;
	private String avgprice;
	
	
	private String starttime;//
	private String endtime;//
	
	private List<GovmentTabletStat> tabletList;
	
	
	/*****************数据库辅助字段********************/
	private String returnInfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private String city;
	private String zyctype;
	private String province;
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getZyctype() {
		return zyctype;
	}
	public void setZyctype(String zyctype) {
		this.zyctype = zyctype;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getReturnInfo() {
		return returnInfo;
	}
	public void setReturnInfo(String returnInfo) {
		this.returnInfo = returnInfo;
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
	public String getMon() {
		return mon;
	}
	public void setMon(String mon) {
		this.mon = mon;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getTabletname() {
		return tabletname;
	}
	public void setTabletname(String tabletname) {
		this.tabletname = tabletname;
	}
	
	public List<GovmentTabletStat> getTabletList() {
		return tabletList;
	}
	public void setTabletList(List<GovmentTabletStat> tabletList) {
		this.tabletList = tabletList;
	}
	public String getTotaltabletweight() {
		return totaltabletweight;
	}
	public void setTotaltabletweight(String totaltabletweight) {
		this.totaltabletweight = totaltabletweight;
	}
	public Integer getCpctabletCount() {
		return cpctabletCount;
	}
	public void setCpctabletCount(Integer cpctabletCount) {
		this.cpctabletCount = cpctabletCount;
	}
	public Integer getCodeCount() {
		return codeCount;
	}
	public void setCodeCount(Integer codeCount) {
		this.codeCount = codeCount;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getOuttotalweight() {
		return outtotalweight;
	}
	public void setOuttotalweight(String outtotalweight) {
		this.outtotalweight = outtotalweight;
	}
	public String getAvgprice() {
		return avgprice;
	}
	public void setAvgprice(String avgprice) {
		this.avgprice = avgprice;
	}
	public Integer getOutorderCount() {
		return outorderCount;
	}
	public void setOutorderCount(Integer outorderCount) {
		this.outorderCount = outorderCount;
	}
	public String getCpctablet() {
		return cpctablet;
	}
	public void setCpctablet(String cpctablet) {
		this.cpctablet = cpctablet;
	}
	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	

}
