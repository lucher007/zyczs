package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;
/**
 * 监管平台报表统计
 * @author Administrator
 *
 */
public class Rp_Stat implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String month;//月
	private Double plantareasum;//每月药材种植面积总和
	private String year;//年
	private List<Rp_Stat> list;
	private String plantname;
	private Rp_Stat rp_state;
	private String m1;
	private String m2;
	private String m3;
	private String m4;
	private String m5;
	private String m6;
	private String m7;
	private String m8;
	private String m9;
	private String m10;
	private String m11;
	private String m12;
	
	private Rp_Stat tabletsells;
	private Rp_Stat tabletproduces;
	
	public List<Rp_Stat> getList() {
		return list;
	}
	public void setList(List<Rp_Stat> list) {
		this.list = list;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public Double getPlantareasum() {
		return plantareasum;
	}
	public void setPlantareasum(Double plantareasum) {
		this.plantareasum = plantareasum;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getPlantname() {
		return plantname;
	}
	public void setPlantname(String plantname) {
		this.plantname = plantname;
	}
	public String getM1() {
		return m1;
	}
	public void setM1(String m1) {
		this.m1 = m1;
	}
	public String getM2() {
		return m2;
	}
	public void setM2(String m2) {
		this.m2 = m2;
	}
	public String getM3() {
		return m3;
	}
	public void setM3(String m3) {
		this.m3 = m3;
	}
	public String getM4() {
		return m4;
	}
	public void setM4(String m4) {
		this.m4 = m4;
	}
	public String getM5() {
		return m5;
	}
	public void setM5(String m5) {
		this.m5 = m5;
	}
	public String getM6() {
		return m6;
	}
	public void setM6(String m6) {
		this.m6 = m6;
	}
	public String getM7() {
		return m7;
	}
	public void setM7(String m7) {
		this.m7 = m7;
	}
	public String getM8() {
		return m8;
	}
	public void setM8(String m8) {
		this.m8 = m8;
	}
	public String getM9() {
		return m9;
	}
	public void setM9(String m9) {
		this.m9 = m9;
	}
	public String getM10() {
		return m10;
	}
	public void setM10(String m10) {
		this.m10 = m10;
	}
	public String getM11() {
		return m11;
	}
	public void setM11(String m11) {
		this.m11 = m11;
	}
	public String getM12() {
		return m12;
	}
	public void setM12(String m12) {
		this.m12 = m12;
	}
	public Rp_Stat getRp_state() {
		return rp_state;
	}
	public void setRp_state(Rp_Stat rp_state) {
		this.rp_state = rp_state;
	}
	public Rp_Stat getTabletsells() {
		return tabletsells;
	}
	public void setTabletsells(Rp_Stat tabletsells) {
		this.tabletsells = tabletsells;
	}
	public Rp_Stat getTabletproduces() {
		return tabletproduces;
	}
	public void setTabletproduces(Rp_Stat tabletproduces) {
		this.tabletproduces = tabletproduces;
	}
}
