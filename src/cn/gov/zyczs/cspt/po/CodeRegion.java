package cn.gov.zyczs.cspt.po;

import java.util.List;

public class CodeRegion {
	private Integer id;
	private String gbcode;
	private String gbname;
	private CodeRegion coderegion;
	private List<CodeRegion> coderegionlist;
	
	private String returnInfo;
	private int pager_count;
	private int pager_offset;
	private int pager_openset;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getGbcode() {
		return gbcode;
	}
	public void setGbcode(String gbcode) {
		this.gbcode = gbcode;
	}
	public String getGbname() {
		return gbname;
	}
	public void setGbname(String gbname) {
		this.gbname = gbname;
	}
	public CodeRegion getCoderegion() {
		return coderegion;
	}
	public void setCoderegion(CodeRegion coderegion) {
		this.coderegion = coderegion;
	}
	public List<CodeRegion> getCoderegionlist() {
		return coderegionlist;
	}
	public void setCoderegionlist(List<CodeRegion> coderegionlist) {
		this.coderegionlist = coderegionlist;
	}
	public String getReturnInfo() {
		return returnInfo;
	}
	public void setReturnInfo(String returnInfo) {
		this.returnInfo = returnInfo;
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
}
