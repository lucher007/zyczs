package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.DocumentException;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.IExamineDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.ChengRate;
import cn.gov.zyczs.cspt.po.CodeArea;
import cn.gov.zyczs.cspt.po.CompanyRate;
import cn.gov.zyczs.cspt.po.Examine;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.User;
import cn.gov.zyczs.cspt.po.ZyczsXml;

import com.opensymphony.xwork2.ModelDriven;

public class ExamineAction  extends BaseAction implements ModelDriven<Examine> {
	Examine form = new Examine();
	@Override
	public Examine getModel() {
		return form;
	}
	
	private IExamineDao examineDao;
	
	public void setExamineDao(IExamineDao examineDao) {
		this.examineDao = examineDao;
	}
	/**
	 * 行政区划dao
	 */
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}
	
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	/**
	 * 地区绩效考核录入
	 * @return
	 * @throws IOException 
	 * @throws DocumentException 
	 */
	@SuppressWarnings("unchecked")
	public String save(){
		User _user = (User)getSession().getAttribute("User");
		form.setAreas(form.getProvince()+form.getCity()+form.getArea());
		
		if (examineDao.findByExist(form)>0) {
			form.setReturninfo("该区域已经存在,请重新添加");
			return "save";
		}	
		
		//地区编码、将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());
		String areacode = codeAreaDao.findByName(codeArea);	
		form.setAreacode(areacode);
		examineDao.save(form);
		
		form.setArea("");
		form.setReturninfo("添加成功!");
		return "save";
	}
	
	/**
	 * 地区绩效考核查询
	 * @return String
	 */
    public String findByList(){
		User user = (User)getSession().getAttribute("User");	

		form.setPager_openset(10);     //一页显示10行
		form.setFlag(0);
		form.setPager_count(examineDao.findByCount(form));
		form.setList(examineDao.findByList(form));
		
		return "success";
	}
    
    public String findById(){
		form.setExamine(examineDao.findById(form.getId()));
		return "update";
	}
    
  
	public String update(){
		if(examineDao.updateById(form)!=0){			
			form.setReturninfo("更新成功!");
		}else{
			form.setReturninfo("更新失败!");
		}
		findById();
		return "update";
	}
	
	public String deleteObject(){		
		if(examineDao.deleteById(form.getId())==0){
			form.setReturninfo("删除失败!");
		}
		findByList();
		return "success";
	}
	
	/**
	 * 地区绩效考核查询
	 * @return String
	 */
    public String calculateList(){
		User user = (User)getSession().getAttribute("User");	
		if(form.getYear()==null){
			Calendar now = Calendar.getInstance();
			form.setYear(now.get(Calendar.YEAR));
			int month = now.get(Calendar.MONTH) + 1;
			if(month == 1 || month ==2 || month ==3){
				form.setQuarter(1);
			}
			else if(month == 4 || month ==5 || month ==6){
				form.setQuarter(2);
			}
			else if(month == 7 || month ==8 || month ==9){
				form.setQuarter(3);
			}
			else if(month == 10 || month ==11 || month ==12){
				form.setQuarter(4);
			}
		}
		Map map = new HashMap();
		map.put("year", form.getYear());
		map.put("quarter", form.getQuarter());
		form.setList(examineDao.findByCalculateList(map));

		return "calculate";
	}
    
    public String calculate(){
		User user = (User)getSession().getAttribute("User");	
		if(form.getList()!=null){
			for(Examine vo:form.getList()){
				if(vo.getUpdateorinsert().equals(0)){
					vo.setYear(form.getYear());
					vo.setQuarter(form.getQuarter());
					examineDao.save(vo);
				}else{
					examineDao.updateById(vo);
				}
			}
		}
		
		List<CompanyRate> detailList=examineDao.companyrateList(form);
		
		
		
		this.getRequest().getSession().setAttribute("detailList", detailList);
//		this.getRequest().setAttribute("detailList", detailList);
		//记录操作日志
		OpLog opLog=new OpLog();
		opLog.setSysid(7);
		opLog.setMethod("考核计算");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent(form.getYear()+"年"+form.getQuarter()+"季度");
		opLogDao.saveOjbect(opLog);
		return "detail";
	}
    
    public String home(){
		User user = (User)getSession().getAttribute("User");		
		if(form.getYear()==null){
			Calendar now = Calendar.getInstance();
			form.setYear(now.get(Calendar.YEAR));
			int month = now.get(Calendar.MONTH) + 1;
			if(month == 1 || month ==2 || month ==3){
				form.setQuarter(1);
			}
			else if(month == 4 || month ==5 || month ==6){
				form.setQuarter(2);
			}
			else if(month == 7 || month ==8 || month ==9){
				form.setQuarter(3);
			}
			else if(month == 10 || month ==11 || month ==12){
				form.setQuarter(4);
			}
		}
		
		List<CompanyRate> detailList=examineDao.companyrateList(form);
		
		
		this.getRequest().setAttribute("detailList", detailList);
	
		return "home";
	}
    
    public String createXml(){
		User user = (User)getSession().getAttribute("User");	
		List<CompanyRate> detailList= (List<CompanyRate>)getSession().getAttribute("detailList");
		if(detailList!=null&&detailList.size()>0){
			
			StringBuffer xml = new StringBuffer();	
			
			StringBuffer rate1 = new StringBuffer();	
			StringBuffer rate2 = new StringBuffer();
			StringBuffer rate3 = new StringBuffer();
			
			xml.append("<msgbody msgtype=\"performance\">");
			xml.append("<checkcycle desc=\"考核周期\">"+form.getYear()+"0"+form.getQuarter()+"</checkcycle>");
			//清除掉历史统计率
			examineDao.deleteRateByYQ(form.getYear(),form.getQuarter());
			
			for(CompanyRate rate:detailList){
				//企业覆盖率
				if(rate.getRatetype()!=null&&rate.getRatetype()==1){					
					rate1.append("<compfgl>");
					rate1.append("<areacode desc=\"地区编码\">"+rate.getAreacode()+"</areacode>");
					rate1.append("<zzjd desc=\"种植基地\">"+rate.getMedrate()+"</zzjd>");
					rate1.append("<zycjyqy desc=\"中药材经销企业\">"+rate.getMedsellrate()+"</zycjyqy>");
					rate1.append("<zyscjyqy desc=\"专业市场经营企业\">"+rate.getMedmarketrate()+"</zyscjyqy>");					
					rate1.append("<ypscqy desc=\"饮片生产企业\">"+rate.getTabletrate()+"</ypscqy>");
					rate1.append("<ypjyqy desc=\"饮片经销企业\">"+rate.getTabletsellrate()+"</ypjyqy>");
					rate1.append("<ypsydw desc=\"饮片使用单位\">"+rate.getTablethosprate()+"</ypsydw>");
					rate1.append("<total desc=\"综合\">"+rate.getAvgrate()+"</total>");
					rate1.append("</compfgl>");
					examineDao.saveRate(rate);
				}
				//企业流通率
				else if(rate.getRatetype()!=null&&rate.getRatetype()==2){
					
					rate2.append("<zssyl desc=\"追溯环节使用率\">");
					rate2.append("<areacode desc=\"地区编码\">"+rate.getAreacode()+"</areacode>");
					rate2.append("<zzjd desc=\"种植基地\">"+rate.getMedrate()+"</zzjd>");
					rate2.append("<zycjyqy desc=\"中药材经销企业\">"+rate.getMedsellrate()+"</zycjyqy>");
					rate2.append("<zyscjyqy desc=\"专业市场经营企业\">"+rate.getMedmarketrate()+"</zyscjyqy>");
					rate2.append("<ypscqy desc=\"饮片生产企业\">"+rate.getTabletrate()+"</ypscqy>");
					rate2.append("<ypjyqy desc=\"饮片经销企业\">"+rate.getTabletsellrate()+"</ypjyqy>");
					rate2.append("<ypsydw desc=\"饮片使用单位\">"+rate.getTablethosprate()+"</ypsydw>");
					rate2.append("<total desc=\"综合\">"+rate.getAvgrate()+"</total>");		
					rate2.append("</zssyl>");
					examineDao.saveRate(rate);
				}
				//溯源秤使用率
				else if(rate.getRatetype()!=null&&rate.getRatetype()==3){				
					rate3.append("<sycsyl desc=\"溯源秤使用率\">");
					rate3.append("<areacode desc=\"地区编码\">"+rate.getAreacode()+"</areacode>");
					rate3.append("<aczyscjyqy desc=\"案秤-专业市场经营企业\">"+rate.getMedrate()+"</aczyscjyqy>");
					rate3.append("<tczzjd desc=\"台秤-种植基地\">"+rate.getMedsellrate()+"</tczzjd>");
					rate3.append("<tczycjyqy desc=\"台秤-中药材经销企业\">"+rate.getMedmarketrate()+"</tczycjyqy>");
					rate3.append("<tczyscjyqy desc=\"台秤-专业市场经营企业\">"+rate.getTabletrate()+"</tczyscjyqy>");
					rate3.append("</sycsyl>");
					examineDao.saveRate(rate);
				}
			}
			
			if(rate1!=null&&!rate1.toString().equals("")){
				xml.append("<compfgls desc=\"企业覆盖率\">");
				xml.append(rate1);
				xml.append("</compfgls>");
			}
			
			if(rate2!=null&&!rate2.toString().equals("")){
				xml.append("<zssyls desc=\"追溯环节使用率\">");
				xml.append(rate2);
				xml.append("</zssyls>");
			}
			
			if(rate3!=null&&!rate3.toString().equals("")){
				xml.append("<sycsyls desc=\"溯源秤使用率\">");
				xml.append(rate3);
				xml.append("</sycsyls>");
			}
			
			
			xml.append("</msgbody>");
			
			System.out.println("xml=="+xml.toString());
			ZyczsXml zyczsXml = new ZyczsXml();
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(user.getLoginname());
		   zyczsXml.setState(0);
		   zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			//成功入库溯源码异步上传中央平台
			zyczsXmlDao.saveOjbect(zyczsXml);
			
			this.getRequest().getSession().removeAttribute("detailList");
		}
		//记录操作日志
		OpLog opLog=new OpLog();
		opLog.setSysid(7);
		opLog.setMethod("考核结果保存");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent(form.getYear()+"年"+form.getQuarter()+"季度");
		opLogDao.saveOjbect(opLog);
		form.setReturninfo("保存成功！");
		return "calculateFinish";
	}

	

}
