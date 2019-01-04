package cn.gov.zyczs.cspt.po;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.common.Tools;

public class Freeze {
	private Integer freezeid; //冻结序列号
	private String cpccode;//CPC编码
	private String reason;//冻结原因
	private String addtime;//操作时间
	private String endtime;//操作时间
	private Integer state;//码的状态：0-解锁 1-加锁
	private Integer cpclevel;//码的类型：1-企业码 2-产品码 3-批次码 4-溯源码
	private String areacode;//地区编码
	private Freeze freeze;
	private List<Freeze> freezelist;
	
	//类型
	public final static Map<Integer,String> cpclevelMap=new HashMap<Integer, String>();
	static{
		cpclevelMap.put(1, "企业码");
		cpclevelMap.put(2, "产品码");
		cpclevelMap.put(3, "批次码");
		cpclevelMap.put(4, "溯源码");		
		
	}
	
	public  String getCpclevelMap() {
		String temp2="";
		temp2=Tools.removeNullString(cpclevelMap.get(this.cpclevel));	
		return temp2;
	}
	
	
	
	//分页参数
	private int pager_count;      //总数目
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示个数
	private String returninfo;	  //返回消息
	public Integer getFreezeid() {
		return freezeid;
	}
	public void setFreezeid(Integer freezeid) {
		this.freezeid = freezeid;
	}
	public String getCpccode() {
		return cpccode;
	}
	public void setCpccode(String cpccode) {
		this.cpccode = cpccode;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getAddtime() {
		if(addtime==null||addtime.length()<10){
			addtime=null;
		}else{
			addtime=addtime.substring(0,10);
		}
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Integer getCpclevel() {
		return cpclevel;
	}
	public void setCpclevel(Integer cpclevel) {
		this.cpclevel = cpclevel;
	}
	public Freeze getFreeze() {
		return freeze;
	}
	public void setFreeze(Freeze freeze) {
		this.freeze = freeze;
	}
	public List<Freeze> getFreezelist() {
		return freezelist;
	}
	public void setFreezelist(List<Freeze> freezelist) {
		this.freezelist = freezelist;
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
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getAreacode() {
		return areacode;
	}
	public void setAreacode(String areacode) {
		this.areacode = areacode;
	}
	
}
