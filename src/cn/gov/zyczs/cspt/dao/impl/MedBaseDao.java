package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IMedBaseDao;
import cn.gov.zyczs.cspt.po.MedBase;
import cn.gov.zyczs.cspt.po.TabletBase;


/**
 * @Title MedBaseDao.java
 * @version 1.0 
 * 药材基础dao实现类
 */
public class MedBaseDao extends SqlMapClientDaoSupport implements IMedBaseDao{

	@Override
	public MedBase findByName(MedBase medBase) {
		return (MedBase)getSqlMapClientTemplate().queryForObject("MedBase.findByName",medBase);
	}
	
	@Override
	public List<MedBase> findByList(MedBase medBase) {
		return (List<MedBase>)getSqlMapClientTemplate().queryForList("MedBase.findByList",medBase);
	}
	
	@Override
	public Integer findByCount(MedBase medBase) {
		return (Integer)getSqlMapClientTemplate().queryForObject("MedBase.findByCount",medBase);
	}
}

