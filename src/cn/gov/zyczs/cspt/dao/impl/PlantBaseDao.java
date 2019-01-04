package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IPlantBaseDao;
import cn.gov.zyczs.cspt.po.PlantBase;


/**
 * @Title PlantBaseDao.java
 * @version 1.0 
 * 植物基础dao实现类
 */
public class PlantBaseDao extends SqlMapClientDaoSupport implements IPlantBaseDao{

	@Override
	public PlantBase findByName(PlantBase plantBase) {
		PlantBase obj = (PlantBase) getSqlMapClientTemplate().queryForObject("PlantBase.findByName",plantBase);
		return obj;
	}

	@Override
	public Integer findByCount(PlantBase plantBase) {
		return (Integer)getSqlMapClientTemplate().queryForObject("PlantBase.findByCount",plantBase);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PlantBase> findByList(PlantBase plantBase) {
		return (List<PlantBase>)getSqlMapClientTemplate().queryForList("PlantBase.findByList",plantBase);
	}
}

