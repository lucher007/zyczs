package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.IMedStatDao;
import cn.gov.zyczs.cspt.po.MedStat;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class MedSellStatAction extends BaseAction implements ModelDriven<MedStat>{
	MedStat form = new MedStat();

	@Override
	public MedStat getModel() {
		return form;
	}
	
	private IMedStatDao medStatDao;// 药材统计Dao

	public void setMedStatDao(IMedStatDao medStatDao) {
		this.medStatDao = medStatDao;
	}
	
	/**
	 * 经销平台药材销售统计
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
}
