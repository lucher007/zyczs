package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Search;
/**
 * 查询机dao接口
 * @author Administrator
 *
 */
public interface ISearchDao {
	
	/**
	 * 根据区域标示查询企业
	 * @param search
	 * @return
	 */
	public List<Search> findByList(Search search);
}
