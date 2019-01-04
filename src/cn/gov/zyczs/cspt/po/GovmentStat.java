package cn.gov.zyczs.cspt.po;

import java.util.List;
import java.util.Map;

/**
 * 监管平台 统计分析实体类
 * 
 */
public class GovmentStat {
    
	//交易统计
	
	private Integer type;     // 类型:药材0,饮片1
	private Integer stortype; //出入库状态：0入库 1出库
	private String prodname;  //药材或者饮片名称
	private String opertime;  //销售时间
	private String province;   //省
	private String city;      //市
	private String area;      //区域
	private String areacode;		//区域号 
	private String zyctype;   //流通类型：药材种植平台-10000000,药材经销商-01000000,饮片生产-00100000,饮片经销商-00010000,市场-00001000,医院-00000100,管理机构-00000010,,其他-00000001
	
	private Double totalweight;     //总重量
	private Double totalmoney;     //总金额
	private Double totalprice;     //价格总和
	private Double averageprice;   //平均价格
	private String strtotalweight; //总重量字符串化
	private String strtotalmoney;  //总金额的字符串化
	private String strtotalprice;   //价格总和的字符串化
	private String straverageprice;   //平均价格字符串化
	
	private String scalecode;      //溯源秤号
	private String scalenorm;      //溯源秤规格
	private Integer scalestate;    //溯源秤状态0表示可用，1表示不可用
	private String addtime;        //添加时间
	private String usercode;       //经营户id
	private String corpname;       //商户名称
	
	
	
	private List<GovmentStat> govmentstatlist;
	
	// ////////分页所需字段///////////
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量
	
	//查询条件
	private String querybegintime;  //查询开始时间
	private String queryendtime;    //查询结束时间
	private String datestattype;    //查询结束时间
	
	//节点企业分布
	Map<String, List<Org>> orgmap; // 出库MAP
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
	public String getProdname() {
		return prodname;
	}
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	public String getOpertime() {
		return opertime;
	}
	public void setOpertime(String opertime) {
		this.opertime = opertime;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getZyctype() {
		return zyctype;
	}
	public void setZyctype(String zyctype) {
		this.zyctype = zyctype;
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
	public Double getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(Double totalprice) {
		this.totalprice = totalprice;
	}
	public Double getAverageprice() {
		return averageprice;
	}
	public void setAverageprice(Double averageprice) {
		this.averageprice = averageprice;
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
	public String getStrtotalprice() {
		return strtotalprice;
	}
	public void setStrtotalprice(String strtotalprice) {
		this.strtotalprice = strtotalprice;
	}
	public String getStraverageprice() {
		return straverageprice;
	}
	public void setStraverageprice(String straverageprice) {
		this.straverageprice = straverageprice;
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
	public List<GovmentStat> getGovmentstatlist() {
		return govmentstatlist;
	}
	public void setGovmentstatlist(List<GovmentStat> govmentstatlist) {
		this.govmentstatlist = govmentstatlist;
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
	public Map<String, List<Org>> getOrgmap() {
		return orgmap;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getScalecode() {
		return scalecode;
	}
	public void setScalecode(String scalecode) {
		this.scalecode = scalecode;
	}
	public String getScalenorm() {
		return scalenorm;
	}
	public void setScalenorm(String scalenorm) {
		this.scalenorm = scalenorm;
	}
	public Integer getScalestate() {
		return scalestate;
	}
	public void setScalestate(Integer scalestate) {
		this.scalestate = scalestate;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getCorpname() {
		return corpname;
	}
	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}
	public void setOrgmap(Map<String, List<Org>> orgmap) {
		this.orgmap = orgmap;
	}
	public String getDatestattype() {
		return datestattype;
	}
	public void setDatestattype(String datestattype) {
		this.datestattype = datestattype;
	}
	
}
