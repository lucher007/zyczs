package cn.gov.zyczs.cspt.dao.impl;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IGoodsCodeDao;
import cn.gov.zyczs.cspt.po.GoodsCode;


/**
 * @Title GoodsCode.java
 * @version 1.0 
 * 商品dao实现类
 */
public class GoodsCodeDao extends SqlMapClientDaoSupport implements IGoodsCodeDao {

	@Override
	public GoodsCode findByList(GoodsCode goodsCode) {
		return (GoodsCode)getSqlMapClientTemplate().queryForObject("GoodsCode.findByList",goodsCode);
	}

	@Override
	public Integer save(GoodsCode goodsCode) {
		return (Integer)getSqlMapClientTemplate().insert("GoodsCode.save",goodsCode);
	}

}

