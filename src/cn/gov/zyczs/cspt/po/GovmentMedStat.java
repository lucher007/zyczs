package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title GovmentMedStat.java
 * @Package com.po
 * @version 1.0 监管种植环节统计实体类
 */
public class GovmentMedStat implements Serializable {

	private String mon;// 月份
	private String area;// 区划
	private Integer orgcount;// 种植企业数量
	private Integer medcount;// 药材数量
	private Integer plantcount;// 种植批次数量
	private String plantareasum;// 种植总面积(亩)
	private String predictweight;// 预计产量
	private String medweight;// 实际产量
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量
	private List<GovmentMedStat> list;// 集合
	private String medname;//
	private Integer state;//
	private String starttime;//
	private String endtime;//
	private String corpname;// 企业名称
	private String province;//
	private String city;//

	private String totalweight;//
	private String avgmoney;//
	private String boxnum;//
	// ///////////中药材流通///////////////
	private Integer usernum;// 经营户数量
	private Integer mednamenum;// 药材品种数量
	private Integer cpcmednum;// 进货批次数量
	private Integer areanum;// 产地数量
	private Integer mednum;// 溯源码数量

	
	private Integer stortype;//出入库状态：0入库 1出库
	private Integer outnum;//销售订单数量
	private Integer orgid;//组织id
	
	public Integer getOrgid() {
		return orgid;
	}

	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}

	public Integer getUsernum() {
		return usernum;
	}

	public void setUsernum(Integer usernum) {
		this.usernum = usernum;
	}

	public Integer getMednamenum() {
		return mednamenum;
	}

	public void setMednamenum(Integer mednamenum) {
		this.mednamenum = mednamenum;
	}

	public Integer getCpcmednum() {
		return cpcmednum;
	}

	public void setCpcmednum(Integer cpcmednum) {
		this.cpcmednum = cpcmednum;
	}

	public Integer getAreanum() {
		return areanum;
	}

	public void setAreanum(Integer areanum) {
		this.areanum = areanum;
	}

	public Integer getMednum() {
		return mednum;
	}

	public void setMednum(Integer mednum) {
		this.mednum = mednum;
	}

	public String getTotalweight() {
		return totalweight;
	}

	public void setTotalweight(String totalweight) {
		this.totalweight = totalweight;
	}

	public String getAvgmoney() {
		return avgmoney;
	}

	public void setAvgmoney(String avgmoney) {
		this.avgmoney = avgmoney;
	}

	public String getBoxnum() {
		return boxnum;
	}

	public void setBoxnum(String boxnum) {
		this.boxnum = boxnum;
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

	public String getCorpname() {
		return corpname;
	}

	public void setCorpname(String corpname) {
		this.corpname = corpname;
	}

	public String getStarttime() {
		return starttime;
	}

	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}

	public String getEndtime() {
		return endtime;
	}

	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
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

	public String getMon() {
		return mon;
	}

	public void setMon(String mon) {
		this.mon = mon;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public Integer getOrgcount() {
		return orgcount;
	}

	public void setOrgcount(Integer orgcount) {
		this.orgcount = orgcount;
	}

	public Integer getMedcount() {
		return medcount;
	}

	public void setMedcount(Integer medcount) {
		this.medcount = medcount;
	}

	public Integer getPlantcount() {
		return plantcount;
	}

	public void setPlantcount(Integer plantcount) {
		this.plantcount = plantcount;
	}

	public String getPlantareasum() {
		return plantareasum;
	}

	public void setPlantareasum(String plantareasum) {
		this.plantareasum = plantareasum;
	}

	public String getPredictweight() {
		return predictweight;
	}

	public void setPredictweight(String predictweight) {
		this.predictweight = predictweight;
	}

	public String getMedweight() {
		return medweight;
	}

	public void setMedweight(String medweight) {
		this.medweight = medweight;
	}

	public List<GovmentMedStat> getList() {
		return list;
	}

	public void setList(List<GovmentMedStat> list) {
		this.list = list;
	}

	public String getMedname() {
		return medname;
	}

	public void setMedname(String medname) {
		this.medname = medname;
	}

	public Integer getStortype() {
		return stortype;
	}

	public void setStortype(Integer stortype) {
		this.stortype = stortype;
	}

	public Integer getOutnum() {
		return outnum;
	}

	public void setOutnum(Integer outnum) {
		this.outnum = outnum;
	}
}
