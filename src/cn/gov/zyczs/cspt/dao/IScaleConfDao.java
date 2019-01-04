package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ScaleConf;

/**
 * @Title IOrgDao.java
 * @Package
 * @version 1.0 溯源秤键配置接口
 */
public interface IScaleConfDao {
	/**
	 * 溯源秤键配置添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(ScaleConf scaleconf);
	
	/**
	 * 溯源秤键配置添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public ScaleConf saveObj(ScaleConf scaleconf);


	/**
	 * 溯源秤键配置更新
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer updateByObj(ScaleConf scaleconf);

	/**
	 * 溯源秤键配置分页总数
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer findByCount(ScaleConf scaleconf);

	/**
	 * 溯源秤键配置列表查询
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public List<ScaleConf> findByList(ScaleConf scaleconf);
	/**
	 * 溯源秤键配置列表查询
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public List<ScaleConf> queryByList(ScaleConf scaleconf);

	/**
	 * 溯源秤键配置查询根据ID
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public ScaleConf findById(ScaleConf scaleconf);
	
}
