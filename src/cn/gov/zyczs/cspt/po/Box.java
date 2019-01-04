package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

/**
 * @Title Box.java
 * @Package com.po
 * @version 1.0
 * 箱码表  
 */
public class Box implements Serializable{
	private static final long serialVersionUID = 4587002037430387293L;
	
	private Integer storid;//药材饮片库存ID
	private String boxcode;//箱码
	private Double boxweight;//每箱重量
	private String addtime; //生产日期
	private Integer state;  //0表示有库存;1表示药材已销毁或饮片已出售
	private Integer instorboxid; //入库单id,关联inoutstorage表的id
	private Integer boxitemnum; //每箱具体包数
	private Integer stortype;   //箱码类型:0药材 ;1饮片
	private Integer outstorboxid; //出库单id,关联inoutstorage表的id
	private Integer orgid;// 组织编码
	private String packcode;//袋码
    
	//分页参数
	private int pager_count;      //总数目
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示个数
	private List<Box> boxlist;	  //箱码列表
	private Box box;			 //箱码对象
	private String sourcecode;    //溯源码
	private String prodname;      //品名
	private Integer flag;
	public String getBoxcode() {
		return boxcode;
	}
	public void setBoxcode(String boxcode) {
		this.boxcode = boxcode;
	}
	public Double getBoxweight() {
		return boxweight;
	}
	public void setBoxweight(Double boxweight) {
		this.boxweight = boxweight;
	}
	public String getAddtime() {
		if (addtime == null || addtime.length() < 19) {
			addtime = null;
		} else {
			addtime = addtime.substring(0, 19);
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
	public List<Box> getBoxlist() {
		return boxlist;
	}
	public void setBoxlist(List<Box> boxlist) {
		this.boxlist = boxlist;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public Box getBox() {
		return box;
	}
	public void setBox(Box box) {
		this.box = box;
	}
	public String getSourcecode() {
		return sourcecode;
	}
	public void setSourcecode(String sourcecode) {
		this.sourcecode = sourcecode;
	}
	public Integer getStorid() {
		return storid;
	}
	public void setStorid(Integer storid) {
		this.storid = storid;
	}
	public Integer getInstorboxid() {
		return instorboxid;
	}
	public void setInstorboxid(Integer instorboxid) {
		this.instorboxid = instorboxid;
	}
	public Integer getBoxitemnum() {
		return boxitemnum;
	}
	public void setBoxitemnum(Integer boxitemnum) {
		this.boxitemnum = boxitemnum;
	}
	public Integer getStortype() {
		return stortype;
	}
	public void setStortype(Integer stortype) {
		this.stortype = stortype;
	}
	public Integer getOutstorboxid() {
		return outstorboxid;
	}
	public void setOutstorboxid(Integer outstorboxid) {
		this.outstorboxid = outstorboxid;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	public Integer getOrgid() {
		return orgid;
	}
	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}
	public String getPackcode() {
		return packcode;
	}
	public void setPackcode(String packcode) {
		this.packcode = packcode;
	}
	public String getProdname() {
		return prodname;
	}
	public void setProdname(String prodname) {
		this.prodname = prodname;
	}
	
}
