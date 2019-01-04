package cn.gov.zyczs.cspt.po;

import java.util.Date;
import java.util.List;

/**
 * 溯源秤交易记录
 * SMappdata entity. @author MyEclipse Persistence Tools
 */

public class ChengData implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	
	private Integer tradeid;            //交易记录ID
	private String chengcode;           //溯源秤编码
	private String sellcpccorp;         //14位卖家企业代码（仅溯源地秤传输，非溯源地秤本数据为空白）
	private String sellcorpname;        //卖家企业名称
	private String buycpccorp;          //14位卖家企业代码(CPC规范)
	private String buycorpname;         //买家企业名称
	private String prodcode;            //商品代码（20位）
	private String medname;             //药材名称
	private String cpcmed;              //药材批次码
	private String tradetime;           //交易时间
	private Double unitprice;           //单价（元/Kg）
	private Double weight;              //重量（Kg）
	private Double totalprice;          //总价（元）
	private String sourcecode;          //溯源码
	
	private int pager_count;	        //分页总数
	private int pager_offset;	        //当页第一行的序号
	private int pager_openset;	        //当页显示个数
	private List<ChengData> chengdatalist;
	private ChengData chengdata;
	private String operstarttime;       //查询开始时间
	private String operendtime;         //查询结束时间
	private String marketcode;          //市场经商户的市场CPC
	private String cpccorp;             //市场经商户单位的CPC
	
	private Integer querytype;          //手持机查询类型
	private String returninfo;
	public Integer getTradeid() {
		return tradeid;
	}
	public void setTradeid(Integer tradeid) {
		this.tradeid = tradeid;
	}
	public String getChengcode() {
		return chengcode;
	}
	public void setChengcode(String chengcode) {
		this.chengcode = chengcode;
	}
	public String getSellcpccorp() {
		return sellcpccorp;
	}
	public void setSellcpccorp(String sellcpccorp) {
		this.sellcpccorp = sellcpccorp;
	}
	public String getBuycpccorp() {
		return buycpccorp;
	}
	public void setBuycpccorp(String buycpccorp) {
		this.buycpccorp = buycpccorp;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
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
	public String getTradetime() {
		return tradetime;
	}
	public void setTradetime(String tradetime) {
		this.tradetime = tradetime;
	}
	public Double getUnitprice() {
		return unitprice;
	}
	public void setUnitprice(Double unitprice) {
		this.unitprice = unitprice;
	}
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
	}
	public Double getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(Double totalprice) {
		this.totalprice = totalprice;
	}
	public String getSourcecode() {
		return sourcecode;
	}
	public void setSourcecode(String sourcecode) {
		this.sourcecode = sourcecode;
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
	public List<ChengData> getChengdatalist() {
		return chengdatalist;
	}
	public void setChengdatalist(List<ChengData> chengdatalist) {
		this.chengdatalist = chengdatalist;
	}
	public ChengData getChengdata() {
		return chengdata;
	}
	public void setChengdata(ChengData chengdata) {
		this.chengdata = chengdata;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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
	public String getMarketcode() {
		return marketcode;
	}
	public void setMarketcode(String marketcode) {
		this.marketcode = marketcode;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public Integer getQuerytype() {
		return querytype;
	}
	public void setQuerytype(Integer querytype) {
		this.querytype = querytype;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	
}