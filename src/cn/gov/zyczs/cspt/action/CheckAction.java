package cn.gov.zyczs.cspt.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.ICheckDao;
import cn.gov.zyczs.cspt.dao.ICheckMatDao;
import cn.gov.zyczs.cspt.dao.IInOutStorBoxDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.ITabletAssistDao;
import cn.gov.zyczs.cspt.dao.ITabletDao;
import cn.gov.zyczs.cspt.dao.ITabletStorageDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.CheckMat;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Tablet;
import cn.gov.zyczs.cspt.po.TabletAssist;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class CheckAction extends BaseAction implements ModelDriven<Check> {
	private static final long serialVersionUID = 1L;

	Check form = new Check();

	@Override
	public Check getModel() {
		return form;
	}

	private ICheckDao checkDao;
	public void setCheckDao(ICheckDao checkDao) {
		this.checkDao = checkDao;
	}

	private IMedStorageDao medStorageDao;
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	
	private ITabletStorageDao tabletStorageDao;
	public void setTabletStorageDao(ITabletStorageDao tabletStorageDao) {
		this.tabletStorageDao = tabletStorageDao;
	}

	private ITabletDao tabletDao;
	public void setTabletDao(ITabletDao tabletDao) {
		this.tabletDao = tabletDao;
	}

	private ICheckMatDao checkMatDao;
	public void setCheckMatDao(ICheckMatDao checkMatDao) {
		this.checkMatDao = checkMatDao;
	}
    
	private IInOutStorDao inOutStorDao;
	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}
	
	private IInOutStorBoxDao inOutStorBoxDao;
	public void setInOutStorBoxDao(IInOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}
	
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	
	private ITabletAssistDao tabletAssistDao;
	public void setTabletAssistDao(ITabletAssistDao tabletAssistDao) {
		this.tabletAssistDao = tabletAssistDao;
	}
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	/**
	 * 保存检验信息
	 * 
	 * @return
	 */
	public String saveCheck() {
		String returnpath = "";
		form.setReturninfo("检验完成!");
		
		String flag = getRequest().getParameter("flag");
		
		User user = null;
		if("4".equals(flag)){//flag为4时是市场药材检验 
			user = (User) getSession().getAttribute("comuser");
		}else{
			user = (User) getSession().getAttribute("User");
		}
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		if (form.getMedstorid() != null && !"".equals(form.getMedstorid())) {//药材检验
			MedStorage medOld = new MedStorage();
			medOld.setMedstorid(form.getMedstorid());
			medOld = medStorageDao.findById(medOld);//查询抽检的那条药材记录
			MedStorage med = new MedStorage();
			med.setCpcmed(medOld.getCpcmed());
			med.setOrgid(medOld.getOrgid());
			med.setCheckstate(medOld.getCheckstate());//未检验
			med.setState(0);//有库存
			//根据抽检的那条药材批次号，查询出库存中所有未检验的同批次的药材
			List<MedStorage> medStorageList = medStorageDao.findMedByMedcpc(med);
			for(int i=0; medStorageList!=null && medStorageList.size()>0 && i<medStorageList.size();i++){
				MedStorage medStorage = medStorageList.get(i);
				form.setType(0);
				form.setProdid(medStorage.getMedstorid());
				// 保存检验信息
				Integer resultCheckid = checkDao.save(form);
				if (resultCheckid!=null && resultCheckid > 0){
					// 更新药材库存表检验状态
					form.setCheckstate(1);// 0-未检验, 1-已检验
					form.setMedstorid(medStorage.getMedstorid());
					medStorageDao.updateByCheck(form);
				} else {
					form.setReturninfo("药材检验失败!");
				}
			}
			List<CheckMat> checkmatlist = checkMatDao.findById(form);
			zyczsXmlDao.saveOjbect(ToolsXml.create_Med_materials(form, user,checkmatlist));
			
			//记录操作日志
			OpLog opLog=new OpLog();
			if(user.getOrg().getZyctype().equals("10000000")){
				opLog.setSysid(1);//药材种植平台
			}else if(user.getOrg().getZyctype().equals("01000000")){
				opLog.setSysid(2);//药材经销平台
			}else if(user.getOrg().getZyctype().equals("00001000")){
				opLog.setSysid(3);//药材市场平台
			}else if(user.getOrg().getZyctype().equals("00100000")){
				opLog.setSysid(4);//饮片生产
			}
			
			opLog.setMethod("药材检验");
			opLog.setLoginName(user.getLoginname());
			opLog.setUserName(user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLog.setContent("批次号:"+medOld.getCpcmed());
			opLogDao.saveOjbect(opLog);
			
		} else if (form.getTabletid() != null && !"".equals(form.getTabletid())){//饮片检验
			form.setType(1);
			form.setProdid(form.getTabletid());
			// 保存检验信息
			Integer resultCheckid = checkDao.save(form);
			String cpctablet="";
			if (resultCheckid!= null && resultCheckid > 0){
				// 更新饮片表检验状态
				form.setCheckstate(1);// 0-未检验, 1-已检验
				form.setTabletweight(form.getTabletweight()*10000);//将重量kg转化成数据库单位
				Integer result = tabletDao.updateByCheck(form);
				
				//饮片检验入库
				Tablet tablet = tabletDao.findById(form.getTabletid()); //将此饮片信息查询出来入库
				
				cpctablet=tablet.getCpctablet();
				// 插入饮片库存表
				TabletStorage tabletStorage = new TabletStorage();
				tabletStorage.setTabletid(tablet.getTabletid());
				tabletStorage.setTabletname(tablet.getTabletname());
				tabletStorage.setCpctablet(tablet.getCpctablet());
				tabletStorage.setProdcode(tablet.getProdcode());
				tabletStorage.setTabletweight(form.getTabletweight());
				tabletStorage.setProvince(tablet.getProvince());
				tabletStorage.setCity(tablet.getCity());
				tabletStorage.setArea(tablet.getArea());
				tabletStorage.setAreacode(tablet.getAreacode());
				tabletStorage.setTablettype(0);//检验入库未分包
				tabletStorage.setUserid(user.getUserid());
				tabletStorage.setOrgid(user.getOrgid());
				tabletStorageDao.save(tabletStorage);  //插入饮片库存
				
				//插入inoutstor表
				InOutStor inOutStor = new InOutStor();
				inOutStor.setType(1);
				inOutStor.setStortype(0);
				inOutStor.setSellcorpname(user.getCompany().getCorpname());
				inOutStor.setBuycorpname(user.getCompany().getCorpname());
				inOutStor.setOpertime(form.getChecktime());
				inOutStor.setUserid(user.getUserid());
				inOutStor.setTotalweight(form.getTabletweight());
				inOutStor.setOrgid(user.getOrgid());
				inOutStor.setZstype(0);
				inOutStor.setCpccorp(user.getCpccorp());
				inOutStor.setOperator(user.getUsername());
				Integer inOutStorid = inOutStorDao.save(inOutStor);
				
				//插入inoutstorbox表
				InOutStorBox inOutStorBox = new InOutStorBox();
				inOutStorBox.setInoutstorid(inOutStorid);
				inOutStorBox.setBatchcpc(tablet.getCpctablet());
				inOutStorBox.setTotalweight(form.getTabletweight());
				inOutStorBox.setRealtotalweight(form.getTabletweight());
				inOutStorBox.setProdname(tablet.getTabletname());
				inOutStorBox.setProdcode(tablet.getProdcode());
				inOutStorBox.setProdnumber(tablet.getTabletnumber());
				inOutStorBoxDao.save(inOutStorBox);
				
				List<CheckMat> checkmatlist = checkMatDao.findById(form);
				zyczsXmlDao.saveOjbect(ToolsXml.create_Tablet_codeinfo(tablet, user));
				zyczsXmlDao.saveOjbect(ToolsXml.create_Tablet_materials(form, user,checkmatlist));
				List<TabletAssist> tabletAssist = tabletAssistDao.findByTablet(tablet.getTabletid());
				if(tabletAssist!=null&&tabletAssist.size()>0){
					zyczsXmlDao.saveOjbect(ToolsXml.create_Tablet_assists(tabletAssist, user,tablet.getCpctablet()));
				}
				
				//记录操作日志
				OpLog opLog=new OpLog();
				if(user.getOrg().getZyctype().equals("00100000")){
					opLog.setSysid(4);//饮片生产
				}else if(user.getOrg().getZyctype().equals("00010000")){
					opLog.setSysid(5);//饮片经销
				}
				
				opLog.setMethod("饮片检验");
				opLog.setLoginName(user.getLoginname());
				opLog.setUserName(user.getUsername());
				opLog.setClientIp(Tools.getRealIp(this.getRequest()));
				opLog.setContent("批次号:"+cpctablet);
				opLogDao.saveOjbect(opLog);
				
			} else {
				form.setReturninfo("饮片检验失败!");
			}
		}
		
		//当flag为0或2时,是种植平台的药材检验; 当flag为1时,是生产平台的药材检验;
		//flag为3时是药材经销商药材检验; flag为4时是市场药材检验 
		if("0".equals(flag) || "2".equals(flag)){
			returnpath = "finishMedCheckmed";
		}else if("1".equals(flag)){
			returnpath = "finishTabletCheckmed";
		}else if("3".equals(flag)){
			returnpath = "finishMedsellCheckmed";
		}else if("4".equals(flag)){
			returnpath = "finishMedmarketCheckmed";
		}else{ //默认为饮片检验
			returnpath = "finishChecktablet";
		}
		return returnpath;
	}

	/**
	 * 保存上传文件
	 * 
	 * @return
	 * @throws IOException 
	 */
	public String saveObjectFile() throws IOException {
		String orgid = getRequest().getParameter("orgid");
		String loginname = getRequest().getParameter("loginname");
		
		form.setOrgid(Integer.valueOf(orgid));
		
		File importFile = null;
		importFile = form.getUploadify();
		if (importFile == null) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件为空!"));
			return SUCCESS;
		}
		if (form.getUploadifyFileName() == null || "".equals(form.getUploadifyFileName())) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件名为空!"));
			return SUCCESS;
		}
		String file_grow_path = ServletActionContext.getServletContext().getInitParameter("file_grow_path");
		if (file_grow_path == null || "".equals(file_grow_path)) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,存储路径为空!"));
			return SUCCESS;
		}
		if (((float) (Math.round(importFile.length() / 1024 * 100)) / 100) > 2000) {
			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,文件最大为2M!"));
			return SUCCESS;
		}
		String type = getStrend(form.getUploadifyFileName());
		String filename = getNow() + "_" + loginname + "." + type;
		String folderpath = ServletActionContext.getRequest().getRealPath("/") + file_grow_path + "/" + getDateMonthStr();
		
//		File folder = new File(folderpath);
//		if (!folder.exists()) {
//			folder.mkdirs();
//		}
//		FileOutputStream fos;
//		try {
//			fos = new FileOutputStream(folderpath + "/" + filename);
//			FileInputStream fis = new FileInputStream(importFile);
//			byte[] buffer = new byte[20480];
//			int len = 0;
//			while ((len = fis.read(buffer)) > 0) {
//				fos.write(buffer, 0, len);
//			}
//		} catch (FileNotFoundException e) {
//			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,存储异常!"));
//			return SUCCESS;
//		} catch (IOException e) {
//			form.setReturninfo(upErrorStr(form.getUploadifyFileName(), "文件错误,存储异常!"));
//			return SUCCESS;
//		}

		
		
		if (form.getMedstorid() != null && !"".equals(form.getMedstorid())) {//药材检验
			MedStorage medOld = new MedStorage();
			medOld.setMedstorid(form.getMedstorid());
			medOld = medStorageDao.findById(medOld);//查询抽检的那条药材记录
			MedStorage med = new MedStorage();
			med.setCpcmed(medOld.getCpcmed());
			med.setOrgid(medOld.getOrgid());
			med.setCheckstate(medOld.getCheckstate());//未检验
			med.setState(0);//有库存
			//根据抽检的那条药材批次号，查询出库存中所有未检验的同批次的药材
			List<MedStorage> medStorageList = medStorageDao.findMedByMedcpc(med);
			for(int i=0; medStorageList!=null && medStorageList.size()>0 && i<medStorageList.size();i++){
				MedStorage medStorage = medStorageList.get(i);
				CheckMat mat = new CheckMat();
				mat.setMatname(form.getUploadifyFileName());// .substring(0,form.getUploadifyFileName().indexOf(".")));
				mat.setMatcontent(file_grow_path + "/" + getDateMonthStr() + "/" + filename);
				mat.setMattype(form.getUploadType());// 1药材质检报告 3药材产地证明
				mat.setProdid(medStorage.getMedstorid());
				mat.setType(form.getType());
				mat.setOrgid(medStorage.getOrgid());
				mat.setMatimage(Tools.getBytesFromFile(form.getUploadify()));
				
				Integer matid =  checkMatDao.save(mat);
				if (matid != null && matid > 0) {
					form.setMatid(matid);
					form.setMatname(mat.getMatname());
					form.setMatcontent(mat.getMatcontent());
					form.setReturninfo(upSuccessStr(mat.getMatname()));
				} else {
					form.setReturninfo("更新失败!");
				}
			}
		} else if (form.getTabletid() != null && !"".equals(form.getTabletid())){//饮片检验
			CheckMat mat = new CheckMat();
			mat.setMatname(form.getUploadifyFileName());// .substring(0,form.getUploadifyFileName().indexOf(".")));
			mat.setMatcontent(file_grow_path + "/" + getDateMonthStr() + "/" + filename);
			mat.setMattype(form.getUploadType());// 1药材质检报告2饮片检验报告 3药材产地证明
			mat.setProdid(form.getTabletid());
			mat.setType(form.getType());
			mat.setOrgid(Integer.parseInt(orgid));
			mat.setMatimage(Tools.getBytesFromFile(form.getUploadify()));
			Integer matid =  checkMatDao.save(mat);
			if (matid != null && matid > 0) {
				form.setMatid(matid);
				form.setMatname(mat.getMatname());
				form.setMatcontent(mat.getMatcontent());
				form.setReturninfo(upSuccessStr(mat.getMatname()));
			} else {
				form.setReturninfo("更新失败!");
			}
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
	 * 根据药材cpc或饮片cpc加orgid查询检验报告
	 * 
	 * @return
	 */
	public String findByMaterial() {
		String flag = getRequest().getParameter("flag");
		User user = null;
		if("4".equals(flag)){
			user = (User) getSession().getAttribute("comuser");	
		}else{
			user = (User) getSession().getAttribute("User");
		}
		user.setOrgid(user.getOrgid());
		form.setMateriallist(checkMatDao.findById(form));
		return SUCCESS;
	}

	/**
	 * 根据检验报告表ID删除检验报告
	 * 
	 * @return
	 */
	public String deleteMaterial() {
		checkMatDao.deleteObejct(form.getMatid());
		return SUCCESS;
	}

	/**
	 * 查询检验详情
	 * @return
	 */
	public String findByCheckDetail(){
		String flag = getRequest().getParameter("flag");
		if("medmarket".equals(flag)){
			User user = (User) getSession().getAttribute("comuser");
			form.setOrgid(user.getOrgid());
		}else{
			User user = (User) getSession().getAttribute("User");
			form.setOrgid(user.getOrgid());
		}
		form.setCheck(checkDao.findCheckDetail(form));
		return "findByCheckDetail";
	}
	
	/**
	 * 生产平台查询饮片检验详情
	 * @return
	 */
	public String findTabletByCheckDetail(){
		User user = (User) getSession().getAttribute("User");
		form.setOrgid(user.getOrgid());
		form.setCheck(checkDao.findTabletCheckDetail(form));
		return "findTabletByCheckDetail";
	}

}
