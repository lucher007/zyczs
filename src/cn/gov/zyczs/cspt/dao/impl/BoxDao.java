package cn.gov.zyczs.cspt.dao.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.Freeze;


public class BoxDao extends SqlMapClientDaoSupport implements IBoxDao {

	@Override
	public Integer findByCount(Box box) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Box.findByCount",box);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Box> findByList(Box box) {
		return (List<Box>)getSqlMapClientTemplate().queryForList("Box.findByList",box);
	}

	@Override
	public Integer saveOjbect(Box box) {
		return (Integer) getSqlMapClientTemplate().insert("Box.save",box);
	}

	@Override
	public Integer updateOjbect(Box box) {
		return (Integer) getSqlMapClientTemplate().insert("Box.update",box);
	}
	@Override
	public Integer updatePackcode(Box box) {
		return (Integer) getSqlMapClientTemplate().insert("Box.updatePackcode",box);
	}

	@Override
	public void saveBoxMed(Map map) {
		getSqlMapClientTemplate().queryForObject("Box.saveBoxMed",map);
	}

	@Override
	public void saveBoxTablet(Map map) {
		getSqlMapClientTemplate().queryForObject("Box.saveBoxTablet",map);
	}

	@Override
	public List<Box> findByAll(Box box) {
		return (List<Box>)getSqlMapClientTemplate().queryForList("Box.findByAll",box);
	}

	@Override
	public List<Freeze> findByFreezeList(String boxcodes) {
		Map map=new HashMap();
		map.put("boxcodes", boxcodes);

		List<Freeze> list=getSqlMapClientTemplate().queryForList("Box.findByFreeze", map);
		 

	       
		return list;
	}

	@Override
	public void saveBoxTabletBag(Map map) {
		getSqlMapClientTemplate().queryForObject("Box.saveBoxTabletBag",map);
	}

	@Override
	public void saveBoxPackTablet(Map map) {
		getSqlMapClientTemplate().queryForObject("Box.saveBoxTabletPack",map);
	}
	
	@Override
	public Integer deleteByPackcode(Box box) {
		return (Integer) getSqlMapClientTemplate().update("Box.deleteByPackcode", box);
	}

	@Override
	public Integer updateWeight(Box box) {
		return (Integer)getSqlMapClientTemplate().update("Box.updateWeight",box);
	}

	@Override
	public void saveBoxTabletBag8(Map map) {
		getSqlMapClientTemplate().queryForObject("Box.saveBoxTabletBag8",map);
	}


}
