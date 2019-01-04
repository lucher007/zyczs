package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.Tablet;

/**
 * @Title ITabletDao.java
 * @Package 
 * @version 1.0 
 * 饮片生产接口
 */
public interface ITabletDao {
	
	/**
	 * 保存饮片生产
	 * @param table
	 * @return Integer
	 */
	public Integer saveOjbect(Tablet tablet);
	/**
	 * 修改饮片生产
	 * @param table
	 * @return Integer
	 */
	public Integer updateOjbect(Tablet tablet);
	/**
	 * 根据条件查询饮片总数
	 * @param table
	 * @return List
	 */
	public Integer findByCount(Tablet table);
	/**
	 * 根据条件查询饮片List
	 * @param table
	 * @return List
	 */
	public List<Tablet> findByList(Tablet table);
	/**
	 * 根据饮片CPC查询饮片
	 * @param ID
	 * @return Tablet
	 */
	public Tablet findByCpc(Tablet tablet);
	/**
	 * 根据饮片ID查询饮片
	 * @param ID
	 * @return Tablet
	 */
	public Tablet findById(Integer tabletid);
	/**
	 * 更新饮片检验状态
	 * @param check
	 * @return
	 */
	Integer updateByCheck(Check check);
}
