package cn.gov.zyczs.cspt.dao;

import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.po.ChengRate;
import cn.gov.zyczs.cspt.po.CompanyRate;
import cn.gov.zyczs.cspt.po.Examine;

public interface IExamineDao {
	
	/**
	 * 地区绩效考核
	 * @param user
	 * @return
	 */
	public Integer save(Examine examine);
	
	/**
	 * 地区绩效考核分页总数
	 * @param user
	 * @return
	 */
	public Integer findByCount(Examine examine);
	/**
	 * 地区绩效考核分页总数
	 * @param user
	 * @return
	 */
	public List<Examine> findByList(Examine examine);
	
	

	public List<Examine> calculateList(Examine examine);
		
	public List<CompanyRate> companyrateList(Examine examine);
	
	
	
	/**
	 * 新增考核计算结果
	 * @param user
	 * @return
	 */
	public Integer saveRate(CompanyRate companyRate);
	
	public Integer deleteRateByYQ(Integer year,Integer quarter);
	
	
	public List<ChengRate> chengrateList(ChengRate chengRate);
	/**
	 * 查找地区绩效考核 by Id
	 * @param TabletBase
	 * @return 
	 */
	public Examine findById(Integer id);	
	
	
	public Integer updateById(Examine examine);
	
	/**
	 * 删除饮片
	 * @param TabletBaseOrg
	 * @return 
	 */
	public Integer deleteById(Integer id);

	/**
	 * 根据地区查询是否存在
	 * 
	 * @param user
	 * @return
	 */
	public Integer findByExist(Examine examine);
	
	public List<Examine> findByCalculateList(Map map);
}
