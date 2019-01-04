package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Freeze;

public interface IFreezeDao {
	/**
	 * 查询分页数
	 * @Title: findByCount 
	 * @Description: TODO
	 *
	 */
	public Integer findByCount(Freeze freeze);
	/**
	 * 查询列表
	 * @Title: findByList 
	 * @Description: TODO
	 *
	 */
	public List<Freeze> findByList(Freeze freeze);
	/**
	 * 查询有无码
	 * @Title: Freeze 
	 * @Description: TODO
	 *
	 */
	public Freeze findByExist(Freeze freeze);
}
