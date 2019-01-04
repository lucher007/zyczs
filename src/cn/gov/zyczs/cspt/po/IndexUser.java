package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title IndexUser.java 中药价格指数品种
 * @Package com.po.xml
 * @version 1.0 
 */
public class IndexUser implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int indexuserid;//自增列
	private String indexusercode;//药材的编码
	private String indexusername;//药材的名称
	
	/***********数据库辅助字段**************/
	private String indexweekid;
	private String indexweekdate;
	private String indexweekcode;
	private String indexweekname;
	private Double indexweekvalue;
	private String indexweekperiod = "month";
	private String price;
	private String pricelimits;
	private int inserttime;//没导入一个xml此变量自增1
	private int pilltype;//药材类型　1:药材2饮片
	
	private String weekpriceindex = "本周价格指数";//本周价格指数
 	private String monthpriceindex = "本月价格指数";//本月价格指数
 	private String weekupdownvalue = "本周涨跌幅";//本周涨跌幅
	private String startindexweekdate;//开始时间
	private String endindexweekdate;//结束时间
	
	private String md = "麦冬";
	private String xf = "香附";
	private String sbx = "水半夏";
	private String cbm = "川贝母";
	private String zx = "泽泻";
	private Integer orgid;//组织id
	private Integer corptype;//企业类型 0为市场 1为其它类型
	private String cpccorp;//企业cpc
	private String medname;
	
	private List<IndexUser> indexuserlist;
	private List<MedStorage> medstorage;
	private List<MedStat> medstat;
	
	public List<IndexUser> getIndexuserlist() {
		return indexuserlist;
	}
	public void setIndexuserlist(List<IndexUser> indexuserlist) {
		this.indexuserlist = indexuserlist;
	}
	public String getMedname() {
		return medname;
	}
	public void setMedname(String medname) {
		this.medname = medname;
	}
	public List<MedStorage> getMedstorage() {
		return medstorage;
	}
	public void setMedstorage(List<MedStorage> medstorage) {
		this.medstorage = medstorage;
	}
	public List<MedStat> getMedstat() {
		return medstat;
	}
	public void setMedstat(List<MedStat> medstat) {
		this.medstat = medstat;
	}
	public Integer getCorptype() {
		return corptype;
	}
	public void setCorptype(Integer corptype) {
		this.corptype = corptype;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getMd() {
		return md;
	}
	public void setMd(String md) {
		this.md = md;
	}
	public String getXf() {
		return xf;
	}
	public void setXf(String xf) {
		this.xf = xf;
	}
	public String getSbx() {
		return sbx;
	}
	public void setSbx(String sbx) {
		this.sbx = sbx;
	}
	public String getCbm() {
		return cbm;
	}
	public void setCbm(String cbm) {
		this.cbm = cbm;
	}
	public String getZx() {
		return zx;
	}
	public void setZx(String zx) {
		this.zx = zx;
	}
	public String getStartindexweekdate() {
		return startindexweekdate;
	}
	public void setStartindexweekdate(String startindexweekdate) {
		this.startindexweekdate = startindexweekdate;
	}
	public String getEndindexweekdate() {
		return endindexweekdate;
	}
	public void setEndindexweekdate(String endindexweekdate) {
		this.endindexweekdate = endindexweekdate;
	}
	public int getPilltype() {
		return pilltype;
	}
	public void setPilltype(int pilltype) {
		this.pilltype = pilltype;
	}
	public String getIndexweekdate() {
		return indexweekdate;
	}
	public void setIndexweekdate(String indexweekdate) {
		this.indexweekdate = indexweekdate;
	}
	public String getIndexweekname() {
		return indexweekname;
	}
	public void setIndexweekname(String indexweekname) {
		this.indexweekname = indexweekname;
	}
	public Double getIndexweekvalue() {
		return indexweekvalue;
	}
	public void setIndexweekvalue(Double indexweekvalue) {
		this.indexweekvalue = indexweekvalue;
	}
	public int getIndexuserid() {
		return indexuserid;
	}
	public void setIndexuserid(int indexuserid) {
		this.indexuserid = indexuserid;
	}
	public String getIndexusercode() {
		return indexusercode;
	}
	public void setIndexusercode(String indexusercode) {
		this.indexusercode = indexusercode;
	}
	public String getIndexusername() {
		return indexusername;
	}
	public void setIndexusername(String indexusername) {
		this.indexusername = indexusername;
	}
	public IndexUser() {
		super();
	}
	public String getIndexweekid() {
		return indexweekid;
	}
	public void setIndexweekid(String indexweekid) {
		this.indexweekid = indexweekid;
	}
	public String getIndexweekcode() {
		return indexweekcode;
	}
	public void setIndexweekcode(String indexweekcode) {
		this.indexweekcode = indexweekcode;
	}
	public String getIndexweekperiod() {
		return indexweekperiod;
	}
	public void setIndexweekperiod(String indexweekperiod) {
		this.indexweekperiod = indexweekperiod;
	}
	public int getInserttime() {
		return inserttime;
	}
	public void setInserttime(int inserttime) {
		this.inserttime = inserttime;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPricelimits() {
		return pricelimits;
	}
	public void setPricelimits(String pricelimits) {
		this.pricelimits = pricelimits;
	}
	public String getWeekpriceindex() {
		return weekpriceindex;
	}
	public void setWeekpriceindex(String weekpriceindex) {
		this.weekpriceindex = weekpriceindex;
	}
	public String getMonthpriceindex() {
		return monthpriceindex;
	}
	public void setMonthpriceindex(String monthpriceindex) {
		this.monthpriceindex = monthpriceindex;
	}
	public String getWeekupdownvalue() {
		return weekupdownvalue;
	}
	public void setWeekupdownvalue(String weekupdownvalue) {
		this.weekupdownvalue = weekupdownvalue;
	}
}

