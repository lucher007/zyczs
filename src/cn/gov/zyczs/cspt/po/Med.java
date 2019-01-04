package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Med.java
 * @Package com.po
 * @version 1.0 
 * 药材实体类
 */
public class Med implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer medid;   //  主键 药材序列号
	private String medname;  //药材名
	private String cpcplant;   //种植批次号关联植物表
	private Double predictweight;	//预计产量(单位:g)
	private String harvesttime;		//收获时间
	private Double medweight;   //实际产量   
	private String source;			//种子来源:自购|栽培|野生
	private String pesticide;		//填写的农药信息
	private String fertilizer;		//填写的施肥信息
	private Integer medtype;		//药材是否分包:0药材未分包,1药材已分包
	private String mednumber;		//企业内部批次码
	private String cpcmed;			//药材批次号  系统生成
	private String prodcode; //商品编码
	
	////////////////数据库辅助字段/////////////////////
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private String plantname;//植物名称
	private String plantaddtime;//种植时间
	private MedStorage medstorage;
	private Med med;
	private List<Med> medlist;//药材集合
	private Plant plant;//植物
	private List<Plant> plantlist;//植物
	private Check check;//检验信息
	
	private Integer userid;
	private Integer orgid;
	private Integer checkstate;
	private String mcontent;
	
	public Plant getPlant() {
		return plant;
	}
	public void setPlant(Plant plant) {
		this.plant = plant;
	}
	public String getPlantname() {
		return plantname;
	}
	public void setPlantname(String plantname) {
		this.plantname = plantname;
	}
	public String getPlantaddtime() {
		if(plantaddtime == null || plantaddtime.length() < 19){
			return null;
		}else{
			plantaddtime	= plantaddtime.substring(0,19);
		}
		return plantaddtime;
	}
	public void setPlantaddtime(String plantaddtime) {
		this.plantaddtime = plantaddtime;
	}
	public Integer getMedid() {
		return medid;
	}
	public void setMedid(Integer medid) {
		this.medid = medid;
	}
	public String getCpcplant() {
		return cpcplant;
	}
	public void setCpcplant(String cpcplant) {
		this.cpcplant = cpcplant;
	}
	public String getMedname() {
		return medname;
	}
	public void setMedname(String medname) {
		this.medname = medname;
	}
	public String getHarvesttime() {
		if(harvesttime == null || harvesttime.length() < 10){
			return null;
		}else{
			harvesttime	= harvesttime.substring(0,10);
		}
		return harvesttime;
	}
	public void setHarvesttime(String harvesttime) {
		this.harvesttime = harvesttime;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getPesticide() {
		return pesticide;
	}
	public void setPesticide(String pesticide) {
		this.pesticide = pesticide;
	}
	public String getFertilizer() {
		return fertilizer;
	}
	public void setFertilizer(String fertilizer) {
		this.fertilizer = fertilizer;
	}
	public Integer getMedtype() {
		return medtype;
	}
	public void setMedtype(Integer medtype) {
		this.medtype = medtype;
	}
	public String getMednumber() {
		return mednumber;
	}
	public void setMednumber(String mednumber) {
		this.mednumber = mednumber;
	}
	public String getCpcmed() {
		return cpcmed;
	}
	public void setCpcmed(String cpcmed) {
		this.cpcmed = cpcmed;
	}
	public Double getMedweight() {
		return medweight;
	}
	public void setMedweight(Double medweight) {
		this.medweight = medweight;
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
	public List<Med> getMedlist() {
		return medlist;
	}
	public void setMedlist(List<Med> medlist) {
		this.medlist = medlist;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public Double getPredictweight() {
		return predictweight;
	}
	public void setPredictweight(Double predictweight) {
		this.predictweight = predictweight;
	}
	public List<Plant> getPlantlist() {
		return plantlist;
	}
	public void setPlantlist(List<Plant> plantlist) {
		this.plantlist = plantlist;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public Integer getCheckstate() {
		return checkstate;
	}
	public void setCheckstate(Integer checkstate) {
		this.checkstate = checkstate;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public MedStorage getMedstorage() {
		return medstorage;
	}
	public void setMedstorage(MedStorage medstorage) {
		this.medstorage = medstorage;
	}
	public Check getCheck() {
		return check;
	}
	public void setCheck(Check check) {
		this.check = check;
	}
	public Med getMed() {
		return med;
	}
	public void setMed(Med med) {
		this.med = med;
	}
}

