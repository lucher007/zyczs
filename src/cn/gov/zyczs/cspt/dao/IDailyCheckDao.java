package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.DailyCheck;
import cn.gov.zyczs.cspt.po.Org;

/**
 * @Title IDailyCheckDao.java
 * @Package
 * @version 1.0 日常检查dao接口
 */
public interface IDailyCheckDao {
	/**
	 * 新增日常检查记录
	 * @param form
	 * @return
	 */
	public Integer save(DailyCheck form);
	
	/**
	 *日常检查分页总数
	 * @param form
	 * @return
	 */
	public Integer findByCount(DailyCheck form);

	/**
	 * 日常检查列表查询
	 * @param form
	 * @return
	 */
	public List<DailyCheck> findByList(DailyCheck form);
	
	/**
	 * 根据id查询详细
	 * @param id
	 * @return
	 */
	public DailyCheck findById(Integer id);
	
	/**
	 *查询每个项目的最近一次检查记录
	 * @return
	 */
	public List<DailyCheck> findByMaxDate(DailyCheck form);
	
	/**
	 * 根据手持机扫描的溯源码返回药材CPC码
	 * @param cpcMeds
	 * @return
	 */
	public List<String> findCpcMedsByBoxCode(String cpcMeds);
}
