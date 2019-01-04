package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

public class TempBox  implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String boxcode;
	private String timestamp;
	private Integer orgid;
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
	public String getBoxcode() {
		return boxcode;
	}
	public void setBoxcode(String boxcode) {
		this.boxcode = boxcode;
	}
	 

}
