package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IScalefckDao;
import cn.gov.zyczs.cspt.po.Scalefck;


/**
 * @Title MappdataDao.java
 * @version 1.0 
 * 溯源秤dao实现类
 */
public class ScalefckDao extends SqlMapClientDaoSupport implements IScalefckDao {

	@Override
	public Scalefck findById(Scalefck data) {
		return (Scalefck)getSqlMapClientTemplate().queryForObject("Scalefck.findById",data);
	}

	@Override
	public Integer findByCount(Scalefck data) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Scalefck.findByCount",data);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Scalefck> findByList(Scalefck data) {
		return (List<Scalefck>) getSqlMapClientTemplate().queryForList("Scalefck.findByList",data);
	}

	@Override
	public Integer save(Scalefck data) {
		return (Integer) getSqlMapClientTemplate().insert("Scalefck.save",data);
	}

	@Override
	public Integer updateByObj(Scalefck data) {
		return (Integer) getSqlMapClientTemplate().update("Scalefck.updateByObj",data);
	}
	@Override
	public Integer deleteObj(Scalefck data) {
		return (Integer) getSqlMapClientTemplate().delete("Scalefck.deleteObj",data);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Scalefck> quryByList(Scalefck data) {
		return (List<Scalefck>) getSqlMapClientTemplate().queryForList("Scalefck.quryByList",data);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Scalefck> quryListByScaleid(Scalefck data) {
		return (List<Scalefck>) getSqlMapClientTemplate().queryForList("Scalefck.quryListByScaleid",data);
	}
}
