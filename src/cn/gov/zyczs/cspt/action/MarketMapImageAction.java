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
import cn.gov.zyczs.cspt.dao.IMarketMapDao;
import cn.gov.zyczs.cspt.dao.IOrgUploadDao;
import cn.gov.zyczs.cspt.po.CheckMat;
import cn.gov.zyczs.cspt.po.MarketMap;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.TabletStorage;



public class MarketMapImageAction extends BaseAction {
	private String contentType;
	InputStream inputStream;
	
	public MarketMapImageAction(){   
        this.contentType = "image/jpeg";              
    } 
	
	private IMarketMapDao marketMapDao;
	public void setMarketMapDao(IMarketMapDao marketMapDao) {
		this.marketMapDao = marketMapDao;
	}
	
	private String mapcontent;
	public String getMapcontent() {
		return mapcontent;
	}

	public void setMapcontent(String mapcontent) {
		this.mapcontent = mapcontent;
	}

	public String execute() throws Exception {
        return SUCCESS;   
    }
	
	private void createInputStream() throws IOException{
		MarketMap marketMap =  marketMapDao.findByIdMarketMapImage(mapcontent);
		if(marketMap != null){
			ByteArrayOutputStream bos =new ByteArrayOutputStream();  
	        BufferedOutputStream stream = null;
	        bos.write(marketMap.getImage()); 
	        inputStream = new ByteArrayInputStream(bos.toByteArray());   			        
	        bos.close();   
		}
    }
	
	public InputStream getInputStream() throws Exception { 
		createInputStream();
    	return inputStream; 
    } 
	
	
	public void getMarketMapImageFile() {
		try {
			HttpServletRequest request=this.getRequest();
			HttpServletResponse response=this.getResponse();
			MarketMap marketMap =  marketMapDao.findByIdMarketMapImage(mapcontent);
			if(marketMap!=null){
								
				response.reset();
				response.setContentType("application/octet-stream");
				response.addHeader("Content-Length", ""+marketMap.getImage().length); //设置返回的文件类型 
				response.addHeader("Content-Disposition", "attachment;filename="+new String(marketMap.getMapname().getBytes("gbk"), "iso-8859-1"));
				
		        InputStream fis = new ByteArrayInputStream(marketMap.getImage());  
				OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
				
				byte[] buffer = new byte[1024*1024];
				while(fis.read(buffer)>0){
					toClient.write(marketMap.getImage()); // 输出数据
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
