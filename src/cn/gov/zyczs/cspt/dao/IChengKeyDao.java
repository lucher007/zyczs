package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ChengKey;

/**
 * @Title IChengKeyDao.java
 * @Package com.dao
 * @version 1.0 溯源秤键配置接口
 */
public interface IChengKeyDao {
	/**
	 * 溯源秤键配置添加
	 * 
	 * @param org
	 * @return
	 */
	public Integer save(ChengKey chengkey);

	/**
	 * 溯源秤键配置更新
	 * 
	 * @param ChengKey
	 * @return
	 */
	public Integer update(ChengKey chengkey);

	/**
	 * 溯源秤键配置分页总数
	 * 
	 * @param ChengKey
	 * @return
	 */
	public Integer findByCount(ChengKey chengkey);

	/**
	 * 溯源秤键配置列表查询
	 * 
	 * @param ChengKey
	 * @return
	 */
	public List<ChengKey> findByList(ChengKey chengkey);
	
	/**
	 * 溯源秤键配置查询所有
	 * 
	 * @param ChengKey
	 * @return
	 */
	public List<ChengKey> queryByList(ChengKey chengkey);

	/**
	 * 溯源秤键配置查询根据ID
	 * 
	 * @param ChengKey
	 * @return
	 */
	public ChengKey findById(ChengKey chengkey);
	
	/**
	 *根据溯源秤键ID，删除溯源秤键
	 * 
	 * @param ChengKey
	 * @return
	 */
	public Integer delete(ChengKey chengkey);
	
	/**
	 *根据溯源秤配置ID，删除该配置下的所有键
	 * 
	 * @param ChengKey
	 * @return
	 */
	public Integer deleteConfKeys(ChengKey chengkey);
	
	/**
	 * 溯源秤键配置列表查询
	 * 
	 * @param ChengKey
	 * @return
	 */
	public List<ChengKey> queryListByValueNull(ChengKey chengkey);
	
	/**
	 * 溯源秤键配置列表查询
	 * 
	 * @param ChengKey
	 * @return
	 */
	public List<ChengKey> queryKeyconfList(ChengKey chengkey);
}
