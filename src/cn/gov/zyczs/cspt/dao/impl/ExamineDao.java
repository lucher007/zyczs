package cn.gov.zyczs.cspt.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IExamineDao;
import cn.gov.zyczs.cspt.po.ChengRate;
import cn.gov.zyczs.cspt.po.CompanyRate;
import cn.gov.zyczs.cspt.po.Examine;


public class ExamineDao extends SqlMapClientDaoSupport implements IExamineDao{

	@Override
	public Integer findByCount(Examine examine) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Examine.findByCount",examine);
		
	}

	@Override
	public List<Examine> findByList(Examine examine) {
		return (List<Examine>)getSqlMapClientTemplate().queryForList("Examine.findByList", examine);
	}
	
	@Override
	public List<Examine> calculateList(Examine examine) {
		return (List<Examine>)getSqlMapClientTemplate().queryForList("Examine.calculateList", examine);
	}
	
	@Override
	public List<CompanyRate> companyrateList(Examine examine) {
		
		Map map=new HashMap();
		map.put("year", examine.getYear());
		map.put("quarter", examine.getQuarter());

		List<CompanyRate> list=null;
//		 map.put("my_cur", list);
		list=getSqlMapClientTemplate().queryForList("Examine.companyrateList", map);
		 
		return list;
	}
	
	@Override
	public List<ChengRate> chengrateList(ChengRate chengRate) {
		return (List<ChengRate>)getSqlMapClientTemplate().queryForList("Examine.chengrateList", chengRate);
	}

	@Override
	public Integer save(Examine examine) {
		return (Integer) getSqlMapClientTemplate().insert("Examine.save",examine);
		
	}
	
	@Override
	public Examine findById(Integer id) {
		return (Examine) getSqlMapClientTemplate().queryForObject("Examine.findById", id);
	}
	
	@Override
	public Integer updateById(Examine examine) {
		return (Integer) getSqlMapClientTemplate().update("Examine.updateById", examine);
	}
	
	
	@Override
	public Integer saveRate(CompanyRate companyRate) {
		return (Integer) getSqlMapClientTemplate().insert("Examine.saveRate",companyRate);
		
	}
	
	@Override
	public Integer deleteRateByYQ(Integer year,Integer quarter) {
		Map map=new HashMap();
		map.put("year", year);
		map.put("quarter", quarter);
		return (Integer) getSqlMapClientTemplate().update("Examine.deleteRateByYQ", map);
	}
	
	@Override
	public Integer deleteById(Integer id) {
		return (Integer) getSqlMapClientTemplate().update("Examine.deleteById", id);
	}

	@Override
	public Integer findByExist(Examine examine) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Examine.findByExist",examine);
	}

	@Override
	public List<Examine> findByCalculateList(Map map) {
		return (List<Examine>)getSqlMapClientTemplate().queryForList("Examine.findByCalculateList", map);
	}

	

}
