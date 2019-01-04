package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IChengSqlDao;
import cn.gov.zyczs.cspt.po.ChengSql;


public class ChengSqlDao extends SqlMapClientDaoSupport implements IChengSqlDao {

	@Override
	public Integer findOutSqlByCount(ChengSql chengsql) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ChengSql.findOutSqlByCount",chengsql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChengSql> findOutSqlByList(ChengSql chengsql) {
		return (List<ChengSql>)getSqlMapClientTemplate().queryForList("ChengSql.findOutSqlByList",chengsql);
	}

	@Override
	public Integer saveOutSql(ChengSql chengsql) {
		return (Integer) getSqlMapClientTemplate().insert("ChengSql.saveOutSql",chengsql);
	}

}
