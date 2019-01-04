package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import cn.gov.zyczs.cspt.dao.IFreezeDao;
import cn.gov.zyczs.cspt.po.Freeze;


public class FreezeDao extends SqlMapClientDaoSupport implements IFreezeDao {

	@Override
	public Integer findByCount(Freeze freeze) {
		return (Integer)getSqlMapClientTemplate().queryForObject("Freeze.findByCount",freeze);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Freeze> findByList(Freeze freeze) {
		return (List<Freeze>)getSqlMapClientTemplate().queryForList("Freeze.findByList", freeze);
	}

	@Override
	public Freeze findByExist(Freeze freeze) {
		return (Freeze)getSqlMapClientTemplate().queryForObject("Freeze.findByExist",freeze);
	}

}
