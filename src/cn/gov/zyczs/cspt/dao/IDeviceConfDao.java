package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.DeviceConf;
/**
 * @Title IDeviceConfDao.java
 * @Package
 * @version 1.0 溯源秤配置接口
 */
public interface IDeviceConfDao {
	/**
	 * 溯源秤键配置添加
	 * 
	 * @param DeviceConf
	 * @return
	 */
	public Integer save(DeviceConf deviceconf);
	
	/**
	 * 溯源秤配置更新
	 * 
	 * @param DeviceConf
	 * @return
	 */
	public Integer update(DeviceConf deviceconf);

	/**
	 * 溯源秤配置分页总数
	 * 
	 * @param DeviceConf
	 * @return
	 */
	public Integer findByCount(DeviceConf deviceconf);

	/**
	 * 溯源秤配置列表查询
	 * 
	 * @param DeviceConf
	 * @return
	 */
	public List<DeviceConf> findByList(DeviceConf deviceconf);
    
	/**
	 * 溯源秤配置列表查询所有
	 * 
	 * @param DeviceConf
	 * @return
	 */
	public List<DeviceConf> queryByList(DeviceConf deviceconf);
	
	/**
	 * 溯源秤配置查询根据ID
	 * 
	 * @param DeviceConf
	 * @return
	 */
	public DeviceConf findById(DeviceConf deviceconf);
	
}
