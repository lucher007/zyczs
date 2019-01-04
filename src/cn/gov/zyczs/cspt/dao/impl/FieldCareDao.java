package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IFieldCareDao;
import cn.gov.zyczs.cspt.po.FieldCare;
/**
 * @Title FieldCareDao.java
 * @version 1.0 
 * 田间管理dao实现类
 */
public class FieldCareDao extends SqlMapClientDaoSupport implements IFieldCareDao{

	@Override
	public Integer findByCount(FieldCare fieldCare) {
		return (Integer)getSqlMapClientTemplate().queryForObject("FieldCare.findByCount",fieldCare);
	}

	@Override
	public FieldCare findById(FieldCare fieldCare) {
		return (FieldCare)getSqlMapClientTemplate().queryForObject("FieldCare.findById",fieldCare);
	}

	@Override
	public List<FieldCare> findByList(FieldCare fieldCare) {
		return (List<FieldCare>)getSqlMapClientTemplate().queryForList("FieldCare.findByList",fieldCare);
	}

	@Override
	public Integer save(FieldCare fieldCare) {
		return (Integer)getSqlMapClientTemplate().insert("FieldCare.save",fieldCare);
	}

}
