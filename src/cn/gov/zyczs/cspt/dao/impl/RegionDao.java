package cn.gov.zyczs.cspt.dao.impl;

import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IRegionDao;

public class RegionDao extends SqlMapClientDaoSupport implements IRegionDao {
	
	public synchronized Map findByCode(Map map) {
			return (Map)getSqlMapClientTemplate().queryForObject("Region.findByCode",map);
	}

}
