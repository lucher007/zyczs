package cn.gov.zyczs.cspt.action;


import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IRp_BuildDao;
import cn.gov.zyczs.cspt.dao.impl.Rp_BuildDao;
import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.ChengConf;
import cn.gov.zyczs.cspt.po.Rp_Build;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

@SuppressWarnings("serial")
public class Rp_BuildAction extends BaseAction implements ModelDriven<Rp_Build>{
	
	Rp_Build form = new Rp_Build();
	@Override
	public Rp_Build getModel() {
		return form;
	}
	
	private IRp_BuildDao rp_buildDao;
	public void setRp_BuildDao(Rp_BuildDao rp_buildDao) {
		this.rp_buildDao = rp_buildDao;
	}
     
	InputStream inputStream;
	public InputStream getInputStream() throws Exception { 
		return inputStream;
	}

	//平台建设-页面报表展示
	public String platformBuildStat(){
		form.setBuildlist(rp_buildDao.findPlatformBuildStat(form));
		return "platformBuildStat";
	}
	
	public String platformBuildQuery(){
		form.setBuildlist(rp_buildDao.findPlatformBuildStat(form));
		return "platformBuildQuery";
	}
	
	//平台建设-导出excel
	public String platformBuildStat_excel(){
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			List<Rp_Build> buildlist = rp_buildDao.findPlatformBuildStat(form);
			//EXCEL头
			String[] buildTitle = {"企业类型","数量(单位:户)"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			for(int j=0; buildlist!= null && j<buildlist.size(); j++){
				String orgname = "";
				if("10000000".equals(buildlist.get(j).getZyctype())){
					orgname = "药材种植";
				}else if ("01000000".equals(buildlist.get(j).getZyctype())){
					orgname = "药材经销";
				}else if ("00100000".equals(buildlist.get(j).getZyctype())){
					orgname = "饮片生产";
				}else if ("00010000".equals(buildlist.get(j).getZyctype())){
					orgname = "饮片经销";
				}else if ("00001000".equals(buildlist.get(j).getZyctype())){
					orgname = "药材市场";
				}else if ("01000000-".equals(buildlist.get(j).getZyctype())){
					orgname = "市场经营户";
				}else if ("00000100".equals(buildlist.get(j).getZyctype())){
					orgname = "医院药店";
				}else if ("00000010".equals(buildlist.get(j).getZyctype())){
					orgname = "管理机构";
				}
				
				
				
				Label label1 = new Label(0,j+1, orgname);
				sheet.addCell(label1);
				Label label2 = new Label(1,j+1, buildlist.get(j).getNum().toString());
				sheet.addCell(label2);					
			}
			
			workbook.write();
            workbook.close();
            form.setFilename(new String("平台各类型企业统计.xls".getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		
		return "platformBuildStat_excel";
	}
	
	//溯源秤分发-页面报表展示
	public String chengSendStat(){
		Integer plansendnum = 2000; //默认计划发送溯源秤为2000
		if(form.getPlansendnum() == null || form.getPlansendnum() == 0){
			String strplansendnum = ToolSql.getXmlValueFromKey("chengSendNum");
			if(!"".equals(strplansendnum)){
				plansendnum = Integer.valueOf(strplansendnum);
			}
		}else{
			plansendnum = form.getPlansendnum();
		}
		form.setPlansendnum(plansendnum);
		Rp_Build sendbuild = rp_buildDao.findChengSendStat(form);
		Double  rate = new Double(0);
		
		if(sendbuild != null && sendbuild.getNum() != null){
			rate = Double.valueOf(sendbuild.getNum().doubleValue()/plansendnum.doubleValue());
			sendbuild.setRate(rate);
		}
		form.setBuild(sendbuild);
		return "chengSendStat";
	}
	
	
	//溯源秤分发-导出excel
	public String chengSendStat_excel(){
		
		return "chengSendStat_excel";
	}
	
	//溯源秤开机-页面报表展示
	public String chengStartStat(){
		Rp_Build buildSend = rp_buildDao.findChengSendStat(new Rp_Build());
		Rp_Build buildStart = rp_buildDao.findChengStartStat(form);
		Double  rate = new Double(0);
		if(buildSend != null && buildSend.getNum() != 0 && buildStart != null){
			rate = Double.valueOf(buildStart.getNum().doubleValue()/buildSend.getNum().doubleValue());
		}
		
		Rp_Build build = new Rp_Build();
		build.setRate(rate);
		
		form.setBuild(build);
		return "chengStartStat";
	}
	
	
	//溯源秤开机数-导出excel
	public String chengStartStat_excel(){
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			List<Rp_Build> buildlist = rp_buildDao.findChengStartStat_excel(form);
			String[] buildTitle = {"企业名称","联系方式","开机次数"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			for(int j=0; buildlist!= null && j<buildlist.size(); j++){
				Label label1 = new Label(0,j+1, buildlist.get(j).getOrgname());
				sheet.addCell(label1);
				Label label2 = new Label(1,j+1, buildlist.get(j).getMobile());
				sheet.addCell(label2);					
				Label label3 = new Label(2,j+1, String.valueOf(buildlist.get(j).getNum()));
				sheet.addCell(label3);					
			}
			
			workbook.write();
            workbook.close();
            form.setFilename(new String("溯源秤开机次数.xls".getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		
		
		return "chengStartStat_excel";
	}
	
	//溯源秤使用-页面报表展示
	public String chengUserStat(){
		Rp_Build buildSend = rp_buildDao.findChengSendStat(new Rp_Build());
		Rp_Build buildUser = rp_buildDao.findChengUserStat(form);
		Double  rate = new Double(0);
		if(buildSend != null && buildSend.getNum() != 0 && buildUser != null){
			rate = Double.valueOf(buildUser.getNum().doubleValue()/buildSend.getNum().doubleValue());
		}
		
		Rp_Build build = new Rp_Build();
		build.setRate(rate);
		
		form.setBuild(build);
		return "chengUserStat";
	}
	
	
	//溯源秤使用-导出excel
	public String chengUserStat_excel(){
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			List<Rp_Build> buildlist = rp_buildDao.findChengUserStat_excel(form);
			String[] buildTitle = {"企业名称","联系方式","使用次数"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			for(int j=0; buildlist!= null && j<buildlist.size(); j++){
				Label label1 = new Label(0,j+1, buildlist.get(j).getOrgname());
				sheet.addCell(label1);
				Label label2 = new Label(1,j+1, buildlist.get(j).getMobile());
				sheet.addCell(label2);					
				Label label3 = new Label(2,j+1, String.valueOf(buildlist.get(j).getNum()));
				sheet.addCell(label3);					
			}
			
			workbook.write();
            workbook.close();
            form.setFilename(new String("溯源秤使用次数.xls".getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		
		
		return "chengUserStat_excel";
	}
	
	//溯源药材统计-页面报表展示
	public String formalMedStat(){
		form.setBuildlist(rp_buildDao.findFormalMedStat(form));
		return "formalMedStat";
	}
	
	
	//溯源药材统计-导出excel
	public String formalMedStat_excel(){
		
		return "formalMedStat_excel";
	}
    
	
	//种子种苗所占比统计-页面报表展示
	public String plantSourceStat(){
		String plantname = "";
		User user = (User) getSession().getAttribute("User");
		if("linye".equals(user.getLoginname())){ //林业局统计
			plantname = ToolSql.getXmlValueFromKey(user.getLoginname());
			form.setPlantname(plantname.replaceAll(",", "','"));
			form.setUsername("-林业局");
		}else if("nongye".equals(user.getLoginname())){//农业局统计
			plantname = ToolSql.getXmlValueFromKey(user.getLoginname());
			form.setPlantname(plantname.replaceAll(",", "','"));
			form.setUsername("-农业局");
		}
		
		form.setBuild(rp_buildDao.findPlantSourceStat(form));
		
		form.setPlantname(plantname);//页面显示种植名称
		
		return "plantSourceStat";
	}
	
	
	//种子种苗所占比统计-导出excel
	public String plantSourceStat_excel(){
		
		return "plantSourceStat_excel";
	}
	
	//中药材流通追溯交易次数统计-页面报表展示
	public String tradeTimesStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findTradeTimesStat(form);
		Map<String,Integer> buildmap = new HashMap<String,Integer>(); 
		for (Rp_Build rpBuild : buildlist) {
			buildmap.put(rpBuild.getOpertime(), rpBuild.getTradetimes());
		}
		form.setBuildmap(buildmap);
		return "tradeTimesStat";
	}
	
	
	//中药材流通追溯交易次数统计-导出excel
	public String tradeTimesStat_excel(){
		
		return "tradeTimesStat_excel";
	}
	
	//中药材流通追溯交易次数同比-页面报表展示
	public String tradeTimesContrastStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findTradeTimesStat(form);
		Map<String,Integer> buildmap = new HashMap<String,Integer>(); 
		for (Rp_Build rpBuild : buildlist) {
			buildmap.put(rpBuild.getOpertime(), rpBuild.getTradetimes());
		}
		form.setBuildmap(buildmap);
		
		
		//设置上一年的查询时间
		Integer opertime_constrast = Integer.parseInt(opertime) - 1;
		form.setOpertime(String.valueOf(opertime_constrast));
		List<Rp_Build> buildconstrastlist = rp_buildDao.findTradeTimesStat(form);
		Map<String,Integer> buildconstrastmap = new HashMap<String,Integer>(); 
		for (Rp_Build rpBuild : buildconstrastlist) {
			buildconstrastmap.put(rpBuild.getOpertime(), rpBuild.getTradetimes());
		}
		form.setBuildcontrastmap(buildconstrastmap);
		
		//在重新设置页面的查询时间参数
		form.setOpertime(opertime);
		
		return "tradeTimesContrastStat";
	}
	
	
	//中药材流通追溯交易次数同比-导出excel
	public String tradeTimesContrastStat_excel(){
		
		return "tradeTimesContrastStat_excel";
	}
	
	//中药材流通追溯交易次数按月份统计-页面报表展示
	public String tradeTimesByMonthStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年当月
			form.setOpertime(findYearMonth());
		}
		
		form.setBuild(rp_buildDao.findTradeTimesByMonthStat(form));
		
		return "tradeTimesByMonthStat";
	}
	
	
	//中药材流通追溯交易次数按月份统计-导出excel
	public String tradeTimesByMonthStat_excel(){
		
		return "tradeTimesByMonthStat_excel";
	}
	
	//中药材流通追溯交易重量统计-页面报表展示
	public String tradeWeightStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findTradeTimesStat(form);
		Map<String,Number> tradeweightmap = new HashMap<String,Number>(); 
		for (Rp_Build rpBuild : buildlist) {
			tradeweightmap.put(rpBuild.getOpertime(), rpBuild.getTradeweight());
		}
		form.setTradeweightmap(tradeweightmap);
		return "tradeWeightStat";
	}
	
	
	//中药材流通追溯交易重量统计-导出excel
	public String tradeWeightStat_excel(){
		
		return "tradeWeightStat_excel";
	}
	
	//中药材流通追溯交易重量同比-页面报表展示
	public String tradeWeightContrastStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findTradeTimesStat(form);
		Map<String,Number> tradeweightmap = new HashMap<String,Number>();
		for (Rp_Build rpBuild : buildlist) {
			tradeweightmap.put(rpBuild.getOpertime(), rpBuild.getTradeweight());
		}
		form.setTradeweightmap(tradeweightmap);
		
		
		//设置上一年的查询时间
		Integer opertime_constrast = Integer.parseInt(opertime) - 1;
		form.setOpertime(String.valueOf(opertime_constrast));
		List<Rp_Build> buildconstrastlist = rp_buildDao.findTradeTimesStat(form);
		Map<String,Number> tradeweightconstrastmap = new HashMap<String,Number>(); 
		for (Rp_Build rpBuild : buildconstrastlist) {
			tradeweightconstrastmap.put(rpBuild.getOpertime(), rpBuild.getTradeweight());
		}
		form.setTradeweightcontrastmap(tradeweightconstrastmap);
		
		//在重新设置页面的查询时间参数
		form.setOpertime(opertime);
		
		return "tradeWeightContrastStat";
	}
	
	
	//中药材流通追溯交易重量同比-导出excel
	public String tradeWeightContrastStat_excel(){
		return "tradeWeightContrastStat_excel";
	}
	
	
	//中药材流通追溯打码数量统计-页面报表展示
	public String codeNumStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findCodeNumStat(form);
		Map<String,Integer> buildmap = new HashMap<String,Integer>(); 
		for (Rp_Build rpBuild : buildlist) {
			buildmap.put(rpBuild.getOpertime(), rpBuild.getCodenum());
		}
		form.setBuildmap(buildmap);
		return "codeNumStat";
	}
	
	//中药材流通追溯打码数量按月份统计-导出excel
	public String codeNumStat_excel(){
		
		return "codeNumStat_excel";
	}
	

	//中药材流通追溯打码数量同比-页面报表展示
	public String codeNumContrastStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findCodeNumStat(form);
		Map<String,Integer> buildmap = new HashMap<String,Integer>(); 
		for (Rp_Build rpBuild : buildlist) {
			buildmap.put(rpBuild.getOpertime(), rpBuild.getCodenum());
		}
		form.setBuildmap(buildmap);
		
		
		//设置上一年的查询时间
		Integer opertime_constrast = Integer.parseInt(opertime) - 1;
		form.setOpertime(String.valueOf(opertime_constrast));
		List<Rp_Build> buildconstrastlist = rp_buildDao.findCodeNumStat(form);
		Map<String,Integer> buildconstrastmap = new HashMap<String,Integer>(); 
		for (Rp_Build rpBuild : buildconstrastlist) {
			buildconstrastmap.put(rpBuild.getOpertime(), rpBuild.getCodenum());
		}
		form.setBuildcontrastmap(buildconstrastmap);
		
		//在重新设置页面的查询时间参数
		form.setOpertime(opertime);
		
		return "codeNumContrastStat";
	}
	
	
	//中药材流通追溯打码数量同比-导出excel
	public String codeNumContrastStat_excel(){
		
		return "codeNumContrastStat_excel";
	}
	
	//中药材饮片打码数量比按月份统计-页面报表展示
	public String codeNumByMonthStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年当月
			form.setOpertime(findYearMonth());
		}
		
		form.setBuild(rp_buildDao.findCodeNumByMonthStat(form));
		
		return "codeNumByMonthStat";
	}
	
	
	//中药材饮片打码数量比按月份统计-导出excel
	public String codeNumByMonthStat_excel(){
		
		return "codeNumByMonthStat_excel";
	}
	
	
	//中药材流通追溯检验率统计-页面报表展示
	public String medCheckedStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findMedCheckedStat(form);
		Map<String,Double> checkedmap = new HashMap<String,Double>(); 
		for (Rp_Build rpBuild : buildlist) {
			checkedmap.put(rpBuild.getOpertime(), rpBuild.getCheckedrate());
		}
		form.setCheckedmap(checkedmap);
		return "medCheckedStat";
	}
	
	//中药材流通追溯检验率按月份统计-导出excel
	public String medCheckedStat_excel(){
		
		return "medCheckedStat_excel";
	}
	

	//中药材流通追溯检验率同比-页面报表展示
	public String medCheckedContrastStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		List<Rp_Build> buildlist = rp_buildDao.findMedCheckedStat(form);
		Map<String,Double> checkedmap = new HashMap<String,Double>(); 
		for (Rp_Build rpBuild : buildlist) {
			checkedmap.put(rpBuild.getOpertime(), rpBuild.getCheckedrate());
		}
		form.setCheckedmap(checkedmap);
		
		
		//设置上一年的查询时间
		Integer opertime_constrast = Integer.parseInt(opertime) - 1;
		form.setOpertime(String.valueOf(opertime_constrast));
		List<Rp_Build> checkedconstrastlist = rp_buildDao.findMedCheckedStat(form);
		Map<String,Double> checkedconstrastmap = new HashMap<String,Double>(); 
		for (Rp_Build rpBuild : checkedconstrastlist) {
			checkedconstrastmap.put(rpBuild.getOpertime(), rpBuild.getCheckedrate());
		}
		form.setCheckedcontrastmap(checkedconstrastmap);
		
		//在重新设置页面的查询时间参数
		form.setOpertime(opertime);
		
		return "medCheckedContrastStat";
	}
	
	
	//中药材流通追溯检验率同比-导出excel
	public String medCheckedContrastStat_excel(){
		
		return "medCheckedContrastStat_excel";
	}
	
	//中药材饮片检验率比按月份统计-页面报表展示
	public String medCheckedByMonthStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年当月
			form.setOpertime(findYearMonth());
		}
		
		form.setBuild(rp_buildDao.findMedCheckedByMonthStat(form));
		
		return "medCheckedByMonthStat";
	}
	
	
	//中药材饮片检验率比按月份统计-导出excel
	public String medCheckedByMonthStat_excel(){
		return "medCheckedByMonthStat_excel";
	}
	
	//流通追溯上传检验报告(合格)率统计-页面报表展示
	public String mattedStat(){
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		if("".equals(form.getChecktype()) || form.getChecktype() == null){
			form.setChecktype("0"); //默认查询药材
		}
		
		List<Rp_Build> buildlist = new ArrayList<Rp_Build>();
        if("0".equals(form.getChecktype())){
        	buildlist = rp_buildDao.findMedMattedStat(form);
		}else if("1".equals(form.getChecktype())){
			buildlist = rp_buildDao.findTabletMattedStat(form);
		}
		
        Map<String,Double> mattedmap = new HashMap<String,Double>(); 
		for (Rp_Build rpBuild : buildlist) {
			mattedmap.put(rpBuild.getOpertime(), rpBuild.getMattedrate());
		}
		form.setMattedmap(mattedmap);
		return "mattedStat";
	}
	
	//流通追溯上传检验报告(合格)率按月份统计-导出excel
	public String mattedStat_excel(){
		return "mattedStat_excel";
	}
	

	//流通追溯上传检验报告(合格)率同比-页面报表展示
	public String mattedContrastStat(){
		
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年
			opertime = String.valueOf(Calendar.getInstance().get(Calendar.YEAR));
			form.setOpertime(opertime);
		}
		
		if("".equals(form.getChecktype()) || form.getChecktype() == null){
			form.setChecktype("0"); //默认查询药材
		}
		
		List<Rp_Build> buildlist = new ArrayList<Rp_Build>();
        if("0".equals(form.getChecktype())){
        	buildlist = rp_buildDao.findMedMattedStat(form);
		}else if("1".equals(form.getChecktype())){
			buildlist = rp_buildDao.findTabletMattedStat(form);
		}
        
        Map<String,Double> mattedmap = new HashMap<String,Double>(); 
		for (Rp_Build rpBuild : buildlist) {
			mattedmap.put(rpBuild.getOpertime(), rpBuild.getMattedrate());
		}
		form.setMattedmap(mattedmap);
		
		
		//设置上一年的查询时间
		Integer opertime_constrast = Integer.parseInt(opertime) - 1;
		form.setOpertime(String.valueOf(opertime_constrast));
		
		
		List<Rp_Build> mattedconstrastlist = new ArrayList<Rp_Build>();
        if("0".equals(form.getChecktype())){
        	mattedconstrastlist = rp_buildDao.findMedMattedStat(form);
		}else if("1".equals(form.getChecktype())){
			mattedconstrastlist = rp_buildDao.findTabletMattedStat(form);
		}
		Map<String,Double> mattedconstrastmap = new HashMap<String,Double>(); 
		for (Rp_Build rpBuild : mattedconstrastlist) {
			mattedconstrastmap.put(rpBuild.getOpertime(), rpBuild.getMattedrate());
		}
		form.setMattedcontrastmap(mattedconstrastmap);
		
		//在重新设置页面的查询时间参数
		form.setOpertime(opertime);
		
		return "mattedContrastStat";
	}
	
	
	//流通追溯上传检验报告(合格)率同比-导出excel
	public String mattedContrastStat_excel(){
		return "mattedContrastStat_excel";
	}
	
	//流通追溯上传检验报告(合格)率比按月份统计-页面报表展示
	public String mattedByMonthStat(){
		String opertime = form.getOpertime();
		if(opertime == null || "".equals(opertime)){//页面查询时间默认为今年当月
			form.setOpertime(findYearMonth());
		}
		
		if("".equals(form.getChecktype()) || form.getChecktype() == null){
			form.setChecktype("0"); //默认查询药材
		}
		
		Rp_Build build = new Rp_Build();
        if("0".equals(form.getChecktype())){
        	build = rp_buildDao.findMedMattedByMonthStat(form);
		}else if("1".equals(form.getChecktype())){
			build = rp_buildDao.findTabletMattedByMonthStat(form);
		}
		
		form.setBuild(build);
		
		return "mattedByMonthStat";
	}
	
	
	//流通追溯上传检验报告(合格)率比按月份统计-导出excel
	public String mattedByMonthStat_excel(){
		
		return "mattedByMonthStat_excel";
	}
	
	//统计导出-库存和交易量查询
	public String storAndTradeQuery(){
		
	    //初始页面默认查询时间
		if(form.getOperstarttime() == null || "".equals(form.getOperstarttime()) ){
			form.setOperstarttime(findYearMonth()+"-01");
		}
		
        if(form.getOperendtime() == null || "".equals(form.getOperendtime()) ){
			form.setOperendtime(Tools.getDateMonthDayStrTwo());
		}
		
		form.setBuild(rp_buildDao.findStorAndTradeStat(form));
		return "storAndTradeQuery";
	}
	
	//统计导出-库存和交易量导出EXCEL
	public String storAndTradeStat_excel(){
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			Rp_Build build = rp_buildDao.findStorAndTradeStat(form);
			//EXCEL头
			String[] buildTitle = {"统计类型","数量(单位:Kg)"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			
				
				
			Label label_01 = new Label(0,1, "药材库存量");
			sheet.addCell(label_01);
			Label label_11 = new Label(1,1, (build.getMedstorweight()==null || build.getMedstorweight() == "")?"0":build.getMedstorweight());
			sheet.addCell(label_11);	
			
			Label label_02 = new Label(0,2, "饮片库存量");
			sheet.addCell(label_02);
			Label label_12 = new Label(1,2, (build.getTabletstorweight()==null || build.getTabletstorweight() == "")?"0":build.getTabletstorweight() );
			sheet.addCell(label_12);
			
			Label label_03 = new Label(0,3, "药材交易量");
			sheet.addCell(label_03);
			Label label_13 = new Label(1,3,(build.getMedtradeweight()==null || build.getMedtradeweight() == "")?"0":build.getMedtradeweight());
			sheet.addCell(label_13);
			
			Label label_04 = new Label(0,4, "饮片交易量");
			sheet.addCell(label_04);
			Label label_14 = new Label(1,4,(build.getTablettradeweight()==null || build.getTablettradeweight() == "")?"0":build.getTablettradeweight() );
			sheet.addCell(label_14);
			
			Label label_05 = new Label(0,5, "交易总量");
			sheet.addCell(label_05);
			Label label_15 = new Label(1,5,(build.getTotaltradeweight()==null || build.getTotaltradeweight() == "")?"0":build.getTotaltradeweight());
			sheet.addCell(label_15);
			
			workbook.write();
            workbook.close();
            form.setFilename(new String("库存和交易量统计.xls".getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		return "storAndTradeStat_excel";
	}
	
	/**
	 * 查询市场用户发秤信息
	 */
	public String marketUserByChengQuery(){
		
		form.setPager_openset(10);
		form.setPager_count(rp_buildDao.findMarketUserByChengStat_count(form));
		form.setBuildlist(rp_buildDao.findMarketUserByChengStat_page(form));
		return "marketUserByChengQuery";
	}
	
	//市场用户发秤信息-导出excel
	public String marketUserByChengStat_excel(){
		
		String strChengFlag = "";
		if(form.getChengflag() == 0){
			strChengFlag = "_未发送";
		}else if(form.getChengflag() == 1){
			strChengFlag = "_已发送";
		}
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			List<Rp_Build> buildlist = rp_buildDao.findMarketUserByChengStat(form);
			//EXCEL头
			String[] buildTitle = {"企业CPC","企业名称","联系电话","固定电话","联系人","法人","注册地址"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			for(int j=0; buildlist!= null && j<buildlist.size(); j++){
				Label label0 = new Label(0,j+1, buildlist.get(j).getCpccorp());
				sheet.addCell(label0);
				Label label1 = new Label(1,j+1, buildlist.get(j).getOrgname());
				sheet.addCell(label1);	
				Label label2 = new Label(2,j+1, buildlist.get(j).getMobile());
				sheet.addCell(label2);
				Label label3 = new Label(3,j+1, buildlist.get(j).getTelephone());
				sheet.addCell(label3);
				Label label4 = new Label(4,j+1, buildlist.get(j).getLinkman());
				sheet.addCell(label4);
				Label label5 = new Label(5,j+1, buildlist.get(j).getMasterman());
				sheet.addCell(label5);
				Label label6 = new Label(6,j+1, buildlist.get(j).getRegisteraddress());
				sheet.addCell(label6);
			}
			
			workbook.write();
            workbook.close();
            form.setFilename(new String(("市场发秤用户统计"+strChengFlag+".xls").getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		
		return "marketUserByChengStat_excel";
	}
	
	
	/**
	 * 查询企业打印溯源码数量统计
	 */
	public String orgCodeNumQuery(){
		
		//初始页面默认查询时间
		if(form.getOperstarttime() == null || "".equals(form.getOperstarttime()) ){
			form.setOperstarttime(findYearMonth()+"-01");
		}
		
        if(form.getOperendtime() == null || "".equals(form.getOperendtime()) ){
			form.setOperendtime(Tools.getDateMonthDayStrTwo());
		}
		
		form.setPager_openset(10);
		form.setPager_count(rp_buildDao.findOrgCodeNumStat_count(form));
		form.setBuildlist(rp_buildDao.findOrgCodeNumStat_page(form));
		return "orgCodeNumQuery";
	}
	
	//企业打印溯源码数量统计-导出excel
	public String orgCodeNumStat_excel(){
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			List<Rp_Build> buildlist = rp_buildDao.findOrgCodeNumStat(form);
			//EXCEL头
			String[] buildTitle = {"企业名称","溯源码数量","联系方式","固定电话"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			for(int j=0; buildlist!= null && j<buildlist.size(); j++){
				Label label0 = new Label(0,j+1, buildlist.get(j).getOrgname());
				sheet.addCell(label0);
				Label label1 = new Label(1,j+1, buildlist.get(j).getStrcodenum());
				sheet.addCell(label1);	
				Label label2 = new Label(2,j+1, buildlist.get(j).getMobile());
				sheet.addCell(label2);
				Label label3 = new Label(3,j+1, buildlist.get(j).getTelephone());
				sheet.addCell(label3);
			}
			
			workbook.write();
            workbook.close();
            form.setFilename(new String(("企业打印溯源码数量统计.xls").getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		
		return "orgCodeNumStat_excel";
	}
	
	/**
	 * 查询企业溯源秤交易统计
	 */
	public String orgChengTradeQuery(){
		
		//初始页面默认查询时间
		if(form.getOperstarttime() == null || "".equals(form.getOperstarttime()) ){
			form.setOperstarttime(findYearMonth()+"-01");
		}
		
        if(form.getOperendtime() == null || "".equals(form.getOperendtime()) ){
			form.setOperendtime(Tools.getDateMonthDayStrTwo());
		}
		
		form.setPager_openset(10);
		form.setPager_count(rp_buildDao.findOrgChengTradeStat_count(form));
		form.setBuildlist(rp_buildDao.findOrgChengTradeStat_page(form));
		return "orgChengTradeQuery";
	}
	
	//企业溯源秤交易统计-导出excel
	public String orgChengTradeStat_excel(){
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			List<Rp_Build> buildlist = rp_buildDao.findOrgChengTradeStat(form);
			//EXCEL头
			String[] buildTitle = {"企业名称","交易次数","交易重量(Kg)","联系方式","固定电话"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			for(int j=0; buildlist!= null && j<buildlist.size(); j++){
				Label label0 = new Label(0,j+1, buildlist.get(j).getOrgname());
				sheet.addCell(label0);
				Label label1 = new Label(1,j+1, buildlist.get(j).getStrtradetimes());
				sheet.addCell(label1);	
				Label label2 = new Label(2,j+1, buildlist.get(j).getStrtradeweight());
				sheet.addCell(label2);	
				Label label3 = new Label(3,j+1, buildlist.get(j).getMobile());
				sheet.addCell(label3);	
				Label label4 = new Label(4,j+1, buildlist.get(j).getTelephone());
				sheet.addCell(label4);	
			}
			
			workbook.write();
            workbook.close();
            form.setFilename(new String(("企业溯源秤交易统计.xls").getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		
		return "orgChengTradeStat_excel";
	}
	
	/**
	 * 查询企业溯源秤交易统计
	 */
	public String medTabletChengCodeNumQuery(){
		
		//初始页面默认查询时间
		if(form.getOperstarttime() == null || "".equals(form.getOperstarttime()) ){
			form.setOperstarttime(findYearMonth()+"-01");
		}
		
        if(form.getOperendtime() == null || "".equals(form.getOperendtime()) ){
			form.setOperendtime(Tools.getDateMonthDayStrTwo());
		}
		
		form.setBuild(rp_buildDao.findMedTabletChengCodeNumStat(form));
		return "medTabletChengCodeNumQuery";
	}
	
	//药材饮片和溯源秤打码量统计-导出excel
	public String medTabletChengCodeNumStat_excel(){
		
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		try {
			WritableWorkbook workbook = Workbook.createWorkbook(os);
			WritableSheet sheet = workbook.createSheet("Sheet1", 0);
			Label label = null;
			Rp_Build build = rp_buildDao.findMedTabletChengCodeNumStat(form);
			//EXCEL头
			String[] buildTitle = {"统计类型","打码个数"};
			for(int i = 0 ;i < buildTitle.length ;i++){
				label = new Label(i, 0, buildTitle[i]);
				sheet.addCell(label);
			}
			
			if(build !=null ){
				Label label_01 = new Label(0,1, "药材打码量");
				sheet.addCell(label_01);
				Label label_11 = new Label(1,1, build.getStrmedcodenum());
				sheet.addCell(label_11);	
				Label label_02 = new Label(0,2, "饮片打码量");
				sheet.addCell(label_02);	
				Label label_12 = new Label(1,2, build.getStrtabletcodenum());
				sheet.addCell(label_12);
				Label label_03 = new Label(0,3, "溯源秤打码量");
				sheet.addCell(label_03);	
				Label label_13 = new Label(1,3, build.getStrchengcodenum());
				sheet.addCell(label_13);	
			}
			
			workbook.write();
            workbook.close();
            form.setFilename(new String(("药材饮片和溯源秤打码量统计.xls").getBytes("GBK"),"ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(os.toByteArray());
		
		return "medTabletChengCodeNumStat_excel";
	}
	
	public String findYearMonth(){
		/**
		 * 声明一个int变量year
		 */
		int year;
		/**
		 * 声明一个int变量month
		 */
		int month;
		/**
		 * 声明一个字符串变量date
		 */
		String date;
		/**
		 * 实例化一个对象calendar
		 */
		Calendar calendar = Calendar.getInstance();
		/**
		 * 获取年份
		 */
		year = calendar.get(Calendar.YEAR);
		/**
		 * 获取月份
		 */
		month = calendar.get(Calendar.MONTH) + 1;
		/**
		 * 拼接年份和月份
		 */
		date = year + "-" + ( month<10 ? "0" + month : month);
		/**
		 * 返回当前年月
		 */
		return date;
	}
}
