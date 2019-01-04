package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Rp_Rate;

public interface IRp_RateDao {
	
	/*
	 * 企业使用率
	 */
	public Integer findCompTotalByMonth(String time);
	public Integer findCompCurTotalByMonth(String time);
	
	/*
	 * 溯源药材,非溯源药材入库所占比
	 */
	public List<Rp_Rate> findMedTypeByMonth(String month);
	
	/*
	 * 溯源秤交易量
	 */
	public Rp_Rate findChengData(String year);
	
	/*
	 * 溯源秤交易次数
	 */
	public Rp_Rate findChengCount(String year);
	
	/*
	 * 商户数
	 */
	public Rp_Rate findShopsData(String year);
	
	public Rp_Rate findMedSellData(String year);
	
	 
	public Rp_Rate findMedContrast(String year,String medname);

}
