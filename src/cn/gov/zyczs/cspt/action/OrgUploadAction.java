package cn.gov.zyczs.cspt.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.apache.taglibs.standard.lang.jstl.OrOperator;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IOrgUploadDao;
import cn.gov.zyczs.cspt.dao.impl.OrgUploadDao;
import cn.gov.zyczs.cspt.po.CheckMat;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class OrgUploadAction extends BaseAction implements ModelDriven<OrgUpload>{

	
	OrgUpload form = new OrgUpload();

	@Override
	public OrgUpload getModel() {
		return form;
	}
	
	
	private IOrgUploadDao orgUploadDao;//企业组织上传附件dao

	public void setOrgUploadDao(IOrgUploadDao orgUploadDao) {
		this.orgUploadDao = orgUploadDao;
	}
	
	
	/**
	 * 保存上传文件
	 * 
	 * @return
	 * @throws IOException 
	 */
	public String saveObjectFile() throws IOException {
		File importFile = null;
		importFile = form.getUploadify();
		User user = (User) getSession().getAttribute("User");
		
		if (importFile == null) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件为空!"));
			return SUCCESS;
		}
		if (form.getUploadifyFileName() == null || "".equals(form.getUploadifyFileName())) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件名为空!"));
			return SUCCESS;
		}
		String file_org_path = ServletActionContext.getServletContext().getInitParameter("file_org_path");
		if (file_org_path == null || "".equals(file_org_path)) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,存储路径为空!"));
			return SUCCESS;
		}
		if (((float) (Math.round(importFile.length() / 1024 * 100)) / 100) > 2000) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件最大为2M!"));
			return SUCCESS;
		}
		String type = getStrend(form.getUploadifyFileName());
		StringBuffer filename = new StringBuffer(getNow()).append("_") ;
		
		//如果user为空,则代表为前台注册而来
		if(user == null){
			filename.append("register");
		}else{
			filename.append(user.getLoginname());
		}
		filename.append(".").append(type);
		
		//新增企业组织上传附件信息
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setUploadname(form.getUploadifyFileName());// .substring(0,form.getUploadifyFileName().indexOf(".")));
		orgUpload.setUploadcontent(file_org_path + "/" + getDateMonthStr() + "/" + filename);
		orgUpload.setUploadtype(form.getUploadtype());//1营业执照 2组织机构代证码 3其他证书
		orgUpload.setType(form.getType());//0企业 1组织
		orgUpload.setUploadimage(Tools.getBytesFromFile(form.getUploadify()));
		orgUpload.setId(form.getId());
		orgUpload.setTokenid(form.getTokenid());//保存页面token值
		Integer uploadId =  orgUploadDao.save(orgUpload);
		if (uploadId != null && uploadId > 0) {
			form.setUploadid(uploadId);
			form.setUploadname(orgUpload.getUploadname());
			form.setUploadcontent(orgUpload.getUploadcontent());
			form.setReturninfo(upSuccessStr(orgUpload.getUploadname()));
		} else {
			form.setReturninfo("更新失败!");
		}
		return SUCCESS;
	}
	
	
	public String upErrorStr(String filename, String errorInfo) {
		return "<div style=\"border:1px solid green;width:100px;float:left;margin:5px 0 0 5px;\"><div style=\"width:100px;height:20px;line-height:20px;vertical-align: middle;font-weight:bold;background:url('images/tabletitle.png') repeat-x;text-align:center;color:red;\">文件错误</div><div style=\"width:100px;height:80px;text-align:center;\">"
				+ filename + "<br style=\"clear:both;\" />" + errorInfo + "</div></div>";
	}

	public String upSuccessStr(String matname) {
		matname = matname.replaceAll(" ", "_");
		return "<div style=\"border:1px solid green;width:100px;float:left;margin:5px 0 0 5px;\"><div style=\"width:100px;height:20px;line-height:20px;vertical-align: middle;font-weight:bold;background:url('images/tabletitle.png') repeat-x;text-align:center;\">上传文件</div><div style=\"width:100px;height:80px;text-align:center;overflow:hidden;\">"
				+ matname + "</div></div>";
	}

	public static String getDateMonthStr() {
		return (new SimpleDateFormat("yyyy-MM")).format(new Date());
	}

	public static String getStrend(String str) {
		String[] strVale = str.split("[.]");
		int Maxs = (strVale.length) - 1;

		str = strVale[Maxs];

		return str;
	}

	public static String getNow() {
		return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date());
	}
	
	
	/**
	 * 根据上传附件id,类型,企业或者组织查询附件
	 * @return
	 */
	public String findByMaterial() {
		form.setList(orgUploadDao.findByCondtion(form));
		return SUCCESS;
	}
	
	/**
	 * 根据检验报告表ID删除检验报告
	 * 
	 * @return
	 */
	public String deleteMaterial() {
		orgUploadDao.deleteObj(form);
		return SUCCESS;
	}
}
