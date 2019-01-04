package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.ScanCompany;

/**
 * @Title IOrgDao.java
 * @Package
 * @version 1.0 
 * 手持机扫描企业dao接口
 */
public interface IScanCompanyDao {
	/**
	 * 新增手持机扫描过企业记录
	 * @param obj
	 * @return
	 */
	public Integer save(ScanCompany form);
	/**
	 * 查询分页条数
	 * @param form
	 * @return
	 */
	public Integer findByCount(ScanCompany form);
	/**
	 * 查询分页记录
	 * @param form
	 * @return
	 */
	public List<Org> findByList(ScanCompany form);
}
