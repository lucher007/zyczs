package cn.gov.zyczs.cspt.dao;

import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.ChengState;
import cn.gov.zyczs.cspt.po.Scale;

/**
 * @Title IChengDao.java
 * @Package
 * @version 1.0 溯源秤接口
 */
public interface IChengDao {
	/**
	 * 溯源秤添加
	 * 
	 * @param ScaleConf
	 * @return
	 */
	public Integer save(Cheng cheng);

	/**
	 * 溯源秤更新
	 * 
	 * @param Cheng
	 * @return
	 */
	public Integer update(Cheng cheng);

	/**
	 * 溯源秤分页总数
	 * 
	 * @param Cheng
	 * @return
	 */
	public Integer findByCount(Cheng cheng);

	/**
	 * 溯源秤列表查询
	 * 
	 * @param Cheng
	 * @return
	 */
	public List<Cheng> findByList(Cheng cheng);
	
	/**
	 * 溯源秤状态变化查询分页总数
	 * 
	 * @param Cheng
	 * @return
	 */
	public Integer findByCount_statelog(Cheng cheng);

	/**
	 * 溯源秤状态变化列表查询
	 * 
	 * @param Cheng
	 * @return
	 */
	public List<Cheng> findByList_statelog(Cheng cheng);

	/**
	 * 溯源秤查询根据ID
	 * 
	 * @param Cheng
	 * @return
	 */
	public Cheng findById(Cheng cheng);
	/**
	 * 溯源秤查询根据秤编号
	 * 
	 * @param Cheng
	 * @return
	 */
	public Cheng findByCode(Cheng cheng);
	
	/**
	 * 溯源秤列表查询
	 * 
	 * @param Cheng
	 * @return
	 */
	public List<Cheng> queryByList(Cheng cheng);
	
	/**
	 * 发放秤组织称初始化XML
	 * @Title: saveChengStatXml 
	 * @Description: TODO
	 * @param map 
	 */
	public void saveChengStatXml(Cheng cheng);
	
	/**
	 * 溯源秤删除
	 * 
	 * @param Cheng
	 * @return
	 */
	public Integer delete(Cheng cheng);
	/**
	 * 溯源秤一周状态历史变化
	 * @param cheng
	 * @return
	 */
	public List<ChengState> findWeekStateLog(ChengState chengState);
	
	/**
	 * 溯源秤分页总数
	 * 
	 * @param Cheng
	 * @return
	 */
	public Integer findByCount_mobile(Cheng cheng);

	/**
	 * 溯源秤列表查询
	 * 
	 * @param Cheng
	 * @return
	 */
	public List<Cheng> findByList_mobile(Cheng cheng);
}
