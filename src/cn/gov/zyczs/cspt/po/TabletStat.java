package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * 生产平台 统计分析实体类
 * 
 */
public class TabletStat {

	private Integer orgid;// 组织编号
	private List<TabletStat> tabletStatList;

	// ////////分页所需字段///////////
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量

	// //////////////生产平台 药材库存统计所需字段//////////////////
	private String medname;// 药材名
	private String cpcmed;// 药材批次号
	public String getMednumber() {
		return mednumber;
	}

	public void setMednumber(String mednumber) {
		this.mednumber = mednumber;
	}

	private String mednumber;// 药材批次号
	private Double mednumweight;// 药材重量
	private Double medweight;// 药材重量
	private String medaddtime;// 药材入库时间
	private String medendtime;// 药材入库时间
	private Integer medstate;// 库存状态, 0-有库存,1-无库存

	// //////////////生产平台 饮片库存统计所需字段//////////////////
	private String tabletname;// 饮片名称
	private String cpctablet; // 饮片批次号
	private String tabletnumber; // 饮片内部批次号
	private Double tabletweight; // 饮片重量
	private String tabletaddtime;// 入库时间
	private String tabletendtime;// 入库时间
	private Integer tabletnumweight;// 饮片规格
	private Integer tabletnum;// 饮片包数
	private Integer tabletboxnum;// 饮片箱数
	private Integer tabletboxitemnum;//饮片每箱包数
	private Integer tabletstate;// 库存状态, 0-有库存,1-无库存
	private Integer tablettype; // 分包状态, 0-未分包,1-已分包
	
	//饮片销售统计
	private Integer boxnum;      //箱数
	private Integer boxitemnum;  //包数
	private Double sumweight;   //所有的记录的总重量
	private String  outime;      //销售时间
	private Integer type;       // 类型:药材0,饮片1
	private Integer stortype; //出入库状态：0入库 1出库
	private String prodname;     //药材或者饮片名称
	private String batchcpc;     //药材或者饮片批次号
	private String boxnumweight; //包装重量(规格)
	private String querybegintime;  //查询开始时间
	private String queryendtime;    //查询结束时间
	private Double totalweight;     //总重量
	private Double totalmoney;     //总价钱
	private String strtotalweight; //总重量字符串化
	private String strtotalmoney;  //总价的字符串化
	private String strsumweight;   //所有的记录的总重量的字符串化
	private String strsummoney;   //所有的记录的总价的字符串化
	private List<TabletStat> tabletStatlist;
	private List<TabletStorage> tabletStoragelist;
	private Integer codetype;
	private String boxcode;   //溯源码
	
	public String getMedname() {
		return medname;
	}

	public void setMedname(String medname) {
		this.medname = medname;
	}

	public String getCpcmed() {
		return cpcmed;
	}

	public void setCpcmed(String cpcmed) {
		this.cpcmed = cpcmed;
	}

	public Integer getOrgid() {
		return orgid;
	}

	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}

	public Double getMedweight() {
		return medweight;
	}

	public void setMedweight(Double medweight) {
		this.medweight = medweight;
	}

	public String getMedaddtime() {
		return medaddtime;
	}

	public void setMedaddtime(String medaddtime) {
		this.medaddtime = medaddtime;
	}

	public String getMedendtime() {
		return medendtime;
	}

	public void setMedendtime(String medendtime) {
		this.medendtime = medendtime;
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

	public List<TabletStat> getTabletStatList() {
		return tabletStatList;
	}

	public void setTabletStatList(List<TabletStat> tabletStatList) {
		this.tabletStatList = tabletStatList;
	}

	public String getTabletname() {
		return tabletname;
	}

	public void setTabletname(String tabletname) {
		this.tabletname = tabletname;
	}

	public String getCpctablet() {
		return cpctablet;
	}

	public void setCpctablet(String cpctablet) {
		this.cpctablet = cpctablet;
	}

	public String getTabletnumber() {
		return tabletnumber;
	}

	public void setTabletnumber(String tabletnumber) {
		this.tabletnumber = tabletnumber;
	}

	public Double getTabletweight() {
		return tabletweight;
	}

	public void setTabletweight(Double tabletweight) {
		this.tabletweight = tabletweight;
	}

	public String getTabletaddtime() {
		return tabletaddtime;
	}

	public void setTabletaddtime(String tabletaddtime) {
		this.tabletaddtime = tabletaddtime;
	}

	public String getTabletendtime() {
		return tabletendtime;
	}

	public void setTabletendtime(String tabletendtime) {
		this.tabletendtime = tabletendtime;
	}

	public Integer getTabletnumweight() {
		return tabletnumweight;
	}

	public void setTabletnumweight(Integer tabletnumweight) {
		this.tabletnumweight = tabletnumweight;
	}

	public Integer getTabletnum() {
		return tabletnum;
	}

	public void setTabletnum(Integer tabletnum) {
		this.tabletnum = tabletnum;
	}

	public Integer getTabletboxnum() {
		return tabletboxnum;
	}

	public void setTabletboxnum(Integer tabletboxnum) {
		this.tabletboxnum = tabletboxnum;
	}

	public Integer getMedstate() {
		return medstate;
	}

	public void setMedstate(Integer medstate) {
		this.medstate = medstate;
	}

	public Integer getTabletstate() {
		return tabletstate;
	}

	public void setTabletstate(Integer tabletstate) {
		this.tabletstate = tabletstate;
	}

	public Integer getBoxnum() {
		return boxnum;
	}

	public void setBoxnum(Integer boxnum) {
		this.boxnum = boxnum;
	}

	public Double getSumweight() {
		return sumweight;
	}

	public void setSumweight(Double sumweight) {
		this.sumweight = sumweight;
	}

	public String getOutime() {
		return outime;
	}

	public void setOutime(String outime) {
		this.outime = outime;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public List<TabletStat> getTabletStatlist() {
		return tabletStatlist;
	}

	public void setTabletStatlist(List<TabletStat> tabletStatlist) {
		this.tabletStatlist = tabletStatlist;
	}

	public String getQuerybegintime() {
		return querybegintime;
	}

	public void setQuerybegintime(String querybegintime) {
		this.querybegintime = querybegintime;
	}

	public String getQueryendtime() {
		return queryendtime;
	}

	public void setQueryendtime(String queryendtime) {
		this.queryendtime = queryendtime;
	}

	public Double getTotalweight() {
		return totalweight;
	}

	public void setTotalweight(Double totalweight) {
		this.totalweight = totalweight;
	}

	public Double getTotalmoney() {
		return totalmoney;
	}

	public void setTotalmoney(Double totalmoney) {
		this.totalmoney = totalmoney;
	}

	public Integer getStortype() {
		return stortype;
	}

	public void setStortype(Integer stortype) {
		this.stortype = stortype;
	}

	public String getProdname() {
		return prodname;
	}

	public void setProdname(String prodname) {
		this.prodname = prodname;
	}

	public String getBatchcpc() {
		return batchcpc;
	}

	public void setBatchcpc(String batchcpc) {
		this.batchcpc = batchcpc;
	}

	public String getBoxnumweight() {
		return boxnumweight;
	}

	public void setBoxnumweight(String boxnumweight) {
		this.boxnumweight = boxnumweight;
	}

	public List<TabletStorage> getTabletStoragelist() {
		return tabletStoragelist;
	}

	public void setTabletStoragelist(List<TabletStorage> tabletStoragelist) {
		this.tabletStoragelist = tabletStoragelist;
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

	public String getStrsumweight() {
		return strsumweight;
	}

	public void setStrsumweight(String strsumweight) {
		this.strsumweight = strsumweight;
	}

	public String getStrsummoney() {
		return strsummoney;
	}

	public void setStrsummoney(String strsummoney) {
		this.strsummoney = strsummoney;
	}

	public Integer getBoxitemnum() {
		return boxitemnum;
	}

	public void setBoxitemnum(Integer boxitemnum) {
		this.boxitemnum = boxitemnum;
	}

	public Integer getCodetype() {
		return codetype;
	}

	public void setCodetype(Integer codetype) {
		this.codetype = codetype;
	}

	public Integer getTablettype() {
		return tablettype;
	}

	public void setTablettype(Integer tablettype) {
		this.tablettype = tablettype;
	}

	public Integer getTabletboxitemnum() {
		return tabletboxitemnum;
	}

	public void setTabletboxitemnum(Integer tabletboxitemnum) {
		this.tabletboxitemnum = tabletboxitemnum;
	}

	public Double getMednumweight() {
		return mednumweight;
	}

	public String getBoxcode() {
		return boxcode;
	}

	public void setBoxcode(String boxcode) {
		this.boxcode = boxcode;
	}

	public void setMednumweight(Double mednumweight) {
		this.mednumweight = mednumweight;
	}

}
