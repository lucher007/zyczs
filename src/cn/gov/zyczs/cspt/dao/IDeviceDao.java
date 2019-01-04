package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Device;
/**
 * @Title IDeviceDao.java
 * @Package
 * @version 1.0 设备接口
 */
public interface IDeviceDao {
	/**
	 * 设备添加
	 * 
	 * @param Device
	 * @return
	 */
	public Integer save(Device device);

	/**
	 * 设备更新
	 * 
	 * @param Device
	 * @return
	 */
	public Integer update(Device device);
	
	/**
	 * 设备删除
	 * 
	 * @param Device
	 * @return
	 */
	public Integer delete(Device device);

	/**
	 * 设备分页总数
	 * 
	 * @param Device
	 * @return
	 */
	public Integer findByCount(Device device);

	/**
	 * 设备列表查询
	 * 
	 * @param Device
	 * @return
	 */
	public List<Device> findByList(Device device);

	/**
	 * 设备查询根据ID
	 * 
	 * @param Device
	 * @return
	 */
	public Device findById(Device device);
	/**
	 * 设备查询根据秤编号
	 * 
	 * @param Device
	 * @return
	 */
	public Device findByCode(Device device);
	
	/**
	 * 设备列表查询
	 * 
	 * @param Device
	 * @return
	 */
	public List<Device> queryByList(Device device);
	
}
