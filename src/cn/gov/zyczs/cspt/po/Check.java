package cn.gov.zyczs.cspt.po;

import java.io.File;
import java.io.Serializable;
import java.util.List;

/**
 * 检验实体类
 * 
 */
public class Check implements Serializable {

	private static final long serialVersionUID = 1L;

	private Integer checkid;// 主键 自增列
	private String checkmethod;// 检验方法
	private String checkgrade;// 质量级别:一级、二级、三级、不合格
	private String checkcondition;// 贮藏条件
	private String checkthickmethod;// 粗加工方法
	private String checkuser;// 检验员
	private String checktime;// 检验时间
	private String addtime;// 系统添加时间
	private Integer orgid;// 组织编码
	private Integer userid;// 用户id
	private Integer prodid;// 药材检验保存medstorage表的id；饮片检验保存tablet表的id
	private Integer type; // 检验类型:0药材;1饮片

	// //////////////////数据库辅助字段////////////////////////////
	private Integer checkstate;// 检验状态
	private String returninfo;// 返回到页面信息

	private File uploadify; // 文件
	private String uploadifyFileName; // 上传的文件名
	private String uploadifyContentType;// 上传的内容类型
	private Integer uploadType;// 1药材检验报告 2饮片检验报告 3药材产地证明

	private String matname;// 用户上传本地文件名
	private String matcontent;// 上传文件服务器端文件名
	private Integer matid;// 检验报告ID

	private String cpcmed;// 药材批次号
	private String medname;// 药材名
	private String cpctablet;// 饮片批次号
	private String tabletname;// 饮片名
	
	private int pager_count; // 分页总数
	private int pager_offset; // 分页量
	private int pager_openset; // 分页量

	private Integer medstorid;
	private Integer tabletid;
	private Double tabletweight;

	private Check check;

	private List<CheckMat> materiallist;

	public String getMatname() {
		return matname;
	}

	public void setMatname(String matname) {
		this.matname = matname;
	}

	public String getMatcontent() {
		return matcontent;
	}

	public void setMatcontent(String matcontent) {
		this.matcontent = matcontent;
	}

	public Integer getMatid() {
		return matid;
	}

	public void setMatid(Integer matid) {
		this.matid = matid;
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

	public Integer getUploadType() {
		return uploadType;
	}

	public void setUploadType(Integer uploadType) {
		this.uploadType = uploadType;
	}

	public String getReturninfo() {
		return returninfo;
	}

	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}

	public Integer getUserid() {
		return userid;
	}

	public void setUserid(Integer userid) {
		this.userid = userid;
	}

	public Integer getCheckstate() {
		return checkstate;
	}

	public void setCheckstate(Integer checkstate) {
		this.checkstate = checkstate;
	}

	public Integer getCheckid() {
		return checkid;
	}

	public void setCheckid(Integer checkid) {
		this.checkid = checkid;
	}

	public String getCheckmethod() {
		return checkmethod;
	}

	public void setCheckmethod(String checkmethod) {
		this.checkmethod = checkmethod;
	}

	public String getCheckgrade() {
		return checkgrade;
	}

	public void setCheckgrade(String checkgrade) {
		this.checkgrade = checkgrade;
	}

	public String getCheckcondition() {
		return checkcondition;
	}

	public void setCheckcondition(String checkcondition) {
		this.checkcondition = checkcondition;
	}

	public String getCheckthickmethod() {
		return checkthickmethod;
	}

	public void setCheckthickmethod(String checkthickmethod) {
		this.checkthickmethod = checkthickmethod;
	}

	public String getCheckuser() {
		return checkuser;
	}

	public void setCheckuser(String checkuser) {
		this.checkuser = checkuser;
	}

	public String getChecktime() {
		if(checktime == null || checktime.length() < 10){
			return null;
		}else{
			checktime = checktime.substring(0,10);
		}
		return checktime;
	}

	public void setChecktime(String checktime) {
		this.checktime = checktime;
	}

	public String getAddtime() {
		return addtime;
	}

	public void setAddtime(String addtime) {
		this.addtime = addtime;
	}

	public Integer getOrgid() {
		return orgid;
	}

	public void setOrgid(Integer orgid) {
		this.orgid = orgid;
	}

	public List<CheckMat> getMateriallist() {
		return materiallist;
	}

	public void setMateriallist(List<CheckMat> materiallist) {
		this.materiallist = materiallist;
	}

	public Check getCheck() {
		return check;
	}

	public void setCheck(Check check) {
		this.check = check;
	}

	public Integer getProdid() {
		return prodid;
	}

	public void setProdid(Integer prodid) {
		this.prodid = prodid;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getMedstorid() {
		return medstorid;
	}

	public void setMedstorid(Integer medstorid) {
		this.medstorid = medstorid;
	}

	public Integer getTabletid() {
		return tabletid;
	}

	public void setTabletid(Integer tabletid) {
		this.tabletid = tabletid;
	}

	public Double getTabletweight() {
		return tabletweight;
	}

	public void setTabletweight(Double tabletweight) {
		this.tabletweight = tabletweight;
	}

	public String getCpcmed() {
		return cpcmed;
	}

	public void setCpcmed(String cpcmed) {
		this.cpcmed = cpcmed;
	}

	public String getMedname() {
		return medname;
	}

	public void setMedname(String medname) {
		this.medname = medname;
	}

	public String getCpctablet() {
		return cpctablet;
	}

	public void setCpctablet(String cpctablet) {
		this.cpctablet = cpctablet;
	}

	public String getTabletname() {
		return tabletname;
	}

	public void setTabletname(String tabletname) {
		this.tabletname = tabletname;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
