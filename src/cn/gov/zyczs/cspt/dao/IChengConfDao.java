package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ChengConf;
/**
 * @Title IChengConfDao.java
 * @Package
 * @version 1.0 溯源秤配置接口
 */
public interface IChengConfDao {
	/**
	 * 溯源秤键配置添加
	 * 
	 * @param ChengConf
	 * @return
	 */
	public Integer save(ChengConf chengconf);
	
	/**
	 * 溯源秤配置更新
	 * 
	 * @param ChengConf
	 * @return
	 */
	public Integer update(ChengConf chengconf);

	/**
	 * 溯源秤配置分页总数
	 * 
	 * @param ChengConf
	 * @return
	 */
	public Integer findByCount(ChengConf chengconf);

	/**
	 * 溯源秤配置列表查询
	 * 
	 * @param ChengConf
	 * @return
	 */
	public List<ChengConf> findByList(ChengConf chengconf);
    
	/**
	 * 溯源秤配置列表查询所有
	 * 
	 * @param ChengConf
	 * @return
	 */
	public List<ChengConf> queryByList(ChengConf chengconf);
	
	/**
	 * 溯源秤配置查询根据ID
	 * 
	 * @param ChengConf
	 * @return
	 */
	public ChengConf findById(ChengConf chengconf);
	
}
