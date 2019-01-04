package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IScaleKeyConfDao;
import cn.gov.zyczs.cspt.po.ScaleKeyConf;


/**
 * @Title ScaleConfDao.java
 * @version 1.0 溯源秤键配置dao实现类
 */
public class ScaleKeyConfDao extends SqlMapClientDaoSupport implements IScaleKeyConfDao {

	@Override
	public ScaleKeyConf findById(ScaleKeyConf scalekeyconf) {
		return (ScaleKeyConf) getSqlMapClientTemplate().queryForObject("ScaleKeyConf.findById", scalekeyconf);
	}

	@Override
	public Integer findByCount(ScaleKeyConf scalekeyconf) {
		return (Integer) getSqlMapClientTemplate().queryForObject("ScaleKeyConf.findByCount", scalekeyconf);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<ScaleKeyConf> findByList(ScaleKeyConf scalekeyconf) {
		return (List<ScaleKeyConf>) getSqlMapClientTemplate().queryForList("ScaleKeyConf.findByList", scalekeyconf);
	}

	@Override
	public Integer save(ScaleKeyConf scalekeyconf) {
		return (Integer) getSqlMapClientTemplate().insert("ScaleKeyConf.save", scalekeyconf);
	}
	@Override
	public Integer updateById(ScaleKeyConf scalekeyconf) {
		return (Integer) getSqlMapClientTemplate().update("ScaleKeyConf.updateById", scalekeyconf);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ScaleKeyConf> queryByList(ScaleKeyConf scalekeyconf) {
		return (List<ScaleKeyConf>) getSqlMapClientTemplate().queryForList("ScaleKeyConf.queryByList", scalekeyconf);
	}
	@Override
	public Integer delete(ScaleKeyConf scalekeyconf) {
		return (Integer) getSqlMapClientTemplate().delete("ScaleKeyConf.deleteObj", scalekeyconf);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ScaleKeyConf> queryListByValueNull(ScaleKeyConf scalekeyconf) {
		return (List<ScaleKeyConf>) getSqlMapClientTemplate().queryForList("ScaleKeyConf.queryListByValueNull", scalekeyconf);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<ScaleKeyConf> queryKeyconfList(ScaleKeyConf scalekeyconf) {
		return (List<ScaleKeyConf>) getSqlMapClientTemplate().queryForList("ScaleKeyConf.queryKeyconfList", scalekeyconf);
	}
}
