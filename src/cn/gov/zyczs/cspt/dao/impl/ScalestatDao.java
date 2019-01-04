package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IScalestatDao;
import cn.gov.zyczs.cspt.po.Scalestat;


/**
 * @Title MappdataDao.java
 * @version 1.0 
 * 溯源秤dao实现类
 */
public class ScalestatDao extends SqlMapClientDaoSupport implements IScalestatDao {

	@Override
	public Scalestat findById(Scalestat data) {
		return (Scalestat)getSqlMapClientTemplate().queryForObject("Scalestat.findById",data);
	}

	@Override
	public Integer findByCount(Scalestat data) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Scalestat.findByCount",data);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Scalestat> findByList(Scalestat data) {
		return (List<Scalestat>) getSqlMapClientTemplate().queryForList("Scalestat.findByList",data);
	}

	@Override
	public Integer save(Scalestat data) {
		return (Integer) getSqlMapClientTemplate().insert("Scalestat.save",data);
	}

	@Override
	public Integer updateByObj(Scalestat data) {
		return (Integer) getSqlMapClientTemplate().update("Scalestat.updateByObj",data);
	}

	@Override
	public Integer updateByComsta(String cpccorp) {
		return (Integer) getSqlMapClientTemplate().update("Scalestat.updateByComsta",cpccorp);
	}

}
