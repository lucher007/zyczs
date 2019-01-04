package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.User;

/**
 * @Title ICompanyDao.java
 * @Package 
 * @version 1.0 
 * 企业表接口
 */
public interface ICompanyDao {
	/**
	 * 根据ID查询企业对象
	 * @param company
	 * @return
	 */
	public Company findById(Company company);
	
	/**
	 * 根据企业CPC码查询企业对象
	 * @param company
	 * @return
	 */
	public Company findByCpccorp(Company company);
	
	/**
	 * 企业添加
	 * @param user
	 * @return
	 */
	public Integer save(Company company);
	/**
	 * 企业更新
	 * @param user
	 * @return
	 */
	public Integer updateById(Company company);
	/**
	 * 企业分页总数
	 * @param user
	 * @return
	 */
	public Integer findByCount(Company company);
	/**
	 * 企业分页总数
	 * @param user
	 * @return
	 */
	public List<Company> findByList(Company company);
	
	/**
	 * 根据企业名查询是否存在企业
	 * 
	 * @param user
	 * @return
	 */
	public List<Company> findByExist(Company company);
	
	/**
	 * 根据企业id删除企业
	 * @param companyId
	 * @return
	 */
	public Integer deleteByCompanyId(Integer companyId);
}
