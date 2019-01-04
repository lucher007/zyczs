package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import cn.gov.zyczs.cspt.dao.IScoreDeductDao;
import cn.gov.zyczs.cspt.po.ScoreDeduct;

public class ScoreDeductDao extends SqlMapClientDaoSupport implements IScoreDeductDao {

	@Override
	public Integer findByCount(ScoreDeduct scoreDeduct) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ScoreDeduct.findByCount",scoreDeduct);
	}

	@Override
	public List<ScoreDeduct> findByList(ScoreDeduct scoreDeduct) {
		return (List<ScoreDeduct>)getSqlMapClientTemplate().queryForList("ScoreDeduct.findByList",scoreDeduct);
	}

	@Override
	public Integer save(ScoreDeduct scoreDeduct) {
		return (Integer)getSqlMapClientTemplate().insert("ScoreDeduct.save",scoreDeduct);
	}

	@Override
	public Integer findByCurrentScore(ScoreDeduct scoreDeduct) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ScoreDeduct.findByCurrentScore",scoreDeduct);
	}

	@Override
	public List<ScoreDeduct> findByListSelectAll(ScoreDeduct scoreDeduct) {
		return (List<ScoreDeduct>)getSqlMapClientTemplate().queryForList("ScoreDeduct.findByListSelectAll",scoreDeduct);
	}
	
	@Override
	public Integer findByCountSelectAll(ScoreDeduct scoreDeduct) {
		return (Integer)getSqlMapClientTemplate().queryForObject("ScoreDeduct.findByCountSelectAll",scoreDeduct);
	}

}
