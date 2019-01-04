package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

public class ChengState implements Serializable{
	
	/**
	 * 用来记录秤一周历史变化的实体类
	 */
	private static final long serialVersionUID = 1L;
	private String chengcode;//秤编码
	private String addtime; //秤记录时间
	private String statestr;//秤的状态
	private String connection="已开机";//已开机
	private String trading="交易中";//交易中
	private String noconnection="未连接";//未连接
	private String state;//秤的状态
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getConnection() {
		return connection;
	}
	public void setConnection(String connection) {
		this.connection = connection;
	}
	public String getTrading() {
		return trading;
	}
	public void setTrading(String trading) {
		this.trading = trading;
	}
	public String getNoconnection() {
		return noconnection;
	}
	public void setNoconnection(String noconnection) {
		this.noconnection = noconnection;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public String getStatestr() {
		return statestr;
	}
	public void setStatestr(String statestr) {
		this.statestr = statestr;
	}
	public String getChengcode() {
		return chengcode;
	}
	public void setChengcode(String chengcode) {
		this.chengcode = chengcode;
	}
}
