package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IMappdataDao;
import cn.gov.zyczs.cspt.po.Mappdata;


/**
 * @Title MappdataDao.java
 * @version 1.0 
 * 溯源秤dao实现类
 */
public class MappdataDao extends SqlMapClientDaoSupport implements IMappdataDao {

	@Override
	public Mappdata findById(Mappdata data) {
		return (Mappdata)getSqlMapClientTemplate().queryForObject("Mappdata.findById",data);
	}

	@Override
	public Integer findByCount(Mappdata data) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Mappdata.findByCount",data);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Mappdata> findByList(Mappdata data) {
		return (List<Mappdata>) getSqlMapClientTemplate().queryForList("Mappdata.findByList",data);
	}

	@Override
	public Integer save(Mappdata data) {
		return (Integer) getSqlMapClientTemplate().insert("Mappdata.save",data);
	}

	@Override
	public Integer updateByObj(Mappdata data) {
		return (Integer) getSqlMapClientTemplate().update("Mappdata.updateByObj",data);
	}

	@Override
	public Integer findScalSaleCount(Mappdata org) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Mappdata.findScalSaleCount",org);
	}

	@Override
	public List<Mappdata> findScalSaleList(Mappdata org) {
		return (List<Mappdata>) getSqlMapClientTemplate().queryForList("Mappdata.findScalSaleList",org);
	}

}
