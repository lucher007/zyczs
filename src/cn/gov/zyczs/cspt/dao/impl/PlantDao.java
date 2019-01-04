package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IPlantDao;
import cn.gov.zyczs.cspt.po.Plant;


/**
 * @Title PlantDao.java
 * @version 1.0 
 * 植物dao实现类
 */
public class PlantDao extends SqlMapClientDaoSupport implements IPlantDao{

	@SuppressWarnings("unchecked")
	@Override
	public List<Plant> findByList(Plant plant) {
		return (List<Plant>)getSqlMapClientTemplate().queryForList("Plant.findByList",plant);
	}

	@Override
	public Integer save(Plant plant) {
		return (Integer) getSqlMapClientTemplate().insert("Plant.save",plant);
	}

	@Override
	public Integer update(Plant plant) {
		return  (Integer)getSqlMapClientTemplate().update("Plant.updateByObj",plant);
	}

	@Override
	public Integer findByCount(Plant plant) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Plant.findByCount",plant);
	}

	@Override
	public Plant findById(Plant plant) {
		return (Plant)getSqlMapClientTemplate().queryForObject("Plant.findById",plant);
	}

}

