package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title DeviceConf.java
 * @Package com.po
 * @version 1.0
 * 溯源秤配置表  
 */
@SuppressWarnings("serial")
public class DeviceConf implements Serializable{
	
	private Integer confid;            //配置ID
	private String companyname;        //厂商名称
	private String normname;           //规格名称
    private Integer conftype;          //类型(1-打印机；2-扫描器；3-移动终端；)   
	//分页参数
	private int pager_count;           //总数目
	private int pager_offset;          //当页第一行的序号
	private int pager_openset;         //当页显示个数
	private List<DeviceConf> deviceconflist; //溯源秤配置列表
	private DeviceConf deviceconf;	   //溯源秤配置对象
	private String returninfo;
	public Integer getConfid() {
		return confid;
	}
	public void setConfid(Integer confid) {
		this.confid = confid;
	}
	public String getCompanyname() {
		return companyname;
	}
	public void setCompanyname(String companyname) {
		this.companyname = companyname;
	}
	public String getNormname() {
		return normname;
	}
	public void setNormname(String normname) {
		this.normname = normname;
	}
	public Integer getConftype() {
		return conftype;
	}
	public void setConftype(Integer conftype) {
		this.conftype = conftype;
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
	public List<DeviceConf> getDeviceconflist() {
		return deviceconflist;
	}
	public void setDeviceconflist(List<DeviceConf> deviceconflist) {
		this.deviceconflist = deviceconflist;
	}
	public DeviceConf getDeviceconf() {
		return deviceconf;
	}
	public void setDeviceconf(DeviceConf deviceconf) {
		this.deviceconf = deviceconf;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	
}
