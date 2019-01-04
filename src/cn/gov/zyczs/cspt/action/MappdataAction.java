package cn.gov.zyczs.cspt.action;
import java.util.List;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.dao.ICompanyDao;
import cn.gov.zyczs.cspt.dao.IMappdataDao;
import cn.gov.zyczs.cspt.po.Mappdata;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤交易信息
 * @author user
 *
 */
public class MappdataAction extends BaseAction implements ModelDriven<Mappdata> {
	private static final long serialVersionUID = 1L;
	
	Mappdata form = new Mappdata();
	public Mappdata getModel() {
		return form;
	}
	private IMappdataDao mappdataDao;
	private ICompanyDao companyDao;
	
	public IMappdataDao getMappdataDao() {
		return mappdataDao;
	}
	public void setMappdataDao(IMappdataDao mappdataDao) {
		this.mappdataDao = mappdataDao;
	}
	public ICompanyDao getCompanyDao() {
		return companyDao;
	}
	public void setCompanyDao(ICompanyDao companyDao) {
		this.companyDao = companyDao;
	}
	/**
	 * 查询溯源秤交易信息
	 */
	public String findByList(){
		form.setPager_openset(10);
		if(!"".equals(form.getStarttime()) && form.getStarttime() != null){
			form.setStarttime(form.getStarttime()+" 00:00:00");
		}
		if(!"".equals(form.getEndtime()) && form.getEndtime() != null){
			form.setEndtime(form.getEndtime()+" 23:59:59");
		}
		form.setPager_count(mappdataDao.findByCount(form));
		List<Mappdata> mappdataList = mappdataDao.findByList(form);
		form.setMappdataList(mappdataList);
		return "findByList";
	}
	
	/**
	 * 更新溯源秤交易信息
	 */
	public String update(){
		if(mappdataDao.updateByObj(form)!=0){
			form.setReturninfo("更新溯源秤成功!");
		}else{
			form.setReturninfo("更新溯源秤失败!");
		}
		return "update";
	}
	
	/**
	 * 溯源秤交易后统计信息
	 * @return
	 */
	public String findScaleSaleList(){
		form.setPager_openset(10);
		form.setPager_count(mappdataDao.findScalSaleCount(form));
		List<Mappdata> mappdataList = mappdataDao.findScalSaleList(form);
		form.setMappdataList(mappdataList);
		return "findScaleSaleList";
	}
	
	/**
	 * 查询溯源秤交易信息
	 */
	public String findScaleBusMarket(){
		form.setPager_openset(10);
		if(!"".equals(form.getStarttime()) && form.getStarttime() != null){
			form.setStarttime(form.getStarttime()+" 00:00:00");
		}
		if(!"".equals(form.getEndtime()) && form.getEndtime() != null){
			form.setEndtime(form.getEndtime()+" 23:59:59");
		}
		form.setPager_count(mappdataDao.findByCount(form));
		List<Mappdata> mappdataList = mappdataDao.findByList(form);
		form.setMappdataList(mappdataList);
		return "findScaleBusMarket";
	}
}
