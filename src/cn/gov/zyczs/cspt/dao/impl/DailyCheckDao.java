package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IDailyCheckDao;
import cn.gov.zyczs.cspt.po.DailyCheck;

public class DailyCheckDao extends SqlMapClientDaoSupport implements IDailyCheckDao{

	@Override
	public Integer findByCount(DailyCheck form) {
		return (Integer)getSqlMapClientTemplate().queryForObject("DailyCheck.findByCount",form);
	}

	@Override
	public List<DailyCheck> findByList(DailyCheck form) {
		return (List)getSqlMapClientTemplate().queryForList("DailyCheck.findByList",form);
	}

	@Override
	public Integer save(DailyCheck form) {
		return (Integer)getSqlMapClientTemplate().insert("DailyCheck.save",form);
	}

	@Override
	public DailyCheck findById(Integer id) {
		return (DailyCheck)getSqlMapClientTemplate().queryForObject("DailyCheck.findById",id);
	}

	@Override
	public List<DailyCheck> findByMaxDate(DailyCheck form) {
		return (List)getSqlMapClientTemplate().queryForList("DailyCheck.findByMaxDate",form);
	}

	@Override
	public List<String> findCpcMedsByBoxCode(String cpcMeds) {
		return (List<String>)getSqlMapClientTemplate().queryForList("DailyCheck.findCpcMedsByBoxCode",cpcMeds);
	}

}
