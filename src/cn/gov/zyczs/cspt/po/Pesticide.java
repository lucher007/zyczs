package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Pesticide.java
 * @Package com.po
 * @version 1.0 
 * 农药表
 */
public class Pesticide implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer pesticideid;	//喷洒农药编号
	private String pesticidename;	//农药名称
	private Double pesticideweight;	//农药重量(单位：g)
	private String addtime;			//添加时间
	private String cpcplant;		//种植批次号
	private String pesticidetime;	//喷洒农药日期
	
	/*****************数据库辅助字段********************/
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private Plant plant;//植物
	private List<Pesticide> pesticidelist;//农药集合
	private String oper;//操作
	public String getOper() {
		return oper;
	}
	public void setOper(String oper) {
		this.oper = oper;
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
	public Integer getPesticideid() {
		return pesticideid;
	}
	public void setPesticideid(Integer pesticideid) {
		this.pesticideid = pesticideid;
	}
	public String getPesticidename() {
		return pesticidename;
	}
	public void setPesticidename(String pesticidename) {
		this.pesticidename = pesticidename;
	}
	public Double getPesticideweight() {
		return pesticideweight;
	}
	public void setPesticideweight(Double pesticideweight) {
		this.pesticideweight = pesticideweight;
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
	public String getPesticidetime() {
		if(pesticidetime == null || pesticidetime.length() < 10){
			pesticidetime = null;
		}else{
			pesticidetime = pesticidetime.substring(0,10);
		}
		return pesticidetime;
	}
	public void setPesticidetime(String pesticidetime) {
		this.pesticidetime = pesticidetime;
	}
	public Plant getPlant() {
		return plant;
	}
	public void setPlant(Plant plant) {
		this.plant = plant;
	}
	public List<Pesticide> getPesticidelist() {
		return pesticidelist;
	}
	public void setPesticidelist(List<Pesticide> pesticidelist) {
		this.pesticidelist = pesticidelist;
	}
}

