package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IFertilizerDao;
import cn.gov.zyczs.cspt.po.Fertilizer;


/**
 * @Title FertilizerDao.java
 * @version 1.0 
 * 肥料dao实现类
 */
public class FertilizerDao extends SqlMapClientDaoSupport implements IFertilizerDao{

	@Override
	public Integer findByCount(Fertilizer fertilizer) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Fertilizer.findByCount",fertilizer);
	}

	@Override
	public Fertilizer findById(Fertilizer fertilizer) {
		return (Fertilizer)getSqlMapClientTemplate().queryForObject("Fertilizer.findById",fertilizer);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Fertilizer> findByList(Fertilizer fertilizer) {
		return (List<Fertilizer>)getSqlMapClientTemplate().queryForList("Fertilizer.findByList", fertilizer);
	}

	@Override
	public Integer save(Fertilizer fertilizer) {
		return (Integer)getSqlMapClientTemplate().insert("Fertilizer.save",fertilizer);
	}

}

