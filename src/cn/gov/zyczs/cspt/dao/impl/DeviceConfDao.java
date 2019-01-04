package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IDeviceConfDao;
import cn.gov.zyczs.cspt.po.DeviceConf;

/**
 * @Title DeviceConfDao.java
 * @version 1.0 溯源秤配置dao实现类
 */
public class DeviceConfDao extends SqlMapClientDaoSupport implements IDeviceConfDao {

	@Override
	public DeviceConf findById(DeviceConf deviceconf) {
		return (DeviceConf) getSqlMapClientTemplate().queryForObject("DeviceConf.findById", deviceconf);
	}

	@Override
	public Integer findByCount(DeviceConf deviceconf) {
		return (Integer) getSqlMapClientTemplate().queryForObject("DeviceConf.findByCount", deviceconf);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DeviceConf> findByList(DeviceConf deviceconf) {
		return (List<DeviceConf>) getSqlMapClientTemplate().queryForList("DeviceConf.findByList", deviceconf);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DeviceConf> queryByList(DeviceConf deviceconf) {
		return (List<DeviceConf>) getSqlMapClientTemplate().queryForList("DeviceConf.queryByList", deviceconf);
	}
	
	@Override
	public Integer save(DeviceConf deviceconf) {
		return (Integer) getSqlMapClientTemplate().insert("DeviceConf.save", deviceconf);
	}
	
	@Override
	public Integer update(DeviceConf deviceconf) {
		return (Integer) getSqlMapClientTemplate().update("DeviceConf.update", deviceconf);
	}

}
