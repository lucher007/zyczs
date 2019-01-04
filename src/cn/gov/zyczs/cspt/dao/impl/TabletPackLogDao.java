package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ITabletPackLogDao;
import cn.gov.zyczs.cspt.po.TabletPackLog;

public class TabletPackLogDao extends SqlMapClientDaoSupport implements ITabletPackLogDao{

	@Override
	public Integer save(TabletPackLog tabletPackLog) {
		return (Integer) getSqlMapClientTemplate().insert("TabletPackLog.save", tabletPackLog);
	}
	
	@Override
	public Integer findByCount(TabletPackLog tabletPackLog) {
		return (Integer) getSqlMapClientTemplate().queryForObject("TabletPackLog.findByCount",tabletPackLog);
	}
    
	@SuppressWarnings("unchecked")
	public List<TabletPackLog> findByList(TabletPackLog tabletPackLog) {
		return (List<TabletPackLog>)getSqlMapClientTemplate().queryForList("TabletPackLog.findByList",tabletPackLog);
	}

}
