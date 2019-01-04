package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.GovmentMedStat;

/**
 * 药材监管统计Dao
 * 
 */
public interface IGovmentMedStatDao {

	/**
	 * 种植库存信息统计
	 * 
	 * @return
	 */
	public List<GovmentMedStat> findMedByList(GovmentMedStat govmentMedStat);

	/**
	 * 种植库存数量
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	public Integer findMedCountByList(GovmentMedStat govmentMedStat);

	/**
	 * 药材市场统计数量
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	Integer findMedmarketCountByList(GovmentMedStat govmentMedStat);

	/**
	 * 药材市场统计列表
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	List<GovmentMedStat> findMedmarketByList(GovmentMedStat govmentMedStat);

	/**
	 * 药材市场销售统计数量
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	Integer findMedmarketSellCountByList(GovmentMedStat govmentMedStat);

	/**
	 * 药材市场销售统计列表
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	List<GovmentMedStat> findMedmarketSellByList(GovmentMedStat govmentMedStat);

	/**
	 * 种植销售
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	public List<GovmentMedStat> findMedSellByList(GovmentMedStat govmentMedStat);

	/**
	 * 种植销售数量
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	public Integer findMedSellCountByList(GovmentMedStat govmentMedStat);

	/**
	 * 中药材经销库存集合
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	public List<GovmentMedStat> findMedSellBase(GovmentMedStat govmentMedStat);

	/**
	 * 中药材经销库存数量
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	public Integer findMedSellCount(GovmentMedStat govmentMedStat);

	/**
	 * 中药材经销销售集合
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	public List<GovmentMedStat> findMedSellSale(GovmentMedStat govmentMedStat);

	/**
	 * 中药材经销销售数量
	 * 
	 * @param govmentMedStat
	 * @return
	 */
	public Integer findMedSellSaleCount(GovmentMedStat govmentMedStat);
}
