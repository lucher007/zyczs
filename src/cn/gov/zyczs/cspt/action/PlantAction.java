package cn.gov.zyczs.cspt.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IFertilizerDao;
import cn.gov.zyczs.cspt.dao.IFieldCareDao;
import cn.gov.zyczs.cspt.dao.IMedBaseDao;
import cn.gov.zyczs.cspt.dao.IMedDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IPesticideDao;
import cn.gov.zyczs.cspt.dao.IPlantBaseDao;
import cn.gov.zyczs.cspt.dao.IPlantDao;
import cn.gov.zyczs.cspt.dao.IRegionDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Fertilizer;
import cn.gov.zyczs.cspt.po.FieldCare;
import cn.gov.zyczs.cspt.po.Med;
import cn.gov.zyczs.cspt.po.MedBase;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Pesticide;
import cn.gov.zyczs.cspt.po.Plant;
import cn.gov.zyczs.cspt.po.PlantBase;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title PlantAction.java
 * @version 1.0 
 * 植物action类
 */
public class PlantAction extends BaseAction implements ModelDriven<Plant> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	Plant form = new Plant();
	@Override
	public Plant getModel() {
		return form;
	}
	
	private IPlantDao plantDao;//植物dao实现类
	public void setMedBaseDao(IMedBaseDao medBaseDao) {
		this.medBaseDao = medBaseDao;
	}

	private IPlantBaseDao plantBaseDao;//植物基础dao实现类
	public void setPlantBaseDao(IPlantBaseDao plantBaseDao) {
		this.plantBaseDao = plantBaseDao;
	}

	private IMedBaseDao medBaseDao;//药材基础dao实现类
	public void setPlantDao(IPlantDao plantDao) {
		this.plantDao = plantDao;
	}
	
	private IFertilizerDao fertilizerDao;//肥料dao实现类
	public void setFertilizerDao(IFertilizerDao fertilizerDao) {
		this.fertilizerDao = fertilizerDao;
	}
	
	private IPesticideDao pesticideDao;//农药dao实现类
	public void setPesticideDao(IPesticideDao pesticideDao) {
		this.pesticideDao = pesticideDao;
	}

	private IMedDao medDao;//药材dao实现类
	public void setMedDao(IMedDao medDao) {
		this.medDao = medDao;
	}

	private IRegionDao regionDao;//
	public void setRegionDao(IRegionDao regionDao) {
		this.regionDao = regionDao;
	}

	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
	
	private IFieldCareDao fieldCareDao;//田间管理接口
	public void setFieldCareDao(IFieldCareDao fieldCareDao) {
		this.fieldCareDao = fieldCareDao;
	}
	
	/**
	 * 新增一种植物 对应多种药材
	 */
	@SuppressWarnings("unchecked")
	public String savePlant(){
		/****1判断种植在数据库中存在****/ 
		PlantBase plantBase = new PlantBase();
		plantBase.setName(form.getPlantname());
		PlantBase gb = plantBaseDao.findByName(plantBase); 
		
		if(gb == null){
			form.setReturninfo("该种子(种苗)"+form.getPlantname()+"不存在, 请重新输入！");
			return "addPlant";
		}
		
		/*****2判断产出药材在数据库存在******/
		String harvestmedwei = form.getHarvestmedwei();
		String [] arrs = harvestmedwei.split("~");
		Plant temp = null;
		List<Plant> plantlist = new ArrayList<Plant>();
		MedBase medBase = new MedBase();
		for(String str : arrs){
			medBase.setName(str.split("@")[0]);
			MedBase mb = medBaseDao.findByName(medBase);
			if(mb == null){
				form.setReturninfo("该"+str.split("@")[0]+"药材不存在, 请重新输入！");
				return "addPlant";
			}
			temp = new Plant();
			temp.setHarvestmed(str.split("@")[0]);
			temp.setHarvestwei(str.split("@")[1]);
			plantlist.add(temp);	
			form.setPlantlist(plantlist);
		}
		
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		form.setState(0);//新增一种植物 state为0 表示未采收完成
		Map map = new HashMap();
		map.put("typeid","1");
		map.put("companycodein",_user.getCpccorp());//企业编码
		regionDao.findByCode(map);
		String cpcPlant =map.get("zycid").toString()+Tools.getCheckCode(map.get("zycid").toString());
		form.setCpcplantimg(Tools.getTwoCode("*CPC*ZYCZS"+ cpcPlant));//二维码图片
		//自动生成植物系统批次号==种植批次码
		form.setCpcplant(cpcPlant);
		form.setProvince(_user.getOrg().getProvince());
		form.setCity(_user.getOrg().getCity());
		form.setArea(_user.getOrg().getArea());
		form.setAreacode(_user.getOrg().getAreacode());
	
		form.setProdcode(gb.getSourceid());
		form.setPlantweight(form.getPlantweight() * 10000);//数据库存放的单位是g,页面是kg,入库时候乘以10000保留到g以下一位
		form.setUserid(_user.getUserid());
		form.setPlantaddress(_user.getOrg().getRegisteraddress());
		int plantId = plantDao.save(form);
		if(plantId !=0){
			zyczsXmlDao.saveOjbect(ToolsXml.create_Plant_codeinfo(form, _user));			
			//记录操作日志
			OpLog opLog=new OpLog();
			opLog.setSysid(1);
			opLog.setMethod("药材种植");
			opLog.setLoginName(_user.getLoginname());
			opLog.setUserName(_user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLog.setContent("批次号:"+cpcPlant);
			opLogDao.saveOjbect(opLog);
			
			form.setReturninfo("新建种植任务完成！");
			
			
		}else{
			form.setReturninfo("新建种植任务失败！");			
		}	
		
		
		return "saveFinish";
	}
	
	/**
	 * 根据植物条件查询种植管理植物信息集合
	 * @return
	 */
	public String findByList(){
		
		User _user = (User)getSession().getAttribute("User");
		form.setState(0);
		form.setOrgid(_user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(plantDao.findByCount(form));
		List<Plant> list = plantDao.findByList(form);
		
		if(list != null && list.size() > 0){
			for(Plant plant :list){
				/*
				*//************查询该植物对应的施肥次数**************//*
				Fertilizer fertilizer = new Fertilizer();
				fertilizer.setCpcplant(plant.getCpcplant());
				plant.setFertilizer(fertilizerDao.findByCount(fertilizer).toString());
				
				*//************查询该植物对应的喷洒农药次数**************//*
				Pesticide pesticide = new Pesticide();
				pesticide.setCpcplant(plant.getCpcplant());
				plant.setPesticide(pesticideDao.findByCount(pesticide).toString());*/
				
				/************查询该植物对应的施肥次数**************/
				FieldCare fieldcare = new FieldCare();
				fieldcare.setCpcplant(plant.getCpcplant());
				plant.setFieldcare(fieldCareDao.findByCount(fieldcare).toString());
				
				/************查询该植物对应的药材收获次数**************/
				Med med = new Med();
				med.setCpcplant(plant.getCpcplant());
				plant.setMed(medDao.findByCount(med).toString());
				
			}
		}
		form.setPlantlist(list);
		return "findByList";
	}
	
	
	/**
	 * 根据种植批次码关闭此次任务
	 * @param sysCode
	 * @return
	 */
	public String updateStateByCpcPlant(){
		User _user = (User)getSession().getAttribute("User");
		form.setState(1);
		String curtime = Tools.getCurrentTime();
		form.setPlantendtime(curtime);
		int count = plantDao.update(form);
		if(count !=0){
			zyczsXmlDao.saveOjbect(ToolsXml.create_Plant_harvest(form, _user));
			form.setReturninfo("该批次种植任务关闭成功！");
		}else{
			form.setReturninfo("该批次种植任务关闭失败,请稍后重试！");
		}
		form.setCpcplant("");
		return findPlantHistory();
	} 
	
	/**
	 * 查询该植物的种植历史记录
	 * @return
	 */
	public String findPlantHistory(){
		User _user = (User)getSession().getAttribute("User");
		form.setState(1);
		form.setOrgid(_user.getOrgid());
		form.setPager_openset(10);
		form.setPager_count(plantDao.findByCount(form));
		List<Plant> list = plantDao.findByList(form);
		form.setPlantlist(list);
		
//		Med med = new Med();
//		med.setCpcplant(form.getCpcplant());
//		form.setMedlist(medDao.findByCpcPlant(med));
		
		return "findPlantHistory";
	}
	
	/**
	 * 根据种植批次号得到详情
	 * @return
	 */
	public String findDetails(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		
		Plant plant = plantDao.findById(form);
		
		/*Fertilizer fertilizer = new Fertilizer();
		fertilizer.setCpcplant(plant.getCpcplant());
		plant.setFertilizer(fertilizerDao.findByCount(fertilizer).toString());
		
		Pesticide pesticide = new Pesticide();
		pesticide.setCpcplant(plant.getCpcplant());
		plant.setPesticide(pesticideDao.findByCount(pesticide).toString());*/
		
		/************查询该植物对应的田间管理次数**************/
		FieldCare fieldcare = new FieldCare();
		fieldcare.setCpcplant(plant.getCpcplant());
		plant.setFieldcare(fieldCareDao.findByCount(fieldcare).toString());
		
		form.setPlant(plant);
		
		Med med = new Med();
		med.setCpcplant(form.getCpcplant());
		form.setMedlist(medDao.findByCpcPlant(med));
		
		//拼接组合成产出药材和产量
		List<Plant> plantlist = new ArrayList<Plant>();
		Plant temp = null;
		String harvestmedwei = plant.getHarvestmedwei();
		String [] groupMeds = harvestmedwei.split("~");
		for(int i = 0 ; i < groupMeds.length ; i++){
			temp = new Plant();
			String [] groupMed = groupMeds[i].split("@");
			temp.setHarvestmed(groupMed[0]);
			temp.setHarvestwei(groupMed[1]);
			plantlist.add(temp);
		}
		form.setPlantlist(plantlist);
		return "findDetails";
	}
	
	/**
	 * 初始化植物信息更新
	 * @return
	 */
	public String updateInit(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		Plant plant = plantDao.findById(form);
		form.setPlant(plant);
		//循环遍历药材
		List<Plant> growlist = new ArrayList<Plant>();
		Plant temp = null;
		String harvestmedwei = plant.getHarvestmedwei();
		String [] groupMeds = harvestmedwei.split("~");
		for(int i = 0 ; i < groupMeds.length ; i++){
			temp = new Plant();
			String [] groupMed = groupMeds[i].split("@");
			temp.setHarvestmed(groupMed[0]);
			temp.setHarvestwei(groupMed[1]);
			growlist.add(temp);
		}
		form.setPlantlist(growlist);
		return "updateInit";
	}
	
	/**
	 * 更新植物信息
	 * @return
	 */
	public String updatePlant(){
		int medId = plantDao.update(form);
		if(medId !=0){
			form.setReturninfo("更新药材信息成功！");
		}else{
			form.setReturninfo("更新药材信息失败！");
		}
		//循环遍历药材
		List<Plant> plantlist = new ArrayList<Plant>();
		Plant temp = null;
		String harvestmedwei = form.getHarvestmedwei();
		String [] groupMeds = harvestmedwei.split("~");
		for(int i = 0 ; i < groupMeds.length ; i++){
			temp = new Plant();
			String [] groupMed = groupMeds[i].split("@");
			temp.setHarvestmed(groupMed[0]);
			temp.setHarvestwei(groupMed[1]);
			plantlist.add(temp);
		}
		form.setPlantlist(plantlist);
		form.setPlantweight(form.getPlantweight() * 10000);
		return "saveFinish";
	}
	
	/**
	 * 根据(植物)系统批次号查询该植物
	 * @return
	 */
	public String initHarverstMed(){
		Plant plant = plantDao.findById(form);
		form.setPlant(plant);
		//循环遍历药材
		List<Plant> growlist = new ArrayList<Plant>();
		Plant temp = null;
		String harvestmedwei = plant.getHarvestmedwei();
		String [] groupMeds = harvestmedwei.split("~");
		for(int i = 0 ; i < groupMeds.length ; i++){
			temp = new Plant();
			String [] groupMed = groupMeds[i].split("@");
			temp.setHarvestmed(groupMed[0]);
			temp.setHarvestwei(groupMed[1]);
			growlist.add(temp);
		}
		form.setPlantlist(growlist);
		return "initHarverstMed";
	}
}

