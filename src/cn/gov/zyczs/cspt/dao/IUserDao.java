package cn.gov.zyczs.cspt.dao;

import java.util.List;

import cn.gov.zyczs.cspt.po.Menu;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.User;

/**
 * @Title IUserDao.java
 * @Package
 * @version 1.0 用户表接口
 */
public interface IUserDao {
	/**
	 * 用户登录
	 * 
	 * @param user
	 * @return
	 */
	public User login(User user);
	
	/**
	 * 用户登录菜单
	 * 
	 * @param user
	 * @return
	 */
	public List<Menu> findRoleMenu(User user);

	/**
	 * 用户添加
	 * 
	 * @param user
	 * @return
	 */
	public Integer save(User user);

	/**
	 * 用户更新
	 * 
	 * @param user
	 * @return
	 */
	public Integer updateById(User user);

	/**
	 * 用户分页总数
	 * 
	 * @param user
	 * @return
	 */
	public Integer findByCount(User user);

	/**
	 * 用户分页总数
	 * 
	 * @param user
	 * @return
	 */
	public List<User> findByList(User user);

	/**
	 * 用户查询根据ID
	 * 
	 * @param user
	 * @return
	 */
	public User findById(User user);

	/**
	 * 根据用户名查询是否存在用户
	 * 
	 * @param user
	 * @return
	 */
	public List<User> findByExist(User user);

	/**
	 * 根据cpc码来查询
	 * 
	 * @param user
	 * @return
	 */
	User findByCpccorp(User user);
	
	/**
	 * 根据企业id删除企业
	 * @param companyId
	 * @return
	 */
	public Integer deleteByCompanyId(Integer companyId);
	
	/**
	 * 根据companyId查询org
	 * @param companyId
	 * @return
	 */
	public List<User> findByCompanyId(Integer companyId);
	
	/**
	 * 根据orgId查询User
	 * @param orgId
	 * @return
	 */
	public User findByOrgId(Integer orgId);
	/**
	 * 根据cpc和partion查询已经存在的coordinate
	 * @param cpccorp
	 * @return
	 */
	public List<User> findParAndCoor(User user);
	
	/**
	 * 重置用户密码
	 * @param user
	 * @return
	 */
	public Integer updatePassword(User user);
}
