package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.po.InOutStor;

/**
 * @Title InOutStorageDao.java
 * @version 1.0 
 * 出入库记录dao实现类
 */
public class InOutStorDao extends SqlMapClientDaoSupport implements IInOutStorDao {

	@Override
	public Integer findByCount(InOutStor inOutStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("InOutStor.findByCount",inOutStorage);
	}

	@Override
	public InOutStor findById(InOutStor inOutStorage) {
		return (InOutStor)getSqlMapClientTemplate().queryForObject("InOutStor.findById",inOutStorage);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InOutStor> findByList(InOutStor inOutStorage) {
		return (List<InOutStor>) getSqlMapClientTemplate().queryForList("InOutStor.findByList",inOutStorage);
	}

	@Override
	public Integer save(InOutStor inOutStorage) {
		return (Integer) getSqlMapClientTemplate().insert("InOutStor.save",inOutStorage);
	}

	@Override
	public Integer updateById(InOutStor inOutStorage) {
		return (Integer) getSqlMapClientTemplate().update("InOutStor.updateById",inOutStorage);
	}

	@Override
	public Integer findByCompanyCount(InOutStor inOutStorage) {
		return (Integer) getSqlMapClientTemplate().queryForObject("InOutStor.findByCompanyCount",inOutStorage);
	}

	@Override
	public List<InOutStor> findByCompanyList(InOutStor inOutStorage) {
		return (List<InOutStor>) getSqlMapClientTemplate().queryForList("InOutStor.findByCompanyList",inOutStorage);
	}

	@Override
	public List<InOutStor> findByList_Search(InOutStor inOutStorage) {
		return (List<InOutStor>) getSqlMapClientTemplate().queryForList("InOutStor.findByList_Search",inOutStorage);
	}

	
	

}
