package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.ChengData;

public interface IChengDataDao {
	/**
	 * 溯源秤交易记录添加
	 * 
	 * @param ChengData
	 * @return
	 */
	public Integer save(ChengData chengData);
	
	/**
	 * 溯源秤交易记录更新
	 * 
	 * @param ChengData
	 * @return
	 */
	public Integer update(ChengData chengData);

	/**
	 * 溯源秤交易记录分页总数
	 * 
	 * @param ChengData
	 * @return
	 */
	public Integer findByCount(ChengData chengData);

	/**
	 * 溯源秤交易记录列表查询
	 * 
	 * @param ChengData
	 * @return
	 */
	public List<ChengData> findByList(ChengData chengData);
    
	/**
	 * 溯源秤交易记录列表查询所有
	 * 
	 * @param ChengData
	 * @return
	 */
	public List<ChengData> queryByList(ChengData chengData);
	
	/**
	 * 溯源秤交易记录查询根据ID
	 * 
	 * @param ChengData
	 * @return
	 */
	public ChengData findById(ChengData chengData);
}
