package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Med;

/**
 * @Title IMedDao.java
 * @Package com.dao
 * @version 1.0 
 * 药材dao接口
 */
public interface IMedDao {
	
	/**
	 * 根据药材信息查询药材数量
	 * @param med
	 * @return
	 */
	public Integer findByCount(Med med);
	
	/**
	 * 根据植物批次号查询对应的药材
	 *@param med
	 * @return
	 */
	public List<Med> findByCpcPlant(Med med);
	
	/**
	 * 新增一种药材
	 * @param med
	 * @return
	 */
	public Integer save(Med med);
	
	/**
	 * 根据条件查询List
	 * @param Med
	 * @return List
	 */
	public List<Med> findByList(Med med);
	
	/**
	 * 根据药材批次号查询对应的药材
	 *@param med
	 * @return
	 */
	public Med findByCpc(Med med);
}

