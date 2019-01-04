package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Scalefck;
/**
 * @Title IScalefckDao.java
 * @Package 
 * @version 1.0 
 * 溯源秤 快捷键
 */
public interface IScalefckDao {
	/**
	 * 溯源秤 快捷键添加
	 * @param org
	 * @return
	 */
	public Integer save(Scalefck org);
	/**
	 * 溯源秤 快捷键更新
	 * @param org
	 * @return
	 */
	public Integer updateByObj(Scalefck org);
	/**
	 * 溯源秤 快捷键分页总数
	 * @param org
	 * @return
	 */
	public Integer findByCount(Scalefck org);
	/**
	 * 溯源秤 快捷键列表查询
	 * @param org
	 * @return
	 */
	public List<Scalefck> findByList(Scalefck org);
	
	/**
	 * 溯源秤 快捷键查询根据ID
	 * @param org
	 * @return
	 */
	public Scalefck findById(Scalefck org);
	
	/**
	 * 删除 快捷键更新
	 * @param org
	 * @return
	 */
	public Integer deleteObj(Scalefck org);
	/**
	 * 溯源秤 快捷键列表查询
	 * @param org
	 * @return
	 */
	public List<Scalefck> quryByList(Scalefck org);
	/**
	 * 溯源秤 快捷键列表查询
	 * @param org
	 * @return
	 */
	public List<Scalefck> quryListByScaleid(Scalefck org);
	
	
	
}
