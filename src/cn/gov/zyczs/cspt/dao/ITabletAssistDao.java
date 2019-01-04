package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.TabletAssist;

/**
 * @Title ITabletBaseDao.java
 * @Package 
 * @version 1.0 
 * 饮片生产--辅料表接口
 */
public interface ITabletAssistDao {
	
	/**
	 * 批量插入饮片生产--辅料
	 * @param List<TabletAssist> list
	 * @return 
	 */
	public Integer saveTabletAssistBatch(final List<TabletAssist> list,final Integer tabletid);
	
	/**
	 * 根据饮片批次号查询对应辅料列表
	 * @param tabletid
	 * @return List<TabletAssist> list
	 */
	public List<TabletAssist> findByTablet(Integer tabletid);
}
