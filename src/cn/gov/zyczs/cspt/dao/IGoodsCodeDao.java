package cn.gov.zyczs.cspt.dao;

import cn.gov.zyczs.cspt.po.GoodsCode;

/**
 * @Title IGoodsCode.java
 * @version 1.0 
 * 商品dao
 */
public interface IGoodsCodeDao {
	
	/**
	 * 根据商品条件查询商品信息
	 * @param goodsCode
	 * @return
	 */
	public GoodsCode findByList(GoodsCode goodsCode);
	/**
	 * 新增商品记录
	 * @param goodsCode
	 * @return
	 */
	public Integer save(GoodsCode goodsCode);
	
}

