package cn.gov.zyczs.cspt.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IRp_RateDao;
import cn.gov.zyczs.cspt.po.Rp_Rate;

public class Rp_RateDao extends SqlMapClientDaoSupport implements IRp_RateDao{

	@Override
	public Integer findCompTotalByMonth(String time) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Rp_Rate.findCompTotalByMonth", time);
	}
	@Override
	public Integer findCompCurTotalByMonth(String time) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Rp_Rate.findCompCurTotalByMonth", time);
	}
	@Override
	public List<Rp_Rate> findMedTypeByMonth(String month) {
		// TODO Auto-generated method stub
		return (List<Rp_Rate>)getSqlMapClientTemplate().queryForList("Rp_Rate.findMedTypeByMonth",month);
	}
	@Override
	public Rp_Rate findChengData(String year) {
		return (Rp_Rate) getSqlMapClientTemplate().queryForObject("Rp_Rate.findChengData", year);
	}
	@Override
	public Rp_Rate findChengCount(String year) {
		return (Rp_Rate) getSqlMapClientTemplate().queryForObject("Rp_Rate.findChengCount", year);
	}
	@Override
	public Rp_Rate findShopsData(String year) {
		return (Rp_Rate) getSqlMapClientTemplate().queryForObject("Rp_Rate.findShopsData", year);
	}
	@Override
	public Rp_Rate findMedSellData(String year) {
		return (Rp_Rate) getSqlMapClientTemplate().queryForObject("Rp_Rate.findMedSellData", year);
	}
	@Override
	public Rp_Rate findMedContrast(String year, String medname) {
		Rp_Rate rate=new Rp_Rate();
		rate.setMed1(medname);
		Map map=new HashMap();
		map.put("ytime", year);
		map.put("medname", medname);
		getSqlMapClientTemplate().queryForObject("Rp_Rate.findMedContrast", map);
		
		rate.setTotal((Integer)map.get("yutotal"));
		rate.setCurTotal((Integer)map.get("shitotal"));
		return rate; 
	}
	

}
