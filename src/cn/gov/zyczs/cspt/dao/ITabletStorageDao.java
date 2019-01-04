package cn.gov.zyczs.cspt.dao;

import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.TabletStorage;

/**
 * @Title ITabletStorageDao.java
 * @Package 
 * @version 1.0 
 * 饮片库存表接口
 */
public interface ITabletStorageDao {
	
	
	/**
	 * 分页查询 列表
	 * @param TabletStorage
	 * @return 
	 */
	public List<TabletStorage> findByList(TabletStorage tabletStorage);
	
	/**
	 * 分页查询总记录
	 * @param TabletStorage
	 * @return 
	 */
	public Integer findByCount(TabletStorage tabletStorage);
	
	
	public List<TabletStorage> findBoxListByAll(String packCode,Integer orgid);
	/**
<<<<<<< .mine
	 * 分页查询 列表
	 * @param TabletStorage
	 * @return 
	 */
	public List<TabletStorage> findByList_codeType(TabletStorage tabletStorage);
	
	/**
	 * 分页查询总记录
	 * @param TabletStorage
	 * @return 
	 */
	public Integer findByCount_codeType(TabletStorage tabletStorage);
	
	/**
=======
	 * 分页查询 列表
	 * @param TabletStorage
	 * @return 
	 */
	public List<TabletStorage> findBoxListByList(TabletStorage tabletStorage);
	
	/**
	 * 分页查询总记录
	 * @param TabletStorage
	 * @return 
	 */
	public Integer findBoxListByCount(TabletStorage tabletStorage);
	
	/**
>>>>>>> .r2552
	 * 新增饮片库存记录
	 * @param tabletStorage
	 * @return
	 */
	public Integer save(TabletStorage tabletStorage);
	
	/**
	 * 根据饮片ID查询饮片
	 * @param ID
	 * @return Tablet
	 */
	public TabletStorage findById(TabletStorage tabletStorage);

	
	public Integer updateWeightById(Double CurrTotal,Integer state,Integer tabletstorid);

	/**
	 * 更新药材库存相关信息
	 * @param medStorage
	 * @return
	 */
	public Integer update(TabletStorage tabletStorage);
	
	/**
	 * 根据扫描箱码查询
	 * @param ID
	 * @return TabletStorage
	 */
	public List<TabletStorage> findByBox(Map map);
	
	/**
	 * 根据扫描箱码查询
	 * @param ID
	 * @return TabletStorage
	 */
	public List<TabletStorage> findByBox_8(Map map);
	
	
	
	/**
	 * 分页查询 列表
	 * @param TabletStorage
	 * @return 
	 */
	public List<TabletStorage> findDownCodeByList(TabletStorage tabletStorage);
	
	/**
	 * 分页查询总记录
	 * @param TabletStorage
	 * @return 
	 */
	public Integer findDownCodeByCount(TabletStorage tabletStorage);
	
//	/**
//	 * 根据扫描袋码查询
//	 * @param ID
//	 * @return TabletStorage
//	 */
//	public List<TabletStorage> findByBoxPackCode(Map map);

}
