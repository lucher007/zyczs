package cn.gov.zyczs.cspt.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IFieldCareDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IPlantDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.FieldCare;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Plant;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;
/**
 * @Title FieldCareAction.java
 * @version 1.0 
 * 田间管理action
 */
public class FieldCareAction extends BaseAction implements ModelDriven<FieldCare>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private FieldCare form = new FieldCare();
	@Override
	public FieldCare getModel() {
		return form;
	}
	
	private IFieldCareDao fieldCareDao;//田间管理接口
	public void setFieldCareDao(IFieldCareDao fieldCareDao) {
		this.fieldCareDao = fieldCareDao;
	}
	
	private IPlantDao plantDao;//植物接口
	public void setPlantDao(IPlantDao plantDao) {
		this.plantDao = plantDao;
	}
	
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
	
	/**
	 * 查询每种植物对应的田间管理信息
	 * @return
	 */
	public String findByList(){
		
		if(form.getFieldcaretype() != null){
			try {
				form.setFieldcaretype(URLDecoder.decode(form.getFieldcaretype(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		
		if(form.getFieldcarename() != null){
			try {
				form.setFieldcarename(URLDecoder.decode(form.getFieldcarename(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		
		User _user = (User)getSession().getAttribute("User");
		Plant plant = new Plant();
		plant.setOrgid(_user.getOrgid());
		plant.setCpcplant(form.getCpcplant());
		form.setPlant(plantDao.findById(plant));
		
		form.setPager_openset(10);
		form.setPager_count(fieldCareDao.findByCount(form));
		form.setFieldcarelist(fieldCareDao.findByList(form));		
		return "findByList";
	}
	
	/**
	 * 新增田间管理初始页面
	 * @return
	 */
	public String saveInit(){
		Plant plant = new Plant();
		plant.setCpcplant(form.getCpcplant());
		form.setPlant(plantDao.findById(plant));
		return "saveInit";
	}
	
	/**
	 * 新增田间管理
	 * @return
	 */
	public String save(){
		User _user = (User)getSession().getAttribute("User");
		if(("农药").equals(form.getFieldcaretype()) || ("施肥").equals(form.getFieldcaretype())){
			form.setFieldcareweight(form.getFieldcareweight() * 10000);
		}
		Integer result = fieldCareDao.save(form);
		if(result !=0){
			zyczsXmlDao.saveOjbect(ToolsXml.create_Plant_fieldmanagements(form, _user));
			form.setReturninfo("田间管理成功！");
			
			//记录操作日志
			OpLog opLog=new OpLog();
			opLog.setSysid(1);
			opLog.setMethod("田间管理");
			opLog.setLoginName(_user.getLoginname());
			opLog.setUserName(_user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLog.setContent("批次号:"+form.getCpcplant());
			opLogDao.saveOjbect(opLog);
		}else{
			form.setReturninfo("田间管理失败！");
		}
		form.setFieldcarename("");
		form.setFieldcaretype("");
		return findByList();
	}	
	
	
}
