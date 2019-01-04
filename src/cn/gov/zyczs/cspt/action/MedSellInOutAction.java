package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.dao.IChengSqlDao;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.ICodeRegionDao;
import cn.gov.zyczs.cspt.dao.ICompanyOtherDao;
import cn.gov.zyczs.cspt.dao.IInOutStorBoxDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IRegionDao;
import cn.gov.zyczs.cspt.dao.IScalestatDao;
import cn.gov.zyczs.cspt.dao.ITempBoxDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.ChengSql;
import cn.gov.zyczs.cspt.po.CodeArea;
import cn.gov.zyczs.cspt.po.CompanyOther;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.InStorFailCode;
import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class MedSellInOutAction  extends BaseAction implements ModelDriven<InOutStor>{
	InOutStor form = new InOutStor();
	public InOutStor getModel() {
		return form;
	}
	
	private IMedStorageDao medStorageDao;//药材库存dao实现类
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	private IInOutStorDao inOutStorDao;
	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}
	private ICompanyOtherDao companyOtherDao;
	public void setCompanyOtherDao(ICompanyOtherDao companyOtherDao) {
		this.companyOtherDao = companyOtherDao;
	}
	
	private IInOutStorBoxDao inOutStorBoxDao;
	public void setInOutStorBoxDao(IInOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}
	
	private IBoxDao boxDao;
	public void setBoxDao(IBoxDao boxDao) {
		this.boxDao = boxDao;
	}
	private ITempBoxDao tempBoxDao;  
    public void setTempBoxDao(ITempBoxDao tempBoxDao) {
		this.tempBoxDao = tempBoxDao;
	}
    
    private ICodeRegionDao codeRegionDao;
	public void setCodeRegionDao(ICodeRegionDao codeRegionDao) {
		this.codeRegionDao = codeRegionDao;
	}
	private IRegionDao regionDao;	
	public void setRegionDao(IRegionDao regionDao) {
		this.regionDao = regionDao;
	}
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	private IScalestatDao scalestatDao;
	public void setScalestatDao(IScalestatDao scalestatDao) {
		this.scalestatDao = scalestatDao;
	}
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
	private IChengSqlDao chengSqlDao;
	
	
	/**
	 * 行政区划dao
	 */
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}
	
	@SuppressWarnings("unchecked")
	public void findInCode() { 
		User user = (User) getSession().getAttribute("User");		
		//市场账号
		if(user.getOrg().getZyctype().equals("00001000")){//flag为4时是市场药材检验 
			user = (User) getSession().getAttribute("comuser");
		}
		HttpServletResponse response=this.getResponse();
		JSONObject jsonObject = new JSONObject(); 			
		try{
			//溯源码锁定状态查询
//			List<Freeze> freezeList=boxDao.findByFreezeList(form.getBoxcodes().replaceAll("\r\n", ""), user.getOrgid(), 0);
//			if(freezeList!=null&&freezeList.size()>0){
//				jsonObject.put("stoVO",null); 
//	            jsonObject.put("code", form.getBoxcodes());
//	            jsonObject.put("returnCode", 1);
//	    		jsonObject.put("returnInfo", freezeList.get(0).getReasonMap());	  
//	    		
//				Tools.printJson(response, jsonObject.toString());
//				return;
//			}
			
			String[] boxcodesarray= form.getBoxcodes().split("\r\n");
			List<String> liststr =Arrays.asList(boxcodesarray);
			if(liststr!=null&&liststr.size()>0)
			{
				//封装入库溯源码xml
				String inXml = ToolsXml.sendPost(ToolsXml.create_InStore(liststr,user,0));
				System.out.println("resp==============="+inXml);
				if(inXml==null||inXml.equals("")){
					String json ="{\"code\":\""+form.getBoxcodes()+"\",\"returnCode\":1,\"returnInfo\":\"入库接口异常\"}"; 
					Tools.printJson(response, json);
					return;
				}
				Map<String,Object> resultMap=Tools.createInStorResult(inXml,0);
				
				//成功溯源码
				List<InStorSuccessCode> succList=(List)resultMap.get("succList");
					
				if(succList!=null&&succList.size()>0)
				{
					jsonObject.put("stoVO",succList.get(0)); 
		            jsonObject.put("code", succList.get(0).getCode());
		    		jsonObject.put("returnCode", 0);
		    		jsonObject.put("returnInfo", "成功");		
				}else{
					List<InStorFailCode> failList=(List)resultMap.get("failList");
					if(failList==null||failList.size()<=0){
						//封装全部错误溯源码
						failList=new ArrayList<InStorFailCode>();
						Tools.setFailCodes(liststr, failList);
					}	
					jsonObject.put("stoVO",null); 
		            jsonObject.put("code", failList.get(0).getCode());
		            jsonObject.put("returnCode", 1);
		    		jsonObject.put("returnInfo", failList.get(0).getReasonMap());	 

				}
				Tools.printJson(response, jsonObject.toString());
			}

			
		}catch(Exception e){
			String json ="{\"code\":\""+form.getBoxcodes()+"\",\"returnCode\":1,\"returnInfo\":\"入库接口异常\"}"; 
			Tools.printJson(response, json);
			e.printStackTrace();
		}
    } 
	
	public String addInCode(){
		User user = (User) getSession().getAttribute("User");		
		//市场账号
		if(user.getOrg().getZyctype().equals("00001000")){
			user = (User) getSession().getAttribute("comuser");
		}
		if(form.getInOutStorList()==null||form.getInOutStorList().size()<1){		
			form.setReturninfo("入库失败,未获取到数据明细!");
			return "addInStorageFinish";
		}
		
		//解析出所有溯源码列表
		List<InStorSuccessCode> succList=new ArrayList<InStorSuccessCode>();
		for(InOutStorBox storbox:form.getInOutStorList()){
			String[] groupInfo=storbox.getGroupInfo().split(";");
			for(String rows:groupInfo){
				String[] group=rows.split(",");
				InStorSuccessCode inCode=new InStorSuccessCode();
				inCode.setCode(group[0]);
				inCode.setLasttime(group[1]);
				inCode.setOrgid(user.getOrgid());
				succList.add(inCode);
			}
		}
		//--写入溯源码临时状态表
		if(tempBoxDao.checkExsit(succList)==false)
		{		
			tempBoxDao.saveTempBoxBatch(succList);
		}
		//判断溯源码是否存在、and 时间戳相等
		if(tempBoxDao.checkStateExsit(succList)==false)
		{
			form.setReturninfo("该批溯源码已入库、不能重复入库!");
			return "addInStorageFinish";
		}
		
		//1--出入库总单**************************************
		form.setBuycorpname(user.getCompany().getCorpname());
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setCpccorp(user.getOrg().getCpccorp());//什么地方获取？
		form.setType(0);//药材
		form.setStortype(0);//入库
		form.setOperator(user.getUsername());
		form.setOpertime(Tools.getCurrentTime());
		form.setZstype(0);	
		form.setTotalweight(form.getTotalweightval());//前台页面需计算单次入库总重量
		Integer inoutstorid = inOutStorDao.save(form); 
		
		if(inoutstorid!=null&&inoutstorid!=0&&!inoutstorid.equals(0)){		
			//地区编码、将省市区封装到codeArea进行查询返回区域码
//			CodeArea codeArea = new CodeArea();
//			codeArea.setProvince(user.getOrg().getProvince());
//			codeArea.setCity(user.getOrg().getCity());
//			codeArea.setArea(user.getOrg().getArea());
//			String areacode = codeAreaDao.findByName(codeArea);	
			
			for(InOutStorBox storbox : form.getInOutStorList()){
				
				String areas=user.getOrg().getProvince()+","+user.getOrg().getCity()+","+user.getOrg().getArea();
				try{//获取卖家区域
					areas=codeAreaDao.findNameByCode(storbox.getAreacode());
				}catch(Exception e){
					e.printStackTrace();
				}
				String[] area=areas.split(",");
				
				//插入库存--同批次、规格合并===============
				MedStorage med=new MedStorage();
				med.setUserid(user.getUserid());
				med.setOrgid(user.getOrgid());
				med.setProvince(area[0]);
				med.setCity(area[1]);
				med.setArea(area[2]);
				med.setAreacode(storbox.getAreacode());//地区编码
				med.setCpccorp(user.getOrg().getCpccorp());
				med.setCpcmed(storbox.getBatchcpc());//批次
				med.setMedname(storbox.getProdname());//品名
				med.setProdcode(storbox.getProdcode());//商品编码
				med.setMedweight(storbox.getTotalweight());//总重量
				med.setOrimedweight(storbox.getTotalweight());//记录原始总重量
				//med.setChangemedweight(storbox.getTotalweight());//实际库存重量
				med.setMednum(storbox.getBoxitemnum());//包数
				med.setMednumweight(storbox.getBoxnumweight());//规格
				med.setState(0);//有库存
				med.setMedtype(1);//已分包				
				med.setPrintstate(3);//已打印
				med.setDownstate(2);//已下载		
				med.setCheckstate(0);
				med.setAddtime(Tools.getCurrentTime());
				Integer medstorid=medStorageDao.save(med);
				
				//插入出库子单--同批次、规格合并===============
				/*
				InOutStorBox inStorBox=new InOutStorBox();
				inStorBox.setInoutstorid(inoutstorid);//出入库单ID
				inStorBox.setBatchcpc(storbox.getBatchcpc());//批次号
				inStorBox.setBoxitemnum(storbox.getBoxitemnum());//包数
				inStorBox.setBoxnum(storbox.getBoxitemnum());////箱数,跟Boxitemnum一样
				inStorBox.setBoxnumweight(storbox.getBoxnumweight());//规格
				inStorBox.setProdcode(storbox.getProdcode());	//产品编码				
				inStorBox.setProdname(storbox.getProdname()); //产品名称						
				inStorBox.setTotalweight(storbox.getTotalweight());//根据规格，每箱数计算
				*/
				storbox.setInoutstorid(inoutstorid);
				storbox.setBoxnum(storbox.getBoxitemnum());
				storbox.setRealtotalweight(storbox.getTotalweight());//上面Totalweight的重量					
				Integer inoutstorboxid = inOutStorBoxDao.save(storbox); 
				
				//更新对应溯源码当前状态
				String[] groupInfo=storbox.getGroupInfo().split(";");
				for(String rows:groupInfo){
					String[] group=rows.split(",");
					Box box = new Box();
					box.setStorid(medstorid);//库存ID
					box.setBoxcode(group[0]);//溯源码
					box.setBoxweight(storbox.getBoxnumweight());//规格 					
					box.setState(0);
					box.setInstorboxid(inoutstorboxid);//出库单ID
					box.setBoxitemnum(1);//一个码就是一包
					box.setStortype(0);//0 药材
					boxDao.saveOjbect(box);		
				}
				
				//饮片生产中的药材入库不需要更新库存变化
				if(!(user.getOrg().getZyctype().equals("00100000"))){
					//根据组织id,商品编码,药材批次号查询当前最新库存
					MedStorage temp = new MedStorage();
					temp.setCpcmed(storbox.getBatchcpc());
					temp.setProdcode(storbox.getProdcode());
					temp.setOrgid(user.getOrgid());
					
					MedStorage medStorage = medStorageDao.findCurrentMedWeight(temp);
					medStorage.setCpccorp(user.getCpccorp());
					
					//更新中间件SQL
					ChengSql outSql = new ChengSql();
					outSql.setSql(ToolSql.updateMedStroage(medStorage));
					chengSqlDao.saveOutSql(outSql);
				}
				
			}
			
		}
		
		//成功入库溯源码异步上传中央平台
		zyczsXmlDao.saveOjbect(ToolsXml.createSuccInStoresync(succList, user,0));
		//更新溯源码时间戳
		tempBoxDao.updateTempBoxBatch(succList);			
		
		
		
		//记录操作日志
		OpLog opLog=new OpLog();
		int sysid=7;
		if(user.getOrg().getZyctype().equals("10000000")){ //种植
			sysid=1;
		}else if(user.getOrg().getZyctype().equals("01000000")){ //种植经销
			sysid=2;
		}else if(user.getOrg().getZyctype().equals("00100000")){ //生产
			sysid=4;
		}else if(user.getOrg().getZyctype().equals("00010000")){ //生产经销
			sysid=5;
		}else if(user.getOrg().getZyctype().equals("00001000")){ //市场
			sysid=3;
		}else if(user.getOrg().getZyctype().equals("00000100")){ //医院
			sysid=6;			
		}
		opLog.setMethod("药材入库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("入库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
		
		return "addInStorageFinish";
	}
	
	/**
	 * 药材入库查询
	 * @return
	 * @throws IOException 
	 */
	/*
	public String findInStorage() throws IOException{
		User user = (User) getSession().getAttribute("User");	
		if(form.getBoxcodes()==null||form.getBoxcodes().length()<3){
			form.setReturninfo("填写溯源码错误");
			return "findInStorage";
		}
		form.setBoxcodes(form.getBoxcodes().substring(0,form.getBoxcodes().length()-2));
		
		String[] boxcodesarray= form.getBoxcodes().split("BR");
		if(boxcodesarray==null||boxcodesarray.length<1||boxcodesarray.length>200)
		{
			form.setReturninfo("填写溯源码错误");
			return "findInStorage";
		}
		
		List<String> liststr =Arrays.asList(boxcodesarray);
		if(liststr!=null&&liststr.size()>0)
		{
			//封装入库溯源码xml
			String inXml = ToolsXml.sendPost(ToolsXml.create_InStore(liststr,user,0));
			System.out.println("==============="+inXml);
			Map<String,Object> resultMap=Tools.createInStorResult(inXml,0);
			
			//成功溯源码
			List<InStorSuccessCode> succList=(List)resultMap.get("succList");
			Map<String,List<InStorSuccessCode>> listMap = new HashMap<String,List<InStorSuccessCode>>();				
			if(succList!=null&&succList.size()>0)
			{
				for(InStorSuccessCode ms :succList){
					String cpc = ms.getBatchno()+ms.getWeight();			
					List<InStorSuccessCode> mslist =  listMap.get(cpc);
					if(mslist!=null&&mslist.size()>0){
						mslist.add(ms);
						listMap.put(cpc,mslist);
					}else{
						List<InStorSuccessCode> mslistnew = new ArrayList<InStorSuccessCode>();
						mslistnew.add(ms);
						listMap.put(cpc,mslistnew);
					}
				}
			}else{
				List<InStorFailCode> failList=(List)resultMap.get("failList");
				if(failList==null||failList.size()<=0){
					//封装全部错误溯源码
					Tools.setFailCodes(liststr, failList);
					resultMap.put("failList", failList);
				}
				
			}
			resultMap.put("listMap", listMap);
			getSession().setAttribute("medSellInStoragemap", resultMap);
		}else{
			form.setReturninfo("请输入正确的溯源码!");
			return "findInStorage";
		}
		

		return "findInStorage";
	}
	*/
	
	
	/**
	 * 药材入库
	 * @return
	 */
	/*
	public String addInStorage(){
		User user = (User) getSession().getAttribute("User");		
		Map<String,Object> resultMap = (Map<String,Object>)getSession().getAttribute("medSellInStoragemap");
	
		//成功溯源码
		List<InStorSuccessCode> succList=(List)resultMap.get("succList");
		//5--写入溯源码临时状态表
		if(tempBoxDao.checkExsit(succList)==false)
		{		
			tempBoxDao.saveTempBoxBatch(succList);
		}
		
		//判断溯源码是否存在、and 时间戳相等
		if(tempBoxDao.checkStateExsit(succList))
		{
			//页面整合显示列表
			Map<String,List<InStorSuccessCode>> listMap=(Map<String,List<InStorSuccessCode>>)resultMap.get("listMap");
			
			if(listMap!=null&&listMap.size()>0)
			{
				//1--出入库总单**************************************
				form.setBuycorpname(user.getCompany().getCorpname());
				form.setUserid(user.getUserid());
				form.setOrgid(user.getOrgid());
//				form.setCpccorp(form.getCpccorp());//什么地方获取？
				form.setType(0);//药材
				form.setStortype(0);//入库
				form.setOperator(user.getUsername());
				form.setOpertime(Tools.getCurrentTime());
				form.setZstype(0);	
//				form.setTotalweight(totalweight)//前台页面需计算单次入库总重量
				Integer inoutstorid = inOutStorDao.save(form); //插入出入库总单
				
				if(inoutstorid!=null&&inoutstorid!=0&&!inoutstorid.equals(0)){		
					for(Map.Entry<String,List<InStorSuccessCode>> m: listMap.entrySet()){ 
						List<InStorSuccessCode> succTotal=m.getValue();
						if(succTotal!=null&&succTotal.size()>0){
							InStorSuccessCode vo=succTotal.get(0);
							
							//读取每箱累加=总包数
							Integer mednum=succTotal.size();						
							//规格
							Double mednumweight=Tools.multiply(vo.getWeight(), String.valueOf(10000));
							//总重量
							Double medweight=Tools.multiply(String.valueOf(mednumweight), mednum+"");
							
							//2--新增库存**************************************
							//地区编码
							//将省市区封装到codeArea进行查询返回区域码
							CodeArea codeArea = new CodeArea();
							codeArea.setProvince(user.getOrg().getProvince());
							codeArea.setCity(user.getOrg().getCity());
							codeArea.setArea(user.getOrg().getArea());
							
							String areacode = codeAreaDao.findByName(codeArea);				
							//饮片批次码系统自动生成
//							Map map = new HashMap();
//							map.put("typeid","1");//批次号类型都为1
//							map.put("companycodein",user.getCpccorp());
//							regionDao.findByCode(map);		
//							String cpctablet = map.get("zycid").toString()+Tools.getCheckCode(map.get("zycid").toString());		
							//String cpctabletimg=Tools.getTwoCode("*CPC*ZYCZS"+cpctablet);//二维码路径		
							
							MedStorage stor=new MedStorage();
							stor.setUserid(user.getUserid());
							stor.setOrgid(user.getOrgid());
							stor.setProvince(user.getOrg().getProvince());
							stor.setCity(user.getOrg().getCity());
							stor.setArea(user.getOrg().getArea());
							stor.setAreacode(areacode);//地区编码
							stor.setCpcmed(vo.getBatchno());//批次
							stor.setMedname(vo.getPname());//品名
							stor.setProdcode(vo.getPcode());//商品编码
							stor.setMedweight(medweight);//总重量
							stor.setMednum(mednum);//包数
							stor.setMednumweight(mednumweight);//规格
							stor.setState(0);//有库存
							stor.setMedtype(1);//已分包
							stor.setPrintstate(3);//已打印
							stor.setDownstate(2);//已下载		
							stor.setCheckstate(0);
							Integer medstorid=medStorageDao.save(stor);
							
							//3--出入库单明细--名称、批次、规格 整合 **************************************
							InOutStorBox storbox=new InOutStorBox();
							storbox.setInoutstorid(inoutstorid);//出入库单ID
							storbox.setBatchcpc(vo.getBatchno());//批次号
							storbox.setBoxnum(succTotal.size());//箱数 + 累加
							storbox.setBoxitemnum(mednum);//包数
							storbox.setBoxnum(mednum);//跟Boxitemnum一样
							storbox.setBoxnumweight(mednumweight);//规格
							storbox.setProdcode(vo.getPcode());	//产品编码	
							storbox.setProdname(vo.getPname()); //产品名称						
							storbox.setTotalweight(medweight);//根据规格，每箱数计算
							storbox.setRealtotalweight(medweight);//上面Totalweight的重量					
							Integer inoutstorboxid = inOutStorBoxDao.save(storbox); 	//插入出入库子单	
							
							//4--BOX箱码 **************************************
							for(InStorSuccessCode ms : succTotal){
								Box box = new Box();
								box.setStorid(medstorid);//库存ID
								box.setBoxcode(ms.getCode());//溯源码
								Double spec=Tools.multiply(ms.getWeight(), String.valueOf(10000));
								//每个码就是一包
								box.setBoxweight(Tools.multiply(String.valueOf(spec),String.valueOf("1")));//每包重量=规格 x 包数						
								box.setState(0);
								box.setInstorboxid(inoutstorboxid);//出库单ID
//								box.setBoxitemnum(Integer.parseInt(ms.getBoxitemnum()));//每箱包数  
								box.setStortype(0);//0 药材
								boxDao.saveOjbect(box);//更新BOX明细												
							}					
						}						
					}
					
					//成功入库溯源码异步上传中央平台
					zyczsXmlDao.saveOjbect(ToolsXml.createSuccInStoresync(succList, user,0));
					//更新溯源码时间戳
					tempBoxDao.updateTempBoxBatch(succList);
					
					this.getSession().removeAttribute("medSellInStoragemap");
					scalestatDao.updateByComsta(user.getCpccorp());
					
					//记录操作日志
					OpLog opLog=new OpLog();
					opLog.setSysid(2);
					opLog.setMethod("药材入库");
					opLog.setLoginName(user.getLoginname());
					opLog.setUserName(user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLog.setContent("入库单编号:"+inoutstorid);
					opLogDao.saveOjbect(opLog);
				}
			}
		}else{
			form.setReturninfo("该批溯源码已入库、不能重复入库!");
		}
		
		
		return "addInStorageFinish";
	}
	*/
	
	
	/*
	 * 单条溯源码出库查询
	 *  Ajax方式返回
	 */	
	@SuppressWarnings("unchecked")
	public void findOutCode() { 
		User user = (User) getSession().getAttribute("User");		
		//市场账号
		if(user.getOrg().getZyctype().equals("00001000")){//flag为4时是市场药材检验 
			user = (User) getSession().getAttribute("comuser");
		}
		HttpServletResponse response=this.getResponse();			
		try{
			JSONObject jsonObject = new JSONObject(); 				
			form.setBoxcodes(form.getBoxcodes().replaceAll("\r\n", ""));
			Map boxmap =new HashMap();
			boxmap.put("boxcodes", "'"+form.getBoxcodes()+"'");
			boxmap.put("orgid", user.getOrgid());						
			List<MedStorage> medstorage = medStorageDao.findByBox(boxmap);		
			
					
			if(medstorage!=null&&medstorage.size()>0){
				MedStorage stoVO=medstorage.get(0);	
				System.out.println("========='"+stoVO.getBoxcode()+"','"+stoVO.getCpcmed()+"','"+stoVO.getProdcode()+"'");
				//溯源码锁定状态查询
				List<Freeze> freezeList=boxDao.findByFreezeList("'"+stoVO.getBoxcode()+"','"+stoVO.getCpcmed()+"','"+stoVO.getProdcode()+"'");
				if(freezeList!=null&&freezeList.size()>0){
					jsonObject.put("stoVO",null); 
		            jsonObject.put("code", form.getBoxcodes());
		            jsonObject.put("returnCode", 1);
		    		jsonObject.put("returnInfo", freezeList.get(0).getCpclevelMap()+"-锁定("+freezeList.get(0).getReason()+")");	  
		    		
					Tools.printJson(response, jsonObject.toString());
					return;
				}
				
				
				jsonObject.put("stoVO",stoVO); 
	            jsonObject.put("code", form.getBoxcodes());
	    		jsonObject.put("returnCode", 0);
	    		jsonObject.put("returnInfo", "成功");		
	    		  	   		
			}else{
				jsonObject.put("stoVO",null); 
	            jsonObject.put("code", form.getBoxcodes());
	            jsonObject.put("returnCode", 1);
	    		jsonObject.put("returnInfo", "无效的溯源码");	    	
	    		  	
			}				
	        Tools.printJson(response, jsonObject.toString());
		}catch(Exception e){
			String json ="{\"code\":\""+form.getBoxcodes()+"\",\"returnCode\":1,\"returnInfo\":\"服务器异常\"}"; 
			Tools.printJson(response, json);
			e.printStackTrace();
		}
    } 
	
	
	public String addOutCode(){
		User user = (User) getSession().getAttribute("User");		
		//市场账号
		if(user.getOrg().getZyctype().equals("00001000")){//flag为4时是市场药材检验 
			user = (User) getSession().getAttribute("comuser");
		}
		
		if(form.getInOutStorList()==null||form.getInOutStorList().size()<1){		
			form.setReturninfo("出库失败,未获取到数据明细!");
			return "addOutStorageFinish";
		}		
		
			
		//出库总单
		form.setSellcorpname(user.getCompany().getCorpname());
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setCpccorp(form.getCpccorp());
		form.setTotalweight(form.getTotalweightval());
		form.setTotalmoney(form.getTotalmoneyval());
		form.setType(0);//药材
		form.setStortype(1);//出库
		form.setOpertime(Tools.getCurrentTime());
		Integer inoutstorid = inOutStorDao.save(form); 
		//非溯源公司数据录入
		if(form.getZstype()==1){
			CompanyOther companyOther = new CompanyOther();
			companyOther.setMobileother(form.getMobile());
			companyOther.setAddressother(form.getAddress());
			companyOther.setCorpnameother(form.getBuycorpname());
			companyOther.setOrgid(user.getOrgid());
			companyOtherDao.save(companyOther);
		}
		//出库明细数据录入
		if(inoutstorid!=null&&inoutstorid!=0&&!inoutstorid.equals(0)){
			for(InOutStorBox storbox : form.getInOutStorList()){	
				//插入出库子单--同批次、规格合并===============
				storbox.setProdcode(storbox.getProdcode());
				storbox.setInoutstorid(inoutstorid);
				storbox.setBoxitemnum(storbox.getBoxitemnum());//总包数
				storbox.setBoxnum(storbox.getBoxitemnum());
				Integer inoutstorboxid = inOutStorBoxDao.save(storbox); 
				
				//更新对应溯源码当前状态
				String[] groupInfo=storbox.getGroupInfo().split(";");
				for(String rows:groupInfo){
					String[] group=rows.split(",");
					Box box = new Box();
					box.setBoxcode(group[0]);//溯源码以逗号分隔每条溯源码
					box.setState(1);
					box.setOutstorboxid(inoutstorboxid);
					box.setFlag(1);	//当flag为1时，更新操作state=0;
					boxDao.updateOjbect(box);//更新BOX明细
					
					//更新溯源码对应库存状态、当前包数
					MedStorage med = new MedStorage();
					med.setMedstorid(Integer.parseInt(group[1]));
					med=medStorageDao.findById(med);
					//只剩下一包、更新库存状态为无库存状态
					if(med.getMednum()==1){
						med.setState(1);
						med.setMedweight(0.0);
					}else{
						med.setMedweight(med.getMedweight()-med.getMednumweight());
					}
					
					med.setMednum(med.getMednum()-1);
					medStorageDao.update(med);
				}
				
			
				
				//根据组织id,商品编码,药材批次号查询当前最新库存
				MedStorage temp = new MedStorage();
				temp.setCpcmed(storbox.getBatchcpc());
				temp.setProdcode(storbox.getProdcode());
				temp.setOrgid(user.getOrgid());
				
				MedStorage medStorage = medStorageDao.findCurrentMedWeight(temp);
				medStorage.setCpccorp(user.getCpccorp());
				
				//更新中间件SQL
				ChengSql outSql = new ChengSql();
				outSql.setSql(ToolSql.updateMedStroage(medStorage));
				chengSqlDao.saveOutSql(outSql);
				
			}		
			
		}
		
		zyczsXmlDao.saveOjbect(ToolsXml.create_Med_outstore2(form,form.getInOutStorList(),user));
//		scalestatDao.updateByComsta(user.getCpccorp());
		
		//记录操作日志
		OpLog opLog=new OpLog();
		int sysid=7;
		if(user.getOrg().getZyctype().equals("10000000")){ //种植
			sysid=1;
		}else if(user.getOrg().getZyctype().equals("01000000")){ //种植经销
			sysid=2;
		}else if(user.getOrg().getZyctype().equals("00100000")){ //生产
			sysid=4;
		}else if(user.getOrg().getZyctype().equals("00010000")){ //生产经销
			sysid=5;
		}else if(user.getOrg().getZyctype().equals("00001000")){ //市场
			sysid=3;
		}else if(user.getOrg().getZyctype().equals("00000100")){ //医院
			sysid=6;			
		}
		opLog.setMethod("药材出库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("出库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
			
		
		
		return "addOutStorageFinish";
	}
	
	/**
	 * 药材出库查询
	 * @return
	 */
	/*
	public String findOutStorage(){
		User user = (User)getSession().getAttribute("User");
		if(form.getBoxcodes()==null||form.getBoxcodes().length()<3){
			form.setReturninfo("填写溯源码错误");
			return "findOutStorage";
		}
		Map<String,List<MedStorage>> map = new HashMap<String,List<MedStorage>>();
		// 记录失败溯源码
		List<InStorFailCode> failList = new ArrayList<InStorFailCode>();
		
		//溯源码锁定状态查询
		List<Freeze> freezeList=boxDao.findByFreezeList(form.getBoxcodes(), user.getOrgid(), 0);
		//设置锁定溯源码
		Tools.setFreezes(form, freezeList, failList);
		
		if(!"".equals(form.getBoxcodes())){
			String[] boxcodesarray= form.getBoxcodes().split("BR");
			List<String> liststr =Arrays.asList(boxcodesarray);
			
			Map boxmap =new HashMap();
			boxmap.put("boxcodes", "'"+form.getBoxcodes().replaceAll("BR", "','")+"'");
			boxmap.put("orgid", user.getOrgid());
			List<MedStorage> medstorage = medStorageDao.findByBox(boxmap);
			
			if(medstorage!=null&&medstorage.size()>0){
				for(String codes:liststr){
					int i = 0;
					for(MedStorage ms :medstorage){
						if(codes.equals(ms.getBoxcode())){
							i=1;
							break;
						}
					}
					if(i==0){
						InStorFailCode instor=new InStorFailCode();
						instor.setReason("0");
						instor.setCode(codes);
						failList.add(instor);
					}
				}//同批次、规格合并
				for(MedStorage ms :medstorage){
					String cpc = ms.getCpcmed()+ms.getBoxweight();
					List<MedStorage> mslist =  map.get(cpc);
					if(mslist!=null&&mslist.size()>0){
						mslist.add(ms);
						map.put(cpc,mslist);
					}else{
						List<MedStorage> mslistnew = new ArrayList<MedStorage>();
						mslistnew.add(ms);
						map.put(cpc,mslistnew);
					}
				}
			}else{
				//封装全部错误溯源码
				Tools.setFailCodes(liststr, failList);
			}	
			
		}		
		getSession().setAttribute("medSellOutStoragemap", map);
		getRequest().setAttribute("failList", failList);
		return "addOutStorage";
	}
	*/
	/**
	 * 药材出库
	 * @return
	 */
	/*
	public String addOutStorage(){
		
		User user = (User) getSession().getAttribute("User");
		Map<String,List<MedStorage>> map = (Map<String,List<MedStorage>>)getSession().getAttribute("medSellOutStoragemap");
		if(form.getDatastr()==null||form.getDatastr().length()<1){
			form.setReturninfo("出库失败,获取明细数据出错!");
			return "addOutStorageFinish";
		}
		List<InOutStorBox> storboxlist = Tools.inOutStorageMedPack(form.getDatastr(),user.getOrgid());
		if(storboxlist==null||storboxlist.size()<1){
			form.setReturninfo("出库失败,解析明细数据出错!");
			return "addOutStorageFinish";
		}
		form.setSellcorpname(user.getCompany().getCorpname());
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setCpccorp(form.getCpccorp());
		form.setTotalweight(form.getTotalweightval());
		form.setTotalmoney(form.getTotalmoneyval());
		form.setType(0);//药材
		form.setStortype(1);//出库
		form.setOpertime(Tools.getCurrentTime());
		Integer inoutstorid = inOutStorDao.save(form); //插入出入库总单
		
		
		if(form.getZstype()==1){
			CompanyOther companyOther = new CompanyOther();
			companyOther.setMobileother(form.getMobile());
			companyOther.setAddressother(form.getAddress());
			companyOther.setCorpnameother(form.getBuycorpname());
			companyOther.setOrgid(user.getOrgid());
			companyOtherDao.save(companyOther);
		}
		
		if(inoutstorid!=null&&inoutstorid!=0&&!inoutstorid.equals(0)){
			for(InOutStorBox storbox : storboxlist){
				
				List<MedStorage> medstoragelist = map.get(storbox.getKeyname());
				storbox.setProdcode(medstoragelist.get(0).getProdcode());
				storbox.setInoutstorid(inoutstorid);
				storbox.setBoxitemnum(storbox.getBoxitemnum());
				Integer inoutstorboxid = inOutStorBoxDao.save(storbox); 	//插入出入库子单
				if(medstoragelist!=null&&medstoragelist.size()>0){
					int mednum=0;
					for(MedStorage ms : medstoragelist){
						Box box = new Box();
						box.setBoxcode(ms.getBoxcode());
						box.setState(1);
						box.setOutstorboxid(inoutstorboxid);
						box.setFlag(1);	//当flag为1时，更新操作state=0;
						boxDao.updateOjbect(box);					//更新BOX明细
						mednum++;
					}
					MedStorage med = medstoragelist.get(0);
					if(mednum==med.getMednum()){
						med.setState(1);
					}
					med.setMednum(med.getMednum()-mednum);
					medStorageDao.update(med);
				}
			}
		}
		zyczsXmlDao.saveOjbect(ToolsXml.create_Med_outstore(form,storboxlist,map,user));
		this.getSession().removeAttribute("medSellOutStoragemap");
		scalestatDao.updateByComsta(user.getCpccorp());
		
		//记录操作日志
		OpLog opLog=new OpLog();
		opLog.setSysid(2);
		opLog.setMethod("药材出库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("出库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
		
		return "addOutStorageFinish";
	}
	*/
	public void setChengSqlDao(IChengSqlDao chengSqlDao) {
		this.chengSqlDao = chengSqlDao;
	}

}
