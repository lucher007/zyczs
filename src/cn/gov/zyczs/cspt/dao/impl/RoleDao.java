package cn.gov.zyczs.cspt.dao.impl;

import java.util.List;
import java.util.Map;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import cn.gov.zyczs.cspt.dao.IRoleDao;
import cn.gov.zyczs.cspt.po.Menu;
import cn.gov.zyczs.cspt.po.Role;
import cn.gov.zyczs.cspt.po.RoleMenu;
import cn.gov.zyczs.cspt.po.User;
import cn.gov.zyczs.cspt.po.UserRole;

public class RoleDao extends SqlMapClientDaoSupport implements IRoleDao {

	public Integer deleteObejct(Role role) {
		return (Integer) getSqlMapClientTemplate().delete("Role.deleteById",role);
	}

	public Integer findByCount(Role role) {
		return (Integer) getSqlMapClientTemplate().queryForObject("Role.findByCount",role);
	}

	public Role findById(Role role) {
		return (Role)getSqlMapClientTemplate().queryForObject("Role.findById",role);
	}

	public List<Role> findByList(Role role) {
		return (List<Role>)getSqlMapClientTemplate().queryForList("Role.findByList",role);
	}

	public Integer saveObject(Role role) {
		return (Integer) getSqlMapClientTemplate().insert("Role.save",role);
	}

	public Integer updateObject(Role role) {
		return (Integer) getSqlMapClientTemplate().update("Role.updateById",role);
	}
		
	public List<Role> findByExist(Role role) {
		return (List<Role>)getSqlMapClientTemplate().queryForList("Role.findByExist",role);
	}

	public Integer deleteByIdRoleMenu(Role role) {
		return (Integer) getSqlMapClientTemplate().delete("Role.deleteByIdRoleMenu",role);
	}

	public Integer deleteByIdUserRole(Role role) {
		return (Integer) getSqlMapClientTemplate().delete("Role.deleteByIdUserRole",role);
	}
	
	
	//================================================================
	
	public List<User> findByRoleUser(Map map) {
		return (List<User>)getSqlMapClientTemplate().queryForList("Role.findByRoleUser",map);
	}
	
	public List<User> findByRoleUserNot(Map map) {
		return (List<User>)getSqlMapClientTemplate().queryForList("Role.findByRoleUserNot",map);
	}

	public Integer saveByIdRoleUserOne(Map map) {
		return (Integer) getSqlMapClientTemplate().insert("Role.saveByIdRoleUserOne",map);
	}
	
	public Integer deleteByIdRoleUserOne(Map map) {
		return (Integer) getSqlMapClientTemplate().delete("Role.deleteByIdRoleUserOne",map);
	}

	public Integer deleteByIdRoleUserId(Map map) {
		return (Integer) getSqlMapClientTemplate().delete("Role.deleteByIdRoleUserId",map);
	}
	
	//================================================================

	public List<RoleMenu> findByRoleMenu(Integer roleid) {
		return (List<RoleMenu>)getSqlMapClientTemplate().queryForList("Role.findByRoleMenu",roleid);
	}

	public List<Menu> findByRoleMenuAll(Integer menusys) {
		return (List<Menu>)getSqlMapClientTemplate().queryForList("Role.findByRoleMenuAll",menusys);
	}

	public Integer saveByIdRoleMenuOne(Map map) {
		return (Integer) getSqlMapClientTemplate().insert("Role.saveByIdRoleMenuOne",map);
	}

	
	//=================================================================另加方法
	@Override
	public List<Role> findByAll(Role role) {
		return (List<Role>)getSqlMapClientTemplate().queryForList("Role.findByAll",role);
	}

	@Override
	public Integer deleteByIdUserRole_userid(Integer userid) {
		return (Integer) getSqlMapClientTemplate().delete("Role.deleteByIdUserRole_userid",userid);
	}

	@Override
	public List<UserRole> findByExistUserRole(Integer userid) {
		return (List<UserRole>)getSqlMapClientTemplate().queryForList("Role.findByExistUserRole",userid);
	}



}
