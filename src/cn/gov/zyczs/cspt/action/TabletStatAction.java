package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.ITabletStatDao;
import cn.gov.zyczs.cspt.po.TabletStat;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * 生产平台 统计分析Action
 * 
 */
@SuppressWarnings("serial")
public class TabletStatAction extends BaseAction implements ModelDriven<TabletStat> {

	TabletStat form = new TabletStat();

	@Override
	public TabletStat getModel() {
		return form;
	}

	private ITabletStatDao tabletStatDao;

	public void setTabletStatDao(ITabletStatDao tabletStatDao) {
		this.tabletStatDao = tabletStatDao;
	}

	/**
	 * 生产平台 药材库存统计
	 * 
	 * @return
	 */
	public String findByMedStorageStat() {
		User user = (User) getSession().getAttribute("User");
		form.setOrgid(user.getOrgid());
		form.setMedstate(0);// 库存状态, 0-有库存,1-无库存
		form.setPager_openset(10);// 每页显示10条记录

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
		
		form.setPager_count(tabletStatDao.findByMedStorageStatCount(form));
		form.setTabletStatList(tabletStatDao.findByMedStorageStatList(form));
		return "medStorageStat";
	}

	public String findByTabletStorageStat() {
		User user = (User) getSession().getAttribute("User");
		form.setOrgid(user.getOrgid());
		form.setTabletstate(0);// 库存状态, 0-有库存,1-无库存
		if(form.getCodetype()==null){
			form.setCodetype(6);
		}
		if(form.getCodetype()==0){//未包装
			form.setTablettype(0);
		}else{
			form.setTablettype(1);//已包装
		}
		
		
		form.setPager_openset(10);// 每页显示10条记录

		String tabletaddtime = getRequest().getParameter("tabletaddtime");
		if (!"".equals(tabletaddtime) && tabletaddtime != null) {
			if(tabletaddtime.length() == 10 || tabletaddtime.length() == 11){
				form.setTabletaddtime(tabletaddtime + " 00:00:00");
			}
		}
		String tabletendtime = getRequest().getParameter("tabletendtime");
		if (!"".equals(tabletendtime) && tabletendtime != null) {
			if(tabletendtime.length() == 10 || tabletendtime.length() == 11){
				form.setTabletendtime(tabletendtime + " 23:59:59");
			}
		}
		
		form.setPager_count(tabletStatDao.findByTabletStorageStatCount_codeType(form));
		form.setTabletStatList(tabletStatDao.findByTabletStorageStatList_codeType(form));
		return "tabletStorageStat";
	}
	
	/**
	 * 生产平台饮片销售统计
	 * 
	 * @param getMedSellStat
	 * @return String
	 */
	public String getTabletSellStat() {
		User user = (User) getSession().getAttribute("User");
		form.setOrgid(user.getOrgid());
		form.setType(1);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10); // 一页显示10行
		
		if(form.getCodetype()==null){
			form.setCodetype(6);
		}
		
		form.setPager_count(tabletStatDao.getTabletSellStatCount(form));
		form.setTabletStatlist(tabletStatDao.getTabletSellStatList(form));
		form.setStrsumweight(tabletStatDao.getTabletSellStatWeight(form));
		return "getTabletSellStat";
	}
}
