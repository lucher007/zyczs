package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

import cn.gov.zyczs.cspt.common.ToolsValid;

/**
 * @Title Company.java
 * @Package com.po
 * @version 1.0 
 * 企业表
 */
public class Company implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer companyid;		//企业序列号
	private String cpccorp;			//企业编码(14位)
	private String corpname;		//企业全名
	private String corpshortname;	//企业简称
	private String linkman;			//企业联系人
	private String masterman;		//企业法人
	private String identitycard;	//企业法人个人身份证号
	private String businesscode;	//企业营业执照号
	private String mobile;			//企业移动电话
	private String telephone;		//企业固定电话
	private String officephone;		//企业传真
	private String email;			//企业电子邮件
	private String postcode;		//邮编
	private String province;		//省
	private String city;			//市
	private String area;			//区/县
	private String areacode;		//区域号
	private String registeraddress;	//详细地址	
	private String addtime;			//注册时间
	private String orgcode;			//组织机构代码
	private String zyctype;			//药材种植平台-10000000,药材经销商-01000000,饮片生产-00100000,饮片经销商-00010000,市场-00001000,医院-00000100,管理机构-00000010,,其他-00000001
	private Integer canum;			//企业CA证书个数
	private String gapcode;			//GAP编码
	private String gmpcode;			//GMP编码
	private String gspcode;			//GSP编码
	private Integer state;			//0未审核 1审核
	private Company company;		//企业类
	private List<Company> companylist;	//企业列表
	
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	
	private String businessnumber;//商户编号
	private List<Org> orgs;//企业上商户集合
	private Integer orgid;//组织id
	private String marketcode;
	private String companyidstr;//企业ID集合
	private int returncode; //判断企业存不存在
	private Integer opertype;//0后台添加,1前台注册
	private String longitude;//经度
	private String latitude;//纬度
	private Integer corp;//集团0,非集团1
	private Integer ishospital;//医院0 药店1
	
	/////////////////////////数据库辅助字段////////////////////////////////////
	private String loginname;	//登录用户名,长度1-50
	private String loginpass;	//登录密码,长度6-50
	private String username; 	//用户姓名
	private User user;//用户
	
	private Org org;
	private String uploadids;//上传附件id集合
	private String partion;//市场内商铺所在的市场分区
	private String coordinate;//市场内的商铺所在市场的具体位置用坐标表示
	private String areafloor;//关联marketmap的外键
	private List<Org> orglist;//
	private String tokenid; //页面获取的tokenid值 唯一
	private String orgnames;//前台注册集合企业,所有下属单位拼接串
	public String getOrgnames() {
		return orgnames;
	}
	public void setOrgnames(String orgnames) {
		this.orgnames = orgnames;
	}
	public String getTokenid() {
		return tokenid;
	}
	public void setTokenid(String tokenid) {
		this.tokenid = tokenid;
	}
	public List<Org> getOrglist() {
		return orglist;
	}
	public void setOrglist(List<Org> orglist) {
		this.orglist = orglist;
	}
	public String getAreafloor() {
		return areafloor;
	}
	public void setAreafloor(String areafloor) {
		this.areafloor = areafloor;
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
	public String getUploadids() {
		return uploadids;
	}
	public void setUploadids(String uploadids) {
		this.uploadids = uploadids;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getLoginname() {
		return loginname;
	}
	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}
	public String getLoginpass() {
		return loginpass;
	}
	public void setLoginpass(String loginpass) {
		this.loginpass = loginpass;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getOpertype() {
		return opertype;
	}
	public void setOpertype(Integer opertype) {
		this.opertype = opertype;
	}
	public String getMarketcode() {
		return marketcode;
	}
	public void setMarketcode(String marketcode) {
		this.marketcode = marketcode;
	}
	public List<Org> getOrgs() {
		return orgs;
	}
	public void setOrgs(List<Org> orgs) {
		this.orgs = orgs;
	}
	public Integer getCompanyid() {
		return companyid;
	}
	public void setCompanyid(Integer companyid) {
		this.companyid = companyid;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getCorpname() {
		return corpname;
	}
	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}
	public String getCorpshortname() {
		return corpshortname;
	}
	public void setCorpshortname(String corpshortname) {
		this.corpshortname = corpshortname;
	}
	public String getLinkman() {
		return linkman;
	}
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getMasterman() {
		return masterman;
	}
	public void setMasterman(String masterman) {
		this.masterman = masterman;
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
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getRegisteraddress() {
		return registeraddress;
	}
	public void setRegisteraddress(String registeraddress) {
		this.registeraddress = registeraddress;
	}
	public String getAddtime() {
		if(addtime==null||addtime.length()<10){
			addtime=null;
		}else{
			addtime=addtime.substring(0,10);
		}
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getOrgcode() {
		return orgcode;
	}
	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}
	public Company getCompany() {
		return company;
	}
	public void setCompany(Company company) {
		this.company = company;
	}
	public List<Company> getCompanylist() {
		return companylist;
	}
	public void setCompanylist(List<Company> companylist) {
		this.companylist = companylist;
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
	public String getZyctype() {
		return zyctype;
	}
	public void setZyctype(String zyctype) {
		this.zyctype = zyctype;
	}
	public Integer getCanum() {
		return canum;
	}
	public void setCanum(Integer canum) {
		this.canum = canum;
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
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getBusinessnumber() {
		return businessnumber;
	}
	public void setBusinessnumber(String businessnumber) {
		this.businessnumber = businessnumber;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getCompanyidstr() {
		return companyidstr;
	}
	public void setCompanyidstr(String companyidstr) {
		this.companyidstr = companyidstr;
	}
	public int getReturncode() {
		return returncode;
	}
	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
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
	public Integer getCorp() {
		return corp;
	}
	public void setCorp(Integer corp) {
		this.corp = corp;
	}
	public Integer getIshospital() {
		return ishospital;
	}
	public void setIshospital(Integer ishospital) {
		this.ishospital = ishospital;
	}
	
//	public boolean checkPo(){
//		if(companyid!=null){
//			if(companyid<=0){
//				return false;
//			}
//		}
//		if(ToolsValid.checkquotmarks(cpccorp)==false){
//			return false;
//		}
//		if(ToolsValid.checkquotmarks(corpname)==false){
//			return false;
//		}
//		if(ToolsValid.checkquotmarks(corpshortname)==false){
//			return false;
//		}
//		return true;
//	}

}
