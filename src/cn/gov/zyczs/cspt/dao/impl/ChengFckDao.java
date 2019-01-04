package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IChengFckDao;
import cn.gov.zyczs.cspt.po.ChengFck;


/**
 * @Title ChengFckDao.java
 * @version 1.0 
 * 溯源秤dao实现类
 */
public class ChengFckDao extends SqlMapClientDaoSupport implements IChengFckDao {

	@Override
	public ChengFck findById(ChengFck chengfck) {
		return (ChengFck)getSqlMapClientTemplate().queryForObject("ChengFck.findById",chengfck);
	}

	@Override
	public Integer findByCount(ChengFck chengfck) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ChengFck.findByCount",chengfck);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChengFck> findByList(ChengFck chengfck) {
		return (List<ChengFck>) getSqlMapClientTemplate().queryForList("ChengFck.findByList",chengfck);
	}

	@Override
	public Integer save(ChengFck chengfck) {
		return (Integer) getSqlMapClientTemplate().insert("ChengFck.save",chengfck);
	}

	@Override
	public Integer update(ChengFck chengfck) {
		return (Integer) getSqlMapClientTemplate().update("ChengFck.update",chengfck);
	}
	@Override
	public Integer delete(ChengFck chengfck) {
		return (Integer) getSqlMapClientTemplate().delete("ChengFck.delete",chengfck);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengFck> quryByList(ChengFck chengfck) {
		return (List<ChengFck>) getSqlMapClientTemplate().queryForList("ChengFck.quryByList",chengfck);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengFck> quryListByChengid(ChengFck chengfck) {
		return (List<ChengFck>) getSqlMapClientTemplate().queryForList("ChengFck.quryListByChengid",chengfck);
	}
}
