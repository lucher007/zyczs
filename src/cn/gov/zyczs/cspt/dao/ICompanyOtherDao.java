package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.CompanyOther;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.User;

/**
 * @Title IUserDao.java
 * @Package 
 * @version 1.0 
 * 非溯源企业接口
 */
public interface ICompanyOtherDao {
	
	/**
	 * 用户非溯源企业
	 * @param user
	 * @return
	 */
	public Integer save(CompanyOther companyOther);
	/**
	 * 用户非溯源企业
	 * @param user
	 * @return
	 */
	public Integer updateById(CompanyOther companyOther);
	/**
	 * 非溯源企业分页总数
	 * @param user
	 * @return
	 */
	public Integer findByCount(CompanyOther companyOther);
	/**
	 * 非溯源企业分页总数
	 * @param user
	 * @return
	 */
	public List<CompanyOther> findByList(CompanyOther companyOther);
	
	/**
	 * 非溯源企业查询根据ID
	 * @param user
	 * @return
	 */
	public CompanyOther findById(Integer companyotherid);
	
	/**
	 * 采购企业名称 分页总数
	 * @param inOutStorage
	 * @return
	 */
	public Integer findByCompanyCount(InOutStor inOutStor);
	
	/**
	 * 采购企业名称 列表查询
	 * @param inOutStorage
	 * @return
	 */
	public List<CompanyOther> findByCompanyList(InOutStor inOutStor);

}
