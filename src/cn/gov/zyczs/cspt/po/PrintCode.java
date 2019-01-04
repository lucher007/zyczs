package cn.gov.zyczs.cspt.po;

import java.util.List;

public class PrintCode {
	private Integer medstorid;//药材库存ID
	private Integer tabletstorid;//饮片库存ID
	private String cpccode;
	private String filename;
	private String filenametime;
	private String returninfo;
	private String dataparam;//打印参数;
	private Integer storageid;
	private Integer storagetype;
	private MedStorage medstorage;
	private TabletStorage tabletstorage;
	private String url;
	private List<Box> boxlist;
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量
	
	private Integer codetype; //溯源码类型（5-包码 6-箱码 7-袋码）
	private String packcode;  //8级包装码
	
	private Integer downCount;
	
	private Med med;
	private Tablet tablet;
	private String codeareashortname;
	private Integer printcol;//在饮片打印页 选择小包打印标签 3.三列 2.二列
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCpccode() {
		return cpccode;
	}
	public void setCpccode(String cpccode) {
		this.cpccode = cpccode;
	}
	public Integer getMedstorid() {
		return medstorid;
	}
	public void setMedstorid(Integer medstorid) {
		this.medstorid = medstorid;
	}
	public Integer getTabletstorid() {
		return tabletstorid;
	}
	public void setTabletstorid(Integer tabletstorid) {
		this.tabletstorid = tabletstorid;
	}
	public String getFilenametime() {
		return filenametime;
	}
	public void setFilenametime(String filenametime) {
		this.filenametime = filenametime;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public String getDataparam() {
		return dataparam;
	}
	public void setDataparam(String dataparam) {
		this.dataparam = dataparam;
	}
	public Integer getStorageid() {
		return storageid;
	}
	public void setStorageid(Integer storageid) {
		this.storageid = storageid;
	}
	public Integer getStoragetype() {
		return storagetype;
	}
	public void setStoragetype(Integer storagetype) {
		this.storagetype = storagetype;
	}
	public MedStorage getMedstorage() {
		return medstorage;
	}
	public void setMedstorage(MedStorage medstorage) {
		this.medstorage = medstorage;
	}
	public TabletStorage getTabletstorage() {
		return tabletstorage;
	}
	public void setTabletstorage(TabletStorage tabletstorage) {
		this.tabletstorage = tabletstorage;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<Box> getBoxlist() {
		return boxlist;
	}
	public void setBoxlist(List<Box> boxlist) {
		this.boxlist = boxlist;
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
	public Med getMed() {
		return med;
	}
	public void setMed(Med med) {
		this.med = med;
	}
	public Tablet getTablet() {
		return tablet;
	}
	public void setTablet(Tablet tablet) {
		this.tablet = tablet;
	}
	public String getCodeareashortname() {
		return codeareashortname;
	}
	public void setCodeareashortname(String codeareashortname) {
		this.codeareashortname = codeareashortname;
	}
	public Integer getCodetype() {
		return codetype;
	}
	public void setCodetype(Integer codetype) {
		this.codetype = codetype;
	}
	public Integer getDownCount() {
		return downCount;
	}
	public void setDownCount(Integer downCount) {
		this.downCount = downCount;
	}
	public Integer getPrintcol() {
		return printcol;
	}
	public void setPrintcol(Integer printcol) {
		this.printcol = printcol;
	}
	public String getPackcode() {
		return packcode;
	}
	public void setPackcode(String packcode) {
		this.packcode = packcode;
	}
	
	
	
	
}
