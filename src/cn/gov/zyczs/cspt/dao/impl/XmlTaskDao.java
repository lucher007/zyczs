package cn.gov.zyczs.cspt.dao.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.ZyczsXml;


public class XmlTaskDao  {
	
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	public void createXml()
	{
		List<ZyczsXml> list=zyczsXmlDao.findByList();
		if(list!=null&&list.size()>0)
		{
			for(ZyczsXml vo:list)
			{
				 String xmlStr = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>";
					 xmlStr+="<zyczs guid=\""+vo.getGuid()+"\">";
					 xmlStr+="<deployment>";
					 xmlStr+="<code>deploy0001</code>";
					 xmlStr+="<name>chengdu</name>";
					 xmlStr+="<password>chengdu</password>";
					 xmlStr+="</deployment>";					 
					 xmlStr+=vo.getXmlcontent();
					 xmlStr+="</zyczs>";
					 
					 if(saveFileToServer2(xmlStr))
					 {
//						 zyczsXmlDao.deleteById(vo.getGuid());
					 }
			}
		}
	}
	
	
	public  Boolean  saveFileToServer2(String xmlStr)  {
		Boolean flag=true;
		try{
			String fileName=Tools.getNowRandom();
			// 创建目录
			File dir = new File("/home/datasync/tradenet/adatper/out/"+fileName+".txt");
//			File dir = new File("d:/"+fileName+".txt");
//			if (!dir.exists()) {
//				dir.mkdir();
//			}
			// 读取文件流并保持在指定路径

			OutputStream outputStream = new FileOutputStream(dir);
			if(xmlStr!=null)
			{
				outputStream.write(xmlStr.getBytes());
			}
			
			outputStream.close();
		}catch(Exception e)
		{
			flag=false;
			e.printStackTrace();
		}
		
		return flag;
	}

}
