package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IFreezeDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class FreezeAction extends BaseAction implements ModelDriven<Freeze> {
	private static final long serialVersionUID = 1L;
	Freeze form = new Freeze();
	@Override
	public Freeze getModel() {
		return form;
	}
	private IFreezeDao freezeDao;
	public void setFreezeDao(IFreezeDao freezeDao) {
		this.freezeDao = freezeDao;
	}
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(freezeDao.findByCount(form));
		form.setFreezelist(freezeDao.findByList(form));	
		return SUCCESS;
	}
	
}
