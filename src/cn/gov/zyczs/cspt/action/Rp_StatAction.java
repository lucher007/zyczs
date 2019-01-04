
package cn.gov.zyczs.cspt.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IRp_StatDao;
import cn.gov.zyczs.cspt.po.Rp_Stat;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class Rp_StatAction extends BaseAction implements ModelDriven<Rp_Stat>{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Rp_Stat form = new Rp_Stat();
	
	private IRp_StatDao rp_StatDao;
	
	public void setRp_StatDao(IRp_StatDao rp_StatDao) {
		this.rp_StatDao = rp_StatDao;
	}

	@Override
	public Rp_Stat getModel() {
		return form;
	}
	
	
	/**
	 * 统计出当前年份每个月的药材种植面积
	 * @return
	 */
	public String findPlantAreaSumByYear(){
		if(form.getYear() == null || ("").equals(form.getYear())){
			form.setYear(Tools.getDateYear());
		}
		
		User user = (User) getSession().getAttribute("User");
		String loginname = user.getLoginname();
		String plantname = "";
		
		if(!("admin").equals(loginname)){
			plantname = ServletActionContext.getServletContext().getInitParameter("linye").replaceAll(",", "','");
			form.setPlantname(plantname);
			form.setList(rp_StatDao.findPlantAreaSumByYear_NotAdmin(form));
			return "findPlantAreaSumByYear_notAdmin";
		}else{
			form.setList(rp_StatDao.findPlantAreaSumByYear(form));
			return "findPlantAreaSumByYear";
		}
	}
	
	/**
	 * 溯源药材销售量
	 * @return
	 */
	public String findSellWeightByYear(){
		if(form.getYear() == null || ("").equals(form.getYear())){
			form.setYear(Tools.getDateYear());
		}
		form.setRp_state(rp_StatDao.findSellWeightByYear(form));
		return "findSellWeightByYear";
	}
	
	/**
	 * 溯源药材每月销售比率
	 * @return
	 */
	public String findMedRateByYear(){
		if(form.getYear() == null || ("").equals(form.getYear())){
			form.setYear(Tools.getDateYear());
		}
		try{
			form.setRp_state(rp_StatDao.findMedRateByYear(form));
		}catch(Exception ex){
			form.setRp_state(null);
		}
		return "findMedRateByYear";
	}
	
	/**
	 * 主要药材交易量走势
	 * @return
	 */
	public String findSellWeightByYear_NotAdmin(){
		if(form.getYear() == null || ("").equals(form.getYear())){
			form.setYear(Tools.getDateYear());
		}
		
		String plantname = "";
		plantname = ServletActionContext.getServletContext().getInitParameter("linye").replaceAll(",", "','");
		form.setPlantname(plantname);
		form.setList(rp_StatDao.findSellWeightByYear_NotAdmin(form));
		return "findSellWeightByYear_notAdmin";
	}
	
	/**
	 * 每月饮片生产量、饮片出库销售量
	 * @return
	 */
	public String findTabletProAndSellByYear(){
		if(form.getYear() == null || ("").equals(form.getYear())){
			form.setYear(Tools.getDateYear());
		}
		
		List<Rp_Stat> list = rp_StatDao.findTabletProAndSellByYear(form);
		
		if(list != null && list.size() > 0){
			form.setTabletsells((Rp_Stat)list.get(0));
			form.setTabletproduces((Rp_Stat)list.get(1));
		}
		
		return "findTabletProAndSellByYear";
	}
}
