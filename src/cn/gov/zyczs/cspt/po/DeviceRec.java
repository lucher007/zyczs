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
public class DeviceRec implements Serializable{
	private Integer devicerecid;            //ID主键
	private String devicecode;              //设备编号
	private Integer confid;                 //配置表id
	private String normname;                //规格全称(秤配置厂商+规格名称)
	private String cpccorp;                 //所属单位CPC
	private String corpname;                //单位名称
	private Integer devicetype;             //设备类型(1-打印机；2-扫描器；3-移动终端；)
	private String addtime;                   //溯源秤回收日期
	private String remark;                  //备注信息
	private Integer reason;                 //回收原因(1-召回；2-维修；3-更换)
	private String cardtype;                //IC卡类型(10000000-台秤卡；00001000-市场商铺智能溯源秤卡)
	private Integer chengtype;              //溯源秤类型(1-案秤、2-台秤)
	private String chengcode;               //IC卡所对应的溯源秤编号
	
	//分页参数
	private int pager_count;                //总数目
	private int pager_offset;               //当页第一行的序号
	private int pager_openset;              //当页显示个数
	private List<DeviceRec> deviceRecList;        //溯源秤集合
	private DeviceRec device;		            //溯源秤对象
	private String returninfo;              //页面返回消息
	private List<Org> orgList;              //企业LIST
	private String marketcode;              //市场经商户的市场CPC
	private Map<Integer,String> deviceconfmap; //溯源秤规格配置Map
	
	
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
	public List<DeviceRec> getDeviceRecList() {
		return deviceRecList;
	}
	public void setDeviceRecList(List<DeviceRec> deviceRecList) {
		this.deviceRecList = deviceRecList;
	}
	public DeviceRec getDevice() {
		return device;
	}
	public void setDevice(DeviceRec device) {
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
	public Integer getDevicerecid() {
		return devicerecid;
	}
	public void setDevicerecid(Integer devicerecid) {
		this.devicerecid = devicerecid;
	}
	public String getCardtype() {
		return cardtype;
	}
	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}
	public Integer getChengtype() {
		return chengtype;
	}
	public void setChengtype(Integer chengtype) {
		this.chengtype = chengtype;
	}
	public String getChengcode() {
		return chengcode;
	}
	public void setChengcode(String chengcode) {
		this.chengcode = chengcode;
	}
	
}
