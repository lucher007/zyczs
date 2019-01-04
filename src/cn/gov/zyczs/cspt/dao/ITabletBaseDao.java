package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.TabletBase;
import cn.gov.zyczs.cspt.po.TabletBaseOrg;

/**
 * @Title ITabletBaseDao.java
 * @Package 
 * @version 1.0 
 * 饮片基础表接口
 */
public interface ITabletBaseDao {
	
	/**
	 * 新增饮片
	 * @param TabletBase
	 * @return 
	 */
//	public Integer save(TabletBase tabletBase);
	
	public Integer saveBaseOrgBatch(final String[] baseorg,final Integer orgid);
	
	/**
	 * 更新饮片
	 * @param TabletBase
	 * @return 
	 */	
//	public Integer updateObject(TabletBase tabletBase);
	
	/**
	 * 删除饮片
	 * @param TabletBaseOrg
	 * @return 
	 */
	public Integer deleteByBaseOrg(TabletBaseOrg baseOrg);
	
	/**
	 * 查找饮片 by Id
	 * @param TabletBase
	 * @return 
	 */
	public TabletBase findById(Integer id);	
	
	/**
	 * 查找饮片 by name
	 * @param TabletBase
	 * @return 
	 */
//	public TabletBase checkExsit(TabletBase tabletBase);	
	
	/**
	 * 分页查询 列表
	 * @param TabletBase
	 * @return 
	 */
	public List<TabletBase> findByList(TabletBase tabletBase);
	
	/**
	 * 分页查询 总记录
	 * @param TabletBase
	 * @return 
	 */
	public Integer findByCount(TabletBase tabletBase);
	
	
	/**
	 *查询机查询所有饮片
	 * @param TabletBase
	 * @return 
	 */
	public List<TabletBase> findByList_Kiosks();
	

}
