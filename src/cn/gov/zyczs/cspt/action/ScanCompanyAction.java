package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.IScanCompanyDao;
import cn.gov.zyczs.cspt.po.ScanCompany;

import com.opensymphony.xwork2.ModelDriven;
/**
 * @Title ScanCompanyAction.java
 * @Package
 * @version 1.0 
 * 手持机扫描企业action
 */
public class ScanCompanyAction extends BaseAction implements ModelDriven<ScanCompany>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ScanCompany form = new ScanCompany();
	
	@Override
	public ScanCompany getModel() {
		return form;
	}
	
	
	private IScanCompanyDao scanCompanyDao;//手持机扫描企业dao实现类
	public void setScanCompanyDao(IScanCompanyDao scanCompanyDao) {
		this.scanCompanyDao = scanCompanyDao;
	}
	
	/**
	 * 新增手持机扫描企业信息
	 * @return
	 */
	public void save(){
		Integer result = scanCompanyDao.save(form);
		if(result != 0){
			form.setReturninfo("新增成功");
		}else{
			form.setReturninfo("新增失败");
		}
	}
}
