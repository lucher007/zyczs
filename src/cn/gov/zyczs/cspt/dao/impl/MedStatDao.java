package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IMedStatDao;
import cn.gov.zyczs.cspt.po.MedStat;


public class MedStatDao extends SqlMapClientDaoSupport implements IMedStatDao {

	@Override
	public Integer getGrowTaskByStatCount(MedStat medState) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStat.getGrowTaskByStatCount", medState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStat> getGrowTaskByStatList(MedStat medState) {
		return (List<MedStat>) getSqlMapClientTemplate().queryForList("MedStat.getGrowTaskByStatList", medState);
	}

	@Override
	public Integer getMedStorageByStatCount(MedStat medStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStat.getMedStorageByStatCount", medStat);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStat> getMedStorageByStatList(MedStat medStat) {
		return (List<MedStat>) getSqlMapClientTemplate().queryForList("MedStat.getMedStorageByStatList", medStat);
	}

	@Override
	public String getMedStorageByTotalWeight(MedStat medStat) {
		return (String) getSqlMapClientTemplate().queryForObject("MedStat.getMedStorageByTotalWeight", medStat);
	}

	@Override
	public Integer getMedSellStatCount(MedStat medState) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStat.getMedSellStatCount", medState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStat> getMedSellStatList(MedStat medState) {
		return (List<MedStat>) getSqlMapClientTemplate().queryForList("MedStat.getMedSellStatList", medState);
	}

	@Override
	public String getMedSellStatWeight(MedStat medState) {
		return (String) getSqlMapClientTemplate().queryForObject("MedStat.getMedSellStatWeight", medState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStat> findMainMeds(MedStat medStat) {
		return (List<MedStat>)getSqlMapClientTemplate().queryForList("MedStat.findMainMeds",medStat);
	}
	
	@Override
	public Integer getMarketMedSellStatCount(MedStat medState) {
		return (Integer) getSqlMapClientTemplate().queryForObject("MedStat.getMarketMedSellStatCount", medState);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<MedStat> getMarketMedSellStatList(MedStat medState) {
		return (List<MedStat>) getSqlMapClientTemplate().queryForList("MedStat.getMarketMedSellStatList", medState);
	}

	@Override
	public String getMarketMedSellStatWeight(MedStat medState) {
		return (String) getSqlMapClientTemplate().queryForObject("MedStat.getMarketMedSellStatWeight", medState);
	}

}
