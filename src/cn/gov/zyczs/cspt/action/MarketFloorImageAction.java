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
import java.io.StringBufferInputStream;

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



public class MarketFloorImageAction extends BaseAction {
	private String contentType;
	InputStream inputStream;
	
	public MarketFloorImageAction(){   
        this.contentType = "image/jpeg";              
    } 
	
	private IMarketMapDao marketMapDao;
	public void setMarketMapDao(IMarketMapDao marketMapDao) {
		this.marketMapDao = marketMapDao;
	}
	private Integer areanum;
	private Integer floornum;
	private String cpccorp;
	
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

	public String getCpccorp() {
		return cpccorp;
	}

	public void setCpccorp(String cpccorp) {
		this.cpccorp = cpccorp;
	}

	public String execute() throws Exception {
        return SUCCESS;   
    }
	
	private void createInputStream() throws IOException{
		MarketMap temp = new MarketMap();
		temp.setAreanum(areanum);
		temp.setFloornum(floornum);
		temp.setCpccorp(cpccorp);
		MarketMap	marketMap =  marketMapDao.findMarketFloorImage(temp);
		if(marketMap != null && marketMap.getImage() != null){
			ByteArrayOutputStream bos =new ByteArrayOutputStream();  
	        BufferedOutputStream stream = null;
	        bos.write(marketMap.getImage()); 
	        inputStream = new ByteArrayInputStream(bos.toByteArray());   			        
	        bos.close();   
		}
    }
	
	public InputStream getInputStream() throws Exception { 
			createInputStream();
			return inputStream != null ? inputStream : new StringBufferInputStream("暂无楼层图信息,请重新选择！");
    } 
	
	public void getMarketFloorImageFile() {
		try {
			HttpServletRequest request=this.getRequest();
			HttpServletResponse response=this.getResponse();
			MarketMap temp = new MarketMap();
			temp.setAreanum(areanum);
			temp.setFloornum(floornum);
			temp.setCpccorp(cpccorp);
			MarketMap marketMap =  marketMapDao.findMarketFloorImage(temp);
			if(marketMap != null && marketMap.getImage() != null){
								
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
