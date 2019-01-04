package cn.gov.zyczs.cspt.action;

import java.util.List;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IScoreDeductDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.ScoreDeduct;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class ScoreDeductAction extends BaseAction implements ModelDriven<ScoreDeduct> {
	ScoreDeduct form = new ScoreDeduct();
	@Override
	public ScoreDeduct getModel() {
		return form;
	}
	private IScoreDeductDao scoreDeductDao;
	public void setScoreDeductDao(IScoreDeductDao scoreDeductDao) {
		this.scoreDeductDao = scoreDeductDao;
	}
	private IOrgDao orgDao;
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	
	public String findByList(){
		Org org = new Org();
		org.setOrgid(form.getOrgid());
		form.setOrg(orgDao.findById(org));
		String chooseTime = form.getAddtime().substring(0,4);
		if(chooseTime.equals(Tools.getLastYear())){
			form.setAddtime(chooseTime+"-01-01 00:00:00");
			form.setEndtime(null);
		}else{
			form.setAddtime(chooseTime+"-01-01 00:00:00");
			form.setEndtime(chooseTime+"-12-31 23:59:59");
		}
		form.setPager_openset(10);
		form.setPager_count(scoreDeductDao.findByCount(form));
		form.setScoredeductlist(scoreDeductDao.findByList(form));
		return SUCCESS;
	}
	
	public String saveInit(){
		Org org = new Org();
		org.setOrgid(form.getOrgid());
		form.setOrg(orgDao.findById(org));
		return "save";
	}
	
	public String save(){
		if(scoreDeductDao.save(form)!=0){
			User _user = (User)getSession().getAttribute("User");
			Org org = new Org();
			org.setOrgid(form.getOrgid());
			org=orgDao.findById(org);
			zyczsXmlDao.saveOjbect(ToolsXml.create_scoreDeduct(form,org,_user));
			form.setReturninfo("扣分成功!");
		}else{
			form.setReturninfo("扣分失败!");
		}
		return "save";
	}
	
	public String saveChoose(){
		if(scoreDeductDao.save(form)!=0){
			User _user = (User)getSession().getAttribute("User");
			Org org = new Org();
			org.setOrgid(form.getOrgid());
			org=orgDao.findById(org);
			zyczsXmlDao.saveOjbect(ToolsXml.create_scoreDeduct(form,org,_user));
			form.setReturninfo("扣分成功!");
		}else{
			form.setReturninfo("扣分失败!");
		}
		return "savechoose";
	}
	
	public String companyChoice(){
		Org org = new Org();
		org.setOrgname(form.getOrgname());
		org.setState(1);//企业必须为审核企业
		org.setPager_openset(5);//一页显示5行
		org.setPager_offset(form.getPager_offset());
		form.setPager_count(orgDao.findByCount_companystate(org));
		form.setOrglist(orgDao.findByList_companystate(org));
		return "companyChoice";
	}
	
	public String findByListSelectAll(){
		form.setPager_openset(10);
		form.setPager_count(scoreDeductDao.findByCountSelectAll(form));
		form.setScoredeductlist(scoreDeductDao.findByListSelectAll(form));
		return "selectall";
	}
}
