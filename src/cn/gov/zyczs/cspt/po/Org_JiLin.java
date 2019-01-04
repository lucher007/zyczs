package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

public class Org_JiLin implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String orgname; // 组织名称
	private String orgshortname;//组织机构简称
	private String cpccorp; // 企业编码(14位)-->先变成组织结构编码
	private String zyctype; // 药材种植平台-10000000,药材经销商-01000000,饮片生产-00100000,饮片经销商-00010000,市场-00001000,医院-00000100,管理机构-00000010,,其他-00000001
	private String mobile; // 移动电话
	private String marketcode; // 市场编码
	private String sendcard; //是否发卡,0:未发 1已发
	private String province; // 省
	private String city; // 市
	private String area; // 区/县
	private String registeraddress; // 详细地址
	private String areacode; // 区域号
	private String telephone; // 固定电话
	private String officephone; // 传真
	private String email; // 电子邮件
	private String postcode; // 邮编
	private String linkman; // 组织联系人
	private String businessnumber; // 商户号编号
	private String identitycard;	//法人个人身份证号
	private String businesscode;	//企业营业执照号
	private String orgcode;			//组织机构代码
	private String longitude;//经度
	private String latitude;//纬度
	private String masterman;// 法人
	
	private Integer uploadid;
	private String uploadcontent;
	private Integer uploadtype;
	private List<OrgUpload> orguploads;
	
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 
	
	
	public String getMasterman() {
		return masterman;
	}
	public void setMasterman(String masterman) {
		this.masterman = masterman;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getOrgshortname() {
		return orgshortname;
	}
	public void setOrgshortname(String orgshortname) {
		this.orgshortname = orgshortname;
	}
	public String getIdentitycard() {
		return identitycard;
	}
	public void setIdentitycard(String identitycard) {
		this.identitycard = identitycard;
	}
	public String getBusinesscode() {
		return businesscode;
	}
	public void setBusinesscode(String businesscode) {
		this.businesscode = businesscode;
	}
	public String getOrgcode() {
		return orgcode;
	}
	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}
	public String getSendcard() {
		return sendcard;
	}
	public void setSendcard(String sendcard) {
		this.sendcard = sendcard;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getZyctype() {
		return zyctype;
	}
	public void setZyctype(String zyctype) {
		this.zyctype = zyctype;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getMarketcode() {
		return marketcode;
	}
	public void setMarketcode(String marketcode) {
		this.marketcode = marketcode;
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
	public String getRegisteraddress() {
		return registeraddress;
	}
	public void setRegisteraddress(String registeraddress) {
		this.registeraddress = registeraddress;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getOfficephone() {
		return officephone;
	}
	public void setOfficephone(String officephone) {
		this.officephone = officephone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getLinkman() {
		return linkman;
	}
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getBusinessnumber() {
		return businessnumber;
	}
	public void setBusinessnumber(String businessnumber) {
		this.businessnumber = businessnumber;
	}
	public Integer getUploadid() {
		return uploadid;
	}
	public void setUploadid(Integer uploadid) {
		this.uploadid = uploadid;
	}
	public String getUploadcontent() {
		return uploadcontent;
	}
	public void setUploadcontent(String uploadcontent) {
		this.uploadcontent = uploadcontent;
	}
	public Integer getUploadtype() {
		return uploadtype;
	}
	public void setUploadtype(Integer uploadtype) {
		this.uploadtype = uploadtype;
	}
	public List<OrgUpload> getOrguploads() {
		return orguploads;
	}
	public void setOrguploads(List<OrgUpload> orguploads) {
		this.orguploads = orguploads;
	}
}
