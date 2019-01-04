package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.IMedBaseDao;
import cn.gov.zyczs.cspt.po.MedBase;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class MedBaseAction extends BaseAction implements ModelDriven<MedBase>{
	
	MedBase form = new MedBase();
	public MedBase getModel() {
		return form;
	}
	
	IMedBaseDao medBaseDao;

	
	public void setMedBaseDao(IMedBaseDao medBaseDao) {
		this.medBaseDao = medBaseDao;
	}


	public String medBaseChoice(){
		User _user = (User)getSession().getAttribute("User");
		form.setEnable("1");	
		form.setPager_openset(5);//一页显示10行
		form.setPager_count(medBaseDao.findByCount(form));
		form.setList(medBaseDao.findByList(form));
		
		return "medBaseChoice";
	}
}
