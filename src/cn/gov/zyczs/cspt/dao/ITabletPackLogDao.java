package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.TabletPackLog;

public interface ITabletPackLogDao {
	
	public Integer save(TabletPackLog tabletPackLog);
	
	public Integer findByCount(TabletPackLog tabletPackLog);
	
	public List<TabletPackLog> findByList(TabletPackLog tabletPackLog);

}
