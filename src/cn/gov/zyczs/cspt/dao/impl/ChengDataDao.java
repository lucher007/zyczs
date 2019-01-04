package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IChengDataDao;
import cn.gov.zyczs.cspt.po.ChengData;

public class ChengDataDao extends SqlMapClientDaoSupport implements IChengDataDao{

	@Override
	public ChengData findById(ChengData chengdata) {
		return (ChengData) getSqlMapClientTemplate().queryForObject("ChengData.findById", chengdata);
	}

	@Override
	public Integer findByCount(ChengData chengdata) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ChengData.findByCount", chengdata);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChengData> findByList(ChengData chengdata) {
		return (List<ChengData>) getSqlMapClientTemplate().queryForList("ChengData.findByList", chengdata);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengData> queryByList(ChengData chengdata) {
		return (List<ChengData>) getSqlMapClientTemplate().queryForList("ChengData.queryByList", chengdata);
	}
	
	@Override
	public Integer save(ChengData chengdata) {
		return (Integer) getSqlMapClientTemplate().insert("ChengData.save", chengdata);
	}
	
	@Override
	public Integer update(ChengData chengdata) {
		return (Integer) getSqlMapClientTemplate().update("ChengData.update", chengdata);
	}

}
