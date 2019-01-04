package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Company.java
 * @Package com.po
 * @version 1.0 组织表
 */
public class Org implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer orgid; // 组织编码
	private String orgname; // 组织名称
	private String cpccorp; // 企业编码(14位)-->先变成组织结构编码
	private String zyctype; // 药材种植平台-10000000,药材经销商-01000000,饮片生产-00100000,饮片经销商-00010000,市场-00001000,医院-00000100,管理机构-00000010,,其他-00000001
	private String gapcode; // GAP编码
	private String gmpcode; // GMP编码
	private String gspcode; // GSP编码
	private String province; // 省
	private String city; // 市
	private String area; // 区/县
	private String registeraddress; // 详细地址
	private String areacode; // 区域号
	private String mobile; // 移动电话
	private String telephone; // 固定电话
	private String officephone; // 传真
	private String email; // 电子邮件
	private String postcode; // 邮编
	private String linkman; // 组织联系人
	private String sendcard; // IC卡号
	private String businessnumber; // 商户号编号
	private String marketcode; // 市场编码
	private String addtime; // 添加时间
	private Org org; // 组织类
	private List<Org> orglist; // 组织列表

	private String returninfo; // 返回消息
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量
	private String masterman;// 法人

	private Company company;
	private String supercpccode;//企业编码
	private String mcontent;
	private String longitude;//经度
	private String latitude;//纬度
	private Integer ishospital;//医院0 药店1
	
	// //////////////辅助字段////////////////
	private String corpname;// 企业名称
	private String scalecode;// 溯源秤编号
	
	private String intotalweight;//入库量
	private String outtotalweight;//出库量
	
	private String marketname; // 市场编码
	
	
	private String orgshortname;//组织机构简称
	private String identitycard;	//法人个人身份证号
	private String businesscode;	//企业营业执照号
	private String orgcode;			//组织机构代码
	
	private String uploadids;//上传附件id集合
	
	
	private String chengcode;               //溯源秤编号
	private Integer state;                  //秤的状态(0无状态变化，1开机，2卖家刷卡，3卖家退出)
	private Integer locked;                 //是否锁定(0正常工作， 1锁定中， 2已锁定，3解锁中)
	private String partion;//市场内商铺所在的市场分区
	private String coordinate;//市场内的商铺所在市场的具体位置用坐标表示
	private Integer chengtype;//秤类型-发放溯源秤的时候，根据秤类型过滤发放企业
	private String cardtype;  //IC卡类型-发放IC卡的时候，根据IC卡过滤发放企业
	private Integer opertype;//企业点击用户管理0,组织点击用户管理1
	private int returncode; //判断组织存不存在
	private String request;
	private int corp;//集团0,1非集团
	private String tokenid; //页面获取的tokenid值 唯一
	private Integer uploadtype;
	private OrgUpload orgupload;
	private int uploadid;
	private String uploadcontent;
	private List<OrgUpload_JiLin> orguploads;
	
	public String getUploadcontent() {
		return uploadcontent;
	}

	public void setUploadcontent(String uploadcontent) {
		this.uploadcontent = uploadcontent;
	}

	public int getUploadid() {
		return uploadid;
	}

	public void setUploadid(int uploadid) {
		this.uploadid = uploadid;
	}


	public List<OrgUpload_JiLin> getOrguploads() {
		return orguploads;
	}

	public void setOrguploads(List<OrgUpload_JiLin> orguploads) {
		this.orguploads = orguploads;
	}

	public OrgUpload getOrgupload() {
		return orgupload;
	}

	public void setOrgupload(OrgUpload orgupload) {
		this.orgupload = orgupload;
	}

	public Integer getUploadtype() {
		return uploadtype;
	}

	public void setUploadtype(Integer uploadtype) {
		this.uploadtype = uploadtype;
	}

	public String getTokenid() {
		return tokenid;
	}

	public void setTokenid(String tokenid) {
		this.tokenid = tokenid;
	}

	public Integer getOpertype() {
		return opertype;
	}

	public void setOpertype(Integer opertype) {
		this.opertype = opertype;
	}

	public String getPartion() {
		return partion;
	}

	public void setPartion(String partion) {
		this.partion = partion;
	}

	public String getCoordinate() {
		return coordinate;
	}

	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}

	public String getChengcode() {
		return chengcode;
	}

	public void setChengcode(String chengcode) {
		this.chengcode = chengcode;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getLocked() {
		return locked;
	}

	public void setLocked(Integer locked) {
		this.locked = locked;
	}

	public String getUploadids() {
		return uploadids;
	}

	public void setUploadids(String uploadids) {
		this.uploadids = uploadids;
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

	public Integer getOrgid() {
		return orgid;
	}

	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
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

	public String getGapcode() {
		return gapcode;
	}

	public void setGapcode(String gapcode) {
		this.gapcode = gapcode;
	}

	public String getGmpcode() {
		return gmpcode;
	}

	public void setGmpcode(String gmpcode) {
		this.gmpcode = gmpcode;
	}

	public String getGspcode() {
		return gspcode;
	}

	public void setGspcode(String gspcode) {
		this.gspcode = gspcode;
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

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
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

	public String getSendcard() {
		return sendcard;
	}

	public void setSendcard(String sendcard) {
		this.sendcard = sendcard;
	}

	public String getBusinessnumber() {
		return businessnumber;
	}

	public void setBusinessnumber(String businessnumber) {
		this.businessnumber = businessnumber;
	}

	public String getMarketcode() {
		return marketcode;
	}

	public void setMarketcode(String marketcode) {
		this.marketcode = marketcode;
	}

	public Org getOrg() {
		return org;
	}

	public void setOrg(Org org) {
		this.org = org;
	}

	public List<Org> getOrglist() {
		return orglist;
	}

	public void setOrglist(List<Org> orglist) {
		this.orglist = orglist;
	}

	public String getReturninfo() {
		return returninfo;
	}

	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
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

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	public String getAddtime() {
		if (addtime == null || addtime.length() < 10) {
			addtime = null;
		} else {
			addtime = addtime.substring(0, 10);
		}
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getMasterman() {
		return masterman;
	}

	public void setMasterman(String masterman) {
		this.masterman = masterman;
	}

	public String getMcontent() {
		return mcontent;
	}

	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}

	public String getCorpname() {
		return corpname;
	}

	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}

	public String getScalecode() {
		return scalecode;
	}

	public void setScalecode(String scalecode) {
		this.scalecode = scalecode;
	}

	public String getIntotalweight() {
		return intotalweight;
	}

	public void setIntotalweight(String intotalweight) {
		this.intotalweight = intotalweight;
	}

	public String getOuttotalweight() {
		return outtotalweight;
	}

	public void setOuttotalweight(String outtotalweight) {
		this.outtotalweight = outtotalweight;
	}

	public String getSupercpccode() {
		return supercpccode;
	}

	public void setSupercpccode(String supercpccode) {
		this.supercpccode = supercpccode;
	}

	public String getMarketname() {
		return marketname;
	}

	public void setMarketname(String marketname) {
		this.marketname = marketname;
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

	public Integer getChengtype() {
		return chengtype;
	}

	public void setChengtype(Integer chengtype) {
		this.chengtype = chengtype;
	}

	public String getCardtype() {
		return cardtype;
	}

	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}

	public int getReturncode() {
		return returncode;
	}

	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}

	public String getRequest() {
		return request;
	}

	public void setRequest(String request) {
		this.request = request;
	}

	public int getCorp() {
		return corp;
	}

	public void setCorp(int corp) {
		this.corp = corp;
	}

	public Integer getIshospital() {
		return ishospital;
	}

	public void setIshospital(Integer ishospital) {
		this.ishospital = ishospital;
	}
	

}
