package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.MedStat;
import cn.gov.zyczs.cspt.po.TabletStat;

/**
 * 生产平台 统计分析Dao
 * 
 */
public interface ITabletStatDao {

	/**
	 * 生产平台 药材库存统计总数量
	 * 
	 * @param tabletStat
	 * @return
	 */
	Integer findByMedStorageStatCount(TabletStat tabletStat);

	/**
	 * 生产平台 药材库存统计List
	 * 
	 * @param tabletStat
	 * @return
	 */
	List<TabletStat> findByMedStorageStatList(TabletStat tabletStat);

	/**
	 * 生产平台 饮片库存统计总数量
	 * 
	 * @param tabletStat
	 * @return
	 */
	Integer findByTabletStorageStatCount(TabletStat tabletStat);

	/**
	 * 生产平台 饮片库存统计List
	 * 
	 * @param tabletStat
	 * @return
	 */
	List<TabletStat> findByTabletStorageStatList(TabletStat tabletStat);
	
	/**
	 * 生产平台 饮片库存统计总数量
	 * 
	 * @param tabletStat
	 * @return
	 */
	Integer findByTabletStorageStatCount_codeType(TabletStat tabletStat);

	/**
	 * 生产平台 饮片库存统计List
	 * 
	 * @param tabletStat
	 * @return
	 */
	List<TabletStat> findByTabletStorageStatList_codeType(TabletStat tabletStat);
	
	/**
	 * 生产平台根据条件查询饮片销售总数
	 * 
	 * @param tabletState
	 * @return Integer
	 */
	public Integer getTabletSellStatCount(TabletStat tabletState);

	/**
	 * 生产平台根据条件查询饮片销售List
	 * 
	 * @param tabletState
	 * @return List
	 */
	public List<TabletStat> getTabletSellStatList(TabletStat tabletState);
	
	/**
	 * 生产平台根据条件查询饮片销售总重量
	 * 
	 * @param tabletState
	 * @return Integer
	 */
	public String getTabletSellStatWeight(TabletStat tabletState);
}
