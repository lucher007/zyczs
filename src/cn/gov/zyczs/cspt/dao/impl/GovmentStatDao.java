package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IGovmentStatDao;
import cn.gov.zyczs.cspt.po.GovmentStat;
import cn.gov.zyczs.cspt.po.Org;


public class GovmentStatDao extends SqlMapClientDaoSupport implements IGovmentStatDao{
    
	@Override
	public Integer getSellTotalWeightStatCount(GovmentStat govmentState) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentStat.getSellTotalWeightStatCount", govmentState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GovmentStat> getSellTotalWeightStatList(GovmentStat govmentState) {
		return (List<GovmentStat>) getSqlMapClientTemplate().queryForList("GovmentStat.getSellTotalWeightStatList", govmentState);
	}
	
	@Override
	public Integer getSellAveragePriceStatCount(GovmentStat govmentState) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentStat.getSellAveragePriceStatCount", govmentState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GovmentStat> getSellAveragePriceStatList(GovmentStat govmentState) {
		return (List<GovmentStat>) getSqlMapClientTemplate().queryForList("GovmentStat.getSellAveragePriceStatList", govmentState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Org> getOrgCount() {
		return (List<Org>) getSqlMapClientTemplate().queryForList("GovmentStat.getOrgCount");
	}
	
	@Override
	public Integer getScaleStatCount(GovmentStat govmentState) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentStat.getScaleStatCount", govmentState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GovmentStat> getScaleStatList(GovmentStat govmentState) {
		return (List<GovmentStat>) getSqlMapClientTemplate().queryForList("GovmentStat.getScaleStatList", govmentState);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<GovmentStat> getTotalWeightJFreeChartStat(GovmentStat govmentState) {
		return (List<GovmentStat>) getSqlMapClientTemplate().queryForList("GovmentStat.getTotalWeightJFreeChartStat", govmentState);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<GovmentStat> getAreaWeightJFreeChartStat(GovmentStat govmentState) {
		return (List<GovmentStat>) getSqlMapClientTemplate().queryForList("GovmentStat.getAreaWeightJFreeChartStat", govmentState);
	}
}
