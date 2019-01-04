package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.FieldCare;


/**
 * @Title IFieldCareDao.java
 * @version 1.0 
 * 田间管理接口
 */
public interface IFieldCareDao {
	
	/**
	 * 查询田间管理次数
	 * @param fertilizer
	 * @return
	 */
	public Integer findByCount(FieldCare fieldCare);
	
	/**
	 * 查询田间管理信息
	 * @param fertilizer
	 * @return
	 */
	public List<FieldCare> findByList(FieldCare fieldCare);
	
	/**
	 * 根据id查询具体田间管理信息
	 * @param fertilizer
	 * @return
	 */
	public FieldCare findById(FieldCare fieldCare);
	
	/**
	 * 新增田间管理
	 * @param fertilizer
	 * @return
	 */
	public Integer save(FieldCare fieldCare);
	
}
