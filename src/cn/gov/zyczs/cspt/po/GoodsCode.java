package cn.gov.zyczs.cspt.po;

import java.io.Serializable;

/**
 * @Title GoodsCode.java
 * @Package com.po
 * @version 1.0 
 * 商品编码表
 */
public class GoodsCode implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;			//商品编码ID
	private String type;		//商品类型 饮片1,药材0
	private String basecode;	//药材,饮片基础编码
	private String prodcode;	//商品编码
	private String cpccorp;		//用户企业码
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBasecode() {
		return basecode;
	}
	public void setBasecode(String basecode) {
		this.basecode = basecode;
	}
	public String getProdcode() {
		return prodcode;
	}
	public void setProdcode(String prodcode) {
		this.prodcode = prodcode;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	
}

