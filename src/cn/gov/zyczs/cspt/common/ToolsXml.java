package cn.gov.zyczs.cspt.common;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.CheckMat;
import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.DailyCheck;
import cn.gov.zyczs.cspt.po.Fertilizer;
import cn.gov.zyczs.cspt.po.FieldCare;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.MarketMap;
import cn.gov.zyczs.cspt.po.Med;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.Pesticide;
import cn.gov.zyczs.cspt.po.Plant;
import cn.gov.zyczs.cspt.po.ScoreDeduct;
import cn.gov.zyczs.cspt.po.Tablet;
import cn.gov.zyczs.cspt.po.TabletAssist;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;
import cn.gov.zyczs.cspt.po.ZyczsXml;

public class ToolsXml {
	
	//植物
	public static ZyczsXml create_Plant_codeinfo(Plant plant,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"plant\">");
		xml.append("<code desc=\"植物批次码\">").append(plant.getCpcplant()==null?"":plant.getCpcplant()).append("</code>");
		
		xml.append("<codeinfo desc=\"种植信息\">");
		xml.append("<plantname desc=\"植物名称\">").append(plant.getPlantname()==null?"":plant.getPlantname()).append("</plantname>");
		xml.append("<corpcode desc=\"企业代码(14位)，流通节点编号\">").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</corpcode>");
		xml.append("<plantsource desc=\"种子来源:自购|栽培|野生\">").append(plant.getPlantsource()==null?"":plant.getPlantsource()).append("</plantsource>");
		xml.append("<weight desc=\"种子重量(单位:g)\">").append(plant.getPlantweight()==null?"":plant.getPlantweight()/10000).append("</weight>");
		xml.append("<plantarea desc=\"种植区域(单位:亩)\">").append(plant.getPlantarea()==null?"":plant.getPlantarea()).append("</plantarea>");
		xml.append("<plantcycle desc=\"种植周期(单位：月）\">").append(plant.getPlantcycle()==null?"":plant.getPlantcycle()).append("</plantcycle>");
		xml.append("<areacode desc=\"地区编码,按国标处理\">").append(plant.getAreacode()==null?"":plant.getAreacode()).append("</areacode>");
		xml.append("<planttime desc=\"种植时间\">").append(plant.getPlantaddtime()==null?"":plant.getPlantaddtime()+" 00:00:00").append("</planttime>");
		xml.append("<plantuser desc=\"负责人\">").append(plant.getPlantusername()==null?"":plant.getPlantusername()).append("</plantuser>");
		xml.append("<address desc=\"详细地址\">").append(plant.getPlantaddress()==null?"":plant.getPlantaddress()).append("</address>");
		xml.append("</codeinfo>");
		
		List<Plant> plantlist = plant.getPlantlist();
		if(plantlist!=null&&plantlist.size()>0){
			xml.append("<preharvests desc=\"预计产出\">");
			
			for(Plant p :plantlist){
				xml.append("<preharvest desc=\"预计产出\">");
				xml.append("<name desc=\"产出物名称\">").append(p.getHarvestmed()==null?"":p.getHarvestmed()).append("</name>");
				xml.append("<weight desc=\"预计产出重量(单位：kg)\">").append(p.getHarvestwei()==null?"":p.getHarvestwei()).append("</weight>");
				xml.append("</preharvest>");
			}
			
			xml.append("</preharvests>");
		}

		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	public static ZyczsXml create_Plant_harvest(Plant plant,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"plant\">");
		xml.append("<code desc=\"植物批次码\">").append(plant.getCpcplant()==null?"":plant.getCpcplant()).append("</code>");
		
		xml.append("<harvest>");
		xml.append("<endtime desc=\"结束时间\">").append(plant.getPlantendtime()==null?"":plant.getPlantendtime()).append("</endtime>");
		xml.append("</harvest>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	//施肥
	public static ZyczsXml create_Plant_fertilizes(Fertilizer fertilizer,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"plant\">");
		xml.append("<code desc=\"植物批次码\">").append(fertilizer.getCpcplant()==null?"":fertilizer.getCpcplant()).append("</code>");
		
		xml.append("<fertilizes desc=\"施肥\">");
		xml.append("<fertilize>");
		xml.append("<name desc=\"肥料名称\">").append(fertilizer.getFertilizername()==null?"":fertilizer.getFertilizername()).append("</name>");
		xml.append("<weight desc=\"肥料重量\">").append(fertilizer.getFertilizerweight()==null?"":fertilizer.getFertilizerweight()/10000).append("</weight>");
		xml.append("<addtime desc=\"施肥时间\">").append(Tools.getCurrentTime()).append("</addtime>");
		xml.append("</fertilize>");
		xml.append("</fertilizes>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	//农药
	public static ZyczsXml create_Plant_pesticides(Pesticide pesticide,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"plant\">");
		xml.append("<code desc=\"植物批次码\">").append(pesticide.getCpcplant()==null?"":pesticide.getCpcplant()).append("</code>");
		
		xml.append("<pesticides desc=\"喷药\">");
		xml.append("<pesticide>");
		xml.append("<name desc=\"农药名称\">").append(pesticide.getPesticidename()==null?"":pesticide.getPesticidename()).append("</name>");
		xml.append("<weight desc=\"农药重量\">").append(pesticide.getPesticideweight()==null?"":pesticide.getPesticideweight()/10000).append("</weight>");
		xml.append("<addtime desc=\"喷药时间\">").append(Tools.getCurrentTime()).append("</addtime>");
		xml.append("</pesticide>");
		xml.append("</pesticides>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	//田间管理
	public static ZyczsXml create_Plant_fieldmanagements(FieldCare fieldCare,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"plant\">");
		xml.append("<code desc=\"植物批次码\">").append(fieldCare.getCpcplant()==null?"":fieldCare.getCpcplant()).append("</code>");
		
		xml.append("<fieldmanagements desc=\"田间管理\">");
		xml.append("<fieldmanagement>");
		xml.append("<name desc=\"名称\">").append(fieldCare.getFieldcarename()==null?"":fieldCare.getFieldcarename()).append("</name>");
		xml.append("<type desc=\"类型\">").append(fieldCare.getFieldcaretype()==null?"":fieldCare.getFieldcaretype()).append("</type>");
		xml.append("<weight desc=\"用量\">").append(fieldCare.getFieldcareweight()==null?"":fieldCare.getFieldcareweight()).append("</weight>");
		xml.append("<addtime desc=\"时间\">").append(fieldCare.getFieldcaretime()==null?"":fieldCare.getFieldcaretime()).append("</addtime>");
		xml.append("<remark desc=\"备注\">").append(fieldCare.getRemark()==null?"":fieldCare.getRemark()).append("</remark>");
		xml.append("</fieldmanagement>");
		xml.append("</fieldmanagements>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	
	
	
	//药材
	public static ZyczsXml create_Med_codeinfo(Med med,User user,String areacode,int type){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"medicine\">");
		xml.append("<code desc=\"药材批次码\">").append(med.getCpcmed()==null?"":med.getCpcmed()).append("</code>");
		
		xml.append("<codeinfo desc=\"药材信息\">");
		xml.append("<name desc=\"药材名称\">").append(med.getMedname()==null?"":med.getMedname()).append("</name>");
		xml.append("<weight desc=\"药材重量(单位:g)\">").append(med.getMedweight()==null?"":med.getMedweight()/10000).append("</weight>");
		xml.append("<areacode desc=\"地区编码,按国标处理\">").append(areacode==null?"":areacode).append("</areacode>");
		xml.append("<plantcode desc=\"种植批次\">").append(med.getCpcplant()==null?"":med.getCpcplant()).append("</plantcode>");	
		xml.append("<harvesttime desc=\"收获时间\">").append(med.getHarvesttime()==null?"":med.getHarvesttime()+" 00:00:00").append("</harvesttime>");
		xml.append("<innerbatchno desc=\"企业内容批次号\">").append(med.getMednumber()==null?"":med.getMednumber()).append("</innerbatchno>");
		if(type==2){
			xml.append("<plantmes desc=\"种植信息\">");
			xml.append("<plantsource desc=\"种子来源:自购|栽培|野生\">").append(med.getSource()==null?"":med.getSource()).append("</plantsource>");
			xml.append("<fertilizer desc=\"施肥情况\">").append(med.getFertilizer()==null?"":med.getFertilizer()).append("</fertilizer>");
			xml.append("<pesticide desc=\"喷药情况\">").append(med.getPesticide()==null?"":med.getPesticide()).append("</pesticide>");
			xml.append("<harvesttime desc=\"收获时间\">").append(med.getHarvesttime()==null?"":med.getHarvesttime()+" 00:00:00").append("</harvesttime>");
			xml.append("</plantmes>");
		}
		xml.append("</codeinfo>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	public static ZyczsXml create_Med_materials(Check check,User user,List<CheckMat> checkmatlist){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"medicine\">");
		xml.append("<code desc=\"药材批次码\">").append(check.getCpcmed()==null?"":check.getCpcmed()).append("</code>");
		
		xml.append("<materials desc=\"检验\">");
		xml.append("<material desc=\"检验\">");
		xml.append("<corpcode desc=\"企业代码(14位)，流通节点编号\">").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</corpcode>");
		xml.append("<checkmethod desc=\"检验方法\">").append(check.getCheckmethod()==null?"":check.getCheckmethod()).append("</checkmethod>");
		xml.append("<checkgrade desc=\"质量级别\">").append(check.getCheckgrade()==null?"":check.getCheckgrade()).append("</checkgrade>");
		xml.append("<checkthickmethod desc=\"粗加工方法\">").append(check.getCheckthickmethod()==null?"":check.getCheckthickmethod()).append("</checkthickmethod>");
		xml.append("<checkcondition desc=\"贮藏条件\">").append(check.getCheckcondition()==null?"":check.getCheckcondition()).append("</checkcondition>");
		xml.append("<checkuser desc=\"检验人员\">").append(check.getCheckuser()==null?"":check.getCheckuser()).append("</checkuser>");
		xml.append("<checktime desc=\"检验时间\">").append(check.getChecktime()==null?"":check.getChecktime()+" 00:00:00").append("</checktime>");
		
		if(checkmatlist!=null&&checkmatlist.size()>0){
			xml.append("<reports>");
			for(CheckMat cm :checkmatlist){
				String type="1";
				if(cm.getMattype().equals(3)){
					type="2";
				}else if(cm.getMattype().equals(4)){
					type="3";
				}else if(cm.getMattype().equals(5)){
					type="4";
				}
				
				xml.append("<report>");
				xml.append("<type desc=\"检验报告类型：(检验报告-1|产地报告-2 |环境检验报告-3 |其他报告-4\">").append(type).append("</type>");
				
				String matcont = cm.getMatcontent();
    			matcont=matcont.substring(matcont.length()-3,matcont.length());
    			System.out.println(matcont);
	    		if(matcont.equals("jpg")||matcont.equals("gif")||matcont.equals("png")||matcont.equals("bmp")){
//    				str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
	    			xml.append("<url desc=\"检验报告地址\">").append(cm.getMatcontent()==null?"":ServletActionContext.getServletContext().getInitParameter("domainname")+"checkMatImage.shtml?matcontent="+cm.getMatcontent()).append("</url>");
	    		}else{
//	    			str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage!getMatImageFile.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
	    			xml.append("<url desc=\"检验报告地址\">").append(cm.getMatcontent()==null?"":ServletActionContext.getServletContext().getInitParameter("domainname")+"checkMatImage!getMatImageFile.shtml?matcontent="+cm.getMatcontent()).append("</url>");
	    		}
	    		
//				xml.append("<url desc=\"检验报告地址\">").append(cm.getMatcontent()==null?"":ServletActionContext.getServletContext().getInitParameter("domainname")+cm.getMatcontent()).append("</url>");
				
				xml.append("</report>");
			}
			xml.append("</reports>");
		}
		
		xml.append("</material>");
		xml.append("</materials>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	//药材调整库存
	public static ZyczsXml create_Med_chanagestorage(MedStorage medStorage,List<Box> boxs,User user,Integer medtype){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"adjust_stock\">");
		xml.append("<code desc=\"药材批次码\">").append(medStorage.getCpcmed()==null?"":medStorage.getCpcmed()).append("</code>");
		
		xml.append("<codeinfo desc=\"调整信息\">");
		xml.append("<name desc=\"药材名称\">").append(medStorage.getMedname()==null?"":medStorage.getMedname()).append("</name>");
		//已分包的传原始规格和修改规格
		if(medtype.equals(1)){
			xml.append("<oldweight desc=\"原药材重量\">").append(medStorage.getOldchange()==null?"":medStorage.getOldchange()).append("</oldweight>");
			xml.append("<newweight desc=\"新调整药材重量\">").append(medStorage.getChange()==null?"":medStorage.getChange()).append("</newweight>");
		}else{
			//未分包传原始重量和修改重量
			xml.append("<oldweight desc=\"原药材重量\">").append(medStorage.getOldchange()==null?"":medStorage.getOldchange()).append("</oldweight>");
			xml.append("<newweight desc=\"新调整药材重量\">").append(medStorage.getChange()==null?"":medStorage.getChange()).append("</newweight>");
		}
	
		
		xml.append("<adjusttime desc=\"调整时间\">").append(Tools.getCurrentTime()==null?"":Tools.getCurrentTime()).append("</adjusttime>");
		xml.append("<operator desc=\"操作员\">").append(user.getLoginname()==null?"":user.getLoginname()).append("</operator>");
		xml.append("</codeinfo>");
		
		if(medtype.equals(1)){
			xml.append("<sourcecode>");
			for(Box box : boxs){
				xml.append("<code desc=\"溯源码\">").append(box.getBoxcode()==null?"":box.getBoxcode()).append("</code>");
			}
			xml.append("</sourcecode>");
		}
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	
	//饮片
	public static ZyczsXml create_Tablet_codeinfo(Tablet tablet,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"tablet\">");
		xml.append("<code desc=\"饮片批次码\">").append(tablet.getCpctablet()==null?"":tablet.getCpctablet()).append("</code>");
		
		xml.append("<codeinfo desc=\"饮片信息\">");
		xml.append("<name desc=\"饮片名称\">").append(tablet.getTabletname()==null?"":tablet.getTabletname()).append("</name>");
		xml.append("<spec desc=\"生产规格\">").append(tablet.getTabletspec()==null?"":tablet.getTabletspec()).append("</spec>");
		xml.append("<standard desc=\"执行标准\">").append(tablet.getExecstandard()==null?"":tablet.getExecstandard()).append("</standard>");
		xml.append("<processflow desc=\"生产流程\">").append(tablet.getProcessflow()==null?"":tablet.getProcessflow()).append("</processflow>");
		xml.append("<operator desc=\"工艺员\">").append(tablet.getOperator()==null?"":tablet.getOperator()).append("</operator>");
		xml.append("<manager desc=\"生产部经理\">").append(tablet.getManager()==null?"":tablet.getManager()).append("</manager>");
		xml.append("<qa desc=\"QA\">").append(tablet.getQa()==null?"":tablet.getQa()).append("</qa>");
		xml.append("<producedate desc=\"生产日期\">").append(tablet.getCreatetime()==null?"":tablet.getCreatetime()).append("</producedate>");
		xml.append("<remark desc=\"备注\">").append(tablet.getRemark()==null?"":tablet.getRemark()).append("</remark>");
		xml.append("<weight desc=\"待包装重量(单位:kg)\">").append(tablet.getTabletweight()==null?"":tablet.getTabletweight()/10000).append("</weight>");
		xml.append("<medicinalcode desc=\"药材批次码,关联外键\">").append(tablet.getCpcmed()==null?"":tablet.getCpcmed()).append("</medicinalcode>");
		xml.append("<medicinalweight desc=\"药材总重量(单位：kg)\">").append(tablet.getMeduseweight()==null?"":tablet.getMeduseweight()/10000).append("</medicinalweight>");
		xml.append("<areacode desc=\"地区编码,按国标处理\">").append(tablet.getAreacode()==null?"":tablet.getAreacode()).append("</areacode>");
		xml.append("<innerbatchno desc=\"企业内容批次号\">").append(tablet.getTabletnumber()==null?"":tablet.getTabletnumber()).append("</innerbatchno>");
		xml.append("</codeinfo>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	
	public static ZyczsXml create_Tablet_materials(Check check,User user,List<CheckMat> checkmatlist){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"tablet\">");
		xml.append("<code desc=\"饮片批次码\">").append(check.getCpctablet()==null?"":check.getCpctablet()).append("</code>");
		
		xml.append("<materials desc=\"检验\">");
		xml.append("<material desc=\"检验\">");
		xml.append("<corpcode desc=\"企业代码(14位)，流通节点编号\">").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</corpcode>");
		xml.append("<checkmethod desc=\"检验方法\">").append(check.getCheckmethod()==null?"":check.getCheckmethod()).append("</checkmethod>");
		xml.append("<checkgrade desc=\"质量级别\">").append(check.getCheckgrade()==null?"":check.getCheckgrade()).append("</checkgrade>");
		xml.append("<checkthickmethod desc=\"粗加工方法\">").append(check.getCheckthickmethod()==null?"":check.getCheckthickmethod()).append("</checkthickmethod>");
		xml.append("<checkcondition desc=\"贮藏条件\">").append(check.getCheckcondition()==null?"":check.getCheckcondition()).append("</checkcondition>");
		xml.append("<checkuser desc=\"检验人员\">").append(check.getCheckuser()==null?"":check.getCheckuser()).append("</checkuser>");
		xml.append("<checktime desc=\"检验时间\">").append(check.getChecktime()==null?"":check.getChecktime()+" 00:00:00").append("</checktime>");
		
		if(checkmatlist!=null&&checkmatlist.size()>0){
			xml.append("<reports>");
			for(CheckMat cm :checkmatlist){
				String type="1";
				if(cm.getMattype().equals(3)){
					type="2";
				}
				xml.append("<report>");
				xml.append("<type desc=\"检验报告类型：(检验报告|产地报告\">").append(type).append("</type>");
				
				String matcont = cm.getMatcontent();
    			matcont=matcont.substring(matcont.length()-3,matcont.length());
	    		if(matcont.equals("jpg")||matcont.equals("gif")||matcont.equals("png")||matcont.equals("bmp")){
//    				str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
	    			xml.append("<url desc=\"检验报告地址\">").append(cm.getMatcontent()==null?"":ServletActionContext.getServletContext().getInitParameter("domainname")+"checkMatImage.shtml?matcontent="+cm.getMatcontent()).append("</url>");
	    		}else{
//	    			str+='<tr><td height=26 bgcolor=#EEEEEE><a class="blue" target="_blank" id="name'+matlist[i].matid +'" href="<%=basePath%>checkMatImage!getMatImageFile.shtml?matcontent='+matlist[i].matcontent+'">'+matlist[i].matname+'</a></td>';
	    			xml.append("<url desc=\"检验报告地址\">").append(cm.getMatcontent()==null?"":ServletActionContext.getServletContext().getInitParameter("domainname")+"checkMatImage!getMatImageFile.shtml?matcontent="+cm.getMatcontent()).append("</url>");
	    		}
	    		
//	    		xml.append("<url desc=\"检验报告地址\">").append(cm.getMatcontent()==null?"":ServletActionContext.getServletContext().getInitParameter("domainname")+cm.getMatcontent()).append("</url>");
	    		
				xml.append("</report>");
			}
			xml.append("</reports>");
		}
		
		xml.append("</material>");
		xml.append("</materials>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	
	
	public static ZyczsXml create_Tablet_assists(List<TabletAssist> tabletAssistlist,User user,String cpctablet){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"tablet\">");
		xml.append("<code desc=\"饮片批次码\">").append(cpctablet==null?"":cpctablet).append("</code>");
		
		xml.append("<assists desc=\"辅料\">");
		for(TabletAssist tabletAssist:tabletAssistlist){
			xml.append("<assist>");
			xml.append("<assistplantname desc=\"辅料品名\">").append(tabletAssist.getAssistplantname()==null?"":tabletAssist.getAssistplantname()).append("</assistplantname>");
			xml.append("<assistgpcode desc=\"辅料编号\">").append(tabletAssist.getAssistgpcode()==null?"":tabletAssist.getAssistgpcode()).append("</assistgpcode>");
			xml.append("<assistarea desc=\"辅料产地\">").append(tabletAssist.getAssistcity()==null?"":tabletAssist.getAssistcity()).append("</assistarea>");
			xml.append("<assistweight desc=\"辅料重量(单位：g)\">").append(tabletAssist.getAssistweight()==null?"":tabletAssist.getAssistweight()).append("</assistweight>");
			xml.append("<assistusecount desc=\"辅料使用比列\">").append(tabletAssist.getAssistusecount()==null?"":tabletAssist.getAssistusecount()).append("</assistusecount>");
			xml.append("<assistmaterial desc=\"辅料净药材\">").append(tabletAssist.getAssistmaterial()==null?"":tabletAssist.getAssistmaterial()).append("</assistmaterial>");
			xml.append("</assist>");
		}
		xml.append("</assists>");
		
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	
	//=======================================================================================================================================================
	//=======================================================================================================================================================
	//=======================================================================================================================================================
	
	
	//药材出库
	public static ZyczsXml create_Med_outstore(InOutStor vo,List<InOutStorBox> storboxlist,Map<String,List<MedStorage>> map,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"stock\">");
		xml.append("<code>").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</code>");
		xml.append("<outstore desc=\"出库\">");
		xml.append("<time desc=\"出库时间\">").append(vo.getOpertime()==null?"":vo.getOpertime()).append("</time>");
		xml.append("<corptype desc=\"溯源企业-1|非溯源企业-0\">").append(vo.getZstype()==null?"":vo.getZstype()).append("</corptype>");
		xml.append("<newcorpcode desc=\"新货主cpccode\">").append(vo.getCpccorp()==null?"":vo.getCpccorp()).append("</newcorpcode>");
		xml.append("<weightall desc=\"出库总重量/单位(kg)\">").append(vo.getTotalweight()==null?"":vo.getTotalweight()/10000).append("</weightall>");
		xml.append("<amount desc=\"合计金额\">").append(vo.getTotalmoney()==null?"":Tools.scienceToString(vo.getTotalmoney()/10000)).append("</amount>");
		xml.append("<ptype desc=\"出库对象\">medicine</ptype>");
		xml.append("<medicinebatchs>");
		
		
		for(InOutStorBox storbox : storboxlist){
			xml.append("<medicinebatch>");
			List<MedStorage> medstoragelist = map.get(storbox.getKeyname());
			xml.append("<batchno desc=\"药材/饮片批次号\">").append(storbox.getBatchcpc()==null?"":storbox.getBatchcpc()).append("</batchno>");
			xml.append("<spec desc=\"规格\">").append(storbox.getBoxnumweight()==null?"":storbox.getBoxnumweight()/10000).append("</spec>");
			xml.append("<weightall desc=\"出库总重量小计(kg)\">").append(storbox.getTotalweight()==null?"":storbox.getTotalweight()/10000).append("</weightall>");
			xml.append("<unitprice desc=\"单价 元/公斤\">").append(storbox.getPrice()==null?"":storbox.getPrice()/10000).append("</unitprice>");
			xml.append("<amount desc=\"合计金额\">").append(storbox.getTotalmoney()==null?"":Tools.scienceToString(storbox.getTotalmoney()/10000)).append("</amount>");
			
			xml.append("<sourcecode>");
			if(medstoragelist!=null&&medstoragelist.size()>0){
				for(MedStorage ms : medstoragelist){
					xml.append("<code desc=\"溯源码\">").append(ms.getBoxcode()==null?"":ms.getBoxcode()).append("</code>");
				}
			}
			xml.append("</sourcecode>");
			xml.append("</medicinebatch>");
		}
		
		xml.append("</medicinebatchs>");
		xml.append("</outstore>");
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	//药材出库
	public static ZyczsXml create_Med_outstore2(InOutStor vo,List<InOutStorBox> storboxlist,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		xml.append("<msgbody msgtype=\"stock\">");
		xml.append("<code>").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</code>");
		xml.append("<outstore desc=\"出库\">");
		xml.append("<time desc=\"出库时间\">").append(vo.getOpertime()==null?"":vo.getOpertime()).append("</time>");
		xml.append("<corptype desc=\"溯源企业-1|非溯源企业-0\">").append(vo.getZstype()==null?"":vo.getZstype()).append("</corptype>");
		xml.append("<newcorpcode desc=\"新货主cpccode\">").append(vo.getCpccorp()==null?"":vo.getCpccorp()).append("</newcorpcode>");
		xml.append("<weightall desc=\"出库总重量/单位(kg)\">").append(vo.getTotalweight()==null?"":vo.getTotalweight()/10000).append("</weightall>");
		xml.append("<amount desc=\"合计金额\">").append(vo.getTotalmoney()==null?"":Tools.scienceToString(vo.getTotalmoney()/10000)).append("</amount>");
		xml.append("<ptype desc=\"出库对象\">medicine</ptype>");
		xml.append("<medicinebatchs>");
		
		
		for(InOutStorBox storbox : storboxlist){
			xml.append("<medicinebatch>");
//			List<MedStorage> medstoragelist = map.get(storbox.getKeyname());
			xml.append("<batchno desc=\"药材/饮片批次号\">").append(storbox.getBatchcpc()==null?"":storbox.getBatchcpc()).append("</batchno>");
			xml.append("<spec desc=\"规格\">").append(storbox.getBoxnumweight()==null?"":storbox.getBoxnumweight()/10000).append("</spec>");
			xml.append("<weightall desc=\"出库总重量小计(kg)\">").append(storbox.getTotalweight()==null?"":storbox.getTotalweight()/10000).append("</weightall>");
			xml.append("<unitprice desc=\"单价 元/公斤\">").append(storbox.getPrice()==null?"":storbox.getPrice()/10000).append("</unitprice>");
			xml.append("<amount desc=\"合计金额\">").append(storbox.getTotalmoney()==null?"":Tools.scienceToString(storbox.getTotalmoney()/10000)).append("</amount>");
			
			xml.append("<sourcecode>");
			if(storbox.getGroupInfo()!=null){
				String[] groupInfo=storbox.getGroupInfo().split(";");	
				for(String rows : groupInfo){
					String[] group=rows.split(",");
					xml.append("<code desc=\"溯源码\">").append(group[0]==null?"":group[0]).append("</code>");
				}
			}
			xml.append("</sourcecode>");
			xml.append("</medicinebatch>");
		}
		
		xml.append("</medicinebatchs>");
		xml.append("</outstore>");
		xml.append("</msgbody>");
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	}
	
	//饮片出库
	public static ZyczsXml create_Tablet_outstore2(InOutStor vo,List<InOutStorBox> storboxlist,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		
		xml.append("<msgbody msgtype=\"stock\">");
		xml.append("<code>").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</code>");
		xml.append("<outstore desc=\"出库\">");
		xml.append("<time desc=\"出库时间\">").append(vo.getOpertime()==null?"":vo.getOpertime()).append("</time>");
		xml.append("<corptype desc=\"溯源企业-1|非溯源企业-0\">").append(vo.getZstype()==null?"":vo.getZstype()).append("</corptype>");
		xml.append("<newcorpcode desc=\"新货主cpccode\">").append(vo.getCpccorp()==null?"":vo.getCpccorp()).append("</newcorpcode>");
		xml.append("<weightall desc=\"出库总重量/单位(kg)\">").append(vo.getTotalweight()==null?"":vo.getTotalweight()/10000).append("</weightall>");
		xml.append("<amount desc=\"合计金额\">").append(vo.getTotalmoney()==null?"":Tools.scienceToString(vo.getTotalmoney()/10000)).append("</amount>");
		xml.append("<ptype desc=\"出库对象\">pieces</ptype>");
		xml.append("<medicinebatchs>");
		
		
		for(InOutStorBox storbox : storboxlist){
			xml.append("<medicinebatch>");
			xml.append("<batchno desc=\"药材/饮片批次号\">").append(storbox.getBatchcpc()==null?"":storbox.getBatchcpc()).append("</batchno>");
			xml.append("<spec desc=\"规格\">").append(storbox.getBoxnumweight()==null?"":storbox.getBoxnumweight()/10000).append("</spec>");
			xml.append("<weightall desc=\"出库总重量小计(kg)\">").append(storbox.getTotalweight()==null?"":storbox.getTotalweight()/10000).append("</weightall>");
			xml.append("<unitprice desc=\"单价 元/公斤\">").append(storbox.getPrice()==null?"":storbox.getPrice()/10000).append("</unitprice>");
			xml.append("<amount desc=\"合计金额\">").append(storbox.getTotalmoney()==null?"":Tools.scienceToString(storbox.getTotalmoney()/10000)).append("</amount>");
			
			xml.append("<sourcecode>");
			//箱装溯源码--同批次合并
			if(storbox.getCodetype()==6){
				if(storbox.getGroupInfo()!=null){
					String[] groupInfo=storbox.getGroupInfo().split(";");	
					for(String rows : groupInfo){
						String[] group=rows.split(",");
						xml.append("<code desc=\"溯源码\">").append(group[0]==null?"":group[0]).append("</code>");
					}
				}
			}else{//袋装溯源码
				xml.append("<code desc=\"溯源码\">").append(storbox.getCode()).append("</code>");
			}
			
			xml.append("</sourcecode>");
			xml.append("</medicinebatch>");
		}
		
		xml.append("</medicinebatchs>");
		xml.append("</outstore>");
		xml.append("</msgbody>");
		
		System.out.println("xml===="+xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	   }
	
	//饮片出库
	public static ZyczsXml create_Tablet_outstore(InOutStor vo,List<InOutStorBox> storboxlist,Map<String,List<TabletStorage>> map,User user){
		ZyczsXml zyczsXml = new ZyczsXml();
		StringBuffer xml = new StringBuffer();
		
		xml.append("<msgbody msgtype=\"stock\">");
		xml.append("<code>").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</code>");
		xml.append("<outstore desc=\"出库\">");
		xml.append("<time desc=\"出库时间\">").append(vo.getOpertime()==null?"":vo.getOpertime()).append("</time>");
		xml.append("<corptype desc=\"溯源企业-1|非溯源企业-0\">").append(vo.getZstype()==null?"":vo.getZstype()).append("</corptype>");
		xml.append("<newcorpcode desc=\"新货主cpccode\">").append(vo.getCpccorp()==null?"":vo.getCpccorp()).append("</newcorpcode>");
		xml.append("<weightall desc=\"出库总重量/单位(kg)\">").append(vo.getTotalweight()==null?"":vo.getTotalweight()/10000).append("</weightall>");
		xml.append("<amount desc=\"合计金额\">").append(vo.getTotalmoney()==null?"":Tools.scienceToString(vo.getTotalmoney()/10000)).append("</amount>");
		xml.append("<ptype desc=\"出库对象\">pieces</ptype>");
		xml.append("<medicinebatchs>");
		
		
		for(InOutStorBox storbox : storboxlist){
			xml.append("<medicinebatch>");
			List<TabletStorage> tabletstoragelist = map.get(storbox.getKeyname());
			xml.append("<batchno desc=\"药材/饮片批次号\">").append(storbox.getBatchcpc()==null?"":storbox.getBatchcpc()).append("</batchno>");
			xml.append("<spec desc=\"规格\">").append(storbox.getBoxnumweight()==null?"":storbox.getBoxnumweight()/10000).append("</spec>");
			xml.append("<weightall desc=\"出库总重量小计(kg)\">").append(storbox.getTotalweight()==null?"":storbox.getTotalweight()/10000).append("</weightall>");
			xml.append("<unitprice desc=\"单价 元/公斤\">").append(storbox.getPrice()==null?"":storbox.getPrice()/10000).append("</unitprice>");
			xml.append("<amount desc=\"合计金额\">").append(storbox.getTotalmoney()==null?"":Tools.scienceToString(storbox.getTotalmoney()/10000)).append("</amount>");
			
			xml.append("<sourcecode>");
			if(tabletstoragelist!=null&&tabletstoragelist.size()>0){
				for(TabletStorage ts : tabletstoragelist){
					xml.append("<code desc=\"溯源码\">").append(ts.getBoxcode()==null?"":ts.getBoxcode()).append("</code>");
				}
			}
			xml.append("</sourcecode>");
			xml.append("</medicinebatch>");
		}
		
		xml.append("</medicinebatchs>");
		xml.append("</outstore>");
		xml.append("</msgbody>");
		
		System.out.println(xml.toString());
		zyczsXml.setXmlcontent(xml.toString());
		zyczsXml.setLoginname(user.getLoginname());
		zyczsXml.setState(0);
		zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		return zyczsXml;
	   }
	
	   //销毁
	   public static ZyczsXml create_destory(List<String> codelist,User user,int type){
		    ZyczsXml zyczsXml = new ZyczsXml();
			StringBuffer xml = new StringBuffer();
			
			xml.append("<msgbody msgtype=\"stock\">");
			xml.append("<code>").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</code>");
			xml.append("<destory desc=\"销毁\">");
			xml.append("<reason desc=\"销毁原因1-拆包销售、2-药厂/医院、3-质量原因、4-印刷废码、5-其他\"></reason>");
			if(type==0){
			   xml.append("<ptype desc=\"对象\">medicine</ptype>");
			}else{
			   xml.append("<ptype desc=\"对象\">pieces</ptype>");
			}
			xml.append("<time desc=\"销毁时间\">").append(Tools.getCurrentTime()).append("</time>");
			xml.append("<sourcecode>");
			
			for(String code : codelist){
				xml.append("<code desc=\"溯源码\">").append(code==null?"":code).append("</code>");
			}
			
			xml.append("</sourcecode>");
			xml.append("</destory>");
			xml.append("</msgbody>");
			System.out.println(xml.toString());
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			return zyczsXml;
	   }
	   
	   //退货
	   public static ZyczsXml create_backstore(List<String> codelist,User user,int type){
		   ZyczsXml zyczsXml = new ZyczsXml();
			StringBuffer xml = new StringBuffer();
			
			xml.append("<msgbody msgtype=\"stock\">");
			xml.append("<code>").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</code>");
			xml.append("<backstore desc=\"退货\">");
			if(type==0){
			   xml.append("<ptype desc=\"对象\">medicine</ptype>");
			}else{
			   xml.append("<ptype desc=\"对象\">pieces</ptype>");
			}
			xml.append("<time desc=\"退货时间\">").append(Tools.getCurrentTime()).append("</time>");
			xml.append("<sourcecode>");
			
			for(String code : codelist){
				xml.append("<code desc=\"溯源码\">").append(code==null?"":code).append("</code>");
			}
			
			xml.append("</sourcecode>");
			xml.append("</backstore>");
			xml.append("</msgbody>");
			System.out.println(xml.toString());
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			return zyczsXml;
	   }
		
	
		//药材饮片入库请求xml
		public static String create_InStore(List<String> codes,User user,int type) {
		   StringBuffer xml = new StringBuffer();
		   xml.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>"); 
		   xml.append("<zyczs guid=\"").append(java.util.UUID.randomUUID().toString().replaceAll("-","")).append("\">");
		   xml.append("<deployment>");
		   xml.append("<code>deploy0001</code>");
		   xml.append("<name>chengdu</name>");
		   xml.append("<password>chengdu</password>");
		   xml.append("</deployment>");	    
		   xml.append("<msgbody msgtype=\"instore\">");
		   xml.append("<code>").append(user.getCpccorp()==null?"":user.getOrg().getCpccorp()).append("</code>");		 
		   xml.append("<codeinfo>");
		   if(type==0){
			   xml.append("<ptype desc=\"入库对象\">medicine</ptype>");
		   }else{
			   xml.append("<ptype desc=\"入库对象\">pieces</ptype>");
		   }
		   xml.append("<sourcecode>");
		   for(String code:codes) {
			   xml.append("<code>").append(code).append("</code>"); 
		   }
		   xml.append("</sourcecode>");
		   xml.append("</codeinfo>");
		   xml.append("</msgbody>");
		   xml.append("</zyczs>");
		   
		   System.out.println(xml.toString());
		   return xml.toString();
	   }
		
		
		
		//药材饮片入库请求post方法
	   public static String sendPost(String xmlstr) throws IOException {
		   String sTotalString = "";
		   try{
			   String urlstr=ServletActionContext.getServletContext().getInitParameter("instore");
			   
		   	   URL url = new URL(urlstr);   
		       URLConnection connection = url.openConnection();        
		       connection.setDoOutput(true);
		       OutputStreamWriter out = new OutputStreamWriter(connection.getOutputStream(), "UTF-8");   
		       out.write("codeXml="+xmlstr);
		       out.flush();
		       out.close();          
		       String sCurrentLine= "";   
		       InputStream l_urlStream = connection.getInputStream();    
		       BufferedReader l_reader = new BufferedReader(new InputStreamReader(l_urlStream,"UTF-8"));   
		       while ((sCurrentLine = l_reader.readLine()) != null) {   
		           sTotalString += sCurrentLine + "\r\n";   
		       }
		       System.out.println(sTotalString);
	       
		   }catch(Exception e){
			   e.printStackTrace();
		   }
		   return sTotalString;
	   }
	   
	   
	   //药材饮片入库异步xml
		public static ZyczsXml createSuccInStoresync(List<InStorSuccessCode> succList,User user,int type) {
		   ZyczsXml zyczsXml = new ZyczsXml();
		   StringBuffer xml = new StringBuffer();
		   xml.append("<msgbody msgtype=\"instore\">");
		   xml.append("<code>").append(user.getCpccorp()==null?"":user.getCpccorp()).append("</code>");		   
		   xml.append("<instore desc=\"入库单\">");
		   xml.append("<time desc=\"入库时间\">"+Tools.getCurrentTime()+"</time>");
		   if(type==0){
			   xml.append("<ptype desc=\"入库对象\">medicine</ptype>");
		   }else{
			   xml.append("<ptype desc=\"入库对象\">pieces</ptype>");
		   }
		   xml.append("<sourcecode>");
		   for(InStorSuccessCode code:succList) {
			   xml.append("<code>").append(code.getCode()).append("</code>"); 
		   }
		   xml.append("</sourcecode>");
		   xml.append("</instore>");
		   xml.append("</msgbody>");
		   System.out.println("instore====="+xml.toString());
		   zyczsXml.setXmlcontent(xml.toString());
		   zyczsXml.setLoginname(user.getLoginname());
		   zyczsXml.setState(0);
		   zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
		   return zyczsXml;
	   }
		
		
		//诚信评价扣分
		public static ZyczsXml create_scoreDeduct(ScoreDeduct scoreDeduct,Org org,User user){
			ZyczsXml zyczsXml = new ZyczsXml();
			StringBuffer xml = new StringBuffer();
			xml.append("<msgbody msgtype=\"credit-punish\">");
			xml.append("<credits>");
			xml.append("<credit>");
			xml.append("<cpccode desc=\"企业CPCCODE\">").append(org.getCpccorp()==null?"":org.getCpccorp()).append("</cpccode>");
			xml.append("<areacode desc=\"地区编码\">").append(org.getAreacode()==null?"":org.getAreacode()).append("</areacode>");
			xml.append("<appraisecycle desc=\"评价时间\">").append(Tools.getCurrentTime()).append("</appraisecycle>");
			xml.append("<subscoreitems desc=\"处罚扣分\">");
			xml.append("<subscoreitem>");
			xml.append("<punishtype desc=\"处罚类型 1-投诉 2-质量问题 3-诚信检查\">").append(scoreDeduct.getDeducttype()==null?"":scoreDeduct.getDeducttype()).append("</punishtype>");
			xml.append("<score desc=\"扣分\">").append(scoreDeduct.getScore()==null?"":scoreDeduct.getScore()).append("</score>");
			xml.append("<remark desc=\"备注\">").append(scoreDeduct.getDeductreason()==null?"":scoreDeduct.getDeductreason()).append("</remark>");
			xml.append("</subscoreitem>");
			xml.append("</subscoreitems>");
			xml.append("</credit>");
			xml.append("</credits>");
			xml.append("</msgbody>");
			System.out.println(xml.toString());
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			return zyczsXml;
		}
	   
		//市场楼层图
		public static ZyczsXml create_marketMap(MarketMap marketMap,User user){
			ZyczsXml zyczsXml = new ZyczsXml();
			StringBuffer xml = new StringBuffer();
			xml.append("<msgbody msgtype=\"marketmap\">");
			xml.append("<marketmaps>");
			xml.append("<marketmap>");
			xml.append("<area desc=\"市场的几楼\">").append(marketMap.getArea()==null?"":marketMap.getArea()).append("</area>");
			xml.append("<floor desc=\"市场的几区\">").append(marketMap.getFloor()==null?"":marketMap.getFloor()).append("</floor>");
			xml.append("<areanum desc=\"楼编号\">").append(marketMap.getAreanum()==null?"":marketMap.getAreanum()).append("</areanum>");
			xml.append("<floornum desc=\"区编号\">").append(marketMap.getFloornum()==null?"":marketMap.getFloornum()).append("</floornum>");
			xml.append("<cpccode desc=\"市场cpc码\">").append(marketMap.getCpccorp()==null?"":marketMap.getCpccorp()).append("</cpccode>");
			xml.append("<url desc=\"市场平面图全路径url\"><![CDATA[").append(marketMap.getMapcontent()==null?"":ServletActionContext.getServletContext().getInitParameter("domainname")+"marketFloorImage.shtml?areanum=").append(marketMap.getAreanum()).append("&floornum=").append(marketMap.getFloornum()).append("&cpccorp=").append(marketMap.getCpccorp()).append("]]></url>");
			xml.append("</marketmap>");
			xml.append("</marketmaps>");
			xml.append("</msgbody>");
			System.out.println(xml.toString());
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			return zyczsXml;
		}
		
		//手持机检查
		public static ZyczsXml create_dailyCheck(DailyCheck dailyCheck){
			ZyczsXml zyczsXml = new ZyczsXml();
			StringBuffer xml = new StringBuffer();
			xml.append("<msgbody msgtype=\"check\">");
			xml.append("<code desc=\"检查单编号市场CPC编码+10位顺序号\">").append(dailyCheck.getSupercpccorp()==null?"":dailyCheck.getSupercpccorp()).append("</code>");
			xml.append("<codeinfo>");
			
			xml.append("<checktime desc=\"检查时间\">").append(dailyCheck.getCheckdate()==null?"":dailyCheck.getCheckdate()).append("</checktime>");
			xml.append("<checkproject desc=\"检查项目(1安全,2质量,3卫生,4价格,5其他)\">").append(dailyCheck.getCheckproject()==null?"":dailyCheck.getCheckproject()).append("</checkproject>");
			xml.append("<checkresult desc=\"检查结果(1合格,2不合格,3检查中)\">").append(dailyCheck.getCheckresult()==null?"":dailyCheck.getCheckresult()).append("</checkresult>");
			xml.append("<opername desc=\"执行单位\">").append(dailyCheck.getOpername()==null?"":dailyCheck.getOpername()).append("</opername>");
			xml.append("<cpccorp desc=\"经营户编号\">").append(dailyCheck.getCpccorp()==null?"":dailyCheck.getCpccorp()).append("</cpccorp>");
			xml.append("<cpcmeds desc=\"药材批次号,多个批次号用,隔开\">").append(dailyCheck.getCpcmeds()==null?"":dailyCheck.getCpcmeds()).append("</cpcmeds>");
			xml.append("<deductscore desc=\"扣分\">").append(dailyCheck.getDeductscore()==null?"":dailyCheck.getDeductscore()).append("</deductscore>");
			
			xml.append("<codeinfo>");
			xml.append("</msgbody>");
			System.out.println(xml.toString());
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(dailyCheck.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			return zyczsXml;
		}
		
		//溯源秤的发放
		public static ZyczsXml provide_chengXml(Cheng cheng,User user){
			ZyczsXml zyczsXml = new ZyczsXml();
			StringBuffer xml = new StringBuffer();
			xml.append("<msgbody msgtype=\"scaleprovide\">");
			xml.append("<scale desc=\"溯源秤发放\">");
			xml.append("<scalecode desc=\"溯源秤编码\">").append(cheng.getChengcode()==null?"":cheng.getChengcode()).append("</scalecode>");
			xml.append("<corpcode desc=\"企业cpccode\">").append(cheng.getCpccorp()==null?"":cheng.getCpccorp()).append("</corpcode>");
			xml.append("<scalediv desc=\"1-台秤、2-地秤\">").append(cheng.getType()==null?"":cheng.getType()).append("</scalediv>");
			xml.append("<scalebrand desc=\"1-九洲、2-欣创摩尔\">").append(cheng.getChengbrand()==null?"":cheng.getChengbrand()).append("</scalebrand>");
			xml.append("<scalemodel desc=\"秤型号\">").append(cheng.getChengmodel()==null?"":cheng.getChengmodel()).append("</scalemodel>");
			xml.append("<providetime desc=\"发放时间\">").append(Tools.getCurrentTime()).append("</providetime>");
			xml.append("</scale>");
			xml.append("</msgbody>");
			System.out.println(xml.toString());
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			return zyczsXml;
		}
		
		//溯源秤的回收
		public static ZyczsXml recover_chengXml(Cheng cheng,User user){
			ZyczsXml zyczsXml = new ZyczsXml();
			StringBuffer xml = new StringBuffer();
			xml.append("<msgbody msgtype=\"scalerecover\">");
			xml.append("<scale desc=\"溯源秤回收\">");
			xml.append("<scalecode desc=\"溯源秤编码\">").append(cheng.getChengcode()==null?"":cheng.getChengcode()).append("</scalecode>");
			xml.append("<corpcode desc=\"企业cpccode\">").append(cheng.getCpccorp()==null?"":cheng.getCpccorp()).append("</corpcode>");
			xml.append("</scale>");
			xml.append("</msgbody>");
			System.out.println(xml.toString());
			zyczsXml.setXmlcontent(xml.toString());
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			return zyczsXml;
		}
}
