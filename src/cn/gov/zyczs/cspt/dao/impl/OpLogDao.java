package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.OpLog;

public class OpLogDao extends SqlMapClientDaoSupport implements IOpLogDao {

	@Override
	public Integer saveOjbect(OpLog opLog) {
		return (Integer) getSqlMapClientTemplate().insert("OpLog.save",opLog);
	}

	@Override
	public Integer findByCount(OpLog opLog) {
		return (Integer)getSqlMapClientTemplate().queryForObject("OpLog.findByCount",opLog);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<OpLog> findByList(OpLog opLog) {
		return (List<OpLog>)getSqlMapClientTemplate().queryForList("OpLog.findByList", opLog);
	}
}
