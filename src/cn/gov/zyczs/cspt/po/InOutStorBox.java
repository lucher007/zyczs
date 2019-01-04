package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title InOutStorBox.java
 * @Package com.po
 * @version 1.0
 * 出入库单明细
 */
public class InOutStorBox implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Integer inoutstorboxid;  //序列号
	private Integer inoutstorid;     //出入库单ID，关联到inoutstorage表
	private String batchcpc;		//药材或者饮片CPC
	private Integer boxnum;	    //箱数
	private Double boxnumweight;//药材规格,每包重量
	private Double totalweight; //总重量
	private Double realtotalweight;//实际总重量
	private Double price;      //单价
	private Double totalmoney; //总价
	private String prodname;   //药材或饮片名称
	private String prodcode;   //药材或饮片编码
	private String prodnumber; //饮片或饮片内部批次号
	private Integer boxitemnum;	//总包数
	private Integer tabletboxitemnum;//每箱包数
	
	private String strtotalweight;//总重量字符串化
	private String strrealtotalweight; //实际总重量字符串化
	private String strtotalmoney;//单价字符串化
	
	private String code;//箱码
	private String boxsCode;
	
	private String areacode;//区域编码
	
	//一个出入库单包含的所有的箱码
	private List<Box> boxitemlist;
	
	//一个出入库单包含的所有的小包码
	private List<BoxItem> packitemlist;
	
	//页面查询辅助信息
	private InOutStorBox inoutstorbox;
	private List<InOutStorBox> inoutstorboxlist;
	
	private String returninfo;	//返回消息
	private String mcontent;    //页面模糊查询输入信息
	private int pager_count;	//分页总数
	private int pager_offset;	//当页第一行的序号
	private int pager_openset;	//分页量
	private String keyname;		//MAP的名称;
	private Integer stortype;   //箱码类型:0入库 ;1出库
	private Integer zstype;     //采购来源/销售去向 类型:0表示非溯源企业;1表示溯源企业;

	private String groupInfo;//该字段保存 溯源码、库存ID、等附件信息 每个属性以逗号隔开、 每组以分号分隔
	private Integer codetype;    //溯源码类型（5-包码 6-箱码 7-袋码）
	private Integer packstorboxid;    //大包装出入库ID
	
	private InOutStor inoutstorage;
	public Integer getInoutstorboxid() {
		return inoutstorboxid;
	}
	public void setInoutstorboxid(Integer inoutstorboxid) {
		this.inoutstorboxid = inoutstorboxid;
	}
	public Integer getInoutstorid() {
		return inoutstorid;
	}
	public void setInoutstorid(Integer inoutstorid) {
		this.inoutstorid = inoutstorid;
	}
	public String getBatchcpc() {
		return batchcpc;
	}
	public void setBatchcpc(String batchcpc) {
		this.batchcpc = batchcpc;
	}
	public Integer getBoxnum() {
		return boxnum;
	}
	public void setBoxnum(Integer boxnum) {
		this.boxnum = boxnum;
	}
	public Double getBoxnumweight() {
		return boxnumweight;
	}
	public void setBoxnumweight(Double boxnumweight) {
		this.boxnumweight = boxnumweight;
	}
	public Double getTotalweight() {
		return totalweight;
	}
	public void setTotalweight(Double totalweight) {
		this.totalweight = totalweight;
	}
	public Double getRealtotalweight() {
		return realtotalweight;
	}
	public void setRealtotalweight(Double realtotalweight) {
		this.realtotalweight = realtotalweight;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Double getTotalmoney() {
		return totalmoney;
	}
	public void setTotalmoney(Double totalmoney) {
		this.totalmoney = totalmoney;
	}
	public String getProdname() {
		return prodname;
	}
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public String getProdnumber() {
		return prodnumber;
	}
	public void setProdnumber(String prodnumber) {
		this.prodnumber = prodnumber;
	}
	
	public Integer getBoxitemnum() {
		return boxitemnum;
	}
	public void setBoxitemnum(Integer boxitemnum) {
		this.boxitemnum = boxitemnum;
	}
	
	public InOutStorBox getInoutstorbox() {
		return inoutstorbox;
	}
	public void setInoutstorbox(InOutStorBox inoutstorbox) {
		this.inoutstorbox = inoutstorbox;
	}
	public List<InOutStorBox> getInoutstorboxlist() {
		return inoutstorboxlist;
	}
	public void setInoutstorboxlist(List<InOutStorBox> inoutstorboxlist) {
		this.inoutstorboxlist = inoutstorboxlist;
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
	public String getKeyname() {
		return keyname;
	}
	public void setKeyname(String keyname) {
		this.keyname = keyname;
	}
	public InOutStor getInoutstorage() {
		return inoutstorage;
	}
	public void setInoutstorage(InOutStor inoutstorage) {
		this.inoutstorage = inoutstorage;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Integer getStortype() {
		return stortype;
	}
	public void setStortype(Integer stortype) {
		this.stortype = stortype;
	}
	public Integer getZstype() {
		return zstype;
	}
	public void setZstype(Integer zstype) {
		this.zstype = zstype;
	}
	public String getStrtotalweight() {
		return strtotalweight;
	}
	public void setStrtotalweight(String strtotalweight) {
		this.strtotalweight = strtotalweight;
	}
	public String getStrtotalmoney() {
		return strtotalmoney;
	}
	public void setStrtotalmoney(String strtotalmoney) {
		this.strtotalmoney = strtotalmoney;
	}
	public String getStrrealtotalweight() {
		return strrealtotalweight;
	}
	public void setStrrealtotalweight(String strrealtotalweight) {
		this.strrealtotalweight = strrealtotalweight;
	}
	public List<Box> getBoxitemlist() {
		return boxitemlist;
	}
	public void setBoxitemlist(List<Box> boxitemlist) {
		this.boxitemlist = boxitemlist;
	}
	public List<BoxItem> getPackitemlist() {
		return packitemlist;
	}
	public void setPackitemlist(List<BoxItem> packitemlist) {
		this.packitemlist = packitemlist;
	}
	public String getGroupInfo() {
		return groupInfo;
	}
	public void setGroupInfo(String groupInfo) {
		this.groupInfo = groupInfo;
	}
	public Integer getTabletboxitemnum() {
		return tabletboxitemnum;
	}
	public void setTabletboxitemnum(Integer tabletboxitemnum) {
		this.tabletboxitemnum = tabletboxitemnum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	

	public String getBoxsCode() {
		return boxsCode;
	}
	public void setBoxsCode(String boxsCode) {
		this.boxsCode = boxsCode;
	}

	public Integer getCodetype() {
		return codetype;
	}
	public void setCodetype(Integer codetype) {
		this.codetype = codetype;
	}
	public Integer getPackstorboxid() {
		return packstorboxid;
	}
	public void setPackstorboxid(Integer packstorboxid) {
		this.packstorboxid = packstorboxid;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}

	
		
	
}
