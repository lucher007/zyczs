package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.GovmentStat;
import cn.gov.zyczs.cspt.po.Org;
/**
 * 监管平台 统计分析Dao
 * 
 */
public interface IGovmentStatDao {
	/**
	 * 监管平台-交易数量Count
	 * 
	 * @param tabletState
	 * @return Integer
	 */
	public Integer getSellTotalWeightStatCount(GovmentStat govmentState);

	/**
	 * 监管平台-交易数量List
	 * 
	 * @param tabletState
	 * @return List
	 */
	public List<GovmentStat> getSellTotalWeightStatList(GovmentStat govmentState);
	
	/**
	 * 监管平台-交易价格Count
	 * 
	 * @param tabletState
	 * @return Integer
	 */
	public Integer getSellAveragePriceStatCount(GovmentStat govmentState);

	/**
	 * 监管平台-交易价格List
	 * 
	 * @param tabletState
	 * @return List
	 */
	public List<GovmentStat> getSellAveragePriceStatList(GovmentStat govmentState);
	
	/**
	 * 监管平台-节点企业分布List
	 * 
	 * @param 
	 * @return List
	 */
	public List<Org> getOrgCount();
	
	/**
	 * 监管平台-设备统计Count
	 * 
	 * @param getScaleStatCount
	 * @return Integer
	 */
	public Integer getScaleStatCount(GovmentStat govmentState);
	
	/**
	 * 监管平台-设备统计List
	 * 
	 * @param getScaleStatList
	 * @return List
	 */
	public List<GovmentStat> getScaleStatList(GovmentStat govmentState);
	
	/**
	 * 监管平台-交易数量List-JFreeChart统计
	 * 
	 * @param govmentState
	 * @return List
	 */
	public List<GovmentStat> getTotalWeightJFreeChartStat(GovmentStat govmentState);
    
	/**
	 * 监管平台-交易数量List-JFreeChart统计
	 * 
	 * @param govmentState
	 * @return List
	 */
	public List<GovmentStat> getAreaWeightJFreeChartStat(GovmentStat govmentState);
}
