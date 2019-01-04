package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.IndexWeek;

/**
 * @Title IIndexWeek.java
 * @Package com.dao
 * @version 1.0 
 */
public interface IIndexWeekDao {
	
	/**********新增************/
	public int saveIndexWeek(List<IndexWeek> indexWeeks);
	/*************************/
}

