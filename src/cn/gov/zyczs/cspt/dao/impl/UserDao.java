package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import cn.gov.zyczs.cspt.dao.IUserDao;
import cn.gov.zyczs.cspt.po.Menu;
import cn.gov.zyczs.cspt.po.User;


/**
 * @Title CompanyDao.java
 * @version 1.0 用户dao实现类
 */
public class UserDao extends SqlMapClientDaoSupport implements IUserDao {

	public User login(User user) {
		return (User) getSqlMapClientTemplate().queryForObject("User.login", user);
	}

	@Override
	public Integer findByCount(User user) {
		return (Integer) getSqlMapClientTemplate().queryForObject("User.findByCount", user);
	}

	@Override
	public User findById(User user) {
		return (User) getSqlMapClientTemplate().queryForObject("User.findById", user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findByList(User user) {
		return (List<User>) getSqlMapClientTemplate().queryForList("User.findByList", user);
	}

	@Override
	public Integer save(User user) {
		return (Integer) getSqlMapClientTemplate().insert("User.save", user);
	}

	@Override
	public Integer updateById(User user) {
		return (Integer) getSqlMapClientTemplate().update("User.updateById", user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findByExist(User user) {
		return (List<User>) getSqlMapClientTemplate().queryForList("User.findByExist", user);
	}

	@Override
	public User findByCpccorp(User user) {
		return (User) getSqlMapClientTemplate().queryForObject("User.findByCpccorp", user);
	}

	@Override
	public Integer deleteByCompanyId(Integer companyId) {
		return (Integer)getSqlMapClientTemplate().delete("User.deleteByCompanyId", companyId);
	}

	@Override
	public List<User> findByCompanyId(Integer companyId) {
		return (List<User>)getSqlMapClientTemplate().queryForList("User.findByCompanyId",companyId);
	}

	@Override
	public User findByOrgId(Integer orgId) {
		return (User) getSqlMapClientTemplate().queryForObject("User.findByOrgId", orgId);
	}

	@Override
	public List<Menu> findRoleMenu(User user) {
		return (List<Menu>)getSqlMapClientTemplate().queryForList("User.findRoleMenu",user);
	}

	@Override
	public List<User> findParAndCoor(User user) {
		return (List<User>)getSqlMapClientTemplate().queryForList("User.findParAndCoor",user);
	}

	@Override
	public Integer updatePassword(User user) {
		return (Integer) getSqlMapClientTemplate().update("User.updatePassword", user);
	}

}
