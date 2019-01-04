package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title MedBase.java
 * @Package com.po
 * @version 1.0
 * 药材基础表 
 */
public class MedBase implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private Integer id;			//ID
	private String name;		//药材详细名称
	private String keyword;		//药材英文名称
	private String source;		//药材来源
	private String sourcepart;	//药材来源部位
	private String medname;		//药材名称
	private String sourcenum;	//药材来源编号
	private String sourcepartnum;//药材来源部位编号
	private String mednamenum;	//药材名称编号
	private String namenum;		//药材详细名称编号
	private String sourceid;	//药材编码
	private String lastime;		//最近更新时间	
	private String enable;		//1=可用,非1=不可用
	
	
	private List<MedBase> list;
	/*****************数据库辅助字段********************/
	private String returnInfo;	//返回消息
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private String mcontent;
	private String plu;
	public String getPlu() {
		return plu;
	}
	public void setPlu(String plu) {
		this.plu = plu;
	}
	public String getMcontent() {
		return mcontent;
	}
	public void setMcontent(String mcontent) {
		this.mcontent = mcontent;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getSourcepart() {
		return sourcepart;
	}
	public void setSourcepart(String sourcepart) {
		this.sourcepart = sourcepart;
	}
	public String getMedname() {
		return medname;
	}
	public void setMedname(String medname) {
		this.medname = medname;
	}
	public String getSourcenum() {
		return sourcenum;
	}
	public void setSourcenum(String sourcenum) {
		this.sourcenum = sourcenum;
	}
	public String getSourcepartnum() {
		return sourcepartnum;
	}
	public void setSourcepartnum(String sourcepartnum) {
		this.sourcepartnum = sourcepartnum;
	}
	public String getMednamenum() {
		return mednamenum;
	}
	public void setMednamenum(String mednamenum) {
		this.mednamenum = mednamenum;
	}
	public String getNamenum() {
		return namenum;
	}
	public void setNamenum(String namenum) {
		this.namenum = namenum;
	}
	public String getSourceid() {
		return sourceid;
	}
	public void setSourceid(String sourceid) {
		this.sourceid = sourceid;
	}
	public String getLastime() {
		return lastime;
	}
	public void setLastime(String lastime) {
		this.lastime = lastime;
	}
	public String getEnable() {
		return enable;
	}
	public void setEnable(String enable) {
		this.enable = enable;
	}
	public String getReturnInfo() {
		return returnInfo;
	}
	public void setReturnInfo(String returnInfo) {
		this.returnInfo = returnInfo;
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
	public List<MedBase> getList() {
		return list;
	}
	public void setList(List<MedBase> list) {
		this.list = list;
	}
}
