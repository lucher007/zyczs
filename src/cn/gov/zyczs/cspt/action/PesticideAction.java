package cn.gov.zyczs.cspt.action;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IPesticideDao;
import cn.gov.zyczs.cspt.dao.IPlantDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Pesticide;
import cn.gov.zyczs.cspt.po.Plant;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;
/**
 * @Title FertilizerAction.java
 * @version 1.0 
 * 农药action类
 */
public class PesticideAction extends BaseAction implements ModelDriven<Pesticide> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	Pesticide form = new Pesticide();
	public Pesticide getModel() {
		return form;
	}
	private IPesticideDao pesticideDao;
	public void setPesticideDao(IPesticideDao pesticideDao) {
		this.pesticideDao = pesticideDao;
	}
	private IPlantDao plantDao;
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
	 * 查询每种植物对应的农药信息
	 * @return
	 */
	public String findByList(){
		if(form.getPesticidename() != null ){
			try {
				form.setPesticidename(URLDecoder.decode(form.getPesticidename(), "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		
		User _user = (User)getSession().getAttribute("User");
		Plant plant = new Plant();
		plant.setCpcplant(form.getCpcplant());
		plant.setOrgid(_user.getOrgid());
		form.setPlant(plantDao.findById(plant));
		form.setPager_openset(10);
		form.setPager_count(pesticideDao.findByCount(form));
		form.setPesticidelist(pesticideDao.findByList(form));		
		
		return "findByList";
	}
	
	/**
	 * 新增农药初始化页面
	 * @return
	 */
	public String saveInit(){
		Plant plant = new Plant();
		plant.setCpcplant(form.getCpcplant());
		form.setPlant(plantDao.findById(plant));
		return "saveInit";
	}
	
	/**
	 * 新增农药
	 * @return
	 */
	public String save(){
		User _user = (User)getSession().getAttribute("User");
		form.setPesticideweight(form.getPesticideweight()*10000);
		Integer result = pesticideDao.save(form);
		if(result != 0){
			zyczsXmlDao.saveOjbect(ToolsXml.create_Plant_pesticides(form, _user));
			form.setReturninfo("施农药成功！");
			
			//记录操作日志
			OpLog opLog=new OpLog();
			opLog.setSysid(1);
			opLog.setMethod("药材农药");
			opLog.setLoginName(_user.getLoginname());
			opLog.setUserName(_user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLog.setContent("批次号:"+form.getCpcplant());
			opLogDao.saveOjbect(opLog);
		}else{
			form.setReturninfo("施农药失败！");
		}		
		form.setPesticidename("");
		return findByList();
	}

}
