package cn.gov.zyczs.cspt.action;

import java.util.List;

import com.opensymphony.xwork2.ModelDriven;

import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.po.CodeArea;

public class CodeAreaAction extends BaseAction implements ModelDriven<CodeArea> {

	private static final long serialVersionUID = 1L;

	private ICodeAreaDao codeAreaDao;

	CodeArea form = new CodeArea();

	@Override
	public CodeArea getModel() {
		return form;
	}

	public String queryProvince() {
		List<CodeArea> codeAreaList = codeAreaDao.findCodeAreaByPcode(form);
		form.setCodeAreaList(codeAreaList);
		return SUCCESS;
	}

	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}

}
