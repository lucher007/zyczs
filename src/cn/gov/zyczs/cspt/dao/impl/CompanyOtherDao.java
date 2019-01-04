package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ICompanyOtherDao;
import cn.gov.zyczs.cspt.po.CompanyOther;
import cn.gov.zyczs.cspt.po.InOutStor;


/**
 * @Title IUserDao.java
 * @Package 
 * @version 1.0 
 * 非溯源企业实现Dao
 */
public class CompanyOtherDao extends SqlMapClientDaoSupport implements ICompanyOtherDao {

	@Override
	public Integer findByCount(CompanyOther companyOther) {
		return (Integer) getSqlMapClientTemplate().queryForObject("CompanyOther.findByCount",companyOther);
	}

	@Override
	public CompanyOther findById(Integer companyotherid) {
		return (CompanyOther)getSqlMapClientTemplate().queryForObject("CompanyOther.findById",companyotherid);
	}

	@Override
	public List<CompanyOther> findByList(CompanyOther companyOther) {
		return (List<CompanyOther>) getSqlMapClientTemplate().queryForList("CompanyOther.findByList",companyOther);
	}

	@Override
	public Integer save(CompanyOther companyOther) {
		return (Integer) getSqlMapClientTemplate().insert("CompanyOther.save",companyOther);
	}

	@Override
	public Integer updateById(CompanyOther companyOther) {
		return (Integer) getSqlMapClientTemplate().update("CompanyOther.updateById",companyOther);
	}
	
	@Override
	public Integer findByCompanyCount(InOutStor inOutStor) {
		return (Integer) getSqlMapClientTemplate().queryForObject("CompanyOther.findByCompanyCount",inOutStor);
	}

	@Override
	public List<CompanyOther> findByCompanyList(InOutStor inOutStor) {
		return (List<CompanyOther>) getSqlMapClientTemplate().queryForList("CompanyOther.findByCompanyList",inOutStor);
	}

}
