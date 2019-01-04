package cn.gov.zyczs.cspt.dao;

import java.util.List;
import cn.gov.zyczs.cspt.po.ScoreFinal;

public interface IScoreFinalDao {
	/**
	 * 查询总数
	 * @param scoreFinal
	 * @return
	 */
	public Integer findByCount(ScoreFinal scoreFinal);
	/**
	 * 查询列表
	 * @param scoreFinal
	 * @return
	 */
	public List<ScoreFinal> findByList(ScoreFinal scoreFinal);
	/**
	 * 查询最近时间
	 * @param scoreFinal
	 * @return
	 */
	public String findByMaxAddTime();
	/**
	 * 查询时间列表
	 * @param scoreFinal
	 * @return
	 */
	public List<String> findByAddTime();
}

