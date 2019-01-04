package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
/*
 * 地区绩效考核
 */
public class Examine implements Serializable{
	private Integer id;
	
	private String province;
	private String city;
	private String area;
	
	private String areacode;
	private String areas;
	private Integer medcount;
	private Integer medsellcount;
	private Integer medmarketcount;
	private Integer tabletcount;
	private Integer tabletsellcount;
	private Integer tablethospcount;
	
	private Integer year;
	private Integer quarter;
	
	private Integer flag;
	
	//分页参数
	private int pager_count;      //总数目
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示个数
	private List<Examine> list;
	
	
	
	private Examine examine;
	private String returninfo;
	private Integer returnCode;
	private Integer updateorinsert;//是更新还是插入0是插入1是更新
	
	public Integer getReturnCode() {
		return returnCode;
	}
	public void setReturnCode(Integer returnCode) {
		this.returnCode = returnCode;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public Integer getMedcount() {
		return medcount;
	}
	public void setMedcount(Integer medcount) {
		this.medcount = medcount;
	}
	public Integer getMedsellcount() {
		return medsellcount;
	}
	public void setMedsellcount(Integer medsellcount) {
		this.medsellcount = medsellcount;
	}
	public Integer getMedmarketcount() {
		return medmarketcount;
	}
	public void setMedmarketcount(Integer medmarketcount) {
		this.medmarketcount = medmarketcount;
	}
	public Integer getTabletcount() {
		return tabletcount;
	}
	public void setTabletcount(Integer tabletcount) {
		this.tabletcount = tabletcount;
	}
	public Integer getTabletsellcount() {
		return tabletsellcount;
	}
	public void setTabletsellcount(Integer tabletsellcount) {
		this.tabletsellcount = tabletsellcount;
	}
	public Integer getTablethospcount() {
		return tablethospcount;
	}
	public void setTablethospcount(Integer tablethospcount) {
		this.tablethospcount = tablethospcount;
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
	public List<Examine> getList() {
		return list;
	}
	public void setList(List<Examine> list) {
		this.list = list;
	}
	public Examine getExamine() {
		return examine;
	}
	public void setExamine(Examine examine) {
		this.examine = examine;
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
	public String getAreas() {
		return areas;
	}
	public void setAreas(String areas) {
		this.areas = areas;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public Integer getQuarter() {
		return quarter;
	}
	public void setQuarter(Integer quarter) {
		this.quarter = quarter;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public Integer getUpdateorinsert() {
		return updateorinsert;
	}
	public void setUpdateorinsert(Integer updateorinsert) {
		this.updateorinsert = updateorinsert;
	}
	

}
