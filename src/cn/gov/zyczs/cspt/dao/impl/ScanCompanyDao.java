package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IScanCompanyDao;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.ScanCompany;

/**
 * @Title IOrgDao.java
 * @Package
 * @version 1.0 
 * 手持机扫描企业dao
 */
public class ScanCompanyDao extends SqlMapClientDaoSupport implements IScanCompanyDao{

	@Override
	public Integer save(ScanCompany form) {
			return (Integer)getSqlMapClientTemplate().insert("ScanCompany.save",form);
	}

	@Override
	public Integer findByCount(ScanCompany form) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ScanCompany.findByCount",form);
	}

	@Override
	public List<Org> findByList(ScanCompany form) {
		return (List<Org>)getSqlMapClientTemplate().queryForList("ScanCompany.findByList",form);
	}
}
