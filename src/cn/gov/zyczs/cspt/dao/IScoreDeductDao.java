package cn.gov.zyczs.cspt.dao;

import java.util.List;
import cn.gov.zyczs.cspt.po.ScoreDeduct;

public interface IScoreDeductDao {
	public Integer findByCount(ScoreDeduct scoreDeduct);
	public List<ScoreDeduct> findByList(ScoreDeduct scoreDeduct);
	public Integer save(ScoreDeduct scoreDeduct);
	public Integer findByCurrentScore(ScoreDeduct scoreDeduct);
	public Integer findByCountSelectAll(ScoreDeduct scoreDeduct);
	public List<ScoreDeduct> findByListSelectAll(ScoreDeduct scoreDeduct);
}
