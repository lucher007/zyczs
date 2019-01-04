package cn.gov.zyczs.cspt.dao.impl;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ICodeRegionDao;

public class CodeRegionDao extends SqlMapClientDaoSupport implements ICodeRegionDao {

	public String findByName(String gbname) {
		return (String)getSqlMapClientTemplate().queryForObject("CodeRegion.findByName",gbname);
	}

}
