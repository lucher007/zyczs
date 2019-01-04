package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Scaleplu;
/**
 * @Title IMappdataDao.java
 * @Package 
 * @version 1.0 
 * 溯源秤plu
 */
public interface IScalepluDao {
	/**
	 * 溯源秤plu添加
	 * @param org
	 * @return
	 */
	public Integer save(Scaleplu org);
	/**
	 * 溯源秤plu更新
	 * @param org
	 * @return
	 */
	public Integer updateByObj(Scaleplu org);
	/**
	 * 溯源秤plu分页总数
	 * @param org
	 * @return
	 */
	public Integer findByCount(Scaleplu org);
	/**
	 * 溯源秤plu列表查询
	 * @param org
	 * @return
	 */
	public List<Scaleplu> findByList(Scaleplu org);
	
	/**
	 * 溯源秤plu查询根据ID
	 * @param org
	 * @return
	 */
	public Scaleplu findById(Scaleplu org);
	
	/**
	 * 溯源秤plu更新
	 * @param org
	 * @return
	 */
	public Integer findMaxPluver(Scaleplu org);
	
	/**
	 * 同步PLU数据
	 * @param org
	 * @return
	 */
	public Integer synchronousPlu(Scaleplu data);
}
