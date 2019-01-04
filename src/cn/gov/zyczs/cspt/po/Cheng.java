package cn.gov.zyczs.cspt.po;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Title ScaleConf.java
 * @Package com.po
 * @version 1.0
 * 溯源秤表  
 */
public class Cheng {
	private static final long serialVersionUID = -3394593862375251625L;
	
	private Integer chengid;                //秤ID主键
	private String chengcode;               //溯源秤编号
	private Integer confid;                 //溯源秤配置表id
	private String normname;                //规格全称(秤配置厂商+规格名称)
	private Integer state;                  //秤的状态(0无状态变化，1开机，2卖家刷卡，3卖家退出)
	private Integer locked;                 //是否锁定(0正常工作， 1锁定中， 2已锁定，3解锁中)
	private Integer overtime;               //是否超时(0正常，1超时)
	private String cpccorp;                 //所属单位CPC
	private String corpname;                //单位名称
	private String ip;                      //IP地址
	private Integer chengmode;              //秤工作模式(0普通管理模式，1松管理模式，2严格管理模式)
	private Integer type;                   //溯源秤类型(1-案秤、2-台秤)
	private String addtime;                 //溯源秤发放日期
	private String remark;                  //备注信息
	private Integer reason;                 //发放原因(1-初次发放；2-维修；3-更换；4-召回)
	private Integer recdeviceid;            //回收设备ID
	private String recdevicecode;           //回收设备编号
	private Integer recreason;              //回收设备原因
	private String recremark;               //回收设备备注信息
	private Integer recoverCheck;           //是否回收标志
	
	//分页参数
	private int pager_count;                //总数目
	private int pager_offset;               //当页第一行的序号
	private int pager_openset;              //当页显示个数
	private List<Cheng> chengList;          //溯源秤集合
	private Cheng cheng;		            //溯源秤对象
	private Map<Integer,String> chengconfmap; //溯源秤规格配置Map
	private ChengConf chengConf;		     //溯源秤规格配置对象
	
	private List<ChengKey> keyconflist;      //溯源秤键集合
	private ChengKey chengkey;		         //溯源秤键对象
	
	private List<ChengFck> chengfcklist;     //溯源秤键对象集合
	private ChengFck chengfck;		         //溯源秤快捷键对象
	
	private String keystring;                //溯源秤键配置 横纵坐标值拼接  -x(横坐标),y(纵坐标)
	private String keymap;                   //溯源秤键配置 横纵坐标值拼接  -x(横坐标),y(纵坐标)@v(value)
	private List<String> strList;   
	private String returninfo;               //页面返回消息
	private int returncode;		             //登录返回状态0成功，1失败
	private List<Org> orgList;               //企业LIST
	private List<ChengData> chengdatalist;   //溯源秤交易list
	private String operstarttime;            //查询开始时间
	private String operendtime;              //查询结束时间
	private String marketcode;               //市场经商户的市场CPC
	private String querytype;                //查询类别；1=市场下经商户查询
	
	private String chengbrand;               //溯源秤厂商
	private String chengmodel;               //溯源秤型号
	private Date opentime;                   //每天开启时间
	private Integer weightcount;             //溯源秤称重数
	private Integer opertype;
	
	//移动终端手持机查询
	private String laststarttime;           //最后开机日期
	private String lasttradetime;           //最后交易日期
	
	public List<String> getStrList() {
		return strList;
	}
	public void setStrList(List<String> strList) {
		this.strList = strList;
	}
	
	
	public Integer getChengid() {
		return chengid;
	}
	public void setChengid(Integer chengid) {
		this.chengid = chengid;
	}
	public String getChengcode() {
		return chengcode;
	}
	public void setChengcode(String chengcode) {
		this.chengcode = chengcode;
	}
	public Integer getConfid() {
		return confid;
	}
	public void setConfid(Integer confid) {
		this.confid = confid;
	}
	public String getNormname() {
		return normname;
	}
	public void setNormname(String normname) {
		this.normname = normname;
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
	public Integer getOvertime() {
		return overtime;
	}
	public void setOvertime(Integer overtime) {
		this.overtime = overtime;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Integer getChengmode() {
		return chengmode;
	}
	public void setChengmode(Integer chengmode) {
		this.chengmode = chengmode;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
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
	public List<Cheng> getChengList() {
		return chengList;
	}
	public void setChengList(List<Cheng> chengList) {
		this.chengList = chengList;
	}
	public Cheng getCheng() {
		return cheng;
	}
	public void setCheng(Cheng cheng) {
		this.cheng = cheng;
	}
	public Map<Integer, String> getChengconfmap() {
		return chengconfmap;
	}
	public void setChengconfmap(Map<Integer, String> chengconfmap) {
		this.chengconfmap = chengconfmap;
	}
	public ChengConf getChengConf() {
		return chengConf;
	}
	public void setChengConf(ChengConf chengConf) {
		this.chengConf = chengConf;
	}
	public List<ChengKey> getKeyconflist() {
		return keyconflist;
	}
	public void setKeyconflist(List<ChengKey> keyconflist) {
		this.keyconflist = keyconflist;
	}
	public ChengKey getChengkey() {
		return chengkey;
	}
	public void setChengkey(ChengKey chengkey) {
		this.chengkey = chengkey;
	}
	public List<ChengFck> getChengfcklist() {
		return chengfcklist;
	}
	public void setChengfcklist(List<ChengFck> chengfcklist) {
		this.chengfcklist = chengfcklist;
	}
	public ChengFck getChengfck() {
		return chengfck;
	}
	public void setChengfck(ChengFck chengfck) {
		this.chengfck = chengfck;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public String getKeystring() {
		return keystring;
	}
	public void setKeystring(String keystring) {
		this.keystring = keystring;
	}
	public String getKeymap() {
		return keymap;
	}
	public void setKeymap(String keymap) {
		this.keymap = keymap;
	}
	public int getReturncode() {
		return returncode;
	}
	public void setReturncode(int returncode) {
		this.returncode = returncode;
	}
	public String getCorpname() {
		return corpname;
	}
	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}
	public String getOperstarttime() {
		return operstarttime;
	}
	public void setOperstarttime(String operstarttime) {
		this.operstarttime = operstarttime;
	}
	public String getOperendtime() {
		return operendtime;
	}
	public void setOperendtime(String operendtime) {
		this.operendtime = operendtime;
	}
	public List<ChengData> getChengdatalist() {
		return chengdatalist;
	}
	public void setChengdatalist(List<ChengData> chengdatalist) {
		this.chengdatalist = chengdatalist;
	}
	public String getMarketcode() {
		return marketcode;
	}
	public void setMarketcode(String marketcode) {
		this.marketcode = marketcode;
	}
	public List<Org> getOrgList() {
		return orgList;
	}
	public void setOrgList(List<Org> orgList) {
		this.orgList = orgList;
	}
	public String getQuerytype() {
		return querytype;
	}
	public void setQuerytype(String querytype) {
		this.querytype = querytype;
	}
	public String getChengbrand() {
		return chengbrand;
	}
	public void setChengbrand(String chengbrand) {
		this.chengbrand = chengbrand;
	}
	public String getChengmodel() {
		return chengmodel;
	}
	public void setChengmodel(String chengmodel) {
		this.chengmodel = chengmodel;
	}
	public Date getOpentime() {
		return opentime;
	}
	public void setOpentime(Date opentime) {
		this.opentime = opentime;
	}
	public Integer getWeightcount() {
		return weightcount;
	}
	public void setWeightcount(Integer weightcount) {
		this.weightcount = weightcount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getReason() {
		return reason;
	}
	public void setReason(Integer reason) {
		this.reason = reason;
	}
	public Integer getRecdeviceid() {
		return recdeviceid;
	}
	public void setRecdeviceid(Integer recdeviceid) {
		this.recdeviceid = recdeviceid;
	}
	public String getRecdevicecode() {
		return recdevicecode;
	}
	public void setRecdevicecode(String recdevicecode) {
		this.recdevicecode = recdevicecode;
	}
	public Integer getRecreason() {
		return recreason;
	}
	public void setRecreason(Integer recreason) {
		this.recreason = recreason;
	}
	public String getRecremark() {
		return recremark;
	}
	public void setRecremark(String recremark) {
		this.recremark = recremark;
	}
	public Integer getRecoverCheck() {
		return recoverCheck;
	}
	public void setRecoverCheck(Integer recoverCheck) {
		this.recoverCheck = recoverCheck;
	}
	public Integer getOpertype() {
		return opertype;
	}
	public void setOpertype(Integer opertype) {
		this.opertype = opertype;
	}
	public String getLaststarttime() {
		return laststarttime;
	}
	public void setLaststarttime(String laststarttime) {
		this.laststarttime = laststarttime;
	}
	public String getLasttradetime() {
		return lasttradetime;
	}
	public void setLasttradetime(String lasttradetime) {
		this.lasttradetime = lasttradetime;
	}
	
}
