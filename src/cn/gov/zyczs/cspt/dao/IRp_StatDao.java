package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Rp_Stat;

/**
 * 监管平台报表统计Dao接口
 * @author Administrator
 *
 */
public interface IRp_StatDao {
	
	
	/**
	 * 每年种植种苗种植区域
	 * @param rp_Stat
	 * @return
	 */
	public List<Rp_Stat> findPlantAreaSumByYear(Rp_Stat rp_Stat);
	
	/**
	 * 非管理员查询每年种植种苗种植区域
	 * @param rp_Stat
	 * @return
	 */
	public List<Rp_Stat> findPlantAreaSumByYear_NotAdmin(Rp_Stat rp_Stat); 
	
	/**
	 * 每年药材销售量
	 * @param rp_Stat
	 * @return
	 */
	public Rp_Stat findSellWeightByYear(Rp_Stat rp_Stat);
	
	/**
	 * 每年每月药材销售比率
	 * @param rp_Stat
	 * @return
	 */
	public Rp_Stat findMedRateByYear(Rp_Stat rp_Stat);
	
	/**
	 * 非管理员查询每年药材销售量
	 * @param rp_Stat
	 * @return
	 */
	public  List<Rp_Stat> findSellWeightByYear_NotAdmin(Rp_Stat rp_Stat);
	
	/**
	 * 每年每月饮片生产量和销售量
	 * @param rp_Stat
	 * @return
	 */
	public List<Rp_Stat> findTabletProAndSellByYear(Rp_Stat rp_Stat);
	
}
