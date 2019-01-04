package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;


import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ITabletDao;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.Tablet;


/**
 * @Title TabletDao.java
 * @version 1.0 
 * 饮片生产dao实现类
 */

public class TabletDao extends SqlMapClientDaoSupport implements ITabletDao{

	@Override
	public Integer saveOjbect(Tablet tablet) {
		return (Integer) getSqlMapClientTemplate().insert("Tablet.save",tablet);
	}
	
	@Override
	public Integer updateOjbect(Tablet tablet) {
		return (Integer) getSqlMapClientTemplate().insert("Tablet.update",tablet);
	}
	

	@Override
	public Integer findByCount(Tablet table) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Tablet.findByCount",table);
	}
    
	@SuppressWarnings("unchecked")
	public List<Tablet> findByList(Tablet table) {
		return (List<Tablet>)getSqlMapClientTemplate().queryForList("Tablet.findByList",table);
	}

	@Override
	public Tablet findByCpc(Tablet tablet) {
		return (Tablet)getSqlMapClientTemplate().queryForObject("Tablet.findByCpc",tablet);
	}


	@Override
	public Tablet findById(Integer tabletid) {
		return (Tablet)getSqlMapClientTemplate().queryForObject("Tablet.findById",tabletid);
	}
	
	@Override
	public Integer updateByCheck(Check check) {
		return getSqlMapClientTemplate().update("Tablet.updateByCheck", check);
	}

}
