package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @Title TabletStorage.java
 * @Package com.po
 * @version 1.0 
 * 饮片库存表
 */
public class TabletStorage implements Serializable{
	private static final long serialVersionUID = 1L;
	
	// Fields
	private Integer tabletstorid;//饮片库表序列号
	private Integer tabletid; //饮片生产id,关联饮片生产表
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
	private Integer state;//饮片库存状态:0有库存,1无库存
	private Integer tablettype;//饮片是否分包:0饮片未分包,1饮片已分包
	private Integer printstate;//打印状态:0未打印,3已打印
	private Integer downstate;//下载状态：0未下载,2已下载
	private Integer flag;
	private Tablet tablet;
	private String tabletnumber;//饮片企业内部批次号 
	private String boxcode; //箱码
	private String packtype; //包装类型（5-小包装；6-中包装；7-袋包装；8-大包装）
	
	private String mcontent;      //查询条件
	private int pager_count;      //分页查询总记录
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示行数
	
	private String packStr;//分包字符串
	private String usetotal;
	
	private List<Tablet> tabletList;
	private List<TabletPackLog> packLogList;
	private List<TabletStorage> tabletStoragelist;
	private TabletStorage tabletStorage;
	private Org org;
	private String returninfo;	//返回消息
	private String boxcodes; // 页面上扫描上的一连串溯源码
	
	private String packcode;//袋码
	private String boxweight;//每箱重量
	private Integer boxitemnum; //每箱实际包数
	
	private InStorSuccessCode inStorSuccessCode;
	
	
	private String codestr; //成功箱码
	private String uncodestr;//失败箱码
	Map<String,List<TabletStorage>> outstoragemap;	//出库MAP
	private Integer codetype;//包装类型（未包装0 小包装5 箱包装6 袋包装7）

	public Map<String, List<TabletStorage>> getOutstoragemap() {
		return outstoragemap;
	}
	public void setOutstoragemap(Map<String, List<TabletStorage>> outstoragemap) {
		this.outstoragemap = outstoragemap;
	}
	public Integer getTabletstorid() {
		return tabletstorid;
	}
	public void setTabletstorid(Integer tabletstorid) {
		this.tabletstorid = tabletstorid;
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
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getTablettype() {
		return tablettype;
	}
	public void setTablettype(Integer tablettype) {
		this.tablettype = tablettype;
	}
	public Integer getPrintstate() {
		return printstate;
	}
	public void setPrintstate(Integer printstate) {
		this.printstate = printstate;
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
	public List<TabletStorage> getTabletStoragelist() {
		return tabletStoragelist;
	}
	public void setTabletStoragelist(List<TabletStorage> tabletStoragelist) {
		this.tabletStoragelist = tabletStoragelist;
	}
	public TabletStorage getTabletStorage() {
		return tabletStorage;
	}
	public void setTabletStorage(TabletStorage tabletStorage) {
		this.tabletStorage = tabletStorage;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public String getPackStr() {
		return packStr;
	}
	public void setPackStr(String packStr) {
		this.packStr = packStr;
	}
	public Tablet getTablet() {
		return tablet;
	}
	public void setTablet(Tablet tablet) {
		this.tablet = tablet;
	}
	public String getBoxcodes() {
		return boxcodes;
	}
	public void setBoxcodes(String boxcodes) {
		this.boxcodes = boxcodes;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getBoxweight() {
		return boxweight;
	}
	public void setBoxweight(String boxweight) {
		this.boxweight = boxweight;
	}
	public String getBoxcode() {
		return boxcode;
	}
	public void setBoxcode(String boxcode) {
		this.boxcode = boxcode;
	}
	public String getCodestr() {
		return codestr;
	}
	public void setCodestr(String codestr) {
		this.codestr = codestr;
	}
	public String getUncodestr() {
		return uncodestr;
	}
	public void setUncodestr(String uncodestr) {
		this.uncodestr = uncodestr;
	}
	public Integer getBoxitemnum() {
		return boxitemnum;
	}
	public void setBoxitemnum(Integer boxitemnum) {
		this.boxitemnum = boxitemnum;
	}
	public String getUsetotal() {
		return usetotal;
	}
	public void setUsetotal(String usetotal) {
		this.usetotal = usetotal;
	}
	public Double getTabletnumweight() {
		return tabletnumweight;
	}
	public void setTabletnumweight(Double tabletnumweight) {
		this.tabletnumweight = tabletnumweight;
	}
	public Integer getDownstate() {
		return downstate;
	}
	public void setDownstate(Integer downstate) {
		this.downstate = downstate;
	}
	public Org getOrg() {
		return org;
	}
	public void setOrg(Org org) {
		this.org = org;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public String getPackcode() {
		return packcode;
	}
	public void setPackcode(String packcode) {
		this.packcode = packcode;
	}
	public Integer getCodetype() {
		return codetype;
	}
	public void setCodetype(Integer codetype) {
		this.codetype = codetype;
	}
	public String getTabletnumber() {
		return tabletnumber;
	}
	public void setTabletnumber(String tabletnumber) {
		this.tabletnumber = tabletnumber;
	}
	public List<Tablet> getTabletList() {
		return tabletList;
	}
	public void setTabletList(List<Tablet> tabletList) {
		this.tabletList = tabletList;
	}
	public List<TabletPackLog> getPackLogList() {
		return packLogList;
	}
	public void setPackLogList(List<TabletPackLog> packLogList) {
		this.packLogList = packLogList;
	}
	public InStorSuccessCode getInStorSuccessCode() {
		return inStorSuccessCode;
	}
	public void setInStorSuccessCode(InStorSuccessCode inStorSuccessCode) {
		this.inStorSuccessCode = inStorSuccessCode;
	}
	public String getPacktype() {
		return packtype;
	}
	public void setPacktype(String packtype) {
		this.packtype = packtype;
	}
	
}
