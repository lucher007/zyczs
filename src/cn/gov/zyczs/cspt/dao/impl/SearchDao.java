package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ISearchDao;
import cn.gov.zyczs.cspt.po.Search;
/**
 * @Title SearchDao.java
 * @version 1.0 查询机企业dao实现类
 */
public class SearchDao extends SqlMapClientDaoSupport implements ISearchDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<Search> findByList(Search search) {
		return (List<Search>)getSqlMapClientTemplate().queryForList("Search.findByList",search);
	}
}
