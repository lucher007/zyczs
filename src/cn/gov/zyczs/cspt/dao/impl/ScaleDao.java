package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IScaleDao;
import cn.gov.zyczs.cspt.po.Scale;


/**
 * @Title ScaleDao.java
 * @version 1.0 溯源秤dao实现类
 */
public class ScaleDao extends SqlMapClientDaoSupport implements IScaleDao {

	@Override
	public Scale findById(Scale Scale) {
		return (Scale) getSqlMapClientTemplate().queryForObject("Scale.findById", Scale);
	}

	@Override
	public Integer findByCount(Scale Scale) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Scale.findByCount", Scale);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Scale> findByList(Scale Scale) {
		return (List<Scale>) getSqlMapClientTemplate().queryForList("Scale.findByList", Scale);
	}

	@Override
	public Integer save(Scale Scale) {
		return (Integer) getSqlMapClientTemplate().insert("Scale.save", Scale);
	}
	@Override
	public Integer updateByObj(Scale Scale) {
		return (Integer) getSqlMapClientTemplate().update("Scale.updateByObj", Scale);
	}
	@Override
	public Scale findObjById(Scale Scale) {
		return (Scale) getSqlMapClientTemplate().queryForObject("Scale.findObjById", Scale);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Scale> findScalesListByCPC(Scale Scale) {
		return (List<Scale>) getSqlMapClientTemplate().queryForList("Scale.findScalesListByCPC", Scale);
	}
	@Override
	public Integer findScalesListByCount(Scale Scale) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Scale.findScalesListByCount", Scale);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Scale> findScalesCPC(Scale Scale) {
		return (List<Scale>) getSqlMapClientTemplate().queryForList("Scale.findScalesCPC", Scale);
	}
	@Override
	public Integer findScalesCPCCount(Scale Scale) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Scale.findScalesCPCCount", Scale);
	}
}
