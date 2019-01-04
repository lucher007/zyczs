package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.ILabelPrintDao;
import cn.gov.zyczs.cspt.po.LabelPrint;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class LabelPrintAction extends BaseAction implements ModelDriven<LabelPrint>{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private LabelPrint form = new LabelPrint();
	
	@Override
	public LabelPrint getModel() {
		return form;
	}
	
	private ILabelPrintDao labelPrintDao;
	public void setLabelPrintDao(ILabelPrintDao labelPrintDao) {
		this.labelPrintDao = labelPrintDao;
	}
	
	
	public String save(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		if(labelPrintDao.save(form) != 0){
			form.setReturninfo("标示打印保存成功");
		}else{
			form.setReturninfo("标示打印保存失败");
		}
		return findByOrgId();
	}
	
	public String update(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		if(labelPrintDao.update(form) != 0){
			form.setReturninfo("标示打印保存成功");
		}else{
			form.setReturninfo("标示打印保存失败");
		}
		return findByOrgId();
	}
	
	public String findByOrgId(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		form.setLabelprint(labelPrintDao.findByOrgId(form));
		return "findByOrgId";
	}
}
