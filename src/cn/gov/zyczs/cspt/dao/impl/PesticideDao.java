package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IPesticideDao;
import cn.gov.zyczs.cspt.po.Pesticide;


/**
 * @Title PesticideDao.java
 * @version 1.0 
 * 农药dao实现类
 */
public class PesticideDao  extends SqlMapClientDaoSupport implements IPesticideDao{

	@Override
	public Integer findByCount(Pesticide pesticide) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Pesticide.findByCount",pesticide);
	}

	@Override
	public Pesticide findById(Pesticide pesticide) {
		return (Pesticide)getSqlMapClientTemplate().queryForObject("Pesticide.findById",pesticide);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Pesticide> findByList(Pesticide pesticide) {
		return (List<Pesticide>)getSqlMapClientTemplate().queryForList("Pesticide.findByList",pesticide);
	}

	@Override
	public Integer save(Pesticide pesticide) {
		return (Integer)getSqlMapClientTemplate().insert("Pesticide.save",pesticide);
	}
	
}

