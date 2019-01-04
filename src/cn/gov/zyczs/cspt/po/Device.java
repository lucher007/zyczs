package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @Title Device.java
 * @Package com.po
 * @version 1.0
 * 溯源秤表  
 */
@SuppressWarnings("serial")
public class Device implements Serializable{
	private Integer deviceid;               //ID主键
	private String devicecode;              //设备编号
	private Integer confid;                 //配置表id
	private String normname;                //规格全称(秤配置厂商+规格名称)
	private String cpccorp;                 //所属单位CPC
	private String corpname;                //单位名称
	private String ip;                      //IP地址
	private Integer devicetype;             //设备类型(1-打印机；2-扫描器；3-移动终端；)
	private String addtime;                   //溯源秤发放日期
	private String remark;                  //备注信息
	private Integer reason;                 //发放原因(1-初次发放；2-维修；3-更换；4-召回)
	private Integer recdeviceid;            //回收设备ID
	private String recdevicecode;           //回收设备编号
	private Integer recreason;              //回收设备原因
	private String recremark;               //回收设备备注信息
	private Integer recoverCheck;           //是否回收标志
	private String cardtype;                //IC卡类型
	private String chengcode;               //IC卡对于的溯源秤编号
	
	
	//分页参数
	private int pager_count;                //总数目
	private int pager_offset;               //当页第一行的序号
	private int pager_openset;              //当页显示个数
	private List<Device> deviceList;        //溯源秤集合
	private Device device;		            //溯源秤对象
	private String returninfo;              //页面返回消息
	private List<Org> orgList;              //企业LIST
	private Org org;                        //企业信息
	private String marketcode;              //市场经商户的市场CPC
	private Map<Integer,String> deviceconfmap; //溯源秤规格配置Map
	private Integer orgid;                   //企业ID编号
	
	
	public Integer getDeviceid() {
		return deviceid;
	}
	public void setDeviceid(Integer deviceid) {
		this.deviceid = deviceid;
	}
	public String getDevicecode() {
		return devicecode;
	}
	public void setDevicecode(String devicecode) {
		this.devicecode = devicecode;
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
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Integer getDevicetype() {
		return devicetype;
	}
	public void setDevicetype(Integer devicetype) {
		this.devicetype = devicetype;
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
	public List<Device> getDeviceList() {
		return deviceList;
	}
	public void setDeviceList(List<Device> deviceList) {
		this.deviceList = deviceList;
	}
	public Device getDevice() {
		return device;
	}
	public void setDevice(Device device) {
		this.device = device;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public List<Org> getOrgList() {
		return orgList;
	}
	public void setOrgList(List<Org> orgList) {
		this.orgList = orgList;
	}
	public String getMarketcode() {
		return marketcode;
	}
	public void setMarketcode(String marketcode) {
		this.marketcode = marketcode;
	}
	public Map<Integer, String> getDeviceconfmap() {
		return deviceconfmap;
	}
	public void setDeviceconfmap(Map<Integer, String> deviceconfmap) {
		this.deviceconfmap = deviceconfmap;
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
	public String getCardtype() {
		return cardtype;
	}
	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}
	public String getChengcode() {
		return chengcode;
	}
	public void setChengcode(String chengcode) {
		this.chengcode = chengcode;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}
	
}
