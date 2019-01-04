package cn.gov.zyczs.cspt.po;

import java.util.List;

/**
 * @Title MedStat.java
 * @Package com.po
 * @version 1.0 种植平台统计表
 */
public class MedStat {
	private Integer plantid; // 植物id
	private String cpcplantimg; // 二维码图片路径
	private String plantname; // 植物名称
	private String plantsource; // 种子来源:自购|栽培|野生
	private String plantarea; // 种植区域(单位:亩)
	private String plantusername; // 种植负责人
	private String plantnumber; // 企业内部批次码
	private Double plantweight; // 种子重量(单位:g)
	private String plantaddtime; // 种植开始时间
	private Integer state; // 状态:0种植任务未收获或部份收获 ,1种植任务已收获结束
	private String province; // 省
	private String city; // 市
	private String area; // 区
	private String plantaddress; // 详细地址
	private String addtime; // 添加时间
	private String cpcplant; // 种植批次号
	private Integer userid; // 关联用户表userid
	private String harvestmedwei; // 预计产物和产量
	private String areacode; // 地区编码,按国标处理
	private String plantcycle; // 种植周期(单位：月)
	private String plantendtime; // 种植结束时间
	private Integer orgid; // 组织编码
	private String prodcode;// 商品编码

	/** ******************种植平台 库存统计所需字段******************* */
	private String medname;// 药材名
	private String cpcmed;// 药材批次号
	private Integer checkstate;// 检验状态,0-未检,1-已检
	private Double mednumweight;// 包装规格
	private Double medweight;// 库存量
	private String totalweight;// 库存总重量
	private String medaddtime;// 入库时间
	private String medendtime;// 入库时间
	private Integer medstate;// 药材库存状态:0有库存,1无库存
	private String mednumber;// 药材库存状态:0有库存,1无库存
	
	//药材销售统计
	private String prodname;     //药材或者饮片名称
	private String batchcpc;     //药材或者饮片批次号
	private String boxnumweight; //包装重量(规格)
	private Integer boxnum;      //包数
	private Double sumweight;   //所有的记录的总重量
	private String  intime;      //销售时间
	private Integer type;       // 类型:药材0,饮片1
	private Integer stortype; //出入库状态：0入库 1出库
	private String strtotalweight; //总重量字符串化
	private String strtotalmoney;  //总价的字符串化
	private String strsumweight;   //所有的记录的总重量的字符串化
	private String strsummoney;   //所有的记录的总价的字符串化

	/** ***************数据库辅助字段******************* */
	private String returninfo; // 返回消息
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量
	private String pesticide;// 农药
	private String fertilizer;// 化肥
	private List<Plant> plantlist;// 植物集合
	private String med;// 药材
	private Plant plant; // 植物
	private String harvestmed;// 预计产物
	private String harvestwei;// 预计产量
	private List<Med> medlist;// 产出药材集合
	private String querybegintime;  //查询开始时间
	private String queryendtime;    //查询结束时间

	private List<MedStat> medStatlist;

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

	public String getReturninfo() {
		return returninfo;
	}

	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
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

	public List<Plant> getPlantlist() {
		return plantlist;
	}

	public void setPlantlist(List<Plant> plantlist) {
		this.plantlist = plantlist;
	}

	public String getMed() {
		return med;
	}

	public void setMed(String med) {
		this.med = med;
	}

	public Plant getPlant() {
		return plant;
	}

	public void setPlant(Plant plant) {
		this.plant = plant;
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

	public List<Med> getMedlist() {
		return medlist;
	}

	public void setMedlist(List<Med> medlist) {
		this.medlist = medlist;
	}

	public List<MedStat> getMedStatlist() {
		return medStatlist;
	}

	public void setMedStatlist(List<MedStat> medStatlist) {
		this.medStatlist = medStatlist;
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

	public Integer getCheckstate() {
		return checkstate;
	}

	public void setCheckstate(Integer checkstate) {
		this.checkstate = checkstate;
	}

	public String getMedaddtime() {
		return medaddtime;
	}

	public void setMedaddtime(String medaddtime) {
		this.medaddtime = medaddtime;
	}

	public Integer getMedstate() {
		return medstate;
	}

	public void setMedstate(Integer medstate) {
		this.medstate = medstate;
	}

	public String getMednumber() {
		return mednumber;
	}

	public void setMednumber(String mednumber) {
		this.mednumber = mednumber;
	}

	public String getMedendtime() {
		return medendtime;
	}

	public void setMedendtime(String medendtime) {
		this.medendtime = medendtime;
	}

	public Double getMedweight() {
		return medweight;
	}

	public void setMedweight(Double medweight) {
		this.medweight = medweight;
	}

	public String getTotalweight() {
		return totalweight;
	}

	public void setTotalweight(String totalweight) {
		this.totalweight = totalweight;
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

	public Integer getBoxnum() {
		return boxnum;
	}

	public void setBoxnum(Integer boxnum) {
		this.boxnum = boxnum;
	}

	public String getIntime() {
		return intime;
	}

	public void setIntime(String intime) {
		this.intime = intime;
	}

	public Double getSumweight() {
		return sumweight;
	}

	public void setSumweight(Double sumweight) {
		this.sumweight = sumweight;
	}

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

	public String getBatchcpc() {
		return batchcpc;
	}

	public void setBatchcpc(String batchcpc) {
		this.batchcpc = batchcpc;
	}

	public String getBoxnumweight() {
		return boxnumweight;
	}

	public void setBoxnumweight(String boxnumweight) {
		this.boxnumweight = boxnumweight;
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

	public String getStrsumweight() {
		return strsumweight;
	}

	public void setStrsumweight(String strsumweight) {
		this.strsumweight = strsumweight;
	}

	public String getStrsummoney() {
		return strsummoney;
	}

	public void setStrsummoney(String strsummoney) {
		this.strsummoney = strsummoney;
	}

	public Double getMednumweight() {
		return mednumweight;
	}

	public void setMednumweight(Double mednumweight) {
		this.mednumweight = mednumweight;
	}

}
