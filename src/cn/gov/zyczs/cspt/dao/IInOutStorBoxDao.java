package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.BoxItem;
import cn.gov.zyczs.cspt.po.InOutStorBox;

/**
 * @Title IInOutStorageDao.java
 * @Package 
 * @version 1.0 
 * 出入库详细记录表
 */
public interface IInOutStorBoxDao {
	/**
	 * 出入库详细添加
	 * @param inOutStorage
	 * @return
	 */
	public Integer save(InOutStorBox inOutStorBox);
	/**
	 * 出入库详细分页总数
	 * @param inOutStorBox
	 * @return
	 */
	public Integer findBoxCount(InOutStorBox inOutStorBox);
	/**
	 * 出入库详细列表查询
	 * @param inOutStorBox
	 * @return
	 */
	public List<InOutStorBox> findBoxList(InOutStorBox inOutStorBox);
	
	/**
	 * 出入库详细查询根据ID
	 * @param inOutStorBox
	 * @return
	 */
	public InOutStorBox findById(InOutStorBox inOutStorBox);
	
	/**
	 * 批量出入库详细添加
	 * @param inOutStorage
	 * @return
	 */
	public Integer saveBatch(final List<InOutStorBox> list,final Integer inoutstorid);
	
	/**
	 * 根据条件查询溯源码码总数
	 * @param table
	 * @return List
	 */
	public Integer findItemCount(InOutStorBox inOutStorbox);
	/**
	 * 根据条件查询溯源码List
	 * @param table
	 * @return List
	 */
	public List<Box> findItemList(InOutStorBox inOutStorbox);
}
