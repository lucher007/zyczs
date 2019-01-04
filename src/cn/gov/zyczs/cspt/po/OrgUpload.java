package cn.gov.zyczs.cspt.po;

import java.io.File;
import java.io.Serializable;
import java.util.List;
/**
 * 企业组织注册上传的附件类
 * @Title OrgUpload.java
 * @Package com.po
 * @version 1.0 
 */
public class OrgUpload implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer uploadid;//主键
	private String uploadname;//用户上传本地文件名
	private String uploadcontent;//上传文件服务器端文件名
	private Integer uploadtype;//1营业执照 2组织机构代证码 3其他证书  4手持机上传身份证 5手持机上传本人照片
	private String uploadaddtime;//上传时间 
	private Integer id;//企业或者组织ID
	private byte[] uploadimage;//图片流
	private Integer type;//0企业 1组织
	private String tempuuid;//临时作为更新企业,组织id
	
	private File uploadify; // 文件
	private String uploadifyFileName; // 上传的文件名
	private String uploadifyContentType;// 上传的内容类型
	private String returninfo;//
	private List<OrgUpload> list;//上传附件集合
	
	private String uploadids;//上传附件id集合
	private String tokenid; //页面获取的tokenid值 唯一
	
	public String getTokenid() {
		return tokenid;
	}
	public void setTokenid(String tokenid) {
		this.tokenid = tokenid;
	}
	public String getReturninfo() {
		return returninfo;
	}
	public void setReturninfo(String returninfo) {
		this.returninfo = returninfo;
	}
	public File getUploadify() {
		return uploadify;
	}
	public void setUploadify(File uploadify) {
		this.uploadify = uploadify;
	}
	public Integer getUploadid() {
		return uploadid;
	}
	public void setUploadid(Integer uploadid) {
		this.uploadid = uploadid;
	}
	public String getUploadname() {
		return uploadname;
	}
	public void setUploadname(String uploadname) {
		this.uploadname = uploadname;
	}
	public String getUploadcontent() {
		return uploadcontent;
	}
	public void setUploadcontent(String uploadcontent) {
		this.uploadcontent = uploadcontent;
	}
	public Integer getUploadtype() {
		return uploadtype;
	}
	public void setUploadtype(Integer uploadtype) {
		this.uploadtype = uploadtype;
	}
	public String getUploadaddtime() {
		return uploadaddtime;
	}
	public void setUploadaddtime(String uploadaddtime) {
		this.uploadaddtime = uploadaddtime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public byte[] getUploadimage() {
		return uploadimage;
	}
	public void setUploadimage(byte[] uploadimage) {
		this.uploadimage = uploadimage;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getTempuuid() {
		return tempuuid;
	}
	public void setTempuuid(String tempuuid) {
		this.tempuuid = tempuuid;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
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
	public List<OrgUpload> getList() {
		return list;
	}
	public void setList(List<OrgUpload> list) {
		this.list = list;
	}
	public String getUploadids() {
		return uploadids;
	}
	public void setUploadids(String uploadids) {
		this.uploadids = uploadids;
	}
}
