package cn.gov.zyczs.cspt.action;

import java.util.List;

import cn.gov.zyczs.cspt.dao.IMedStatDao;
import cn.gov.zyczs.cspt.po.MedStat;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title GrowStatisticsAction.java
 * @Package
 * @version 1.0 种植平台统计Action
 */
@SuppressWarnings("serial")
public class MedStatAction extends BaseAction implements ModelDriven<MedStat> {

	MedStat form = new MedStat();

	@Override
	public MedStat getModel() {
		return form;
	}

	private IMedStatDao medStatDao;// 种植统计Dao

	public void setMedStatDao(IMedStatDao medStatDao) {
		this.medStatDao = medStatDao;
	}

	/**
	 * 种植任务查询
	 * 
	 * @param growStatistics
	 * @return String
	 */
	public String getGrowTaskStat() {
		User user = (User) getSession().getAttribute("User");
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10); // 一页显示10行
		form.setPager_count(medStatDao.getGrowTaskByStatCount(form));
		form.setMedStatlist(medStatDao.getGrowTaskByStatList(form));
		return "getGrowTaskStat";
	}

	/**
	 * 药材库存统计
	 * 
	 * @return
	 */
	public String getMedStorageStat() {
		User user = (User) getSession().getAttribute("User");
		// form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setMedstate(0);
		form.setPager_openset(10);

		String medaddtime = getRequest().getParameter("medaddtime");
		if (!"".equals(medaddtime) && medaddtime != null) {
			if(medaddtime.length() == 10 || medaddtime.length() == 11){
				form.setMedaddtime(medaddtime + " 00:00:00");
			}
		}
		String medendtime = getRequest().getParameter("medendtime");
		if (!"".equals(medendtime) && medendtime != null) {
			if(medendtime.length() == 10 || medendtime.length() == 11){
				form.setMedendtime(medendtime + " 23:59:59");
			}
		}

		form.setPager_count(medStatDao.getMedStorageByStatCount(form));
		form.setMedStatlist(medStatDao.getMedStorageByStatList(form));
		String totalWeight = medStatDao.getMedStorageByTotalWeight(form);
		if(totalWeight != null && !"".equals(totalWeight)){
			form.setTotalweight(totalWeight);
		}

		return "getMedStorageStat";
	}

	/**
	 * 药材销售统计
	 * 
	 * @param getMedSellStat
	 * @return String
	 */
	public String getMedSellStat() {
		User user = (User) getSession().getAttribute("User");
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10); // 一页显示10行
		form.setPager_count(medStatDao.getMedSellStatCount(form));
		form.setMedStatlist(medStatDao.getMedSellStatList(form));
		form.setStrsumweight(medStatDao.getMedSellStatWeight(form));
		return "getMedSellStat";
	}
	
	
	/**
	 * 查询该种植基地下主要的产出药材 
	 */
	public String findMainMeds(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		List<MedStat> list  =  medStatDao.findMainMeds(form);
		form.setMedStatlist(list);
		return "medPriceChart";
	}
}
