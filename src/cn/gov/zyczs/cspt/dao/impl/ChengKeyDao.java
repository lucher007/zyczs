package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IChengKeyDao;
import cn.gov.zyczs.cspt.po.ChengKey;

/**
 * @Title ChengKeyDao.java
 * @version 1.0 溯源秤键配置dao实现类
 */
public class ChengKeyDao extends SqlMapClientDaoSupport implements IChengKeyDao {

	@Override
	public ChengKey findById(ChengKey chengkey) {
		return (ChengKey) getSqlMapClientTemplate().queryForObject("ChengKey.findById", chengkey);
	}

	@Override
	public Integer findByCount(ChengKey chengkey) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ChengKey.findByCount", chengkey);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChengKey> findByList(ChengKey chengkey) {
		return (List<ChengKey>) getSqlMapClientTemplate().queryForList("ChengKey.findByList", chengkey);
	}

	@Override
	public Integer save(ChengKey chengkey) {
		return (Integer) getSqlMapClientTemplate().insert("ChengKey.save", chengkey);
	}
	@Override
	public Integer update(ChengKey chengkey) {
		return (Integer) getSqlMapClientTemplate().update("ChengKey.update", chengkey);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengKey> queryByList(ChengKey chengkey) {
		return (List<ChengKey>) getSqlMapClientTemplate().queryForList("ChengKey.queryByList", chengkey);
	}
	@Override
	public Integer delete(ChengKey chengkey) {
		return (Integer) getSqlMapClientTemplate().delete("ChengKey.delete", chengkey);
	}
	
	@Override
	public Integer deleteConfKeys(ChengKey chengkey) {
		return (Integer) getSqlMapClientTemplate().delete("ChengKey.deleteConfKeys", chengkey);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengKey> queryListByValueNull(ChengKey chengkey) {
		return (List<ChengKey>) getSqlMapClientTemplate().queryForList("ChengKey.queryListByValueNull", chengkey);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengKey> queryKeyconfList(ChengKey chengkey) {
		return (List<ChengKey>) getSqlMapClientTemplate().queryForList("ChengKey.queryKeyconfList", chengkey);
	}
}
