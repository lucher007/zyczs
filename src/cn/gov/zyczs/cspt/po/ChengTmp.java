package cn.gov.zyczs.cspt.po;

import java.util.List;
import java.util.Map;

/**
 * 溯源秤 快捷键
 * SScalefck entity. @author MyEclipse Persistence Tools
 */

public class ChengTmp implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer tmpid;        //模板ID
	private Integer confid;        //秤配置规格类型
	private String tmpname;       //模板名称
	private String remark;        //备注
	
	private String normname;      //配置规格名称
	
	//分页参数
	private int pager_count;                   //总数目
	private int pager_offset;                  //当页第一行的序号
	private int pager_openset;                 //当页显示个数
	private List<ChengTmp> chengtmplist;       //快捷键模板列表
	private ChengTmp chengtmp;		           //溯源秤快捷键模板
	private Map<Integer,String> chengconfmap;  //溯源秤规格配置Map
	private ChengConf chengConf;		     //溯源秤规格配置对象
	private List<String> strList; 
	private String returninfo;                 //页面返回消息
	
	private List<ChengFckTmp> chengfcktmplist; //模板快捷键对象集合
	private ChengFckTmp chengfcktmp;		   //模板快捷键对象
	private String keystring;                  //模板键配置 横纵坐标值拼接  -x(横坐标),y(纵坐标)
	
	public Integer getTmpid() {
		return tmpid;
	}
	public void setTmpid(Integer tmpid) {
		this.tmpid = tmpid;
	}
	public Integer getConfid() {
		return confid;
	}
	public void setConfid(Integer confid) {
		this.confid = confid;
	}
	public String getTmpname() {
		return tmpname;
	}
	public void setTmpname(String tmpname) {
		this.tmpname = tmpname;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
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
	public String getNormname() {
		return normname;
	}
	public void setNormname(String normname) {
		this.normname = normname;
	}
	public List<ChengTmp> getChengtmplist() {
		return chengtmplist;
	}
	public void setChengtmplist(List<ChengTmp> chengtmplist) {
		this.chengtmplist = chengtmplist;
	}
	public ChengTmp getChengtmp() {
		return chengtmp;
	}
	public void setChengtmp(ChengTmp chengtmp) {
		this.chengtmp = chengtmp;
	}
	public Map<Integer, String> getChengconfmap() {
		return chengconfmap;
	}
	public void setChengconfmap(Map<Integer, String> chengconfmap) {
		this.chengconfmap = chengconfmap;
	}
	public List<String> getStrList() {
		return strList;
	}
	public void setStrList(List<String> strList) {
		this.strList = strList;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public List<ChengFckTmp> getChengfcktmplist() {
		return chengfcktmplist;
	}
	public void setChengfcktmplist(List<ChengFckTmp> chengfcktmplist) {
		this.chengfcktmplist = chengfcktmplist;
	}
	public ChengFckTmp getChengfcktmp() {
		return chengfcktmp;
	}
	public void setChengfcktmp(ChengFckTmp chengfcktmp) {
		this.chengfcktmp = chengfcktmp;
	}
	public ChengConf getChengConf() {
		return chengConf;
	}
	public void setChengConf(ChengConf chengConf) {
		this.chengConf = chengConf;
	}
	public String getKeystring() {
		return keystring;
	}
	public void setKeystring(String keystring) {
		this.keystring = keystring;
	}
	
}