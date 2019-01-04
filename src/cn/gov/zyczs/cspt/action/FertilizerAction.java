package cn.gov.zyczs.cspt.action;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IFertilizerDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IPlantDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Fertilizer;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Plant;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title FertilizerAction.java
 * @version 1.0 
 * 肥料action类
 */
public class FertilizerAction extends BaseAction implements ModelDriven<Fertilizer> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	Fertilizer form = new Fertilizer();
	public Fertilizer getModel() {
		return form;
	}
	
	private IFertilizerDao fertilizerDao;//肥料接口
	public void setFertilizerDao(IFertilizerDao fertilizerDao) {
		this.fertilizerDao = fertilizerDao;
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
	 * 查询每种植物对应的施肥信息
	 * @return
	 */
	public String findByList(){
		if(form.getFertilizername() != null ){
			try {
				form.setFertilizername(URLDecoder.decode(form.getFertilizername(), "UTF-8"));
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
		form.setPager_count(fertilizerDao.findByCount(form));
		form.setFertilizerlist(fertilizerDao.findByList(form));		
		return "findByList";
	}
	
	/**
	 * 新增肥料初始页面
	 * @return
	 */
	public String saveInit(){
		Plant plant = new Plant();
		plant.setCpcplant(form.getCpcplant());
		form.setPlant(plantDao.findById(plant));
		return "saveInit";
	}
	
	/**
	 * 新增肥料
	 * @return
	 */
	public String save(){
		User _user = (User)getSession().getAttribute("User");
		form.setFertilizerweight(form.getFertilizerweight() * 10000);
		Integer result = fertilizerDao.save(form);
		if(result !=0){
			zyczsXmlDao.saveOjbect(ToolsXml.create_Plant_fertilizes(form, _user));
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
		form.setFertilizername("");
		return findByList();
	}	
}
