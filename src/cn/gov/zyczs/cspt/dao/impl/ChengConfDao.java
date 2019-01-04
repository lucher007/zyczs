package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IChengConfDao;
import cn.gov.zyczs.cspt.po.ChengConf;

/**
 * @Title ChengConfDao.java
 * @version 1.0 溯源秤配置dao实现类
 */
public class ChengConfDao extends SqlMapClientDaoSupport implements IChengConfDao {

	@Override
	public ChengConf findById(ChengConf chengconf) {
		return (ChengConf) getSqlMapClientTemplate().queryForObject("ChengConf.findById", chengconf);
	}

	@Override
	public Integer findByCount(ChengConf chengconf) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ChengConf.findByCount", chengconf);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ChengConf> findByList(ChengConf chengconf) {
		return (List<ChengConf>) getSqlMapClientTemplate().queryForList("ChengConf.findByList", chengconf);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ChengConf> queryByList(ChengConf chengconf) {
		return (List<ChengConf>) getSqlMapClientTemplate().queryForList("ChengConf.queryByList", chengconf);
	}
	
	@Override
	public Integer save(ChengConf chengconf) {
		return (Integer) getSqlMapClientTemplate().insert("ChengConf.save", chengconf);
	}
	
	@Override
	public Integer update(ChengConf chengconf) {
		return (Integer) getSqlMapClientTemplate().update("ChengConf.update", chengconf);
	}

}
