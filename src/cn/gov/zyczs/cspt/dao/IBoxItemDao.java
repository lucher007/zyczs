package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.BoxItem;

public interface IBoxItemDao {
	/**
	 * 保存小包溯源码
	 * @param table
	 * @return Integer
	 */
	public Integer saveOjbect(BoxItem boxItem);
	/**
	 * 根据条件查询小包溯源码总数
	 * @param table
	 * @return List
	 */
	public Integer findByCount(BoxItem table);
	/**
	 * 根据条件查询小白溯源码
	 * @param table
	 * @return List
	 */
	public List<BoxItem> findByList(BoxItem boxItem);
	
	/**
	 * 修改小包溯源码
	 * @param table
	 * @return Integer
	 */
	public Integer update(BoxItem boxItem);
}
