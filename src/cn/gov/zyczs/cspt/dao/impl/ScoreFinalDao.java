package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import cn.gov.zyczs.cspt.dao.IScoreFinalDao;
import cn.gov.zyczs.cspt.po.ScoreFinal;

public class ScoreFinalDao extends SqlMapClientDaoSupport implements IScoreFinalDao{

	@Override
	public Integer findByCount(ScoreFinal scoreFinal) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ScoreFinal.findByCount",scoreFinal);
	}

	@Override
	public List<ScoreFinal> findByList(ScoreFinal scoreFinal) {
		return (List<ScoreFinal>)getSqlMapClientTemplate().queryForList("ScoreFinal.findByList", scoreFinal);
	}

	@Override
	public List<String> findByAddTime() {
		return (List<String>)getSqlMapClientTemplate().queryForList("ScoreFinal.findByAddTime");
	}

	@Override
	public String findByMaxAddTime() {
		return (String)getSqlMapClientTemplate().queryForObject("ScoreFinal.findByMaxAddTime");
	}

}
