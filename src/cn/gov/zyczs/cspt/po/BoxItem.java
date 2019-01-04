package cn.gov.zyczs.cspt.po;

import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
public class BoxItem implements Serializable{
    private String boxcode;   //箱码
    private String sourcecode;//小包装溯源码
    private Double weight;    //规格
    
    //分页参数
	private int pager_count;      //总数目
	private int pager_offset;     //当页第一行的序号
	private int pager_openset;    //当页显示个数
	private List<BoxItem> boxitemlist;
	private BoxItem boxitem;
	
	
	public String getBoxcode() {
		return boxcode;
	}
	public void setBoxcode(String boxcode) {
		this.boxcode = boxcode;
	}
	public String getSourcecode() {
		return sourcecode;
	}
	public void setSourcecode(String sourcecode) {
		this.sourcecode = sourcecode;
	}
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
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
	public List<BoxItem> getBoxitemlist() {
		return boxitemlist;
	}
	public void setBoxitemlist(List<BoxItem> boxitemlist) {
		this.boxitemlist = boxitemlist;
	}
	public BoxItem getBoxitem() {
		return boxitem;
	}
	public void setBoxitem(BoxItem boxitem) {
		this.boxitem = boxitem;
	}
	
}
