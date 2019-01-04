package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IDailyCheckDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.DailyCheck;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;
/**
 * 日常检查action
 * @author Administrator
 *
 */
public class DailyCheckAction extends BaseAction implements ModelDriven<DailyCheck> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private DailyCheck form = new DailyCheck();
	
	@Override
	public DailyCheck getModel() {
		return form;
	}
	
	private IDailyCheckDao dailyCheckDao;//日常检查dao
	public void setDailyCheckDao(IDailyCheckDao dailyCheckDao) {
		this.dailyCheckDao = dailyCheckDao;
	}
	

	/**
	 * 新增日常检查
	 */
	public String save(){
		dailyCheckDao.save(form);
		return SUCCESS;
	}
	
	/**
	 * 日常检查分页查询
	 */
	public String findByList(){
		User user = (User)getSession().getAttribute("User");
		Org org = user.getOrg();
		//如果org不为空,则证明非admin用户登录
		if(org != null){
			form.setSupercpccorp(org.getCpccorp());
		}
		form.setPager_openset(10);
		form.setPager_count(dailyCheckDao.findByCount(form));
		form.setList(dailyCheckDao.findByList(form));
		return "findByList";
	}
	
	/**
	 * 查询每种项目最近一次检查结果
	 * @return
	 */
	public String findByMaxDate(){
		form.setList(dailyCheckDao.findByMaxDate(form));
		return SUCCESS;
	}
	
	/**
	 * 根据id查询详细
	 * @return
	 */
	public String findById(){
		form.setForm(dailyCheckDao.findById(form.getId()));
		return "findById";
	}
}
