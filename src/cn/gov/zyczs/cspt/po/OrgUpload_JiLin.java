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
public class OrgUpload_JiLin implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer uploadid;//主键
	private String uploadname;//用户上传本地文件名
	private String uploadcontent;//上传文件服务器端文件名
	private Integer uploadtype;//1营业执照 2组织机构代证码 3其他证书  4手持机上传身份证 5手持机上传本人照片
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
	
}
