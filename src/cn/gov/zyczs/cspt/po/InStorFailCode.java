package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import cn.gov.zyczs.cspt.common.Tools;

/*
 * 入库失败溯源码
 */
public class InStorFailCode implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private String code;//溯源码
	private String reason;//失败原因
	private String oriownercpc;//原货主
	private String newownercpc;//新货主
	
	
	
	//类型
	public final static Map<String,String> reasonMap=new HashMap<String, String>();
	static{
		reasonMap.put("0", "溯源码不存在");
		reasonMap.put("1", "溯源码已冻结");
		reasonMap.put("2", "溯源码未出库");
		reasonMap.put("3", "货权信息不匹配");
		reasonMap.put("4", "货权信息不匹配");
		reasonMap.put("6", "中码入库异常");
		
		
		reasonMap.put("01", "溯源码已冻结-质量原因");
		reasonMap.put("02", "溯源码已冻结-其他原因");
		
		reasonMap.put("11", "批次码已冻结-质量原因");
		reasonMap.put("12", "批次码已冻结-其他原因");
		
		reasonMap.put("21", "产品码已冻结-质量原因");
		reasonMap.put("22", "产品码已冻结-其他原因");
	}
	
	public  String getReasonMap() {
		String tmp=Tools.removeNullString(this.reason);
		String temp2="";
		temp2=Tools.removeNullString(reasonMap.get(tmp));
		if(temp2.equals(""))
		{
			temp2="无效的溯源码";
		}
		return temp2;
	}
	
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getOriownercpc() {
		return oriownercpc;
	}
	public void setOriownercpc(String oriownercpc) {
		this.oriownercpc = oriownercpc;
	}
	public String getNewownercpc() {
		return newownercpc;
	}
	public void setNewownercpc(String newownercpc) {
		this.newownercpc = newownercpc;
	}

}
