package cn.gov.zyczs.cspt.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.dao.IBoxItemDao;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.IMedDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.ITabletDao;
import cn.gov.zyczs.cspt.dao.ITabletStorageDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.Med;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.PrintCode;
import cn.gov.zyczs.cspt.po.Tablet;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;
/**
 * @Title PrintCodeAction.java
 * @Package com.action
 * @version 1.0 
 * 打印action
 */
public class PrintCodeAction extends BaseAction implements ModelDriven<PrintCode> {
	PrintCode form = new PrintCode();
	@Override
	public PrintCode getModel() {
		return form;
	}
	private IBoxDao boxDao;
	public void setBoxDao(IBoxDao boxDao) {
		this.boxDao = boxDao;
	}
	private IBoxItemDao boxItemDao;
	public void setBoxItemDao(IBoxItemDao boxItemDao) {
		this.boxItemDao = boxItemDao;
	}

	private IMedStorageDao medStorageDao;
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	private ITabletStorageDao tabletStorageDao;
	public void setTabletStorageDao(ITabletStorageDao tabletStorageDao) {
		this.tabletStorageDao = tabletStorageDao;
	}
	private IMedDao medDao;
	public void setMedDao(IMedDao medDao) {
		this.medDao = medDao;
	}
	private ITabletDao tabletDao;
	public void setTabletDao(ITabletDao tabletDao) {
		this.tabletDao = tabletDao;
	}
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}
	//===================================================药材===================================================
	/**
	 * 
	 * 生成药材溯源码文件
	 * @throws IOException 
	 */
	public String createMedFile() throws IOException{
		User user = (User) getSession().getAttribute("User");
		if(form.getMedstorid()==null||form.getCpccode()==null){
			return SUCCESS;
		}
		
		//================================华丽的分割线====================================================
		 //省去此方法的文件生成策略、在下载方法中直接读取溯源码字符串以文件方式输出，为了不用更新jsp中js 代码
		 //Filename===form.getTabletstorid()

		MedStorage medStorage = new MedStorage();
		medStorage.setMedstorid(form.getMedstorid());
		medStorage.setDownstate(1);
		if(medStorageDao.update(medStorage)==0){
			return SUCCESS;
		}
		
		form.setFilename(form.getMedstorid().toString());
		
		return SUCCESS;
	}
	
	
	public void getMedFile() {
		try {
			HttpServletResponse response=this.getResponse();
			//注：filename传递过来的是medstorid
			form.setMedstorid(Integer.parseInt(form.getFilename()));
			
			Box box = new Box();
			box.setStorid(form.getMedstorid());
			box.setStortype(0);
			List<Box> boxlist = boxDao.findByAll(box);
			if(boxlist==null||boxlist.size()<1){
				throw new Exception("文件不存在!");
			}
			
			StringBuffer codeStr=new StringBuffer();
			for(int i=0; i<boxlist.size(); i++){
				codeStr.append(boxlist.get(i).getBoxcode());
				codeStr.append("\r\n");
			}
			//设置文件名
			User user = (User) getSession().getAttribute("User");
			String filename = form.getCpccode()+"_"+form.getMedstorid()+"_"+user.getUserid()+"_"+Tools.getNowRandomThree()+".txt";
			int flen=codeStr.toString().getBytes("UTF-8").length;
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", ""+flen); //设置返回的文件类型 
			response.addHeader("Content-Disposition", "attachment;filename="+filename);
	
			//二维码字符串转换字节流
			InputStream fis = new ByteArrayInputStream(codeStr.toString().getBytes("UTF-8"));		
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());			
			byte[] buffer = new byte[flen];		
			while(fis.read(buffer)>0){
				toClient.write(buffer); // 输出数据
			}		
			fis.close();
			toClient.flush();
			toClient.close();
			
			//更新下载状态
			MedStorage medStorage = new MedStorage();
			medStorage.setMedstorid(form.getMedstorid());
			medStorage.setDownstate(2);
			medStorageDao.update(medStorage);
			
		} catch (Exception ex) {
			ex.printStackTrace(); 
		}

	}
	
	//跳转打印页面
	public String findByStorageId_med(){
		try{
		MedStorage medStorage = new MedStorage();
		medStorage.setMedstorid(form.getStorageid());
		medStorage.setPrintstate(2);
		medStorageDao.update(medStorage);
		medStorage = medStorageDao.findById(medStorage);
		form.setCodeareashortname(codeAreaDao.findShortName(medStorage.getAreacode()));
		Med med = new Med();
		med.setCpcmed(medStorage.getCpcmed());
		med = medDao.findByCpc(med);
		form.setMed(med);
		form.setMedstorage(medStorage);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "successprintmed";
	}
	
	//打印完毕更新
	public String updateObject_med(){
		MedStorage medStorage = new MedStorage();
		medStorage.setMedstorid(form.getStorageid());
		medStorage.setPrintstate(3);
		medStorageDao.update(medStorage);
		return SUCCESS;
	}
	
	
	
	//===================================================饮片===================================================
	
	public void getTabletFile() {
		try {
			User user = (User) getSession().getAttribute("User");
			HttpServletRequest request=this.getRequest();
			HttpServletResponse response=this.getResponse();
			
			//注：filename传递过来的是tabletstorid,Filenametime传递的是printcol
			form.setTabletstorid(Integer.parseInt(form.getFilename()));
			form.setPrintcol(Integer.parseInt(form.getFilenametime()));
			
			
			StringBuffer codesStr=new StringBuffer();
			//普通模式离线下载
			if(form.getTabletstorid()!=-99){
				Box box = new Box();
				box.setStorid(form.getTabletstorid());
				box.setStortype(1);
				List<Box> boxlist = boxDao.findByAll(box);
				if(boxlist==null||boxlist.size()<1){
					throw new Exception("下载文件失败");
				}
				String boxcode="";			
				if(form.getPrintcol().equals(3)){
					for(int i=0; i<boxlist.size(); i++){
						if(!boxcode.equals(boxlist.get(i).getBoxcode())){
							boxcode=boxlist.get(i).getBoxcode();
							codesStr.append("===================================");
							codesStr.append("\r\n");
							codesStr.append(boxlist.get(i).getBoxcode());
							codesStr.append("\r\n");
							codesStr.append("-----------------------------------");
							codesStr.append("\r\n");
							codesStr.append(boxlist.get(i).getSourcecode());
							codesStr.append("\r\n");
						}else{
							codesStr.append(boxlist.get(i).getSourcecode());
							codesStr.append("\r\n");
						}
						  
					}
				}else if(form.getPrintcol().equals(2)){
					for(int i=0; i<boxlist.size(); i++){
						codesStr.append(boxlist.get(i).getSourcecode());
						codesStr.append("\r\n");
					}
				}
				
				//更新下载状态
				TabletStorage tabletStorage = new TabletStorage();
				tabletStorage.setTabletstorid(form.getTabletstorid());
				tabletStorage.setDownstate(2);
				tabletStorageDao.update(tabletStorage);
				
				
			}else{//8级码下载
				
				form.setDownCount(Integer.parseInt(form.getFilenametime()));//此处传过来的是下载数量
				//循环产生大包装码
				for(int i=0;i<form.getDownCount();i++){
					Map map=new HashMap();
					map.put("cpccorp", user.getCpccorp());
					boxDao.saveBoxTabletBag8(map);	
					String code=map.get("zycid").toString();
					codesStr.append(code);
					codesStr.append("\r\n");

				}
			}
			
			
			//设置文件名
			String filename = user.getCpccorp()+"_"+user.getUserid()+"_"+Tools.getNowRandomThree()+".txt";
			int flen=codesStr.toString().getBytes("UTF-8").length;
			//文件方式下载
			response.reset();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Length", ""+flen); //设置返回的文件类型 
			response.addHeader("Content-Disposition", "attachment;filename="+filename);
			InputStream fis = new ByteArrayInputStream(codesStr.toString().getBytes("UTF-8"));	
			OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
			
			byte[] buffer = new byte[flen];
			while(fis.read(buffer)>0){
				toClient.write(buffer); // 输出数据
			}
			
			fis.close();	
			toClient.flush();
			toClient.close();
			
			
			
			
			
		} catch (Exception ex) {
			ex.printStackTrace(); 
		}

	}
	
	
	/**
	 * 
	 * 生成饮片溯源码文件
	 * @throws IOException 
	 */
	public String createTabletFile() throws IOException{
		User user = (User) getSession().getAttribute("User");
		if(form.getTabletstorid()==null||form.getCpccode()==null){
			return SUCCESS;
		}		
		 //省去此方法的文件生成策略、在下载方法中直接读取溯源码字符串以文件方式输出，为了不用更新jsp中js 代码
		 //Filename===form.getTabletstorid()
		 //Filenametime==form.getPrintcol()
		
		//更新当前包装状态
		TabletStorage tabletStorage = new TabletStorage();
		tabletStorage.setTabletstorid(form.getTabletstorid());
		tabletStorage.setDownstate(1);
		if(tabletStorageDao.update(tabletStorage)==0){
			return SUCCESS;
		}
		
		form.setFilename(form.getTabletstorid().toString());
		form.setFilenametime(form.getPrintcol().toString());
		return SUCCESS;
	}
	
	
	
	
	
	
	
	
	/**
	 * 
	 * 生成饮片袋装溯源码文件--8级
	 * @throws IOException 
	 */
	public String createTabletFile_packCode_8() throws IOException{
		User user = (User) getSession().getAttribute("User");
		//此属性直接传递 饮片装袋 溯源码
		if(form.getDownCount()==null){
			return SUCCESS;
		}	
		//===================================华丽的分割线=========================================
		//省去此方法的文件生成策略、在下载方法中直接读取溯源码字符串以文件方式输出，为了不用更新jsp中js 代码
		 //Filename===-99
		 //Filenametime==form.getDownCount()
		form.setFilename("-99");
		form.setFilenametime(form.getDownCount().toString());
		
		
		return SUCCESS;
	}
	
	/**
	 * 
	 * 生成饮片袋装溯源码文件--8级 在线打印
	 * @throws IOException 
	 */
	public String createTabletFile_packCodeList_8() throws IOException{
		User user = (User) getSession().getAttribute("User");
		//此属性直接传递 饮片装袋 溯源码
		if(form.getDownCount()==null){
			return SUCCESS;
		}
		
		List<Box> boxlist = new ArrayList<Box>();
		Box box = null;
		//循环产生大包装码
		for(int i=0;i<form.getDownCount();i++){
			box = new Box();
			Map map=new HashMap();
			map.put("cpccorp", user.getCpccorp());
			boxDao.saveBoxTabletBag8(map);
			//packCode+=map.get("zycid").toString()+",";
			box.setBoxcode(map.get("zycid").toString());
			box.setAddtime(Tools.getCurrentTime());
			boxlist.add(box);
			
		}
		form.setBoxlist(boxlist);
		if(form.getPrintcol().equals(3)){
			return "successprinttablet8";
		}else{
			return "successprinttablettwo8";
		}

	}
	
	
	/**
	 * 
	 * 生成饮片袋装溯源码文件--7级
	 * @throws IOException 
	 */
	public String createTabletFile_packCode() throws IOException{
		User user = (User) getSession().getAttribute("User");
		//此属性直接传递 饮片装袋 溯源码
		if(form.getCpccode()==null||form.getDownCount()==null){
			return SUCCESS;
		}
				
				
//		String file_tabletcode_path = ServletActionContext.getServletContext().getInitParameter("file_tabletcode_path");
//		if (file_tabletcode_path == null || "".equals(file_tabletcode_path)) {
//			return SUCCESS;
//		}
		String filenametime = Tools.getDateMonthStr();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		 File tempDir=new File("uploadtemp");
		 if(!tempDir.exists()){    
		    tempDir.mkdirs();
		 }
		 factory.setRepository(tempDir);	   
		 String folderpath = tempDir.getAbsolutePath() + File.separator + Tools.getDateMonthStr();	
//		String folderpath = ServletActionContext.getRequest().getRealPath(File.separator) + file_tabletcode_path + File.separator + Tools.getDateMonthStr();
		File folder = new File(folderpath);
		if (!folder.exists()) {
			folder.mkdirs();
		}
		String name=form.getCpccode();
		
		/*
		File file = new File(folderpath);
		File[] files = file.listFiles();
		for(File f :files){
			if(f.getName().startsWith(name)&&f.getName().endsWith(".txt")){
				form.setFilename(f.getName());
				form.setFilenametime(filenametime);
				return SUCCESS;
			}
		}
		*/
		
		String filename = java.util.UUID.randomUUID()+".txt";
//		String filename = form.getCpccode()+"_"+user.getUserid()+"_"+Tools.getNowRandomThree()+".txt";

		BufferedWriter writer = new BufferedWriter(new FileWriter(folderpath + File.separator + filename));
		
		//循环产生大包装码
		for(int i=0;i<form.getDownCount();i++){
			Map map=new HashMap();
			map.put("cpccorp", user.getCpccorp());
			map.put("prodcode",form.getCpccode());
			boxDao.saveBoxTabletBag(map);	
			String code=map.get("zycid").toString();
			writer.write(code);
			writer.write("\r\n");
		}
		
		writer.flush();
		writer.close();
		
		
		
		form.setFilename(filename);
		form.setFilenametime(filenametime);
		
		return SUCCESS;
	}
	/**
	 * 
	 * 生成饮片袋装溯源码文件--7级
	 * @throws IOException 
	 */
	public String createTabletFile_packCodeList() throws IOException{
		User user = (User) getSession().getAttribute("User");
		//此属性直接传递 饮片装袋 溯源码
		if(form.getCpccode()==null||form.getDownCount()==null){
			return SUCCESS;
		}
				
		String packCode="";
		//循环产生大包装码
		for(int i=0;i<form.getDownCount();i++){
			Map map=new HashMap();
			map.put("cpccorp", user.getCpccorp());
			map.put("prodcode",form.getCpccode());
			boxDao.saveBoxTabletBag(map);
			packCode+=map.get("zycid").toString()+",";
			
		}
		if(packCode!=null&&!packCode.equals("")){
			packCode=packCode.substring(0,packCode.length()-1);
		}
		form.setCpccode(packCode);
		
		return SUCCESS;
	}
	
	
	
	
	
	
	
	//跳转打印页面
	public String findByStorageId_tablet(){
		TabletStorage tabletStorage = new TabletStorage();
		tabletStorage.setTabletstorid(form.getStorageid());
		tabletStorage.setPrintstate(2);
		tabletStorageDao.update(tabletStorage);
		tabletStorage = tabletStorageDao.findById(tabletStorage);
		form.setCodeareashortname(codeAreaDao.findShortName(tabletStorage.getAreacode()));
		Tablet tablet = new Tablet();
		tablet.setCpctablet(tabletStorage.getCpctablet());
		tablet = tabletDao.findByCpc(tablet);
		form.setTablet(tablet);
		form.setTabletstorage(tabletStorage);
		if(form.getPrintcol().equals(3)){
			return "successprinttablet";
		}else{
			return "successprinttablettwo";
		}
	}
	
	
	//打印完毕更新
	public String updateObject_tablet(){
		TabletStorage tabletStorage = new TabletStorage();
		tabletStorage.setTabletstorid(form.getStorageid());
		tabletStorage.setPrintstate(3);
		tabletStorageDao.update(tabletStorage);
		return SUCCESS;
	}
	
	
	//===================================================方法===================================================
	public String checkParam(){
		User user = (User) getSession().getAttribute("comuser");
		if(user == null){
			user = (User) getSession().getAttribute("User");
		}
		
		System.out.println(user.getUserid());
		if(form.getStorageid()==null||"".equals(form.getStorageid())){
			return SUCCESS;
		}
		if(form.getStoragetype()==null||"".equals(form.getStoragetype())){
			return SUCCESS;
		}
		
		if(form.getStoragetype().equals(0)){
			MedStorage medStorage = new MedStorage();
			medStorage.setMedstorid(form.getStorageid());
			medStorage = medStorageDao.findById(medStorage);
			if(medStorage.getUserid()!=null&&medStorage.getUserid()!=0&&!"".equals(medStorage.getUserid())&&medStorage.getUserid().toString().length()>0&&!medStorage.getUserid().equals(user.getUserid())){
				form.setDataparam("该数据，已由其它用户操作请关闭!");
				return SUCCESS;
			}
			
			medStorage.setPrintstate(1);
			medStorage.setUserid(user.getUserid());
			if(medStorageDao.update(medStorage)==0){
				return SUCCESS;
			}
		}else{
			TabletStorage tabletStorage = new TabletStorage();
			tabletStorage.setTabletstorid(form.getStorageid());
			tabletStorage= tabletStorageDao.findById(tabletStorage);
			if(tabletStorage.getUserid()!=null&&tabletStorage.getUserid()!=0&&!"".equals(tabletStorage.getUserid())&&tabletStorage.getUserid().toString().length()>0&&!tabletStorage.getUserid().equals(user.getUserid())){
				form.setDataparam("该数据，已由其它用户操作请关闭!");
				return SUCCESS;
			}
			
			tabletStorage.setPrintstate(1);
			tabletStorage.setUserid(user.getUserid());
			if(tabletStorageDao.update(tabletStorage)==0){
				return SUCCESS;
			}
		}
		
		String dataparam="";
		dataparam+=user.getLoginname()+" ";
		String unixtime= Tools.getDateUnix();
		System.out.println(user.getLoginname()+"===="+user.getLoginpass()+"===="+unixtime);
		dataparam+=Tools.MD5(user.getLoginname()+user.getLoginpass()+unixtime)+" ";
		dataparam+=unixtime+" ";
		dataparam+=form.getStorageid()+" ";
		dataparam+=form.getStoragetype()+" ";
		dataparam+=ServletActionContext.getServletContext().getInitParameter("printurl")+" ";
		dataparam+=ServletActionContext.getServletContext().getInitParameter("printport");
		form.setDataparam(dataparam);
		System.out.println(dataparam);
		return SUCCESS;
	}
	
	
	//打印查看溯源码
	public String findByBox(){
		Box box = new Box();
		box.setStorid(form.getStorageid());
		box.setStortype(form.getStoragetype());
		if(form.getPackcode()!=null){
			box.setPackcode(form.getPackcode());
		}else{
			box.setPackcode(form.getCodetype()==null?null:form.getCodetype().toString());
		}
		box.setPager_offset(form.getPager_offset());
		box.setPager_openset(10);
		box.setState(0);
		form.setPager_count(boxDao.findByCount(box));
		List<Box> boxlist = boxDao.findByList(box);
		for (Box tmpbox : boxlist) {
			if(tmpbox.getStortype()==0){//药材溯源码
				MedStorage medstorage = new MedStorage();
				medstorage.setMedstorid(tmpbox.getStorid());
				medstorage = medStorageDao.findById(medstorage);
				if(medstorage!=null){
					tmpbox.setProdname(medstorage.getMedname());
				}
			}else if (tmpbox.getStortype()==1){
				TabletStorage taletstorage = new TabletStorage();
				taletstorage.setTabletstorid(tmpbox.getStorid());
				taletstorage = tabletStorageDao.findById(taletstorage);
				if(taletstorage!=null){
					tmpbox.setProdname(taletstorage.getTabletname());
				}
			}
			
		}
		form.setBoxlist(boxlist);
		return "viewbox";
	}
	
}
