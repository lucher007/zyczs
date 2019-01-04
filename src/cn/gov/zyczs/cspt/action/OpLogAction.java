package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.OpLog;

import com.opensymphony.xwork2.ModelDriven;

public class OpLogAction extends BaseAction implements ModelDriven<OpLog> {
	private static final long serialVersionUID = 1L;
	OpLog form = new OpLog();
	@Override
	public OpLog getModel() {
		return form;
	}
	
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(opLogDao.findByCount(form));
		form.setList(opLogDao.findByList(form));	
		return SUCCESS;
	}

}
