package cn.gov.zyczs.cspt.po;

import java.util.ArrayList;
import java.util.List;

public class Rp_Rate {
	
	
	private String year;
	
	private String year2;
	private String month;
	private Integer total;
	private Integer curTotal;
	
	
	//0.溯源，1非溯源
	private Integer medtype;
	private Double medweight;
	
	
	//主要药材产量统计
	private String med1;
	private String med2;
	private String med3;
	private String med4;
	private String med5;
	
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getCurTotal() {
		return curTotal;
	}
	public void setCurTotal(Integer curTotal) {
		this.curTotal = curTotal;
	}
	
	List<Rp_Rate> list=new ArrayList<Rp_Rate>();
	
	List<Rp_Rate> list2=new ArrayList<Rp_Rate>();
	
	public List<Rp_Rate> getList2() {
		return list2;
	}
	public void setList2(List<Rp_Rate> list2) {
		this.list2 = list2;
	}
	public List<Rp_Rate> getList() {
		return list;
	}
	public void setList(List<Rp_Rate> list) {
		this.list = list;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public Integer getMedtype() {
		return medtype;
	}
	public void setMedtype(Integer medtype) {
		this.medtype = medtype;
	}
	public Double getMedweight() {
		return medweight;
	}
	public void setMedweight(Double medweight) {
		this.medweight = medweight;
	}
	public String getMed1() {
		return med1;
	}
	public void setMed1(String med1) {
		this.med1 = med1;
	}
	public String getMed2() {
		return med2;
	}
	public void setMed2(String med2) {
		this.med2 = med2;
	}
	public String getMed3() {
		return med3;
	}
	public void setMed3(String med3) {
		this.med3 = med3;
	}
	public String getMed4() {
		return med4;
	}
	public void setMed4(String med4) {
		this.med4 = med4;
	}
	public String getMed5() {
		return med5;
	}
	public void setMed5(String med5) {
		this.med5 = med5;
	}
	public String getYear2() {
		return year2;
	}
	public void setYear2(String year2) {
		this.year2 = year2;
	}

}
