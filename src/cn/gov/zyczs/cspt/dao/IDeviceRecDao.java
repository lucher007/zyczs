package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.DeviceRec;
/**
 * @Title IDeviceRecDao.java
 * @Package
 * @version 1.0 设备回收接口
 */
public interface IDeviceRecDao {
	/**
	 * 设备添加
	 * 
	 * @param Device
	 * @return
	 */
	public Integer save(DeviceRec deviceRec);

	/**
	 * 设备更新
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public Integer update(DeviceRec deviceRec);

	/**
	 * 设备分页总数
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public Integer findByCount(DeviceRec deviceRec);

	/**
	 * 设备列表查询
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public List<DeviceRec> findByList(DeviceRec deviceRec);
    
	/**
	 * 设备分页总数
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public Integer findByCount_cheng(DeviceRec deviceRec);

	/**
	 * 设备列表查询
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public List<DeviceRec> findByList_cheng(DeviceRec deviceRec);
	
	/**
	 * 设备查询根据ID
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public DeviceRec findById(DeviceRec deviceRec);
	/**
	 * 设备查询根据秤编号
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public DeviceRec findByCode(DeviceRec deviceRec);
	
	/**
	 * 设备列表查询
	 * 
	 * @param DeviceRec
	 * @return
	 */
	public List<DeviceRec> queryByList(DeviceRec deviceRec);
	
}
