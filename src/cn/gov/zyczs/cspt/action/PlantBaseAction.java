package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.IPlantBaseDao;
import cn.gov.zyczs.cspt.po.PlantBase;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title PlantBaseAction.java
 * @Package com.action
 * @version 1.0 
 * 植物基础action
 */
public class PlantBaseAction extends BaseAction implements ModelDriven<PlantBase> {
	
	PlantBase form  = new PlantBase();
	@Override
	public PlantBase getModel() {
		return form;
	} 
	
	private IPlantBaseDao plantBaseDao;//植物基础类dao实现类
	public void setPlantBaseDao(IPlantBaseDao plantBaseDao) {
		this.plantBaseDao = plantBaseDao;
	}

	/**
	 * 植物基础信息选择
	 * @return
	 */
	public String plantBaseChoice(){
		form.setPager_openset(5);//一页显示10行
		form.setEnabled("1");
		form.setPager_count(plantBaseDao.findByCount(form));
		form.setList(plantBaseDao.findByList(form));
		return "plantBaseChoice";
	}

}

