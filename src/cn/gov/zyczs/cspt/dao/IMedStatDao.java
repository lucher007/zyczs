package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.MedStat;

public interface IMedStatDao {
	/**
	 * 根据条件查询种植任务总数
	 * 
	 * @param medState
	 * @return Integer
	 */
	public Integer getGrowTaskByStatCount(MedStat medState);

	/**
	 * 根据条件查询种植任务List
	 * 
	 * @param medState
	 * @return List
	 */
	public List<MedStat> getGrowTaskByStatList(MedStat medState);

	/**
	 * 种植平台 药材库存数量
	 * 
	 * @param medStat
	 * @return
	 */
	Integer getMedStorageByStatCount(MedStat medStat);

	/**
	 * 种植平台 药材库存List
	 * 
	 * @param medStat
	 * @return
	 */
	List<MedStat> getMedStorageByStatList(MedStat medStat);
	/**
	 * 种植平台 药材库存总重量
	 * @param medStat
	 * @return
	 */
	String getMedStorageByTotalWeight(MedStat medStat);
	
	/**
	 * 根据条件查询药材销售总数
	 * 
	 * @param medState
	 * @return Integer
	 */
	public Integer getMedSellStatCount(MedStat medState);

	/**
	 * 根据条件查询药材销售List
	 * 
	 * @param medState
	 * @return List
	 */
	public List<MedStat> getMedSellStatList(MedStat medState);
	
	/**
	 * 根据条件查询药材销售总重量
	 * 
	 * @param medState
	 * @return Integer
	 */
	public String getMedSellStatWeight(MedStat medState);
	
	/**
	 * 查询该种植基地下主要的产出药材
	 * @param medStat
	 * @return
	 */
	public List<MedStat> findMainMeds(MedStat medStat);
	
	/**
	 * 根据条件查询药材市场销售总数
	 * 
	 * @param medState
	 * @return Integer
	 */
	public Integer getMarketMedSellStatCount(MedStat medState);

	/**
	 * 根据条件查询药材市场销售List
	 * 
	 * @param medState
	 * @return List
	 */
	public List<MedStat> getMarketMedSellStatList(MedStat medState);
	
	/**
	 * 根据条件查询药材市场销售总重量
	 * 
	 * @param medState
	 * @return Integer
	 */
	public String getMarketMedSellStatWeight(MedStat medState);
}
