package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IScalepluDao;
import cn.gov.zyczs.cspt.po.Scaleplu;


/**
 * @Title MappdataDao.java
 * @version 1.0 
 * 溯源秤dao实现类
 */
public class ScalepluDao extends SqlMapClientDaoSupport implements IScalepluDao {

	@Override
	public Scaleplu findById(Scaleplu data) {
		return (Scaleplu)getSqlMapClientTemplate().queryForObject("Scaleplu.findById",data);
	}

	@Override
	public Integer findByCount(Scaleplu data) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Scaleplu.findByCount",data);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Scaleplu> findByList(Scaleplu data) {
		return (List<Scaleplu>) getSqlMapClientTemplate().queryForList("Scaleplu.findByList",data);
	}

	@Override
	public Integer save(Scaleplu data) {
		return (Integer) getSqlMapClientTemplate().insert("Scaleplu.save",data);
	}

	@Override
	public Integer updateByObj(Scaleplu data) {
		return (Integer) getSqlMapClientTemplate().update("Scaleplu.updateByObj",data);
	}
	@Override
	public Integer findMaxPluver(Scaleplu data) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Scaleplu.findMaxPluver",data);
	}
	@Override
	public Integer synchronousPlu(Scaleplu data) {
		return (Integer) getSqlMapClientTemplate().insert("Scaleplu.synchronousPlu",data);
	}
}
