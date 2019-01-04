package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Mappdata;
/**
 * @Title IMappdataDao.java
 * @Package 
 * @version 1.0 
 * 溯源秤
 */
public interface IMappdataDao {
	/**
	 * 溯源秤添加
	 * @param org
	 * @return
	 */
	public Integer save(Mappdata org);
	/**
	 * 溯源秤更新
	 * @param org
	 * @return
	 */
	public Integer updateByObj(Mappdata org);
	/**
	 * 溯源秤分页总数
	 * @param org
	 * @return
	 */
	public Integer findByCount(Mappdata org);
	/**
	 * 溯源秤列表查询
	 * @param org
	 * @return
	 */
	public List<Mappdata> findByList(Mappdata org);
	
	/**
	 * 溯源秤查询根据ID
	 * @param org
	 * @return
	 */
	public Mappdata findById(Mappdata org);
	
	/**
	 * 溯源秤交易后数据分页总数
	 * @param org
	 * @return
	 */
	public Integer findScalSaleCount(Mappdata org);
	/**
	 * 溯源秤交易后列表查询
	 * @param org
	 * @return
	 */
	public List<Mappdata> findScalSaleList(Mappdata org);
}
