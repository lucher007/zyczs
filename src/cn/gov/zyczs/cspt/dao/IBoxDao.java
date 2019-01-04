package cn.gov.zyczs.cspt.dao;

import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.Freeze;

/**
 * @Title IBoxDao.java
 * @Package 
 * @version 1.0 
 * 箱码接口
 */
public interface IBoxDao {
	/**
	 * 保存箱码
	 * @param table
	 * @return Integer
	 */
	public Integer saveOjbect(Box box);
	/**
	 * 修改箱码
	 * @param table
	 * @return Integer
	 */
	public Integer updateOjbect(Box box);
	
	
	public Integer updatePackcode(Box box);
	
	
	/**
	 * 根据条件查询箱码总数
	 * @param table
	 * @return List
	 */
	public Integer findByCount(Box box);
	/**
	 * 根据条件查询箱码
	 * @param table
	 * @return List
	 */
	public List<Box> findByList(Box box);
	
	/**
	 * 调用生成箱码和溯源码
	 * @Title: saveBoxMed 
	 * @Description: TODO
	 * @param map 
	 */
	public void saveBoxMed(Map map);
	/**
	 * 调用生成箱码和溯源码
	 * @Title: saveBoxTablet 
	 * @Description: TODO
	 * @param map 
	 */
	public void saveBoxTablet(Map map);
	
	/**
	 * 查询所有溯源码打印
	 * @Title: findByAll
	 * @Description: TODO
	 * @param List<Box> 
	 */
	public List<Box> findByAll(Box box);
	
	
	/**
	 * 溯源码锁定列表查询
	 * @param 
	 * @return List
	 */
	public List<Freeze> findByFreezeList(String boxcodes);
	/**
	 * 调用生成袋码7开头
	 * @Title: saveBoxTablet 
	 * @Description: TODO
	 * @param map 
	 */
	public void saveBoxTabletBag(Map map);
	/**
	 * 调用生成袋码8开头
	 * @Title: saveBoxTablet 
	 * @Description: TODO
	 * @param map 
	 */
	public void saveBoxTabletBag8(Map map);
	/**
	 * 调用生成一级饮片溯源码
	 * @Title: saveBoxTablet 
	 * @Description: TODO
	 * @param map 
	 */
	public void saveBoxPackTablet(Map map);
	
	
	public Integer deleteByPackcode(Box box);
	
	/**
	 * 
	 * @param box
	 * @return
	 */
	public Integer updateWeight(Box box);
}
