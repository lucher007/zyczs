package cn.gov.zyczs.cspt.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IRoleDao;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.Role;
import cn.gov.zyczs.cspt.po.RoleMenu;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;


public class RoleAction extends BaseAction implements ModelDriven<Role> {

	Role form = new Role();
	public Role getModel() {
		return form;
	}
	private IRoleDao roleDao;
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}
	private IOrgDao orgDao;
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	
	public String findByList(){
		form.setPager_count(roleDao.findByCount(form));
		form.setRolelist(roleDao.findByList(form));
		return SUCCESS;
	}
	
	public String deleteObject(){
		roleDao.deleteByIdRoleMenu(form);
		roleDao.deleteByIdUserRole(form);
		roleDao.deleteObejct(form);
		findByList();
		return SUCCESS;
	}
	
	public String saveObjectInit(){
		return "save";
	}
	public String save(){
		List<Role> rolelist = roleDao.findByExist(form);
		if(rolelist!=null&&rolelist.size()>0){
			form.setReturninfo("角色名已存在，请重新添加");
			return "save";
		}
		if(roleDao.saveObject(form)!=0){
			form.setReturninfo("添加成功");
		}else{
			form.setReturninfo("添加失败");
		}
		return "save";
	}
	public String findByExist(){
		List<Role> rolelist = roleDao.findByExist(form);
		if(rolelist!=null&&rolelist.size()>0){
			form.setReturncode(1);
		}else{
			form.setReturncode(0);
		}
		return SUCCESS;
	}
	
	public String updateObjectInit(){
		form.setRole(roleDao.findById(form));
		return "update";
	}
		
	public String updateObject(){
		List<Role> rolelist = roleDao.findByExist(form);
		if(rolelist!=null&&rolelist.size()>0){
			form.setReturninfo("角色名已存在，请重新修改");
			updateObjectInit();
			return "update";
		}
		if(roleDao.updateObject(form)!=0){
			form.setReturninfo("更新成功");
		}else{
			form.setReturninfo("更新失败");
		}
		updateObjectInit();
		return "update";
	}
	
	//==================================================================================
	
	public String findByIdRoleUser(){
		Map map = new HashMap();
		map.put("orgid", form.getOrgid());
		map.put("roleid", form.getRoleid());
		form.setRole(roleDao.findById(form));
		form.setUserlist(roleDao.findByRoleUserNot(map));		
		form.setUserlistchoose(roleDao.findByRoleUser(map));
		return "updateRoleUser";
	}

	public String updateByIdRoleUser(){
		if(form.getUseridtype().equals("deluser")){
			if(form.getUseriddel()!=null&&!form.getUseriddel().equals("")){
				String[] useriddel = form.getUseriddel().split(",");
				for(int i = 0 ;i<useriddel.length;i++){
					if(useriddel[i].equals("")){
						continue;
					}
					Map useridmap = new HashMap();
					useridmap.put("userid", useriddel[i]);
					useridmap.put("roleid", form.getRoleid());
					roleDao.deleteByIdRoleUserOne(useridmap);
				}
			}
		}else if(form.getUseridtype().equals("adduser")){
			if(form.getUseridadd()!=null&&!form.getUseridadd().equals("")){
				String[] useridadd = form.getUseridadd().split(", ");
				for(int i = 0 ;i<useridadd.length;i++){
					if(useridadd[i].equals("")){
						continue;
					}
					Map useridmap = new HashMap();
					useridmap.put("userid", useridadd[i]);
					useridmap.put("roleid", form.getRoleid());	
					roleDao.saveByIdRoleUserOne(useridmap);
				}
			}
		}
		findByIdRoleUser();
		return "updateRoleUser";
	}

	//==================================================================================
	
	public String findByIdRoleMenu(){
		Integer menusys=null;
		Org org = new Org();
		org.setOrgid(form.getOrgid());
		org = orgDao.findById(org);
		if(org.getZyctype().equals("10000000")){
			menusys=0;
		}else if(org.getZyctype().equals("01000000")){
			menusys=1;
		}else if(org.getZyctype().equals("00100000")){
			menusys=2;
		}else if(org.getZyctype().equals("00010000")){
			menusys=3;
			//如果是饮片经销企业，会判断选择该组是否是药材组
			List<RoleMenu> rolemenulist = roleDao.findByRoleMenu(form.getRoleid());
			//种植经销  默认组和管理组
			String medsell_manage=ServletActionContext.getServletContext().getInitParameter("medsell_manage");
			System.out.println(medsell_manage);
			for(RoleMenu rml : rolemenulist ){
				System.out.println(rml.getMenuid());
				if(medsell_manage.indexOf(rml.getMenuid().toString())!=-1){
					menusys=1;
					break;
				}
			}
		}else if(org.getZyctype().equals("00001000")){
			menusys=4;
		}else if(org.getZyctype().equals("00000100")){
			menusys=5;
		}else if(org.getZyctype().equals("00000010")){
			menusys=6;
		}else if(org.getZyctype().equals("00000001")){
			menusys=7;
		}
		form.setMenulist(roleDao.findByRoleMenuAll(menusys));
		form.setRolemenulist(roleDao.findByRoleMenu(form.getRoleid()));
		return "updateRoleMenu";
	}
	
	public String updateByIdRoleMenu(){
		System.out.println(form.getMenustr());
		System.out.println(form.getMenustrchild());
		if(form.getMenustr()==null||"".equals(form.getMenustr())){
			form.setReturninfo("权限ID为空，请重试！");
			findByIdRoleMenu();
			return "updateRoleMenu";
		}
		roleDao.deleteByIdRoleMenu(form);
		String[] menustr = form.getMenustr().split(",");
		List<String> menuidlist = new ArrayList<String>();
		for(int i = 0 ;i<menustr.length;i++){
			String[] menuid =menustr[i].split("_");			
			Map map = new HashMap();
			map.put("roleid", form.getRoleid());
			map.put("menuid", menuid[0]);
			roleDao.saveByIdRoleMenuOne(map);
			if(menuidlist!=null&&menuidlist.size()>0){
				int flag = 1;
				for(int j=0;j<menuidlist.size();j++){
					if(menuidlist.get(j).equals(menuid[1])){
						flag =2;
					}
				}
				if(flag==1){
					menuidlist.add(menuid[1]);
				}
			}else{
				menuidlist.add(menuid[1]);
			}
		}
		
		for(String menuidstr :menuidlist){
			Map map = new HashMap();
			map.put("roleid", form.getRoleid());
			map.put("menuid",menuidstr);
			roleDao.saveByIdRoleMenuOne(map);
		}
		
		if(form.getMenustrchild()!=null&&!"".equals(form.getMenustrchild())){
			String[] menustrchild = form.getMenustrchild().split(",");
			if(menustrchild.length>0){
				for(int j = 0 ;j<menustrchild.length;j++){
					Map map = new HashMap();
					map.put("roleid", form.getRoleid());
					map.put("menuid",menustrchild[j]);
					roleDao.saveByIdRoleMenuOne(map);
				}
			}
		}
		form.setReturninfo("更新权限成功！");
		findByIdRoleMenu();
		return "updateRoleMenu";
	}
	
	
	

}
