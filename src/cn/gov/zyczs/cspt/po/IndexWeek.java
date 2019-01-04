package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

/**
 * @Title IndexWeek.java
 * @Package com.po
 * @version 1.0 
 */
public class IndexWeek implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int indexweekid;
	
	private String indexweekdate;//统计的时间
	private String indexweekcode;//药材编码
	private String indexweekname;//每周和每月的类型
	private String indexweekvalue;//每周和每月的不同种类统计值
	private String indexweekperiod;//
	
	private int inserttime;//没导入一个xml此变量自增1
	
	public int getInserttime() {
		return inserttime;
	}
	public void setInserttime(int inserttime) {
		this.inserttime = inserttime;
	}
	public String getIndexweekcode() {
		return indexweekcode;
	}
	public void setIndexweekcode(String indexweekcode) {
		this.indexweekcode = indexweekcode;
	}
	public String getIndexweekname() {
		return indexweekname;
	}
	public void setIndexweekname(String indexweekname) {
		this.indexweekname = indexweekname;
	}
	public String getIndexweekvalue() {
		return indexweekvalue;
	}
	public void setIndexweekvalue(String indexweekvalue) {
		this.indexweekvalue = indexweekvalue;
	}
	public String getIndexweekperiod() {
		return indexweekperiod;
	}
	public void setIndexweekperiod(String indexweekperiod) {
		this.indexweekperiod = indexweekperiod;
	}
	public String getIndexweekdate() {
		return indexweekdate;
	}
	public void setIndexweekdate(String indexweekdate) {
		this.indexweekdate = indexweekdate;
	}
	public int getIndexweekid() {
		return indexweekid;
	}
	public void setIndexweekid(int indexweekid) {
		this.indexweekid = indexweekid;
	}
}

