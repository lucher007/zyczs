package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IGovmentMedStatDao;
import cn.gov.zyczs.cspt.po.GovmentMedStat;


public class GovmentMedStatDao extends SqlMapClientDaoSupport implements IGovmentMedStatDao {

	@Override
	public List<GovmentMedStat> findMedByList(GovmentMedStat govmentMedStat) {
		return (List<GovmentMedStat>) getSqlMapClientTemplate().queryForList("GovmentMedStat.findMedByList", govmentMedStat);
	}

	@Override
	public Integer findMedCountByList(GovmentMedStat govmentMedStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentMedStat.findMedCountByList", govmentMedStat);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GovmentMedStat> findMedmarketByList(GovmentMedStat govmentMedStat) {
		return (List<GovmentMedStat>) getSqlMapClientTemplate().queryForList("GovmentMedStat.findMedmarketByList", govmentMedStat);
	}

	@Override
	public Integer findMedmarketCountByList(GovmentMedStat govmentMedStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentMedStat.findMedmarketCountByList", govmentMedStat);
	}

	@Override
	public List<GovmentMedStat> findMedSellByList(GovmentMedStat govmentMedStat) {
		return (List<GovmentMedStat>) getSqlMapClientTemplate().queryForList("GovmentMedStat.findMedSellByList", govmentMedStat);
	}

	@Override
	public Integer findMedSellCountByList(GovmentMedStat govmentMedStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentMedStat.findMedSellCountByList", govmentMedStat);
	}

	@Override
	public List<GovmentMedStat> findMedSellBase(GovmentMedStat govmentMedStat) {
		return (List<GovmentMedStat>) getSqlMapClientTemplate().queryForList("GovmentMedStat.findMedSellBase", govmentMedStat);
	}

	@Override
	public Integer findMedSellCount(GovmentMedStat govmentMedStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentMedStat.findMedSellCount", govmentMedStat);
	}

	@Override
	public List<GovmentMedStat> findMedSellSale(GovmentMedStat govmentMedStat) {
		return (List<GovmentMedStat>) getSqlMapClientTemplate().queryForList("GovmentMedStat.findMedSellSale", govmentMedStat);
	}

	@Override
	public Integer findMedSellSaleCount(GovmentMedStat govmentMedStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentMedStat.findMedSellSaleCount", govmentMedStat);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GovmentMedStat> findMedmarketSellByList(GovmentMedStat govmentMedStat) {
		return (List<GovmentMedStat>) getSqlMapClientTemplate().queryForList("GovmentMedStat.findMedmarketSellByList", govmentMedStat);
	}

	@Override
	public Integer findMedmarketSellCountByList(GovmentMedStat govmentMedStat) {
		return (Integer) getSqlMapClientTemplate().queryForObject("GovmentMedStat.findMedmarketSellCountByList", govmentMedStat);
	}

}
