package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Plant;

/**
 * @Title IPlantDao.java
 * @version 1.0 
 * 植物接口
 */
public interface IPlantDao {
	
	/**
	 * 根据种植条件类型查询植物信息集合
	 * @param plant
	 * @return
	 */
	public List<Plant> findByList(Plant plant);
	
	/**
	 * 根据种植条件类型查询植物信息数量
	 * @param plant
	 * @return
	 */
	public Integer findByCount(Plant plant);
	
	/**
	 * 新增植物信息
	 * @param plant
	 * @return
	 */
	public Integer save(Plant plant);
	
	/**
	 * 根据种植条件类型更新植物信息
	 * @param plant
	 * @return
	 */
	public Integer update(Plant plant);
	
	/**
	 * 根据种植条件类型查询具体植物信息
	 * @param plant
	 * @return
	 */
	public Plant findById(Plant plant);
}

