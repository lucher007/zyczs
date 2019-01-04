package cn.gov.zyczs.cspt.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.dao.ICheckMatDao;
import cn.gov.zyczs.cspt.dao.IOrgUploadDao;
import cn.gov.zyczs.cspt.po.CheckMat;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.TabletStorage;



public class CheckMatImageAction extends BaseAction {
	private String contentType;
	InputStream inputStream;
	
	public CheckMatImageAction(){   
        this.contentType = "image/jpeg";              
    } 
	private ICheckMatDao checkMatDao;
	public void setCheckMatDao(ICheckMatDao checkMatDao) {
		this.checkMatDao = checkMatDao;
	}
	
	private String matcontent;
	public String getMatcontent() {
		return matcontent;
	}
	public void setMatcontent(String matcontent) {
		this.matcontent = matcontent;
	}
	
	
	private String uploadcontent;
	public String getUploadcontent() {
		return uploadcontent;
	}
	public void setUploadcontent(String uploadcontent) {
		this.uploadcontent = uploadcontent;
	}
	public String execute() throws Exception {
        return SUCCESS;   
    }
	
	private void createInputStream() throws IOException{
		CheckMat checkMat =  checkMatDao.findByIdMatImage(matcontent);
		if(checkMat!=null){
			ByteArrayOutputStream bos =new ByteArrayOutputStream();  
	        BufferedOutputStream stream = null;
	        bos.write(checkMat.getMatimage()); 
	        inputStream = new ByteArrayInputStream(bos.toByteArray());   			        
	        bos.close();   
		}
    }
	
	public InputStream getInputStream() throws Exception { 
		createInputStream();
    	return inputStream; 
    } 
	
	
	public void getMatImageFile() {
		try {
			HttpServletRequest request=this.getRequest();
			HttpServletResponse response=this.getResponse();
			CheckMat checkMat =  checkMatDao.findByIdMatImage(matcontent);
			if(checkMat!=null){
								
				response.reset();
				response.setContentType("application/octet-stream");
				response.addHeader("Content-Length", ""+checkMat.getMatimage().length); //设置返回的文件类型 
				response.addHeader("Content-Disposition", "attachment;filename="+new String(checkMat.getMatname().getBytes("gbk"), "iso-8859-1"));
				
		        InputStream fis = new ByteArrayInputStream(checkMat.getMatimage());  
				OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
				
				byte[] buffer = new byte[1024*1024];
				while(fis.read(buffer)>0){
					toClient.write(checkMat.getMatimage()); // 输出数据
				}
				
				fis.close();
				
				toClient.flush();
				toClient.close();
			
			}
			
		} catch (Exception ex) {
			ex.printStackTrace(); 
		}

	}
}
