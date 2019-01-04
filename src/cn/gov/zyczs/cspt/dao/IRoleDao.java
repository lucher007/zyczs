package cn.gov.zyczs.cspt.dao;

import java.util.List;
import java.util.Map;
import cn.gov.zyczs.cspt.po.Menu;
import cn.gov.zyczs.cspt.po.Role;
import cn.gov.zyczs.cspt.po.RoleMenu;
import cn.gov.zyczs.cspt.po.User;
import cn.gov.zyczs.cspt.po.UserRole;


public interface IRoleDao {
	public Integer findByCount(Role role);
	public List<Role> findByList(Role role);
	public Role findById(Role role);	
	public Integer saveObject(Role role);
	public Integer updateObject(Role role);	
	public Integer deleteObejct(Role role);	
	public List<Role> findByExist(Role role);
	
	public Integer deleteByIdUserRole(Role role);
	public Integer deleteByIdRoleMenu(Role role);
	
	public List<User> findByRoleUser(Map map);
	public List<User> findByRoleUserNot(Map map);
	public Integer saveByIdRoleUserOne(Map map);
	public Integer deleteByIdRoleUserOne(Map map);
	public Integer deleteByIdRoleUserId(Map map);
	
	
	public List<Menu> findByRoleMenuAll(Integer menusys);
	public List<RoleMenu> findByRoleMenu(Integer roleid);	
	public Integer saveByIdRoleMenuOne(Map map);
	
	public List<Role> findByAll(Role role);
	public List<UserRole> findByExistUserRole(Integer userid);
	public Integer deleteByIdUserRole_userid(Integer userid);
	
}
