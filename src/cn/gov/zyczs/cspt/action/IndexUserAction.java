package cn.gov.zyczs.cspt.action;
import java.util.List;

import cn.gov.zyczs.cspt.common.HttpDownloader;
import cn.gov.zyczs.cspt.common.XMLUtils;
import cn.gov.zyczs.cspt.dao.IMedStatDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.impl.IndexUserDao;
import cn.gov.zyczs.cspt.dao.impl.IndexWeekDao;
import cn.gov.zyczs.cspt.po.IndexUser;
import cn.gov.zyczs.cspt.po.IndexWeek;
import cn.gov.zyczs.cspt.po.MedStat;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title IndexUserAction.java
 * @Package com.action
 * @date Mar 31, 2012 10:51:26 AM
 * @version 1.0 
 */
public class IndexUserAction extends BaseAction implements ModelDriven<IndexUser> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private IndexUser form = new IndexUser();
	@Override
	public IndexUser getModel() {
		return form;
	}
	
	
	private IndexWeekDao indexWeekDao;//
	public void setIndexWeekDao(IndexWeekDao indexWeekDao) {
		this.indexWeekDao = indexWeekDao;
	}
	
	private IndexUserDao indexUserDao;//
	public void setIndexUserDao(IndexUserDao indexUserDao) {
		this.indexUserDao = indexUserDao;
	}
	
	private IMedStorageDao medStorageDao;// 药材库存dao实现类
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	

	private IMedStatDao medStatDao;// 种植统计Dao
	public void setMedStatDao(IMedStatDao medStatDao) {
		this.medStatDao = medStatDao;
	}
	
	/**
	 * 导入indexUser
	 */
	public void saveIndexUser(){
		List<IndexUser> indexUsers = XMLUtils.instance().getIndexUser();
		indexUserDao.saveIndexUser(indexUsers);
	}
	/**
	 * 导入IndexWeek
	 */
	public void saveIndexWeek(){
		List<IndexWeek> indexWeeks = XMLUtils.instance().getIndexWeek();
		indexWeekDao.saveIndexWeek(indexWeeks);
	}
	
	/**
	 * 定时保存indexUser和indexWeek
	 * @throws InterruptedException 
	 */
	public void saveIndexUserAndIndexWeekRegular() throws InterruptedException{
		HttpDownloader.regularDownloads();
		Thread.sleep(1000*60);//休眠一分钟
		//saveIndexUser();
		saveIndexWeek();
	}
	
	public String findPriceChart_medSell() {
		User _user = (User) getSession().getAttribute("User");
		MedStorage stor =  new MedStorage();
		stor.setOrgid(_user.getOrgid());
		List<MedStorage> list = medStorageDao.findMainMeds(stor);
		form.setMedstorage(list);
		
		if(form.getOrgid() != null){
			if("week".equalsIgnoreCase(form.getIndexweekperiod())){
				form.setIndexweekname("week");
			}else if("month".equalsIgnoreCase(form.getIndexweekperiod())){
				form.setIndexweekname("month");
			}
			if(form.getStartindexweekdate() != null && form.getStartindexweekdate().trim().length() > 0){
				form.setStartindexweekdate(form.getStartindexweekdate().replaceAll("-", "/")+" 00:00:00");
			}
			if(form.getEndindexweekdate() != null && form.getEndindexweekdate().trim().length() > 0){
				form.setEndindexweekdate(form.getEndindexweekdate().replaceAll("-", "/")+" 23:59:59");
			}
			form.setIndexuserlist(indexUserDao.findPriceChart(form));
		}
		return "findPriceChart_medSell";
	}

	public String findPriceChart_med() {
		User _user = (User)getSession().getAttribute("User");
		MedStat stat = new MedStat();
		stat.setOrgid(_user.getOrgid());
		List<MedStat> list  =  medStatDao.findMainMeds(stat);
		form.setMedstat(list);
		
		if(form.getOrgid() != null){
			if("week".equalsIgnoreCase(form.getIndexweekperiod())){
				form.setIndexweekname("week");
			}else if("month".equalsIgnoreCase(form.getIndexweekperiod())){
				form.setIndexweekname("month");
			}
			if(form.getStartindexweekdate() != null && form.getStartindexweekdate().trim().length() > 0){
				form.setStartindexweekdate(form.getStartindexweekdate().replaceAll("-", "/")+" 00:00:00");
			}
			if(form.getEndindexweekdate() != null && form.getEndindexweekdate().trim().length() > 0){
				form.setEndindexweekdate(form.getEndindexweekdate().replaceAll("-", "/")+" 23:59:59");
			}
			form.setIndexuserlist(indexUserDao.findPriceChart(form));
		}
		return "findPriceChart_med";
	}
	
	public String findPriceChart_medMarket() {
		User _user = (User) getSession().getAttribute("User");
		MedStorage storage = new MedStorage();
		storage.setCpccorp(_user.getCpccorp());
		storage.setState(0);//0-有库存, 1-无库存
		List<MedStorage> list = medStorageDao.findMarketMainMeds(storage);
		form.setMedstorage(list);
		
		if(form.getCpccorp() != null){
			form.setOrgid(0);
			if("week".equalsIgnoreCase(form.getIndexweekperiod())){
				form.setIndexweekname("week");
			}else if("month".equalsIgnoreCase(form.getIndexweekperiod())){
				form.setIndexweekname("month");
			}
			if(form.getStartindexweekdate() != null && form.getStartindexweekdate().trim().length() > 0){
				form.setStartindexweekdate(form.getStartindexweekdate().replaceAll("-", "/")+" 00:00:00");
			}
			if(form.getEndindexweekdate() != null && form.getEndindexweekdate().trim().length() > 0){
				form.setEndindexweekdate(form.getEndindexweekdate().replaceAll("-", "/")+" 23:59:59");
			}
			form.setIndexuserlist(indexUserDao.findPriceChart(form));
		}
		return "findPriceChart_medMarket";
	}
}

