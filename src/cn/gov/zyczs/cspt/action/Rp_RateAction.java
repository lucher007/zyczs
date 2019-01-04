package cn.gov.zyczs.cspt.action;

import java.util.ArrayList;
import java.util.List;

import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IRp_RateDao;
import cn.gov.zyczs.cspt.dao.impl.Rp_RateDao;
import cn.gov.zyczs.cspt.po.Rp_Rate;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class Rp_RateAction extends BaseAction implements ModelDriven<Rp_Rate>{
	
	Rp_Rate form=new Rp_Rate();
	
	private IRp_RateDao rp_RateDao;


	public void setRp_RateDao(Rp_RateDao rp_RateDao) {
		this.rp_RateDao = rp_RateDao;
	}

	@Override
	public Rp_Rate getModel() {
		// TODO Auto-generated method stub
		return form;
	}

	//企业使用率
	public String companyUseRate(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
		
		int m=13;
		if(form.getYear()==null){
			form.setYear(Tools.getDateYear());
		}
		
		for(int i=1;i<m;i++){
			//当月企业总数
			String lastTime=Tools.lastDayOfMonth(form.getYear()+"-"+i+"-"+"01");
			Integer total=rp_RateDao.findCompTotalByMonth(lastTime+" 23:59:59");
			
			String month=form.getYear();
			if(i<10){
				month=form.getYear()+"-0"+i;
			}else{
				month=form.getYear()+"-"+i;
			}
			//当月企业使用数
			Integer curTotal=0;	
			curTotal=rp_RateDao.findCompCurTotalByMonth(month);
			if(curTotal==null){
				curTotal=0;
			}

			Rp_Rate v=new Rp_Rate();
			v.setMonth(i+"月");
			v.setTotal(total);
			v.setCurTotal(curTotal);
			list.add(v);
		}
		form.setList(list);
		return "compUseRate";
	}
	//导出excel
	public String companyUseRate_excel(){
		
		return "";
	}
	
	//企业使用率--同比
	public String companyUseRate_double(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
		List<Rp_Rate> list2=new ArrayList<Rp_Rate>();
		int m=13;
		
		
		if(form.getYear()==null){
			form.setYear(Tools.getDateYear());
		}
		
		for(int i=1;i<m;i++){
			//当月企业总数
			String lastTime=Tools.lastDayOfMonth(form.getYear()+"-"+i+"-"+"01");
			Integer total=rp_RateDao.findCompTotalByMonth(lastTime+" 23:59:59");
			
			String month=form.getYear();
			if(i<10){
				month=form.getYear()+"-0"+i;
			}else{
				month=form.getYear()+"-"+i;
			}
			//当月企业使用数
			Integer curTotal=0;	
			curTotal=rp_RateDao.findCompCurTotalByMonth(month);
			if(curTotal==null){
				curTotal=0;
			}

			Rp_Rate v=new Rp_Rate();
			v.setMonth(i+"月");
			v.setTotal(total);
			v.setCurTotal(curTotal);
			list.add(v);
		}
		form.setList(list);
		
		//===============================
		
		
		

		if(form.getYear2()==null){
			int y=Integer.parseInt(Tools.getDateYear());
			y=y-1;
			form.setYear2(String.valueOf(y));
		}
		
		for(int j=1;j<m;j++){
			//当月企业总数
			String lastTime=Tools.lastDayOfMonth(form.getYear2()+"-"+j+"-"+"01");
			Integer total=rp_RateDao.findCompTotalByMonth(lastTime+" 23:59:59");
			
			String month=form.getYear2();
			if(j<10){
				month=form.getYear2()+"-0"+j;
			}else{
				month=form.getYear2()+"-"+j;
			}
			//当月企业使用数
			Integer curTotal=0;	
			curTotal=rp_RateDao.findCompCurTotalByMonth(month);
			if(curTotal==null){
				curTotal=0;
			}

			Rp_Rate v=new Rp_Rate();
			
			v.setMonth(j+"月");
			v.setTotal(total);
			v.setCurTotal(curTotal);
			list2.add(v);
		}
		form.setList2(list2);
		
		
		return "compUseRate_double";
	}
	
	//企业使用率--同比
	public String companyUseRate_month(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
	
		
		if(form.getMonth()==null){
			form.setMonth(Tools.getDateMonthStr());
		}
		
		
			//当月企业总数
			String lastTime=Tools.lastDayOfMonth(form.getMonth()+"-01");
			Integer total=rp_RateDao.findCompTotalByMonth(lastTime+" 23:59:59");
			
			
			//当月企业使用数
			Integer curTotal=0;	
			curTotal=rp_RateDao.findCompCurTotalByMonth(form.getMonth());
			if(curTotal==null){
				curTotal=0;
			}

			Rp_Rate v=new Rp_Rate();
			v.setMonth(form.getMonth());
			v.setTotal(total);
			v.setCurTotal(curTotal);
			list.add(v);
	
		form.setList(list);
		
		
		
		
		return "compUseRate_month";
	}
	
	/*
	 * 溯源药材入库所占比
	 */
	public String medTypeRate(){
		
		if(form.getMonth()==null){
			form.setMonth(Tools.getDateMonthStr());
		}
		form.setList(rp_RateDao.findMedTypeByMonth(form.getMonth()));
		return "medTypeRate";
	}
	
	public String medTypeRate_excel(){
		return "";
	}
	
	/*
	 * 溯源秤交易量
	 */
	public String chengData(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
		
		int m=13;
		if(form.getYear()==null){
			form.setYear(Tools.getDateYear());
		}
		
		for(int i=1;i<m;i++){
			//当月企业总数	
			Rp_Rate v=rp_RateDao.findChengData(form.getYear()+"-"+i);
			v.setMonth(form.getYear()+"-"+i);
			list.add(v);
		}
		form.setList(list);
		return "chengData";
	}
	
	public String chengData_excel(){
		
		return "chengData";
	}
	
	/*
	 * 溯源秤交易次数
	 */
	public String chengCount(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
		
		int m=13;
		if(form.getYear()==null){
			form.setYear(Tools.getDateYear());
		}
		
		for(int i=1;i<m;i++){
			//当月企业总数	
			Rp_Rate v=rp_RateDao.findChengCount(form.getYear()+"-"+i);
			v.setMonth(form.getYear()+"-"+i);
			list.add(v);
		}
		form.setList(list);
		return "chengCount";
	}
	
	public String chengCount_excel(){
		
		return "chengData";
	}
	
	/*
	 * 商户数
	 */

	public String shopsData(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
		
		int m=13;
		if(form.getYear()==null){
			form.setYear(Tools.getDateYear());
		}
		
		for(int i=1;i<m;i++){
			//当月企业总数	
			Rp_Rate v=rp_RateDao.findShopsData(form.getYear()+"-"+i);
			v.setMonth(form.getYear()+"-"+i);
			list.add(v);
		}
		form.setList(list);
		return "shopsData";
	}
	
	public String shopsData_excel(){
		
		return "";
	}
	
	/*
	 * 溯源药材销售量
	 */
	public String medSellData(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
		
		int m=13;
		if(form.getYear()==null){
			form.setYear(Tools.getDateYear());
		}

		for(int i=1;i<m;i++){
			//当月企业总数	
			Rp_Rate v=rp_RateDao.findMedSellData(form.getYear()+"-"+i);
			v.setMonth(form.getYear()+"-"+i);
			list.add(v);
		}
		form.setList(list);
		return "medSellData";
	}
	
	/*
	 * 主要药材实际产出与预计产出比较
	 */
	public String medContrast(){
		List<Rp_Rate> list=new ArrayList<Rp_Rate>();
		
		if(form.getYear()==null){
			form.setYear(Tools.getDateYear());
		}
		
		User user = (User) getSession().getAttribute("User");
		//林业局统计
		if("linye".equals(user.getLoginname())){ 
			String plantname = ToolSql.getXmlValueFromKey(user.getLoginname());
			String[] pname=plantname.split(",");
			for(int i=0;i<pname.length;i++){
				Rp_Rate v=rp_RateDao.findMedContrast(form.getYear(), pname[i]);
				list.add(v);
			}

		}
		//农业局统计
		else if("nongye".equals(user.getLoginname())){ //林业局统计
			String plantname = ToolSql.getXmlValueFromKey(user.getLoginname());
			String[] pname=plantname.split(",");
			for(int i=0;i<pname.length;i++){
				Rp_Rate v=rp_RateDao.findMedContrast(form.getYear(), pname[i]);
				list.add(v);
			}

		}else{
			//系统默认
			for(int i=1;i<6;i++){
				String med=this.getRequest().getParameter("med"+i);
				if(med!=null&&!med.equals("")){
					Rp_Rate v=rp_RateDao.findMedContrast(form.getYear(), med);
					
					System.out.println(v.getTotal()+"==========="+v.getCurTotal());
					list.add(v);
				}
			}		
			
		}
		
		
		
		form.setList(list);
		return "medContrast";
	}
	
	
	
}
