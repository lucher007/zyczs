package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/*
 * 入库成功溯源码
 */
public class InStorSuccessCode implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String batchno;//批次号
	private String code;//溯源码
	private String spec;//规格(单位：片)
	private String weight;//每包重量
	private String boxitemnum;//每箱包数
	private String pcode;//商品编码
	private String pname;//品名
	private String areacode;//区域编码
	private String lasttime;//最后操作时间 时间戳类型
	
	private String boxsCode="";
	private Integer boxnum;
	
	private Integer orgid;
	
	
	
	private List<InStorSuccessCode> childList=new ArrayList<InStorSuccessCode>();
	
	
	public List<InStorSuccessCode> getChildList() {
		return childList;
	}
	public void setChildList(List<InStorSuccessCode> childList) {
		this.childList = childList;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getBatchno() {
		return batchno;
	}
	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	public String getLasttime() {
		return lasttime;
	}
	public void setLasttime(String lasttime) {
		this.lasttime = lasttime;
	}
	public String getBoxitemnum() {
		return boxitemnum;
	}
	public void setBoxitemnum(String boxitemnum) {
		this.boxitemnum = boxitemnum;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getBoxsCode() {
		return boxsCode;
	}
	public void setBoxsCode(String boxsCode) {
		this.boxsCode = boxsCode;
	}
	public Integer getBoxnum() {
		return boxnum;
	}
	public void setBoxnum(Integer boxnum) {
		this.boxnum = boxnum;
	}

}
