package cn.gov.zyczs.cspt.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import cn.gov.zyczs.cspt.dao.IGovmentMedStatDao;
import cn.gov.zyczs.cspt.po.GovmentMedStat;
import cn.gov.zyczs.cspt.po.Plant;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * 药材市场监管统计
 * 
 */
public class GovmentMedStatAction extends BaseAction implements ModelDriven<GovmentMedStat> {

	private IGovmentMedStatDao govmentMedStatDao;
	private GovmentMedStat form  = new GovmentMedStat();
	
	public void setGovmentMedStatDao(IGovmentMedStatDao govmentMedStatDao) {
		this.govmentMedStatDao = govmentMedStatDao;
	}

	@Override
	public GovmentMedStat getModel() {
		return form;
	}
	
	
	/**
	 *种植库存信息统计
	 * @return
	 */
	public String findMedByList(){
		form.setPager_openset(10);
		form.setPager_count(govmentMedStatDao.findMedCountByList(form));
		form.setList(govmentMedStatDao.findMedByList(form));		
		return "findMedByList";
	} 
	/**
	 * 市场统计
	 * @return
	 */
	public String findMedmarketByList(){
		form.setPager_openset(10);
		form.setState(0);//有库存
		form.setPager_count(govmentMedStatDao.findMedmarketCountByList(form));
		form.setList(govmentMedStatDao.findMedmarketByList(form));		
		return "findMedmarketByList";
	}
	/**
	 * 市场销售统计
	 * @return
	 */
	public String findMedmarketSellByList(){
		form.setPager_openset(10);
		form.setStortype(0);//出入库状态：0入库 1出库
		form.setPager_count(govmentMedStatDao.findMedmarketSellCountByList(form));
		form.setList(govmentMedStatDao.findMedmarketSellByList(form));	
		return "findMedmarketSellByList";
	}
	/**
	 *种植销售信息统计
	 * @return
	 */
	public String findGovMedSell(){
		form.setPager_openset(10);
		form.setPager_count(govmentMedStatDao.findMedSellCountByList(form));
		form.setList(govmentMedStatDao.findMedSellByList(form));		
		return "findMedSellByList";
	} 
	/**
	 * 中药材经销库存统计
	 * @param govmentMedStat
	 * @return
	 */
	public String findMedSellBase(){
		form.setPager_openset(10);
		form.setPager_count(govmentMedStatDao.findMedSellCount(form));
		form.setList(govmentMedStatDao.findMedSellBase(form));		
		return "findMedSellBase";
	}
	/**
	 * 中药材经销销售统计
	 * @param govmentMedStat
	 * @return
	 */
	public String findMedSellSale(){
		form.setPager_openset(10);
		form.setPager_count(govmentMedStatDao.findMedSellSaleCount(form));
		form.setList(govmentMedStatDao.findMedSellSale(form));		
		return "findMedSellSale";
	}
	
}
