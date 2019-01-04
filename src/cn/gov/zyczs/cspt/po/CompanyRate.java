package cn.gov.zyczs.cspt.po;

public class CompanyRate{
	
	private Integer Id;
	private String areacode;
	private String areas;
	private String medrate;
	private String medsellrate;
	private String medmarketrate;
	private String tabletrate;
	private String tabletsellrate;
	private String tablethosprate;
	private String avgrate;
	private Integer ratetype;
	private Integer year;
	private Integer quarter;
	public Integer getId() {
		return Id;
	}
	public void setId(Integer id) {
		Id = id;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getAreas() {
		return areas;
	}
	public void setAreas(String areas) {
		this.areas = areas;
	}
	public String getMedrate() {
		return medrate;
	}
	public void setMedrate(String medrate) {
		this.medrate = medrate;
	}
	public String getMedsellrate() {
		return medsellrate;
	}
	public void setMedsellrate(String medsellrate) {
		this.medsellrate = medsellrate;
	}
	public String getMedmarketrate() {
		return medmarketrate;
	}
	public void setMedmarketrate(String medmarketrate) {
		this.medmarketrate = medmarketrate;
	}
	public String getTabletrate() {
		return tabletrate;
	}
	public void setTabletrate(String tabletrate) {
		this.tabletrate = tabletrate;
	}
	public String getTabletsellrate() {
		return tabletsellrate;
	}
	public void setTabletsellrate(String tabletsellrate) {
		this.tabletsellrate = tabletsellrate;
	}
	public String getTablethosprate() {
		return tablethosprate;
	}
	public void setTablethosprate(String tablethosprate) {
		this.tablethosprate = tablethosprate;
	}
	public String getAvgrate() {
		return avgrate;
	}
	public void setAvgrate(String avgrate) {
		this.avgrate = avgrate;
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
	public Integer getRatetype() {
		return ratetype;
	}
	public void setRatetype(Integer ratetype) {
		this.ratetype = ratetype;
	}
	
	

}
