package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ChengFck;
/**
 * @Title IChengFckDao.java
 * @Package 
 * @version 1.0 
 * 溯源秤 快捷键
 */
public interface IChengFckDao {
	/**
	 * 溯源秤 快捷键添加
	 * @param org
	 * @return
	 */
	public Integer save(ChengFck chengfck);
	/**
	 * 溯源秤 快捷键更新
	 * @param chengfck
	 * @return
	 */
	public Integer update(ChengFck chengfck);
	/**
	 * 溯源秤 快捷键分页总数
	 * @param chengfck
	 * @return
	 */
	public Integer findByCount(ChengFck chengfck);
	/**
	 * 溯源秤 快捷键列表查询
	 * @param chengfck
	 * @return
	 */
	public List<ChengFck> findByList(ChengFck chengfck);
	
	/**
	 * 溯源秤 快捷键查询根据秤编号
	 * @param chengfck
	 * @return
	 */
	public ChengFck findById(ChengFck chengfck);
	
	/**
	 * 删除 快捷键更新
	 * @param chengfck
	 * @return
	 */
	public Integer delete(ChengFck chengfck);
	/**
	 * 溯源秤 快捷键列表查询
	 * @param chengfck
	 * @return
	 */
	public List<ChengFck> quryByList(ChengFck chengfck);
	
	/**
	 * 根据秤编号查询已配置PLU值的KEY信息
	 * @param chengfck
	 * @return
	 */
	public List<ChengFck> quryListByChengid(ChengFck chengfck);
	
	
	
}
