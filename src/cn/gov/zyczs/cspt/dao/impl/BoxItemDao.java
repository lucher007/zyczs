package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IBoxItemDao;
import cn.gov.zyczs.cspt.po.BoxItem;


public class BoxItemDao extends SqlMapClientDaoSupport implements IBoxItemDao {

	@Override
	public Integer findByCount(BoxItem boxItem) {
		return (Integer) getSqlMapClientTemplate().queryForObject("BoxItem.findByCount",boxItem);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<BoxItem> findByList(BoxItem boxItem) {
		return (List<BoxItem>)getSqlMapClientTemplate().queryForList("BoxItem.findByList",boxItem);
	}

	@Override
	public Integer saveOjbect(BoxItem boxItem) {
		return (Integer) getSqlMapClientTemplate().insert("BoxItem.save",boxItem);
	}

	@Override
	public Integer update(BoxItem boxItem) {
		return (Integer) getSqlMapClientTemplate().update("BoxItem.update",boxItem);
	}

}
