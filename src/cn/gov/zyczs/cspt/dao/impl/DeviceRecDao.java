package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IDeviceRecDao;
import cn.gov.zyczs.cspt.po.DeviceRec;

/**
 * @Title DeviceRecDao.java
 * @version 1.0 设备dao实现类
 */
public class DeviceRecDao extends SqlMapClientDaoSupport implements IDeviceRecDao {

	@Override
	public DeviceRec findById(DeviceRec deviceRec) {
		return (DeviceRec) getSqlMapClientTemplate().queryForObject("DeviceRec.findById", deviceRec);
	}

	@Override
	public Integer findByCount(DeviceRec deviceRec) {
		return (Integer) getSqlMapClientTemplate().queryForObject("DeviceRec.findByCount", deviceRec);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DeviceRec> findByList(DeviceRec deviceRec) {
		return (List<DeviceRec>) getSqlMapClientTemplate().queryForList("DeviceRec.findByList", deviceRec);
	}
	
	@Override
	public Integer findByCount_cheng(DeviceRec deviceRec) {
		return (Integer) getSqlMapClientTemplate().queryForObject("DeviceRec.findByCount_cheng", deviceRec);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DeviceRec> findByList_cheng(DeviceRec deviceRec) {
		return (List<DeviceRec>) getSqlMapClientTemplate().queryForList("DeviceRec.findByList_cheng", deviceRec);
	}

	@Override
	public Integer save(DeviceRec deviceRec) {
		return (Integer) getSqlMapClientTemplate().insert("DeviceRec.save", deviceRec);
	}
	@Override
	public Integer update(DeviceRec deviceRec) {
		return (Integer) getSqlMapClientTemplate().update("DeviceRec.update", deviceRec);
	}
	@Override
	public DeviceRec findByCode(DeviceRec deviceRec) {
		return (DeviceRec) getSqlMapClientTemplate().queryForObject("DeviceRec.findByCode", deviceRec);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DeviceRec> queryByList(DeviceRec deviceRec) {
		return (List<DeviceRec>) getSqlMapClientTemplate().queryForList("DeviceRec.queryByList", deviceRec);
	}
}
