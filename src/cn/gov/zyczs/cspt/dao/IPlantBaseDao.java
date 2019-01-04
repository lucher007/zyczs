package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.MedBase;
import cn.gov.zyczs.cspt.po.PlantBase;

/**
 * @Title IPlantBaseDao.java
 * @version 1.0 
 * 植物基础接口
 */
public interface IPlantBaseDao {
	
	/**
	 * 查询植物基础信息
	 * @param plantName
	 * @return
	 */
	public PlantBase findByName(PlantBase plantName);
	
	/**
	 * 分页查询 列表
	 * @param TabletBase
	 * @return 
	 */
	public List<PlantBase> findByList(PlantBase plantBase);
	
	/**
	 * 分页查询 总记录
	 * @param TabletBase
	 * @return 
	 */
	public Integer findByCount(PlantBase plantBase);
}

