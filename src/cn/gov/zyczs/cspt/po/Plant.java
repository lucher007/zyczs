package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Plant.java
 * @Package com.po
 * @version 1.0 
 * 植物表
 */
public class Plant implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer plantid;		//植物id
	private String cpcplantimg;		//二维码图片路径
	private String plantname;		//植物名称
	private String plantsource;		//种子来源:自购|栽培|野生
	private String plantarea;		//种植区域(单位:亩)
	private String plantusername;	//种植负责人
	private String plantnumber;		//企业内部批次码
	private Double plantweight;		//种子重量(单位:g)
	private String plantaddtime;	//种植开始时间
	private Integer state;			//状态:0种植任务未收获或部份收获 ,1种植任务已收获结束
	private String province;		//省
	private String city;			//市
	private String area;			//区
	private String plantaddress;	//详细地址
	private String addtime;			//添加时间
	private String cpcplant;		//种植批次号
	private Integer userid;			//关联用户表userid
	private String harvestmedwei;	//预计产物和产量
	private String areacode;		//地区编码,按国标处理
	private String plantcycle;		//种植周期(单位：月)
	private String plantendtime;	//种植结束时间
	private Integer orgid;			//组织编码	
	private String prodcode;//商品编码
	
	/*****************数据库辅助字段********************/
	private String returninfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private String pesticide;//农药
	private String fertilizer;//化肥
	private List<Plant> plantlist;//植物集合
	private String med;//药材
	private Plant plant; //植物
	private String harvestmed;//预计产物
 	private String harvestwei;//预计产量 
	private List<Med> medlist;//产出药材集合
	private String oper;//操作
	private String fieldcare;//田间管理
	public String getFieldcare() {
		return fieldcare;
	}
	public void setFieldcare(String fieldcare) {
		this.fieldcare = fieldcare;
	}
	public String getOper() {
		return oper;
	}
	public void setOper(String oper) {
		this.oper = oper;
	}
	public List<Med> getMedlist() {
		return medlist;
	}
	public void setMedlist(List<Med> medlist) {
		this.medlist = medlist;
	}
	public Plant getPlant() {
		return plant;
	}
	public void setPlant(Plant plant) {
		this.plant = plant;
	}
	public String getMed() {
		return med;
	}
	public void setMed(String med) {
		this.med = med;
	}
	public List<Plant> getPlantlist() {
		return plantlist;
	}
	public void setPlantlist(List<Plant> plantlist) {
		this.plantlist = plantlist;
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
	public Integer getPlantid() {
		return plantid;
	}
	public void setPlantid(Integer plantid) {
		this.plantid = plantid;
	}
	public String getCpcplantimg() {
		return cpcplantimg;
	}
	public void setCpcplantimg(String cpcplantimg) {
		this.cpcplantimg = cpcplantimg;
	}
	public String getPlantname() {
		return plantname;
	}
	public void setPlantname(String plantname) {
		this.plantname = plantname;
	}
	public String getPlantsource() {
		return plantsource;
	}
	public void setPlantsource(String plantsource) {
		this.plantsource = plantsource;
	}
	public String getPlantarea() {
		return plantarea;
	}
	public void setPlantarea(String plantarea) {
		this.plantarea = plantarea;
	}
	public String getPlantusername() {
		return plantusername;
	}
	public void setPlantusername(String plantusername) {
		this.plantusername = plantusername;
	}
	public String getPlantnumber() {
		return plantnumber;
	}
	public void setPlantnumber(String plantnumber) {
		this.plantnumber = plantnumber;
	}
	public Double getPlantweight() {
		return plantweight;
	}
	public void setPlantweight(Double plantweight) {
		this.plantweight = plantweight;
	}
	public String getPlantaddtime() {
		if(plantaddtime == null){
			return null;
		}else{
			plantaddtime = plantaddtime.substring(0,10);
		}
		return plantaddtime;
	}
	public void setPlantaddtime(String plantaddtime) {
		this.plantaddtime = plantaddtime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
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
	public String getPlantaddress() {
		return plantaddress;
	}
	public void setPlantaddress(String plantaddress) {
		this.plantaddress = plantaddress;
	}
	public String getAddtime() {
		if(addtime == null || addtime.length() < 19){
			addtime = null;
		}else{
			addtime = addtime.substring(0,19);
		}
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
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public String getHarvestmedwei() {
		return harvestmedwei;
	}
	public void setHarvestmedwei(String harvestmedwei) {
		this.harvestmedwei = harvestmedwei;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getPlantcycle() {
		return plantcycle;
	}
	public void setPlantcycle(String plantcycle) {
		this.plantcycle = plantcycle;
	}
	public String getPlantendtime() {
		if(plantendtime == null || plantendtime.length() < 19){
			plantendtime = null;
		}else{
			plantendtime = plantendtime.substring(0,19);
		}
		return plantendtime;
	}
	public void setPlantendtime(String plantendtime) {
		this.plantendtime = plantendtime;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public String getHarvestmed() {
		return harvestmed;
	}
	public void setHarvestmed(String harvestmed) {
		this.harvestmed = harvestmed;
	}
	public String getHarvestwei() {
		return harvestwei;
	}
	public void setHarvestwei(String harvestwei) {
		this.harvestwei = harvestwei;
	}
}

