package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

public class TabletPackLog implements Serializable{
	private static final long serialVersionUID = 1L;
	
	// Fields
	private Integer logid;//饮片库表序列号
	private Integer tabletid; //饮片生产id,关联饮片生产表
	private Integer tabletstorid;//饮片库表序列号
	private String cpctablet;//饮片批次号,关联饮片生产表
	private String tabletname;//饮片名称
	private String prodcode; //商品编码
	private Double tabletweight;//实际产量(单位:g),库存量
	private Integer tabletnum; //饮片包数
	private Double tabletnumweight;//饮片规格,每包重量(单位:g)
	private Integer tabletboxnum;   //箱数
	private Integer tabletboxitemnum;  //每箱包数
	private String province;//
	private String city;
	private String area;
	private String areacode;//地区编码,按国标处理
	private Integer userid;//关联用户id
	private String addtime;
	private Integer orgid;//组织编码


	private String mcontent;      //查询条件
	private int pager_count;      //分页查询总记录
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示行数
	
	private List<TabletPackLog> list;
	private TabletPackLog tabletPackLog;
	public Integer getLogid() {
		return logid;
	}
	public void setLogid(Integer logid) {
		this.logid = logid;
	}
	public Integer getTabletid() {
		return tabletid;
	}
	public void setTabletid(Integer tabletid) {
		this.tabletid = tabletid;
	}
	public String getCpctablet() {
		return cpctablet;
	}
	public void setCpctablet(String cpctablet) {
		this.cpctablet = cpctablet;
	}
	public String getTabletname() {
		return tabletname;
	}
	public void setTabletname(String tabletname) {
		this.tabletname = tabletname;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public Double getTabletweight() {
		return tabletweight;
	}
	public void setTabletweight(Double tabletweight) {
		this.tabletweight = tabletweight;
	}
	public Integer getTabletnum() {
		return tabletnum;
	}
	public void setTabletnum(Integer tabletnum) {
		this.tabletnum = tabletnum;
	}
	public Double getTabletnumweight() {
		return tabletnumweight;
	}
	public void setTabletnumweight(Double tabletnumweight) {
		this.tabletnumweight = tabletnumweight;
	}
	public Integer getTabletboxnum() {
		return tabletboxnum;
	}
	public void setTabletboxnum(Integer tabletboxnum) {
		this.tabletboxnum = tabletboxnum;
	}
	public Integer getTabletboxitemnum() {
		return tabletboxitemnum;
	}
	public void setTabletboxitemnum(Integer tabletboxitemnum) {
		this.tabletboxitemnum = tabletboxitemnum;
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
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
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
	public List<TabletPackLog> getList() {
		return list;
	}
	public void setList(List<TabletPackLog> list) {
		this.list = list;
	}
	public TabletPackLog getTabletPackLog() {
		return tabletPackLog;
	}
	public void setTabletPackLog(TabletPackLog tabletPackLog) {
		this.tabletPackLog = tabletPackLog;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public Integer getTabletstorid() {
		return tabletstorid;
	}
	public void setTabletstorid(Integer tabletstorid) {
		this.tabletstorid = tabletstorid;
	}

}
