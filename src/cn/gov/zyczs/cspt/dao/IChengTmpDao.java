package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ChengTmp;
/**
 * @Title IChengTmpDao.java
 * @Package 
 * @version 1.0 
 * 溯源秤 模板
 */
public interface IChengTmpDao {
	/**
	 * 溯源秤 模板添加
	 * @param org
	 * @return
	 */
	public Integer save(ChengTmp chengtmp);
	/**
	 * 溯源秤 模板更新
	 * @param chengtmp
	 * @return
	 */
	public Integer update(ChengTmp chengtmp);
	/**
	 * 溯源秤 模板分页总数
	 * @param chengtmp
	 * @return
	 */
	public Integer findByCount(ChengTmp chengtmp);
	/**
	 * 溯源秤 模板列表查询
	 * @param chengtmp
	 * @return
	 */
	public List<ChengTmp> findByList(ChengTmp chengtmp);
	
	/**
	 * 溯源秤 模板查询根据秤编号
	 * @param chengtmp
	 * @return
	 */
	public ChengTmp findById(ChengTmp chengtmp);
	
	/**
	 * 删除 模板更新
	 * @param chengtmp
	 * @return
	 */
	public Integer delete(ChengTmp chengtmp);
	/**
	 * 溯源秤 模板列表查询
	 * @param chengtmp
	 * @return
	 */
	public List<ChengTmp> quryByList(ChengTmp chengtmp);
	
}
