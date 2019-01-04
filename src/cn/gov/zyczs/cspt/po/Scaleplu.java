package cn.gov.zyczs.cspt.po;

/**
 * 
 * SScaleplu entity. @author MyEclipse Persistence Tools
 */

public class Scaleplu implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String plucode;                //PLU代码
	private String commoditycode;          //商品码
	private String commodityname;          //商品名称
	private Long pluver;                   //PLU版本
	/**
	 * 
	 */
	public Scaleplu() {
		super();
	}
	/**
	 * @param commoditycode
	 * @param commodityname
	 * @param plucode
	 * @param pluver
	 */
	public Scaleplu(String commoditycode, String commodityname,
			String plucode, Long pluver) {
		super();
		this.commoditycode = commoditycode;
		this.commodityname = commodityname;
		this.plucode = plucode;
		this.pluver = pluver;
	}
	public String getPlucode() {
		return plucode;
	}
	public void setPlucode(String plucode) {
		this.plucode = plucode;
	}
	public String getCommoditycode() {
		return commoditycode;
	}
	public void setCommoditycode(String commoditycode) {
		this.commoditycode = commoditycode;
	}
	public String getCommodityname() {
		return commodityname;
	}
	public void setCommodityname(String commodityname) {
		this.commodityname = commodityname;
	}
	public Long getPluver() {
		return pluver;
	}
	public void setPluver(Long pluver) {
		this.pluver = pluver;
	}

}