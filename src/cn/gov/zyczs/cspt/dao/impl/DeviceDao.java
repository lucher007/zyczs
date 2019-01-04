package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IDeviceDao;
import cn.gov.zyczs.cspt.po.Device;

/**
 * @Title DeviceDao.java
 * @version 1.0 溯源秤dao实现类
 */
public class DeviceDao extends SqlMapClientDaoSupport implements IDeviceDao {

	@Override
	public Device findById(Device device) {
		return (Device) getSqlMapClientTemplate().queryForObject("Device.findById", device);
	}

	@Override
	public Integer findByCount(Device device) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Device.findByCount", device);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Device> findByList(Device device) {
		return (List<Device>) getSqlMapClientTemplate().queryForList("Device.findByList", device);
	}

	@Override
	public Integer save(Device device) {
		return (Integer) getSqlMapClientTemplate().insert("Device.save", device);
	}
	@Override
	public Integer update(Device device) {
		return (Integer) getSqlMapClientTemplate().update("Device.update", device);
	}
	@Override
	public Integer delete(Device device) {
		return (Integer) getSqlMapClientTemplate().update("Device.delete", device);
	}
	@Override
	public Device findByCode(Device device) {
		return (Device) getSqlMapClientTemplate().queryForObject("Device.findByCode", device);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Device> queryByList(Device device) {
		return (List<Device>) getSqlMapClientTemplate().queryForList("Device.queryByList", device);
	}
}
