package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Fertilizer;

/**
 * @Title IFertilizerDao.java
 * @version 1.0 
 * 肥料接口
 */
public interface IFertilizerDao {
	/**
	 * 根据肥料条件查询施肥次数
	 * @param fertilizer
	 * @return
	 */
	public Integer findByCount(Fertilizer fertilizer);
	/**
	 * 根据肥料条件查询肥料信息
	 * @param fertilizer
	 * @return
	 */
	public List<Fertilizer> findByList(Fertilizer fertilizer);
	/**
	 * 根据肥料id查询具体肥料信息
	 * @param fertilizer
	 * @return
	 */
	public Fertilizer findById(Fertilizer fertilizer);
	/**
	 * 新增施肥
	 * @param fertilizer
	 * @return
	 */
	public Integer save(Fertilizer fertilizer);
	
}

