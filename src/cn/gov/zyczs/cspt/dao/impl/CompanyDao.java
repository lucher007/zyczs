package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ICompanyDao;
import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.User;


/**
 * @Title CompanyDao.java
 * @version 1.0 
 * 企业dao实现类
 */
public class CompanyDao extends SqlMapClientDaoSupport implements ICompanyDao {

	@Override
	public Company findById(Company company) {
		return (Company)getSqlMapClientTemplate().queryForObject("Company.findById",company);
	}

	@Override
	public Company findByCpccorp(Company company) {
		return (Company)getSqlMapClientTemplate().queryForObject("Company.findByCpccorp",company);
	}

	@Override
	public Integer findByCount(Company company) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Company.findByCount",company);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Company> findByList(Company company) {
		return (List<Company>) getSqlMapClientTemplate().queryForList("Company.findByList",company);
	}

	@Override
	public Integer save(Company company) {
		return (Integer) getSqlMapClientTemplate().insert("Company.save",company);
	}

	@Override
	public Integer updateById(Company company) {
		return (Integer) getSqlMapClientTemplate().update("Company.updateById",company);
	}

	@Override
	public List<Company> findByExist(Company company) {
		return (List<Company>) getSqlMapClientTemplate().queryForList("Company.findByExist", company);
	}

	@Override
	public Integer deleteByCompanyId(Integer companyId) {
		return (Integer)getSqlMapClientTemplate().delete("Company.deleteByCompanyId", companyId);
	}

}
