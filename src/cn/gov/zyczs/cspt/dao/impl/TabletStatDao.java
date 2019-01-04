package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.ITabletStatDao;
import cn.gov.zyczs.cspt.po.MedStat;
import cn.gov.zyczs.cspt.po.TabletStat;
import cn.gov.zyczs.cspt.po.TabletStorage;


public class TabletStatDao extends SqlMapClientDaoSupport implements ITabletStatDao {

	@Override
	public Integer findByMedStorageStatCount(TabletStat tabletStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("TabletStat.findByMedStorageStatCount", tabletStat);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TabletStat> findByMedStorageStatList(TabletStat tabletStat) {
		return (List<TabletStat>) getSqlMapClientTemplate().queryForList("TabletStat.findByMedStorageStatList", tabletStat);
	}

	@Override
	public Integer findByTabletStorageStatCount(TabletStat tabletStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("TabletStat.findByTabletStorageStatCount", tabletStat);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TabletStat> findByTabletStorageStatList(TabletStat tabletStat) {
		return (List<TabletStat>) getSqlMapClientTemplate().queryForList("TabletStat.findByTabletStorageStatList", tabletStat);
	}
	
	@Override
	public Integer findByTabletStorageStatCount_codeType(TabletStat tabletStat) {
		if(tabletStat!=null && tabletStat.getCodetype() == 8){
			return (Integer) getSqlMapClientTemplate().queryForObject("TabletStat.findByTabletStorageStatCount_codeType_8", tabletStat);
		}else{
			return (Integer) getSqlMapClientTemplate().queryForObject("TabletStat.findByTabletStorageStatCount_codeType", tabletStat);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TabletStat> findByTabletStorageStatList_codeType(TabletStat tabletStat) {
		if(tabletStat!=null && tabletStat.getCodetype() == 8){
			return (List<TabletStat>) getSqlMapClientTemplate().queryForList("TabletStat.findByTabletStorageStatList_codeType_8", tabletStat);
		}else{
			return (List<TabletStat>) getSqlMapClientTemplate().queryForList("TabletStat.findByTabletStorageStatList_codeType", tabletStat);
		}
	}
    
	@Override
	public Integer getTabletSellStatCount(TabletStat tabletState) {
		return (Integer) getSqlMapClientTemplate().queryForObject("TabletStat.getTabletSellStatCount", tabletState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<TabletStat> getTabletSellStatList(TabletStat tabletState) {
		return (List<TabletStat>) getSqlMapClientTemplate().queryForList("TabletStat.getTabletSellStatList", tabletState);
	}

	@Override
	public String getTabletSellStatWeight(TabletStat tabletState) {
		return (String) getSqlMapClientTemplate().queryForObject("TabletStat.getTabletSellStatWeight", tabletState);
	}

}
