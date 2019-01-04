package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Scale;

/**
 * @Title IOrgDao.java
 * @Package
 * @version 1.0 溯源秤接口
 */
public interface IScaleDao {
	/**
	 * 溯源秤添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Scale Scale);

	/**
	 * 溯源秤更新
	 * 
	 * @param Scale
	 * @return
	 */
	public Integer updateByObj(Scale Scale);

	/**
	 * 溯源秤分页总数
	 * 
	 * @param Scale
	 * @return
	 */
	public Integer findByCount(Scale Scale);

	/**
	 * 溯源秤列表查询
	 * 
	 * @param Scale
	 * @return
	 */
	public List<Scale> findByList(Scale Scale);

	/**
	 * 溯源秤查询根据ID
	 * 
	 * @param Scale
	 * @return
	 */
	public Scale findById(Scale Scale);
	/**
	 * 溯源秤查询根据ID
	 * 
	 * @param Scale
	 * @return
	 */
	public Scale findObjById(Scale Scale);
	
	/**
	 * 根据经营户信息查询溯源秤列表
	 * 
	 * @param Scale
	 * @return
	 */
	public List<Scale> findScalesListByCPC(Scale Scale);
	/**
	 * 溯源秤分页总数
	 * 
	 * @param Scale
	 * @return
	 */
	public Integer findScalesListByCount(Scale Scale);
	
	/**
	 * 根据经营户信息查询溯源秤列表
	 * 
	 * @param Scale
	 * @return
	 */
	public List<Scale> findScalesCPC(Scale Scale);
	/**
	 * 溯源秤分页总数
	 * 
	 * @param Scale
	 * @return
	 */
	public Integer findScalesCPCCount(Scale Scale);
	
}
