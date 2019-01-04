package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.OrgUpload;


/**
 * @Title CompanyDao.java
 * @version 1.0 组织dao实现类
 */
public class OrgDao extends SqlMapClientDaoSupport implements IOrgDao {

	@Override
	public Org findById(Org org) {
		return (Org) getSqlMapClientTemplate().queryForObject("Org.findById", org);
	}

	@Override
	public Integer findByCount(Org org) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Org.findByCount", org);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Org> findByList(Org org) {
		return (List<Org>) getSqlMapClientTemplate().queryForList("Org.findByList", org);
	}
	
	@Override
	public Integer findByCount_companystate(Org org) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Org.findByCount_companystate", org);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Org> findByList_companystate(Org org) {
		return (List<Org>) getSqlMapClientTemplate().queryForList("Org.findByList_companystate", org);
	}

	@Override
	public Integer save(Org org) {
		return (Integer) getSqlMapClientTemplate().insert("Org.save", org);
	}

	@Override
	public Integer updateById(Org org) {
		return (Integer) getSqlMapClientTemplate().update("Org.updateById", org);
	}

	@Override
	public Integer findByMedmarketUserStatCount(Org org) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Org.findByMedmarketUserStatCount", org);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Org> findByMedmarketUserStatList(Org org) {
		return (List<Org>) getSqlMapClientTemplate().queryForList("Org.findByMedmarketUserStatList", org);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Org> findByCpccorp(Org org) {
		return (List<Org>) getSqlMapClientTemplate().queryForList("Org.findByCpccorp", org);
	}

	@Override
	public Integer updateByMap(Map<String, Object> map) {
		return getSqlMapClientTemplate().update("Org.updateByMap", map);
	}

	@Override
	public List<Org> findByCompanyId(Integer companyId) {
		return (List<Org>)getSqlMapClientTemplate().queryForList("Org.findByCompanyId",companyId);
	}

	@Override
	public Integer deleteByCompanyId(Integer companyId) {
		return (Integer)getSqlMapClientTemplate().delete("Org.deleteByCompanyId", companyId);
	}

	@Override
	public List<Org> findOrgCheng() {
		return (List<Org>)getSqlMapClientTemplate().queryForList("Org.findOrgCheng");
	}

	@Override
	public Integer updateLogLat(Org org) {
		return getSqlMapClientTemplate().update("Org.updateLogLat", org);
	}

	@Override
	public List<Org> findMarket() {
		return (List<Org>)getSqlMapClientTemplate().queryForList("Org.findMarket");
	}

	@Override
	public List<Org> findByExist(String orgname) {
		return (List<Org>)getSqlMapClientTemplate().queryForList("Org.findByExist",orgname);
	}

	@Override
	public Org findByCpccorpObject(String cpccorp) {
		return (Org) getSqlMapClientTemplate().queryForObject("Org.findByCpccorpObject", cpccorp);
	}

	@Override
	public Org findByMarketcode(Org org) {
		return (Org) getSqlMapClientTemplate().queryForObject("Org.findByMarketcode", org);
	}

	@Override
	public List<Org> findExistByOrgnames(String orgnames) {
		return (List<Org>)getSqlMapClientTemplate().queryForList("Org.findExistByOrgnames",orgnames);
	}

	@Override
	public Integer updateBySuperCpC(Org org) {
		return (Integer)getSqlMapClientTemplate().update("Org.updateBySuperCpC",org);
	}

	@Override
	public Integer findCardByCpc_JiLin(String cpccorp) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Org.findCardByCpc_JiLin",cpccorp);
	}

	@Override
	public List<OrgUpload> findPic_JiLin(Org org) {
		return (List<OrgUpload>)getSqlMapClientTemplate().queryForList("Org.findPic_JiLin",org);
	}

}
