package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IChengTmpDao;
import cn.gov.zyczs.cspt.po.ChengTmp;


/**
 * @Title ChengFckDao.java
 * @version 1.0 
 * 溯源秤dao实现类
 */
public class ChengTmpDao extends SqlMapClientDaoSupport implements IChengTmpDao {

	@Override
	public ChengTmp findById(ChengTmp chengtmp) {
		return (ChengTmp)getSqlMapClientTemplate().queryForObject("ChengTmp.findById",chengtmp);
	}

	@Override
	public Integer findByCount(ChengTmp chengtmp) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ChengTmp.findByCount",chengtmp);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChengTmp> findByList(ChengTmp chengtmp) {
		return (List<ChengTmp>) getSqlMapClientTemplate().queryForList("ChengTmp.findByList",chengtmp);
	}

	@Override
	public Integer save(ChengTmp chengtmp) {
		return (Integer) getSqlMapClientTemplate().insert("ChengTmp.save",chengtmp);
	}

	@Override
	public Integer update(ChengTmp chengtmp) {
		return (Integer) getSqlMapClientTemplate().update("ChengTmp.update",chengtmp);
	}
	@Override
	public Integer delete(ChengTmp chengtmp) {
		return (Integer) getSqlMapClientTemplate().delete("ChengTmp.delete",chengtmp);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengTmp> quryByList(ChengTmp chengtmp) {
		return (List<ChengTmp>) getSqlMapClientTemplate().queryForList("ChengTmp.quryByList",chengtmp);
	}
}
