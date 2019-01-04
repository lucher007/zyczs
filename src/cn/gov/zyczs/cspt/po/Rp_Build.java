package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class Rp_Build implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private Integer plantNum;
	private Integer medSellNum;
	private Integer marketNum;
	private Integer tabletNum;
	private Integer tabletSellNum;
	private Integer hospitalNum;
	private String operstarttime;       //查询开始时间
	private String operendtime;         //查询结束时间
	private String opertime;            //查询时间
	
	private String zyctype;
	private Integer num;
	private Double rate;
	private Double formalrate;
	private Double informalrate;
	private Double weight;
	private Double totalweight;
	
	//溯源秤分发统计
	private Integer plansendnum; //计划分发数量
	
	//种子种苗来源统计参数
	private Double buyweight;   //自购重量
	private Double plantweight; //栽培重量
	private Double wildweight;  //野生重量
	private Double buyrate;     //自购比例
	private Double plantrate;   //栽培比例
	private Double wildrate;    //野生比例
	private String plantsource_buy="自购";
	private String plantsource_plant="栽培";
	private String plantsource_wild="野生";
	private String plantname;   //种植名称
	private String username;    //林业局、农业局
	
	//中药材交易次数/重量统计参数
	private Integer tradetimes;        //交易次数
	private Double tradeweight;        //交易重量
	private Integer medtradetimes;     //药材交易次数
	private Integer tablettradetimes;  //饮片交易次数
	private Double medtraderate;       //药材交易比例
	private Double tablettraderate;    //饮片交易比例
	private Map<String,Number> tradeweightmap;
	private Map<String,Number> tradeweightcontrastmap;
	
	//中药材打码数量统计参数
	private String codetype;           //打码类型
	private Integer codenum;           //打码总量
	private Integer medcodenum;        //药材打码总量
	private Integer tabletcodenum;     //饮片打码总量
	private Integer medcoderate;       //药材打码比例
	private Integer tabletcoderate;    //饮片打码比例
	
	//中药材检验率统计参数
	private Double checkedweight; //检验重量
	private Double uncheckedweight;//未检验重量
	private Double checkedrate;    //检查率
	private Double uncheckedrate;    //未检查率
	private Map<String,Double> checkedmap;
	private Map<String,Double> checkedcontrastmap;
	
	//中药材上传检验报告(合格)率统计参数
	private String checktype;  //检验类型 :药材-0 饮片-1
	private Double mattedweight; //合格重量
	private Double mattedrate;  //合格率
	private Map<String,Double> mattedmap;
	private Map<String,Double> mattedcontrastmap;
	
	//分页参数
	private int pager_count;                //总数目
	private int pager_offset;               //当页第一行的序号
	private int pager_openset;              //当页显示个数
	private Rp_Build build;		            //建设PO对象
	private List<Rp_Build> buildlist;       //建设PO集合
	private Map<String,Integer> buildmap;
	private Map<String,Integer> buildcontrastmap;
	
	
	//导出报表
	private String filename;   //文件名称
	private String cpccorp;    //企业CPC
	private String orgname;    //企业名称
	private String mobile;     //联系电话
	private String medstorweight; //药材库存量
	private String tabletstorweight; //饮片库存量
	private String medtradeweight; //药材交易量
	private String tablettradeweight; //饮片交易量
	private String totaltradeweight; //交易总量
	
	//市场发秤用户
	private String registeraddress; //注册地址
	private String businessnumber;  //营业执照
	private String telephone;       //固定电话
	private String linkman;         //联系人
	private String masterman;       //法人
	private int chengflag;          //是否发送秤0-未发送；1-已发送
	
	//企业溯源秤交易次数/重量统计参数
	private String strtradetimes;        //交易次数
	private String strtradeweight;        //交易重量
	
	//企业打印溯源码数量统计
	private String strcodenum;
	
	//药材、饮片、溯源秤打码量统计
	private String strmedcodenum;
	private String strtabletcodenum;
	private String strchengcodenum;
	
	public Integer getPlantNum() {
		return plantNum;
	}
	public void setPlantNum(Integer plantNum) {
		this.plantNum = plantNum;
	}
	public Integer getMedSellNum() {
		return medSellNum;
	}
	public void setMedSellNum(Integer medSellNum) {
		this.medSellNum = medSellNum;
	}
	public Integer getMarketNum() {
		return marketNum;
	}
	public void setMarketNum(Integer marketNum) {
		this.marketNum = marketNum;
	}
	public Integer getTabletNum() {
		return tabletNum;
	}
	public void setTabletNum(Integer tabletNum) {
		this.tabletNum = tabletNum;
	}
	public Integer getTabletSellNum() {
		return tabletSellNum;
	}
	public void setTabletSellNum(Integer tabletSellNum) {
		this.tabletSellNum = tabletSellNum;
	}
	public Integer getHospitalNum() {
		return hospitalNum;
	}
	public void setHospitalNum(Integer hospitalNum) {
		this.hospitalNum = hospitalNum;
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
	public String getOpertime() {
		return opertime;
	}
	public void setOpertime(String opertime) {
		this.opertime = opertime;
	}
	public String getZyctype() {
		return zyctype;
	}
	public void setZyctype(String zyctype) {
		this.zyctype = zyctype;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Double getRate() {
		return rate;
	}
	public void setRate(Double rate) {
		this.rate = rate;
	}
	public Double getFormalrate() {
		return formalrate;
	}
	public void setFormalrate(Double formalrate) {
		this.formalrate = formalrate;
	}
	public Double getInformalrate() {
		return informalrate;
	}
	public void setInformalrate(Double informalrate) {
		this.informalrate = informalrate;
	}
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
	}
	public Double getTotalweight() {
		return totalweight;
	}
	public void setTotalweight(Double totalweight) {
		this.totalweight = totalweight;
	}
	public Integer getPlansendnum() {
		return plansendnum;
	}
	public void setPlansendnum(Integer plansendnum) {
		this.plansendnum = plansendnum;
	}
	public Double getBuyweight() {
		return buyweight;
	}
	public void setBuyweight(Double buyweight) {
		this.buyweight = buyweight;
	}
	public Double getWildweight() {
		return wildweight;
	}
	public void setWildweight(Double wildweight) {
		this.wildweight = wildweight;
	}
	public String getPlantsource_buy() {
		return plantsource_buy;
	}
	public void setPlantsource_buy(String plantsourceBuy) {
		plantsource_buy = plantsourceBuy;
	}
	public String getPlantsource_plant() {
		return plantsource_plant;
	}
	public void setPlantsource_plant(String plantsourcePlant) {
		plantsource_plant = plantsourcePlant;
	}
	public String getPlantsource_wild() {
		return plantsource_wild;
	}
	public void setPlantsource_wild(String plantsourceWild) {
		plantsource_wild = plantsourceWild;
	}
	public String getPlantname() {
		return plantname;
	}
	public void setPlantname(String plantname) {
		this.plantname = plantname;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getMedtradetimes() {
		return medtradetimes;
	}
	public void setMedtradetimes(Integer medtradetimes) {
		this.medtradetimes = medtradetimes;
	}
	public Integer getTablettradetimes() {
		return tablettradetimes;
	}
	public void setTablettradetimes(Integer tablettradetimes) {
		this.tablettradetimes = tablettradetimes;
	}
	public Double getMedtraderate() {
		return medtraderate;
	}
	public void setMedtraderate(Double medtraderate) {
		this.medtraderate = medtraderate;
	}
	public Double getTablettraderate() {
		return tablettraderate;
	}
	public void setTablettraderate(Double tablettraderate) {
		this.tablettraderate = tablettraderate;
	}
	public Map<String, Number> getTradeweightmap() {
		return tradeweightmap;
	}
	public void setTradeweightmap(Map<String, Number> tradeweightmap) {
		this.tradeweightmap = tradeweightmap;
	}
	public Map<String, Number> getTradeweightcontrastmap() {
		return tradeweightcontrastmap;
	}
	public void setTradeweightcontrastmap(Map<String, Number> tradeweightcontrastmap) {
		this.tradeweightcontrastmap = tradeweightcontrastmap;
	}
	public Double getBuyrate() {
		return buyrate;
	}
	public void setBuyrate(Double buyrate) {
		this.buyrate = buyrate;
	}
	public Double getPlantrate() {
		return plantrate;
	}
	public void setPlantrate(Double plantrate) {
		this.plantrate = plantrate;
	}
	public Double getWildrate() {
		return wildrate;
	}
	public void setWildrate(Double wildrate) {
		this.wildrate = wildrate;
	}
	public Double getPlantweight() {
		return plantweight;
	}
	public void setPlantweight(Double plantweight) {
		this.plantweight = plantweight;
	}
	public Integer getTradetimes() {
		return tradetimes;
	}
	public void setTradetimes(Integer tradetimes) {
		this.tradetimes = tradetimes;
	}
	public Double getTradeweight() {
		return tradeweight;
	}
	public void setTradeweight(Double tradeweight) {
		this.tradeweight = tradeweight;
	}
	public Map<String, Integer> getBuildmap() {
		return buildmap;
	}
	public void setBuildmap(Map<String, Integer> buildmap) {
		this.buildmap = buildmap;
	}
	
	public Map<String, Integer> getBuildcontrastmap() {
		return buildcontrastmap;
	}
	public void setBuildcontrastmap(Map<String, Integer> buildcontrastmap) {
		this.buildcontrastmap = buildcontrastmap;
	}
	public String getCodetype() {
		return codetype;
	}
	public void setCodetype(String codetype) {
		this.codetype = codetype;
	}
	public Integer getCodenum() {
		return codenum;
	}
	public void setCodenum(Integer codenum) {
		this.codenum = codenum;
	}
	public Integer getMedcodenum() {
		return medcodenum;
	}
	public void setMedcodenum(Integer medcodenum) {
		this.medcodenum = medcodenum;
	}
	public Integer getTabletcodenum() {
		return tabletcodenum;
	}
	public void setTabletcodenum(Integer tabletcodenum) {
		this.tabletcodenum = tabletcodenum;
	}
	public Integer getMedcoderate() {
		return medcoderate;
	}
	public void setMedcoderate(Integer medcoderate) {
		this.medcoderate = medcoderate;
	}
	public Integer getTabletcoderate() {
		return tabletcoderate;
	}
	public void setTabletcoderate(Integer tabletcoderate) {
		this.tabletcoderate = tabletcoderate;
	}
	public Double getCheckedweight() {
		return checkedweight;
	}
	public void setCheckedweight(Double checkedweight) {
		this.checkedweight = checkedweight;
	}
	public Double getUncheckedweight() {
		return uncheckedweight;
	}
	public void setUncheckedweight(Double uncheckedweight) {
		this.uncheckedweight = uncheckedweight;
	}
	public Double getCheckedrate() {
		return checkedrate;
	}
	public void setCheckedrate(Double checkedrate) {
		this.checkedrate = checkedrate;
	}
	public Double getUncheckedrate() {
		return uncheckedrate;
	}
	public void setUncheckedrate(Double uncheckedrate) {
		this.uncheckedrate = uncheckedrate;
	}
	public Map<String, Double> getCheckedmap() {
		return checkedmap;
	}
	public void setCheckedmap(Map<String, Double> checkedmap) {
		this.checkedmap = checkedmap;
	}
	public Map<String, Double> getCheckedcontrastmap() {
		return checkedcontrastmap;
	}
	public void setCheckedcontrastmap(Map<String, Double> checkedcontrastmap) {
		this.checkedcontrastmap = checkedcontrastmap;
	}
	public String getChecktype() {
		return checktype;
	}
	public void setChecktype(String checktype) {
		this.checktype = checktype;
	}
	public Double getMattedweight() {
		return mattedweight;
	}
	public void setMattedweight(Double mattedweight) {
		this.mattedweight = mattedweight;
	}
	public Double getMattedrate() {
		return mattedrate;
	}
	public void setMattedrate(Double mattedrate) {
		this.mattedrate = mattedrate;
	}
	public Map<String, Double> getMattedmap() {
		return mattedmap;
	}
	public void setMattedmap(Map<String, Double> mattedmap) {
		this.mattedmap = mattedmap;
	}
	public Map<String, Double> getMattedcontrastmap() {
		return mattedcontrastmap;
	}
	public void setMattedcontrastmap(Map<String, Double> mattedcontrastmap) {
		this.mattedcontrastmap = mattedcontrastmap;
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
	public Rp_Build getBuild() {
		return build;
	}
	public void setBuild(Rp_Build build) {
		this.build = build;
	}
	public List<Rp_Build> getBuildlist() {
		return buildlist;
	}
	public void setBuildlist(List<Rp_Build> buildlist) {
		this.buildlist = buildlist;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getMedstorweight() {
		return medstorweight;
	}
	public void setMedstorweight(String medstorweight) {
		this.medstorweight = medstorweight;
	}
	public String getTabletstorweight() {
		return tabletstorweight;
	}
	public void setTabletstorweight(String tabletstorweight) {
		this.tabletstorweight = tabletstorweight;
	}
	public String getMedtradeweight() {
		return medtradeweight;
	}
	public void setMedtradeweight(String medtradeweight) {
		this.medtradeweight = medtradeweight;
	}
	public String getTablettradeweight() {
		return tablettradeweight;
	}
	public void setTablettradeweight(String tablettradeweight) {
		this.tablettradeweight = tablettradeweight;
	}
	public String getTotaltradeweight() {
		return totaltradeweight;
	}
	public void setTotaltradeweight(String totaltradeweight) {
		this.totaltradeweight = totaltradeweight;
	}
	public String getRegisteraddress() {
		return registeraddress;
	}
	public void setRegisteraddress(String registeraddress) {
		this.registeraddress = registeraddress;
	}
	public String getBusinessnumber() {
		return businessnumber;
	}
	public void setBusinessnumber(String businessnumber) {
		this.businessnumber = businessnumber;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getLinkman() {
		return linkman;
	}
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getMasterman() {
		return masterman;
	}
	public void setMasterman(String masterman) {
		this.masterman = masterman;
	}
	public int getChengflag() {
		return chengflag;
	}
	public void setChengflag(int chengflag) {
		this.chengflag = chengflag;
	}
	public String getStrcodenum() {
		return strcodenum;
	}
	public void setStrcodenum(String strcodenum) {
		this.strcodenum = strcodenum;
	}
	public String getStrtradetimes() {
		return strtradetimes;
	}
	public void setStrtradetimes(String strtradetimes) {
		this.strtradetimes = strtradetimes;
	}
	public String getStrtradeweight() {
		return strtradeweight;
	}
	public void setStrtradeweight(String strtradeweight) {
		this.strtradeweight = strtradeweight;
	}
	public String getStrmedcodenum() {
		return strmedcodenum;
	}
	public void setStrmedcodenum(String strmedcodenum) {
		this.strmedcodenum = strmedcodenum;
	}
	public String getStrtabletcodenum() {
		return strtabletcodenum;
	}
	public void setStrtabletcodenum(String strtabletcodenum) {
		this.strtabletcodenum = strtabletcodenum;
	}
	public String getStrchengcodenum() {
		return strchengcodenum;
	}
	public void setStrchengcodenum(String strchengcodenum) {
		this.strchengcodenum = strchengcodenum;
	}
	
	
	

}
