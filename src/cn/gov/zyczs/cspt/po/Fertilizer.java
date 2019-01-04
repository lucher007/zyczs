package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Fertilizer.java
 * @Package com.po
 * @version 1.0 
 * 肥料表
 */
public class Fertilizer implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer fertilizerid;		//施肥编号
	private String fertilizername;		//施肥名称
	private Double fertilizerweight;	//施肥重量(单位:g)
	private String addtime;				//添加时间
	private String cpcplant;			//种植批次号
	private String fertilizertime;		//施肥添加日期
	
	/*****************数据库辅助字段********************/
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private Plant plant;//植物
	private List<Fertilizer> fertilizerlist;//肥料集合
	private String oper;//操作
	public String getOper() {
		return oper;
	}
	public void setOper(String oper) {
		this.oper = oper;
	}
	public List<Fertilizer> getFertilizerlist() {
		return fertilizerlist;
	}
	public void setFertilizerlist(List<Fertilizer> fertilizerlist) {
		this.fertilizerlist = fertilizerlist;
	}
	public Plant getPlant() {
		return plant;
	}
	public void setPlant(Plant plant) {
		this.plant = plant;
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
	public Integer getFertilizerid() {
		return fertilizerid;
	}
	public void setFertilizerid(Integer fertilizerid) {
		this.fertilizerid = fertilizerid;
	}
	public String getFertilizername() {
		return fertilizername;
	}
	public void setFertilizername(String fertilizername) {
		this.fertilizername = fertilizername;
	}
	public Double getFertilizerweight() {
		return fertilizerweight;
	}
	public void setFertilizerweight(Double fertilizerweight) {
		this.fertilizerweight = fertilizerweight;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getCpcplant() {
		return cpcplant;
	}
	public void setCpcplant(String cpcplant) {
		this.cpcplant = cpcplant;
	}
	public String getFertilizertime() {
		if(fertilizertime == null || fertilizertime.length() < 10){
			fertilizertime = null;
		}else{
			fertilizertime = fertilizertime.substring(0,10);
		}
		return fertilizertime;
	}
	public void setFertilizertime(String fertilizertime) {
		this.fertilizertime = fertilizertime;
	}
}

