package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IRp_StatDao;
import cn.gov.zyczs.cspt.po.Rp_Stat;

public class Rp_StatDao extends SqlMapClientDaoSupport implements IRp_StatDao{

	@Override
	public List<Rp_Stat> findPlantAreaSumByYear(Rp_Stat rp_Stat) {
		return (List<Rp_Stat>)getSqlMapClientTemplate().queryForList("Rp_Stat.findPlantAreaSumByYear",rp_Stat);
	}

	@Override
	public List<Rp_Stat> findPlantAreaSumByYear_NotAdmin(Rp_Stat rp_Stat) {
		return (List<Rp_Stat>)getSqlMapClientTemplate().queryForList("Rp_Stat.findPlantAreaSumByYear_NotAdmin",rp_Stat);
	}

	@Override
	public Rp_Stat findSellWeightByYear(Rp_Stat rp_Stat) {
		return  (Rp_Stat)getSqlMapClientTemplate().queryForObject("Rp_Stat.findSellWeightByYear",rp_Stat);
	}

	@Override
	public Rp_Stat findMedRateByYear(Rp_Stat rp_Stat) {
		return  (Rp_Stat)getSqlMapClientTemplate().queryForObject("Rp_Stat.findMedRateByYear",rp_Stat);
	}

	@Override
	public  List<Rp_Stat> findSellWeightByYear_NotAdmin(Rp_Stat rp_Stat) {
		return (List<Rp_Stat>)getSqlMapClientTemplate().queryForList("Rp_Stat.findSellWeightByYear_NotAdmin",rp_Stat);
	}

	@Override
	public List<Rp_Stat> findTabletProAndSellByYear(Rp_Stat rp_Stat) {
		return (List<Rp_Stat>)getSqlMapClientTemplate().queryForList("Rp_Stat.findTabletProAndSellByYear",rp_Stat);
	}

}
