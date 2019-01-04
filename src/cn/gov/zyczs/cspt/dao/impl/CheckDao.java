package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ICheckDao;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.MedStorage;


public class CheckDao extends SqlMapClientDaoSupport implements ICheckDao {

	@Override
	public Integer save(Check check) {
		return (Integer) getSqlMapClientTemplate().insert("Check.save", check);
	}

	@Override
	public Check findCheckDetail(Check check) {
		return (Check) getSqlMapClientTemplate().queryForObject("Check.findCheckDetail", check);
	}

	@Override
	public Check findTabletCheckDetail(Check check) {
		return (Check) getSqlMapClientTemplate().queryForObject("Check.findTabletCheckDetail", check);
	}
    
	@SuppressWarnings("unchecked")
	public List<Check> findByList(Check check) {
		return (List<Check>) getSqlMapClientTemplate().queryForList("Check.findByList", check);
	}
}
