package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IScaleConfDao;
import cn.gov.zyczs.cspt.po.ScaleConf;


/**
 * @Title ScaleConfDao.java
 * @version 1.0 溯源秤配置dao实现类
 */
public class ScaleConfDao extends SqlMapClientDaoSupport implements IScaleConfDao {

	@Override
	public ScaleConf findById(ScaleConf scaleconf) {
		return (ScaleConf) getSqlMapClientTemplate().queryForObject("ScaleConf.findById", scaleconf);
	}

	@Override
	public Integer findByCount(ScaleConf scaleconf) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ScaleConf.findByCount", scaleconf);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ScaleConf> findByList(ScaleConf scaleconf) {
		return (List<ScaleConf>) getSqlMapClientTemplate().queryForList("ScaleConf.findByList", scaleconf);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ScaleConf> queryByList(ScaleConf scaleconf) {
		return (List<ScaleConf>) getSqlMapClientTemplate().queryForList("ScaleConf.queryByList", scaleconf);
	}
	@Override
	public Integer save(ScaleConf scaleconf) {
		return (Integer) getSqlMapClientTemplate().insert("ScaleConf.save", scaleconf);
	}
	@Override
	public ScaleConf saveObj(ScaleConf scaleconf) {
		return (ScaleConf) getSqlMapClientTemplate().insert("ScaleConf.save", scaleconf);
	}
	@Override
	public Integer updateByObj(ScaleConf scaleconf) {
		return (Integer) getSqlMapClientTemplate().update("ScaleConf.updateByObj", scaleconf);
	}

}
