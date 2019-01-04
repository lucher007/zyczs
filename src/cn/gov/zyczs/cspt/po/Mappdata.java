package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * 溯源秤
 * SMappdata entity. @author MyEclipse Persistence Tools
 */

public class Mappdata implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String scalecode;           //溯源秤编码（32位）
	private String usercode;            //14位买家企业代码（仅溯源地秤传输，非溯源地秤本数据为空白）
	private String buyusercode;         //14位卖家企业代码(CPC规范)
	private String sourcecode;          //溯源码
	private String commoditycode;       //商品代码（20位）
	private String tradingtime;         //交易时间：yyyy-MM-dd hh:mm:ss
	private Double unitprice;           //单价（元/Kg）
	private Double weight;              //重量（Kg）
	private Double totalprice;          //总价（元）
	private String addtime;             //入库时间
	private String isupload;            //0需要上传 1已上传 默认为0
	
	private String corpname;			//组织名称
	private String name;			    //品名
	private String endtime;             //交易结束时间
	private String starttime;           //交易开始时间
	
	
	private String returninfo;	        //返回消息
	private int pager_count;	        //分页总数
	private int pager_offset;	        //分页量
	private int pager_openset;	        //分页量
	
	private List<Mappdata> mappdataList;
	
	private String medname;//药材名称
	private String prodcode;//商品代码（20位）
	private Double medweight;//
	public String getMedname() {
		return medname;
	}

	public void setMedname(String medname) {
		this.medname = medname;
	}

	public String getProdcode() {
		return prodcode;
	}

	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}

	/**
	 * 
	 */
	public Mappdata() {
		super();
	}
	
	/**
	 * @param addtime
	 * @param buyusercode
	 * @param commoditycode
	 * @param corpname
	 * @param endtime
	 * @param isupload
	 * @param mappdataList
	 * @param pager_count
	 * @param pager_offset
	 * @param pager_openset
	 * @param returninfo
	 * @param scalecode
	 * @param sourcecode
	 * @param starttime
	 * @param totalprice
	 * @param tradingtime
	 * @param unitprice
	 * @param usercode
	 * @param weight
	 */
	public Mappdata(String addtime, String buyusercode, String commoditycode,
			String corpname, String endtime, String isupload,
			List<Mappdata> mappdataList, int pager_count, int pager_offset,
			int pager_openset, String returninfo, String scalecode,
			String sourcecode, String starttime, Double totalprice,
			String tradingtime, Double unitprice, String usercode, Double weight) {
		super();
		this.addtime = addtime;
		this.buyusercode = buyusercode;
		this.commoditycode = commoditycode;
		this.corpname = corpname;
		this.endtime = endtime;
		this.isupload = isupload;
		this.mappdataList = mappdataList;
		this.pager_count = pager_count;
		this.pager_offset = pager_offset;
		this.pager_openset = pager_openset;
		this.returninfo = returninfo;
		this.scalecode = scalecode;
		this.sourcecode = sourcecode;
		this.starttime = starttime;
		this.totalprice = totalprice;
		this.tradingtime = tradingtime;
		this.unitprice = unitprice;
		this.usercode = usercode;
		this.weight = weight;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public List<Mappdata> getMappdataList() {
		return mappdataList;
	}
	public void setMappdataList(List<Mappdata> mappdataList) {
		this.mappdataList = mappdataList;
	}
	public String getScalecode() {
		return scalecode;
	}
	public void setScalecode(String scalecode) {
		this.scalecode = scalecode;
	}
	public String getUsercode() {
		return usercode;
	}
	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}
	public String getBuyusercode() {
		return buyusercode;
	}
	public void setBuyusercode(String buyusercode) {
		this.buyusercode = buyusercode;
	}
	public String getSourcecode() {
		return sourcecode;
	}
	public void setSourcecode(String sourcecode) {
		this.sourcecode = sourcecode;
	}
	public String getCommoditycode() {
		return commoditycode;
	}
	public void setCommoditycode(String commoditycode) {
		this.commoditycode = commoditycode;
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
	public String getIsupload() {
		return isupload;
	}
	public void setIsupload(String isupload) {
		this.isupload = isupload;
	}
	
	public String getCorpname() {
		return corpname;
	}



	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}



	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
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

	public String getTradingtime() {
		if(tradingtime == null || tradingtime.length() < 10){
			return null;
		}else{
			tradingtime	= tradingtime.substring(0,tradingtime.length() - 2);
		}
		return tradingtime;
	}

	public void setTradingtime(String tradingtime) {
		this.tradingtime = tradingtime;
	}

//	public String getAddtime() {
//		if(addtime == null || addtime.length() < 10){
//			return null;
//		}else{
//			addtime	= addtime.substring(0,10);
//		}
//		return addtime;
//	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public String getAddtime() {
		return addtime;
	}
//
//	public String getTradingtime() {
//		return tradingtime;
//	}

	public Double getMedweight() {
		return medweight;
	}

	public void setMedweight(Double medweight) {
		this.medweight = medweight;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}