package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * @Title InOutStorage.java
 * @Package com.po
 * @version 1.0
 * 出入库单
 */
public class InOutStor {
	private Integer inoutstorid;//序列号
	private Integer type;		//类型:药材0,饮片1
	private Integer stortype;//出入库状态：0入库 1出库
	private String sellcorpname;//卖方单位名称
	private String buycorpname;	//买方单位名称
	private String opersystime; //入库系统时间
	private String opertime; 	//出库系统时间
	private Integer userid;     //用户id
	private Double totalmoney; //药材或饮片总价
	private Double totalweight; //药材或饮片重量
	private Integer zstype;     //采购来源/销售去向 类型:0表示非溯源企业;1表示溯源企业;
	private String operator;    //出入库操作人
	private String cpccorp;     //出入库填写对方企业CPC
	private String mobile;  //买方联系电话
	private String address; //买方地址
	private Integer orgid; 	//组织编码
	
	private String strtotalmoney; //药材或饮片总价字符串化
	private String strtotalweight; //药材或饮片重量字符串化
	private Integer codetype;    //溯源码类型（5-包码 6-箱码 7-袋码）
	
	
	private InOutStor inoutstorage;
	private List<InOutStor> inoutstoragelist;
	
	private List<CompanyOther> otherCompList;
	
	
	
	private String returninfo;	//返回消息
	private String mcontent;    //页面模糊查询输入信息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	
	
	/** ***************出入库辅助字段******************* */
	private String datastr;			//出入库数据字符串
	private Double totalweightval; 	//药材或饮片重量
	private Double totalmoneyval; 	//药材或饮片总价
	private String operstarttime;   //查询开始时间
	private String operendtime;     //查询结束时间
	private String prodname;
	private String prodcode;
	
	private String boxcodes;//查询溯源码
	private String uncodestr;
	private String packcode;
	private String batchcpc;//批次号
	
	//出入库集合
	private List<InOutStorBox> inOutStorList;
	
	public List<InOutStorBox> getInOutStorList() {
		return inOutStorList;
	}
	public void setInOutStorList(List<InOutStorBox> inOutStorList) {
		this.inOutStorList = inOutStorList;
	}
	public Integer getInoutstorid() {
		return inoutstorid;
	}
	public void setInoutstorid(Integer inoutstorid) {
		this.inoutstorid = inoutstorid;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getStortype() {
		return stortype;
	}
	public void setStortype(Integer stortype) {
		this.stortype = stortype;
	}
	public String getSellcorpname() {
		return sellcorpname;
	}
	public void setSellcorpname(String sellcorpname) {
		this.sellcorpname = sellcorpname;
	}
	public String getBuycorpname() {
		return buycorpname;
	}
	public void setBuycorpname(String buycorpname) {
		this.buycorpname = buycorpname;
	}
	public String getOpersystime() {
		return opersystime;
	}
	public void setOpersystime(String opersystime) {
		this.opersystime = opersystime;
	}
	public String getOpertime() {
		return opertime;
	}
	public void setOpertime(String opertime) {
		this.opertime = opertime;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Double getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(Double totalmoney) {
		this.totalmoney = totalmoney;
	}
	public Double getTotalweight() {
		return totalweight;
	}
	public void setTotalweight(Double totalweight) {
		this.totalweight = totalweight;
	}
	public Integer getZstype() {
		return zstype;
	}
	public void setZstype(Integer zstype) {
		this.zstype = zstype;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public InOutStor getInoutstorage() {
		return inoutstorage;
	}
	public void setInoutstorage(InOutStor inoutstorage) {
		this.inoutstorage = inoutstorage;
	}
	public List<InOutStor> getInoutstoragelist() {
		return inoutstoragelist;
	}
	public void setInoutstoragelist(List<InOutStor> inoutstoragelist) {
		this.inoutstoragelist = inoutstoragelist;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
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
	public String getDatastr() {
		return datastr;
	}
	public void setDatastr(String datastr) {
		this.datastr = datastr;
	}
	public Double getTotalweightval() {
		return totalweightval;
	}
	public void setTotalweightval(Double totalweightval) {
		this.totalweightval = totalweightval;
	}
	public Double getTotalmoneyval() {
		return totalmoneyval;
	}
	public void setTotalmoneyval(Double totalmoneyval) {
		this.totalmoneyval = totalmoneyval;
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
	public String getBoxcodes() {
		return boxcodes;
	}
	public void setBoxcodes(String boxcodes) {
		this.boxcodes = boxcodes;
	}
	public String getUncodestr() {
		return uncodestr;
	}
	public void setUncodestr(String uncodestr) {
		this.uncodestr = uncodestr;
	}
	public String getStrtotalmoney() {
		return strtotalmoney;
	}
	public void setStrtotalmoney(String strtotalmoney) {
		this.strtotalmoney = strtotalmoney;
	}
	public String getStrtotalweight() {
		return strtotalweight;
	}
	public void setStrtotalweight(String strtotalweight) {
		this.strtotalweight = strtotalweight;
	}
	public String getProdname() {
		return prodname;
	}
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	public List<CompanyOther> getOtherCompList() {
		return otherCompList;
	}
	public void setOtherCompList(List<CompanyOther> otherCompList) {
		this.otherCompList = otherCompList;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public Integer getCodetype() {
		return codetype;
	}
	public void setCodetype(Integer codetype) {
		this.codetype = codetype;
	}
	public String getPackcode() {
		return packcode;
	}
	public void setPackcode(String packcode) {
		this.packcode = packcode;
	}
	public String getBatchcpc() {
		return batchcpc;
	}
	public void setBatchcpc(String batchcpc) {
		this.batchcpc = batchcpc;
	}
	
	
	
	
}
