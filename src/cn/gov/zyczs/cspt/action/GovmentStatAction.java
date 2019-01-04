package cn.gov.zyczs.cspt.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.dao.IGovmentStatDao;
import cn.gov.zyczs.cspt.po.GovmentStat;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.Org;

import com.opensymphony.xwork2.ModelDriven;

/**
 * 监管平台 统计分析Action
 * 
 */
@SuppressWarnings("serial")
public class GovmentStatAction extends BaseAction implements ModelDriven<GovmentStat>{
	GovmentStat form = new GovmentStat();

	@Override
	public GovmentStat getModel() {
		return form;
	}
	
	private IGovmentStatDao govmentStatDao;

	public void setGovmentStatDao(IGovmentStatDao govmentStatDao) {
		this.govmentStatDao = govmentStatDao;
	}
	
	
	/**
	 * 监管平台-交易数量统计
	 * 
	 * @param getMedSellStat
	 * @return String
	 */
	public String getSellTotalWeightStat() {
		if(form.getType() == null){
			form.setType(0); //默认为药材查询
		}
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10); // 一页显示10行
		form.setPager_count(govmentStatDao.getSellTotalWeightStatCount(form));
		form.setGovmentstatlist(govmentStatDao.getSellTotalWeightStatList(form));
		return "getSellTotalWeightStat";
	}
	
	/**
	 * 监管平台-交易价格统计
	 * 
	 * @param getMedSellStat
	 * @return String
	 */
	public String getSellAveragePriceStat() {
		if(form.getType() == null){
			form.setType(0); //默认为药材查询
		}
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10); // 一页显示10行
		form.setPager_count(govmentStatDao.getSellAveragePriceStatCount(form));
		form.setGovmentstatlist(govmentStatDao.getSellAveragePriceStatList(form));
		return "getSellAveragePriceStat";
	}
	
	/**
	 * 监管平台-节点企业分布
	 */
	public String getOrgCount(){
		List<Org> orglist = govmentStatDao.getOrgCount();
		Map<String, List<Org>> map = new HashMap<String, List<Org>>();
		for(Org o :orglist){
			String city =o.getCity(); 
			List<Org> olist = map.get(city);
			if (olist != null && olist.size() > 0) {
				olist.add(o);
				map.put(city, olist);
			} else {
				List<Org> olistnew = new ArrayList<Org>();
				olistnew.add(o);
				map.put(city, olistnew);
			}
		}
		form.setOrgmap(map);
		return "getOrg";
	}
	
	/**
	 * 监管平台-设备统计
	 * 
	 * @param getScaleStat
	 * @return String
	 */
	public String getScaleStat() {
		form.setPager_openset(10); // 一页显示10行
		form.setPager_count(govmentStatDao.getScaleStatCount(form));
		form.setGovmentstatlist(govmentStatDao.getScaleStatList(form));
		return "getScaleStat";
	}
}
