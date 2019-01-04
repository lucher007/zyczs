package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
/**
 * @Title FieldCare.java
 * @Package com.po
 * @version 1.0 
 * 田间管理表
 */
public class FieldCare implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private Integer fieldcareid;  //田间管理编号
	private String fieldcaretype; //田间管理类型
	private String fieldcarename; //田间管理名称
	private Double fieldcareweight; //重量
	private String addtime;				//添加时间
	private String cpcplant;			//种植批次号
	private String fieldcaretime;   //田间管理添加时间
	private String remark;			//备注
	
	/**************数据库辅助字段********************/
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private Plant plant;//植物
	private List<FieldCare> fieldcarelist;//田间管理集合
	private String oper;//操作
	public Integer getFieldcareid() {
		return fieldcareid;
	}
	public void setFieldcareid(Integer fieldcareid) {
		this.fieldcareid = fieldcareid;
	}
	public String getFieldcaretype() {
		return fieldcaretype;
	}
	public void setFieldcaretype(String fieldcaretype) {
		this.fieldcaretype = fieldcaretype;
	}
	public String getFieldcarename() {
		return fieldcarename;
	}
	public void setFieldcarename(String fieldcarename) {
		this.fieldcarename = fieldcarename;
	}
	public Double getFieldcareweight() {
		return fieldcareweight;
	}
	public void setFieldcareweight(Double fieldcareweight) {
		this.fieldcareweight = fieldcareweight;
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
	public String getFieldcaretime() {
		if(fieldcaretime == null || fieldcaretime.length() < 10){
			fieldcaretime = null;
		}else{
			fieldcaretime = fieldcaretime.substring(0,10);
		}
		return fieldcaretime;
	}
	public void setFieldcaretime(String fieldcaretime) {
		this.fieldcaretime = fieldcaretime;
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
	public Plant getPlant() {
		return plant;
	}
	public void setPlant(Plant plant) {
		this.plant = plant;
	}
	public List<FieldCare> getFieldcarelist() {
		return fieldcarelist;
	}
	public void setFieldcarelist(List<FieldCare> fieldcarelist) {
		this.fieldcarelist = fieldcarelist;
	}
	public String getOper() {
		return oper;
	}
	public void setOper(String oper) {
		this.oper = oper;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
