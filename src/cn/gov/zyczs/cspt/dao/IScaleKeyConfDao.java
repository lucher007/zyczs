package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ScaleKeyConf;

/**
 * @Title IScaleKeyConfDao.java
 * @Package com.dao
 * @version 1.0 溯源秤配置接口
 */
public interface IScaleKeyConfDao {
	/**
	 * 溯源秤配置添加
	 * 
	 * @param org
	 * @return
	 */
	public Integer save(ScaleKeyConf scalekeyconf);

	/**
	 * 溯源秤配置更新
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public Integer updateById(ScaleKeyConf scalekeyconf);

	/**
	 * 溯源秤配置分页总数
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public Integer findByCount(ScaleKeyConf scalekeyconf);

	/**
	 * 溯源秤配置列表查询
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public List<ScaleKeyConf> findByList(ScaleKeyConf scalekeyconf);
	/**
	 * 溯源秤配置列表查询
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public List<ScaleKeyConf> queryByList(ScaleKeyConf scalekeyconf);

	/**
	 * 溯源秤配置查询根据ID
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public ScaleKeyConf findById(ScaleKeyConf scalekeyconf);
	/**
	 *根据溯源秤配置ID，删除溯源秤键
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public Integer delete(ScaleKeyConf scalekeyconf);
	
	/**
	 * 溯源秤配置列表查询
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public List<ScaleKeyConf> queryListByValueNull(ScaleKeyConf scalekeyconf);
	/**
	 * 溯源秤配置列表查询
	 * 
	 * @param ScaleKeyConf
	 * @return
	 */
	public List<ScaleKeyConf> queryKeyconfList(ScaleKeyConf scalekeyconf);
}
