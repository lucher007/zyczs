package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IGovmentTabletStatDao;
import cn.gov.zyczs.cspt.po.GovmentTabletStat;
import cn.gov.zyczs.cspt.po.TabletBase;


public class GovmentTabletStatDao extends SqlMapClientDaoSupport implements IGovmentTabletStatDao{
	
	@Override
	public List<GovmentTabletStat> findByTabletList(GovmentTabletStat govmentTabletStat) {
		return (List<GovmentTabletStat>)getSqlMapClientTemplate().queryForList("GovmentTabletStat.findByTabletList",govmentTabletStat);
	}
	
	@Override
	public Integer findByTabletCount(GovmentTabletStat govmentTabletStat) {
		return (Integer)getSqlMapClientTemplate().queryForObject("GovmentTabletStat.findByTabletCount",govmentTabletStat);
	}

	@Override
	public GovmentTabletStat findByOutStor(GovmentTabletStat govmentTabletStat) {
		return (GovmentTabletStat) getSqlMapClientTemplate().queryForObject("GovmentTabletStat.findByOutStor", govmentTabletStat);
	}
}
