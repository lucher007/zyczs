package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Scalestat;
/**
 * @Title IMappdataDao.java
 * @Package 
 * @version 1.0 
 * 溯源秤
 */
public interface IScalestatDao {
	/**
	 * 溯源秤添加
	 * @param org
	 * @return
	 */
	public Integer save(Scalestat org);
	/**
	 * 溯源秤更新
	 * @param org
	 * @return
	 */
	public Integer updateByObj(Scalestat org);
	/**
	 * 溯源秤分页总数
	 * @param org
	 * @return
	 */
	public Integer findByCount(Scalestat org);
	/**
	 * 溯源秤列表查询
	 * @param org
	 * @return
	 */
	public List<Scalestat> findByList(Scalestat org);
	
	/**
	 * 溯源秤查询根据ID
	 * @param org
	 * @return
	 */
	public Scalestat findById(Scalestat org);
	/**
	 * 更新用户药材出入库
	 */
	public Integer updateByComsta(String cpccorp);
}
