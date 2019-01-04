package cn.gov.zyczs.cspt.po;

import java.io.File;
import java.io.Serializable;
import java.util.List;
/**
 *  @Title MarketMap.java
 * @Package com.po
 * @version 1.0 
 * 市场区域图
 *
 */
public class MarketMap implements Serializable{
	
	
	private Integer id;//主键
	private String area;//市场的几区 因项目调整了区域楼层间包含关系 楼为大 现在area保存的楼信息
	private String floor;//市场的几楼  floor保存的是区信息
	private byte[] image;//市场区域图
	private String mapname;//用户上传本地文件名
	private String mapcontent;//上传文件服务器端文件名
	private Integer areanum;//区编号
	private String addtime;//上传时间
	private Integer floornum;//楼编号
	private String cpccorp;//市场cpc码
	
	/************辅助字段,不计入数据库*****************/
	private int pager_count;	//分页总数
	private int pager_offset;	//分页量
	private int pager_openset;	//分页量
	private List<MarketMap> list;//
	private Integer layers;//层数
	private Integer maxareanum;//当前最大区域
	private File uploadify; // 文件
	private String uploadifyFileName; // 上传的文件名
	private String uploadifyContentType;// 上传的内容类型
	private String returninfo;//
	private List<MarketMap> arealist;//区和区编号集合
	private List<MarketMap> floorlist;//楼和楼编号集合
	private String orgname;
	public String getOrgname() {
		return orgname;
	}
	public void setOrgname(String orgname) {
		this.orgname = orgname;
	}
	public List<MarketMap> getArealist() {
		return arealist;
	}
	public void setArealist(List<MarketMap> arealist) {
		this.arealist = arealist;
	}
	public List<MarketMap> getFloorlist() {
		return floorlist;
	}
	public void setFloorlist(List<MarketMap> floorlist) {
		this.floorlist = floorlist;
	}
	public Integer getMaxareanum() {
		return maxareanum;
	}
	public void setMaxareanum(Integer maxareanum) {
		this.maxareanum = maxareanum;
	}
	public Integer getLayers() {
		return layers;
	}
	public void setLayers(Integer layers) {
		this.layers = layers;
	}
	public int getPager_count() {
		return pager_count;
	}
	public void setPager_count(int pager_count) {
		this.pager_count = pager_count;
	}
	public int getPager_offset() {
		return pager_offset;
	}
	public void setPager_offset(int pager_offset) {
		this.pager_offset = pager_offset;
	}
	public int getPager_openset() {
		return pager_openset;
	}
	public void setPager_openset(int pager_openset) {
		this.pager_openset = pager_openset;
	}
	public List<MarketMap> getList() {
		return list;
	}
	public void setList(List<MarketMap> list) {
		this.list = list;
	}
	public String getCpccorp() {
		return cpccorp;
	}
	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}
	public String getMapname() {
		return mapname;
	}
	public void setMapname(String mapname) {
		this.mapname = mapname;
	}
	public String getMapcontent() {
		return mapcontent;
	}
	public void setMapcontent(String mapcontent) {
		this.mapcontent = mapcontent;
	}
	public String getAddtime() {
		return addtime;
	}
	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getFloor() {
		return floor;
	}
	public void setFloor(String floor) {
		this.floor = floor;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	public Integer getAreanum() {
		return areanum;
	}
	public void setAreanum(Integer areanum) {
		this.areanum = areanum;
	}
	public Integer getFloornum() {
		return floornum;
	}
	public void setFloornum(Integer floornum) {
		this.floornum = floornum;
	}
	public File getUploadify() {
		return uploadify;
	}
	public void setUploadify(File uploadify) {
		this.uploadify = uploadify;
	}
	public String getUploadifyFileName() {
		return uploadifyFileName;
	}
	public void setUploadifyFileName(String uploadifyFileName) {
		this.uploadifyFileName = uploadifyFileName;
	}
	public String getUploadifyContentType() {
		return uploadifyContentType;
	}
	public void setUploadifyContentType(String uploadifyContentType) {
		this.uploadifyContentType = uploadifyContentType;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
}
