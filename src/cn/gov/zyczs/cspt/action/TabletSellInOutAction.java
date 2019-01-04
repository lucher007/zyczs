package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSON;
import net.sf.json.JSONObject;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.ICodeRegionDao;
import cn.gov.zyczs.cspt.dao.ICompanyOtherDao;
import cn.gov.zyczs.cspt.dao.IInOutStorBoxDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IRegionDao;
import cn.gov.zyczs.cspt.dao.ITabletDao;
import cn.gov.zyczs.cspt.dao.ITabletStorageDao;
import cn.gov.zyczs.cspt.dao.ITempBoxDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.CodeArea;
import cn.gov.zyczs.cspt.po.CompanyOther;
import cn.gov.zyczs.cspt.po.Freeze;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.InStorFailCode;
import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;
import cn.gov.zyczs.cspt.po.ZyczsXml;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title TabletSellAction.java
 * @Package 
 * @version 1.0
 * 饮片经销出、入库Action
 */
public class TabletSellInOutAction  extends BaseAction implements ModelDriven<InOutStor>{
	
	InOutStor form = new InOutStor();
	public InOutStor getModel() {
		return form;
	}
	
	private ITabletStorageDao tabletStorageDao;
	private ITabletDao tabletDao;
	private IBoxDao boxDao;

	public void setTabletDao(ITabletDao tabletDao) {
		this.tabletDao = tabletDao;
	}

	public void setTabletStorageDao(ITabletStorageDao tabletStorageDao) {
		this.tabletStorageDao = tabletStorageDao;
	}
	
	public void setBoxDao(IBoxDao boxDao) {
		this.boxDao = boxDao;
	}
	
	private IOrgDao orgDao;
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	
	private IInOutStorBoxDao inOutStorBoxDao;
	
	public void setInOutStorBoxDao(IInOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}
	
	private IInOutStorDao inOutStorDao;
	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}
	
	private ICompanyOtherDao companyOtherDao;
	public void setCompanyOtherDao(ICompanyOtherDao companyOtherDao) {
		this.companyOtherDao = companyOtherDao;
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
	
	/**
	 * 行政区划dao
	 */
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	/**
	 * 查询出库企业历史列表
	 * @return type,stortype,orgid
	 * @throws IOException 
	 */
	public String companyChoice(){
		User user = (User)getSession().getAttribute("User");
//		form.setType(1);//饮片
//		form.setStortype(1);//出库
		form.setPager_openset(5);//一页显示10行
		form.setZstype(0);//溯源企业类型
		form.setPager_count(inOutStorDao.findByCompanyCount(form));
		form.setInoutstoragelist(inOutStorDao.findByCompanyList(form));
		
		return "companyChoice";
	}
	
	/**
	 * 查询出库非溯源企业历史列表
	 * @return type,stortype,orgid
	 * @throws IOException 
	 */
	public String companyOtherChoice(){
		User user = (User)getSession().getAttribute("User");	
		form.setPager_openset(5);//一页显示10行
		form.setPager_count(companyOtherDao.findByCompanyCount(form));
		form.setOtherCompList(companyOtherDao.findByCompanyList(form));
		
		return "companyOtherChoice";
	}
	
	
	@SuppressWarnings("unchecked")
	public void findInCode() { 
		User user = (User) getSession().getAttribute("User");		
		
		HttpServletResponse response=this.getResponse();
				
		try{
			String[] boxcodesarray= form.getBoxcodes().split("\r\n");
			List<String> liststr =Arrays.asList(boxcodesarray);
			if(liststr!=null&&liststr.size()>0)
			{
				//封装入库溯源码xml
				String inXml = ToolsXml.sendPost(ToolsXml.create_InStore(liststr,user,1));
				System.out.println("resp==============="+inXml);
				if(inXml==null||inXml.equals("")){
					String json ="{\"code\":\""+form.getBoxcodes()+"\",\"returnCode\":1,\"returnInfo\":\"入库接口异常\"}"; 
					Tools.printJson(response, json);
					return;
				}
				
				
				
				Map<String,Object> resultMap=Tools.createInStorResult(inXml,1);
				
				//成功溯源码
				List<InStorSuccessCode> succList=(List)resultMap.get("succList");
				JSONObject jsonObject = new JSONObject(); 		
				if(succList!=null&&succList.size()>0)
				{
					InStorSuccessCode stoVo=succList.get(0);
					//保存子级信息列表
					if(stoVo.getChildList()!=null&&stoVo.getChildList().size()>0){
						
						Map<String,Object> chileMap=null;
						if(this.getRequest().getSession().getAttribute("inStor_childMap")==null){
							chileMap=new HashMap<String,Object>();
						}else{
							chileMap=(Map)this.getRequest().getSession().getAttribute("inStor_childMap");
						}	
						chileMap.put(stoVo.getCode(), stoVo.getChildList());
						this.getRequest().getSession().setAttribute("inStor_childMap", chileMap);
					}
					
					
					
					jsonObject.put("stoVO",stoVo); 
		            jsonObject.put("code", stoVo.getCode());
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
	
	
	
	/**
	 * 查询出用户输入的饮片入库溯源码
	 * @return String
	 * @throws IOException 
	 */
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
			String inXml = ToolsXml.sendPost(ToolsXml.create_InStore(liststr,user,1));
			System.out.println("==============="+inXml);
			
			Map<String,Object> resultMap=Tools.createInStorResult(inXml,1);
			
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
			getSession().setAttribute("tabletSellInStoragemap", resultMap);
		}else{
			form.setReturninfo("请输入正确的溯源码!");
			return "findInStorage";
		}
		

		return "addInStorage";
	}
	
	public String forInCode(){
		if(this.getRequest().getSession().getAttribute("inStor_childMap")!=null){
			this.getRequest().getSession().removeAttribute("inStor_childMap");
		}
		
		return "forInCode";
	}
	
	public String addInCode(){
		User user = (User) getSession().getAttribute("User");		
		
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
//		form.setCpccorp(form.getCpccorp());//什么地方获取？
		form.setType(1);//饮片
		form.setStortype(0);//入库
		form.setOperator(user.getUsername());
		form.setOpertime(Tools.getCurrentTime());
		form.setZstype(0);	
		form.setTotalweight(form.getTotalweightval());//前台页面需计算单次入库总重量
		Integer inoutstorid = inOutStorDao.save(form); 
		
		if(inoutstorid!=null&&inoutstorid!=0&&!inoutstorid.equals(0)){
			//地区编码、将省市区封装到codeArea进行查询返回区域码
			CodeArea codeArea = new CodeArea();
			codeArea.setProvince(user.getOrg().getProvince());
			codeArea.setCity(user.getOrg().getCity());
			codeArea.setArea(user.getOrg().getArea());
			String areacode = codeAreaDao.findByName(codeArea);	
			
			for(InOutStorBox storbox : form.getInOutStorList()){	
										
				Integer inoutstorboxid =0;
				Integer tabletstorid=0;
				if(storbox.getCodetype()!=8){//8级码过来的数据没有基础信息-----	
					//库存=============================================
					//插入出库子单--同批次、规格合并===============						
					storbox.setInoutstorid(inoutstorid);//出入库单ID
					storbox.setRealtotalweight(storbox.getTotalweight());
					if(storbox.getCodetype()==7){
						storbox.setBoxnum(1);
					}else if(storbox.getCodetype()==5){
						storbox.setBoxnum(1);
					}
					inoutstorboxid=inOutStorBoxDao.save(storbox); 
					
					
					//插入库存--同批次、规格合并===============
					TabletStorage stor=new TabletStorage();
					stor.setUserid(user.getUserid());
					stor.setOrgid(user.getOrgid());
					stor.setTabletid(0);
					stor.setProvince(user.getOrg().getProvince());
					stor.setCity(user.getOrg().getCity());
					stor.setArea(user.getOrg().getArea());
					stor.setAreacode(areacode);//地区编码
					stor.setCpctablet(storbox.getBatchcpc());//批次
					stor.setTabletname(storbox.getProdname());//品名
					stor.setProdcode(storbox.getProdcode());//商品编码
					stor.setTabletweight(storbox.getTotalweight());//总重量
					stor.setTabletnum(storbox.getBoxitemnum());//包数
					stor.setTabletnumweight(storbox.getBoxnumweight());//规格				
					if(storbox.getCodetype()==7){
						stor.setPacktype("7");
						stor.setTabletboxnum(storbox.getBoxnum());//箱数 boxitemnum
						stor.setTabletboxitemnum(storbox.getBoxitemnum()/storbox.getBoxnum());//总包数除以箱数
					}else if(storbox.getCodetype()==6){
						stor.setPacktype("6");
						stor.setTabletboxnum(storbox.getBoxnum());//箱数 boxitemnum
						stor.setTabletboxitemnum(storbox.getTabletboxitemnum());//每箱包数 ..库存里面的每箱包数 依照入库中的是不对的
					}else if(storbox.getCodetype()==5){
						stor.setPacktype("5");
						stor.setTabletboxnum(0);//箱数 boxitemnum
						stor.setTabletboxitemnum(0);
					}
					stor.setState(0);//有库存
					stor.setTablettype(1);//已分包
					stor.setPrintstate(3);//已打印
					stor.setDownstate(2);//已下载		
					tabletstorid=tabletStorageDao.save(stor);
				}
				
				//二级箱码
				if(storbox.getCodetype()==6){
					//更新对应溯源码当前状态
					String[] groupInfo=storbox.getGroupInfo().split(";");//该字段保存 溯源码、溯源码时间戳、每箱包数,每个属性以逗号隔开、每组以分号分隔
					for(String rows:groupInfo){
						String[] group=rows.split(",");
						Box box = new Box();
						box.setStorid(tabletstorid);//库存ID
						box.setBoxcode(group[0]);//溯源码
						box.setBoxweight(Tools.multiply(String.valueOf(storbox.getBoxnumweight()),group[2]));//每箱重量=规格 x 每箱包数						
						box.setState(0);
						box.setInstorboxid(inoutstorboxid);//出库单ID
						box.setBoxitemnum(Integer.parseInt(group[2]));//每箱包数
						box.setStortype(1);//1饮片
						box.setPackcode("6");
						boxDao.saveOjbect(box);//更新BOX明细	
						
					}
				}else if(storbox.getCodetype()==8){
					//8级入库工单
					InOutStorBox storbox_8=new InOutStorBox();
					storbox_8.setBoxnum(1);
					storbox_8.setTotalweight(storbox.getTotalweight());
					storbox_8.setRealtotalweight(storbox.getTotalweight());
					storbox_8.setInoutstorid(inoutstorid);
//					storbox_8.setProdnumber(prodnumber)
//					storbox_8.setBoxitemnum(boxs.getBoxitemnum()*1);//每箱包数*箱数						
					storbox_8.setCodetype(8);//
					int inoutstorboxid_8 =inOutStorBoxDao.save(storbox_8); 
					
					//保存8级溯源码
					Box box_8 = new Box();
					box_8.setStorid(0);//库存ID
					box_8.setBoxcode(storbox.getCode());//溯源码
					box_8.setBoxweight(storbox.getTotalweight());//每箱重量=规格 x 每箱包数						
					box_8.setState(0);
					box_8.setOrgid(user.getOrgid());
					box_8.setInstorboxid(inoutstorboxid_8);//出库单ID
//					box.setBoxitemnum(storbox.getBoxnum());//箱数
					box_8.setStortype(1);//1饮片
					box_8.setPackcode("8");
					boxDao.saveOjbect(box_8);//更新BOX明细	
					
					//获取子级码列表
					Map<String,Object> chileMap=null;
					if(this.getRequest().getSession().getAttribute("inStor_childMap")==null){
						chileMap=new HashMap<String,Object>();
					}else{
						chileMap=(Map)this.getRequest().getSession().getAttribute("inStor_childMap");
					}
					
					
					List<InStorSuccessCode> childList=(List<InStorSuccessCode>)chileMap.get(storbox.getCode());
					for(InStorSuccessCode child:childList){
						
						//子级入库工单=====
						InOutStorBox storbox_b=new InOutStorBox();
						storbox_b.setBatchcpc(child.getBatchno());
						storbox_b.setBoxnum(1);
						storbox_b.setBoxnumweight(Tools.dealNullDouble(child.getWeight(), 0)*10);
						storbox_b.setTotalweight(Tools.multiply(child.getWeight(),child.getBoxitemnum())*10);//规格*包数
						storbox_b.setRealtotalweight(Tools.multiply(child.getWeight(),child.getBoxitemnum())*10);
						storbox_b.setProdname(child.getPname());
						storbox_b.setInoutstorid(inoutstorid);//
						storbox_b.setProdcode(child.getPcode());
//						storbox_b.setProdnumber(prodnumber)
						storbox_b.setBoxitemnum(Tools.dealNullInt(child.getBoxitemnum(), 0));//每箱包数*箱数						
						storbox_b.setCodetype(Tools.dealNullInt(child.getCode().substring(0, 1), 6));//
						storbox_b.setPackstorboxid(inoutstorboxid_8);
						int inoutstorboxid_b =inOutStorBoxDao.save(storbox_b); 	
						
						//子级库存=====
						TabletStorage stor=new TabletStorage();
						stor.setUserid(user.getUserid());
						stor.setOrgid(user.getOrgid());
						stor.setTabletid(0);
						stor.setProvince(user.getOrg().getProvince());
						stor.setCity(user.getOrg().getCity());
						stor.setArea(user.getOrg().getArea());
						stor.setAreacode(areacode);//地区编码
						stor.setCpctablet(child.getBatchno());//批次
						stor.setTabletname(child.getPname());//品名
						stor.setProdcode(child.getPcode());//商品编码
						stor.setTabletweight(Tools.multiply(child.getWeight(),child.getBoxitemnum())*10);//总重量
						//总包数===5开头头是以计算包数为标准--减库存减的是包数 、而6开头的是减的是箱数
						if(Tools.dealNullInt(child.getCode().substring(0, 1), 6)==5){
							stor.setTabletnum(0);//包数
							stor.setTabletboxitemnum(0);
						}else{//6===============
							stor.setTabletnum(Tools.dealNullInt(child.getBoxitemnum(), 0));//包数							
							stor.setTabletboxitemnum(Tools.dealNullInt(child.getBoxitemnum(), 0));
						}						
						stor.setTabletboxnum(0);//箱数 boxitemnum
						stor.setTabletnumweight(Tools.dealNullDouble(child.getWeight(), 0)*10);//规格					
						stor.setState(1);//无库存
						stor.setTablettype(1);//已分包
						stor.setPrintstate(3);//已打印
						stor.setDownstate(2);//已下载		
						stor.setPacktype("8");					
						Integer tabletstorid_b=tabletStorageDao.save(stor);
						
						//保存子级溯源码
						Box box_b = new Box();
						box_b.setStorid(tabletstorid_b);//库存ID
						box_b.setBoxcode(child.getCode());//溯源码
						box_b.setBoxweight(Tools.multiply(child.getWeight(),child.getBoxitemnum())*10);//每箱重量=规格 x 每箱包数						
						box_b.setState(0);
						box_b.setOrgid(user.getOrgid());
						box_b.setInstorboxid(inoutstorboxid_b);//出库单ID
						box_b.setBoxitemnum(Tools.dealNullInt(child.getBoxitemnum(), 0));//每箱实际包数
						box_b.setStortype(1);//1饮片
						box_b.setPackcode(storbox.getCode());
						boxDao.saveOjbect(box_b);//更新BOX明细	
						
					}
						
					
				}else if(storbox.getCodetype()==7){
					//解析二级箱码
					if(!"".equals(storbox.getBoxsCode())){
						String[] boxsCode=storbox.getBoxsCode().split(";");
						for(String bcode:boxsCode){
							Box box = new Box();
							box.setStorid(tabletstorid);//库存ID
							box.setBoxcode(bcode);//溯源码
							box.setBoxweight(Tools.multiply(String.valueOf(storbox.getBoxnumweight()),storbox.getTabletboxitemnum()+""));//每箱重量=规格 x 每箱包数						
							box.setState(0);
							box.setInstorboxid(inoutstorboxid);//出库单ID
							box.setBoxitemnum(storbox.getTabletboxitemnum());//每箱包数
							box.setStortype(1);//1饮片
							box.setPackcode(storbox.getCode());
							boxDao.saveOjbect(box);//更新BOX明细	
						}
					}
					//保存三级溯源码
					Box box = new Box();
					box.setStorid(tabletstorid);//库存ID
					box.setBoxcode(storbox.getCode());//溯源码
					box.setBoxweight(storbox.getTotalweight());//每箱重量=规格 x 每箱包数						
					box.setState(0);
					box.setInstorboxid(inoutstorboxid);//出库单ID
					box.setBoxitemnum(storbox.getBoxnum());//箱数
					box.setStortype(1);//1饮片
					box.setPackcode("7");
					boxDao.saveOjbect(box);//更新BOX明细	
					
				}
				else if(storbox.getCodetype()==5){
					//保存三级溯源码
					Box box = new Box();
					box.setStorid(tabletstorid);//库存ID
					box.setBoxcode(storbox.getCode());//溯源码
					box.setBoxweight(storbox.getTotalweight());//每箱重量=规格 x 每箱包数						
					box.setState(0);
					box.setInstorboxid(inoutstorboxid);//出库单ID
					box.setBoxitemnum(1);//箱数
					box.setStortype(1);//1饮片
					box.setPackcode("5");
					boxDao.saveOjbect(box);//更新BOX明细	
				}
				
			}
			
		}
		//成功入库溯源码异步上传中央平台
		zyczsXmlDao.saveOjbect(ToolsXml.createSuccInStoresync(succList, user,1));
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
		opLog.setMethod("饮片入库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("入库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
		
		
		if(this.getRequest().getSession().getAttribute("inStor_childMap")!=null){
			this.getRequest().getSession().removeAttribute("inStor_childMap");
		}
		
		
		return "addInStorageFinish";
	}
	
	/*
	 * 饮片装袋-7
	 */
	public String addBagCode(){
		User user = (User) getSession().getAttribute("User");		
		
		if(form.getInOutStorList()!=null&&form.getInOutStorList().size()>0){	
			
//			Map map=new HashMap();
//			map.put("cpccorp", user.getCpccorp());
//			map.put("prodcode",form.getProdcode());
//			boxDao.saveBoxTabletBag(map);
//			String packCode=map.get("zycid").toString();
			
			
			Integer storid=0;
			String cpctablet="";
			String areacode="";
			String pname="";
			String pcode="";
			Double weight=0.0;
			String xmlCode="";
			int num=0;
			for(InOutStorBox storbox:form.getInOutStorList()){
				
				if(num==0){
					cpctablet=storbox.getBatchcpc();			
					pname=storbox.getProdname();
					pcode=storbox.getProdcode();
					weight=storbox.getTotalweight();
					
				}
				num++;
				
				xmlCode+="<code desc=\"溯源码\">"+storbox.getCode()+"</code>";
				
				storid=storbox.getInoutstorboxid();
				//更新箱码信息
				Box b=new Box();
				b.setStortype(1);
				b.setBoxcode(storbox.getCode());
				b.setStorid(storid);
				b.setPackcode(form.getPackcode());
				b.setState(0);
				boxDao.updatePackcode(b);
				//更新对应库存信息			
				TabletStorage tab =  new TabletStorage();
				tab.setTabletstorid(storid);
				tab=tabletStorageDao.findById(tab);	
				//获取地区编码---下面用
				areacode=tab.getAreacode();
				
				//只剩下一箱、更新库存状态为无库存状态
				if(tab.getTabletboxnum()==1){
					tab.setState(1);
				}
				tab.setTabletboxnum(tab.getTabletboxnum()-1);//箱数
				//更新库存当前饮片包数
				tab.setTabletnum(tab.getTabletnum()-storbox.getBoxitemnum());//饮片包数		
				tab.setTabletweight(Tools.subtr(tab.getTabletweight()+"",storbox.getBoxnumweight()+""));//当前总重量
				tabletStorageDao.update(tab);
						
			}
			//设置袋码
			Box box=new Box();
			box.setOrgid(user.getOrgid());
			box.setStorid(storid);
			box.setBoxcode(form.getPackcode());
			box.setBoxweight(form.getTotalweightval());
			box.setBoxitemnum(form.getInOutStorList().size());//此处设置箱数
			box.setState(0);
			box.setStortype(1);//饮片
			box.setPackcode("7");//表示袋码
			boxDao.saveOjbect(box);
			
			
			String xmlcontent="<msgbody msgtype=\"tablet\">";
			xmlcontent+="<code desc=\"饮片批次码\">"+cpctablet+"</code> ";
			xmlcontent+="<boxs desk=\"包装\">";
			xmlcontent+="<box desk=\"箱\">";
			xmlcontent+="<boxweight desc=\"每箱重量单位（kg)\">"+Tools.division(form.getTotalweightval()+"", "10000")+"</boxweight>";
			xmlcontent+="<boxcode desc=\"箱码\">"+form.getPackcode()+"</boxcode>";	
			xmlcontent+="<boxtime desc=\"包装时间\">"+Tools.getCurrentTime()+"</boxtime>";	
			xmlcontent+="<weight desc=\"每包重量单位(g)\">"+weight+"</weight>";	
			xmlcontent+="<pcode desc=\"商品编码\">"+pcode+"</pcode>";	
			xmlcontent+="<pname desc=\"品名\">"+pname+"</pname>";	
			xmlcontent+="<areacode desc=\"区域编码\">"+areacode+"</areacode>";	
			xmlcontent+="<spec desc=\"规格\">箱</spec>";	
			xmlcontent+="<sourcecode>";
			xmlcontent+=xmlCode;
			xmlcontent+="</sourcecode>";
			xmlcontent+="</box>";					
			xmlcontent+="</boxs></msgbody>";
			System.out.println("xmlcontent===="+xmlcontent);
			ZyczsXml zyczsXml = new ZyczsXml();
			zyczsXml.setXmlcontent(xmlcontent);
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			zyczsXmlDao.saveOjbect(zyczsXml);
			

			form.setReturninfo("饮片包装成功！");
		}
		
		
		return "addBagFinish";
	}
	
	/*
	 * 饮片装袋-8级
	 */
	public String addBagCode_8(){
		User user = (User) getSession().getAttribute("User");		
		
		if(form.getInOutStorList()!=null&&form.getInOutStorList().size()>0){	
					
			Integer storid=0;
			String xmlCode="";
			int num=0;
			for(InOutStorBox storbox:form.getInOutStorList()){
				
				
				xmlCode+="<code desc=\"溯源码\">"+storbox.getCode()+"</code>";
				
				storid=storbox.getInoutstorboxid();
				//更新箱码信息
				Box b=new Box();
				b.setStortype(1);
				b.setBoxcode(storbox.getCode());
				b.setStorid(storid);
				b.setPackcode(form.getPackcode());
				b.setState(0);
				boxDao.updatePackcode(b);
				//更新对应库存信息			
				TabletStorage tab =  new TabletStorage();
				tab.setTabletstorid(storid);
				tab=tabletStorageDao.findById(tab);
				
				//只剩下一箱、更新库存状态为无库存状态
				if(tab.getTabletboxnum()==1){
					tab.setState(1);
					tab.setPacktype("8");
				}
				tab.setTabletboxnum(tab.getTabletboxnum()-1);//箱数
				//更新库存当前饮片包数
				tab.setTabletnum(tab.getTabletnum()-storbox.getBoxitemnum());//饮片包数		
				tab.setTabletweight(Tools.subtr(tab.getTabletweight()+"",storbox.getTotalweight()+""));//当前总重量
							
				tabletStorageDao.update(tab);
						
			}
			//设置8级码
			Box box=new Box();
			box.setOrgid(user.getOrgid());
			box.setStorid(0);
			box.setBoxcode(form.getPackcode());
			box.setBoxweight(form.getTotalweightval());
			box.setBoxitemnum(form.getInOutStorList().size());//此处设置箱数
			box.setState(0);
			box.setStortype(1);//饮片
			box.setPackcode("8");//表示袋码
			boxDao.saveOjbect(box);
			
			
			String xmlcontent="<msgbody msgtype=\"tablet\">";
			xmlcontent+="<code desc=\"饮片批次码\"></code> ";
			xmlcontent+="<boxs desk=\"包装\">";
			xmlcontent+="<box desk=\"箱\">";
			xmlcontent+="<boxweight desc=\"每箱重量单位（kg)\"></boxweight>";
			xmlcontent+="<boxcode desc=\"箱码\">"+form.getPackcode()+"</boxcode>";	
			xmlcontent+="<boxtime desc=\"包装时间\">"+Tools.getCurrentTime()+"</boxtime>";	
			xmlcontent+="<weight desc=\"每包重量单位(g)\"></weight>";	
			xmlcontent+="<pcode desc=\"商品编码\"></pcode>";	
			xmlcontent+="<pname desc=\"品名\"></pname>";	
			xmlcontent+="<areacode desc=\"区域编码\">"+user.getOrg().getAreacode()+"</areacode>";	
			xmlcontent+="<spec desc=\"规格\"></spec>";	
			xmlcontent+="<sourcecode>";
			xmlcontent+=xmlCode;
			xmlcontent+="</sourcecode>";
			xmlcontent+="</box>";					
			xmlcontent+="</boxs></msgbody>";
			System.out.println("xmlcontent==8=="+xmlcontent);
			ZyczsXml zyczsXml = new ZyczsXml();
			zyczsXml.setXmlcontent(xmlcontent);
			zyczsXml.setLoginname(user.getLoginname());
			zyczsXml.setState(0);
			zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
			zyczsXmlDao.saveOjbect(zyczsXml);
			

			form.setReturninfo("饮片包装成功！");
		}
		
		
		return "addBagFinish8";
	}
	
	
	
	/*
	 * 单条溯源码出库查询
	 *  Ajax方式返回
	 */	
	@SuppressWarnings("unchecked")
	public void findOpenBugCode() { 
		User user = (User) getSession().getAttribute("User");		
		
		HttpServletResponse response=this.getResponse();			
		try{
			JSONObject jsonObject = new JSONObject(); 	
			form.setBoxcodes(form.getBoxcodes().replaceAll("\r\n", ""));	
			
			Map boxmap =new HashMap();
			boxmap.put("boxcodes", "'"+form.getBoxcodes()+"'");
			boxmap.put("orgid", user.getOrgid());	
			boxmap.put("flag", "0");
			List<TabletStorage> tabletStorage = tabletStorageDao.findByBox(boxmap);
			
					
			if(tabletStorage!=null&&tabletStorage.size()>0){
				TabletStorage stoVO=tabletStorage.get(0);	
//				System.out.println("========='"+stoVO.getBoxcode()+"','"+stoVO.getCpctablet()+"','"+stoVO.getProdcode()+"'");
				/*
				//溯源码锁定状态查询
				List<Freeze> freezeList=boxDao.findByFreezeList("'"+stoVO.getBoxcode()+"','"+stoVO.getCpctablet()+"','"+stoVO.getProdcode()+"'");
				if(freezeList!=null&&freezeList.size()>0){
					jsonObject.put("stoVO",null); 
		            jsonObject.put("code", form.getBoxcodes());
		            jsonObject.put("returnCode", 1);
		    		jsonObject.put("returnInfo", freezeList.get(0).getCpclevelMap()+"-锁定("+freezeList.get(0).getReason()+")");	  
		    		
					Tools.printJson(response, jsonObject.toString());
					return;
				}
				*/
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
	
	
	/*
	 * 单条溯源码出库查询
	 *  Ajax方式返回
	 */	
	@SuppressWarnings("unchecked")
	public void findOpenBugCode_8() { 
		User user = (User) getSession().getAttribute("User");		
		
		HttpServletResponse response=this.getResponse();			
		try{
			JSONObject jsonObject = new JSONObject(); 	
			form.setBoxcodes(form.getBoxcodes().replaceAll("\r\n", ""));	
			
			Map boxmap =new HashMap();
			boxmap.put("boxcodes", "'"+form.getBoxcodes()+"'");
			boxmap.put("orgid", user.getOrgid());	
			boxmap.put("flag", "0");
			List<TabletStorage> tabletStorage = tabletStorageDao.findByBox_8(boxmap);
			
					
			if(tabletStorage!=null&&tabletStorage.size()>0){
				TabletStorage stoVO=tabletStorage.get(0);	
//				System.out.println("========='"+stoVO.getBoxcode()+"','"+stoVO.getCpctablet()+"','"+stoVO.getProdcode()+"'");
				/*
				//溯源码锁定状态查询
				List<Freeze> freezeList=boxDao.findByFreezeList("'"+stoVO.getBoxcode()+"','"+stoVO.getCpctablet()+"','"+stoVO.getProdcode()+"'");
				if(freezeList!=null&&freezeList.size()>0){
					jsonObject.put("stoVO",null); 
		            jsonObject.put("code", form.getBoxcodes());
		            jsonObject.put("returnCode", 1);
		    		jsonObject.put("returnInfo", freezeList.get(0).getCpclevelMap()+"-锁定("+freezeList.get(0).getReason()+")");	  
		    		
					Tools.printJson(response, jsonObject.toString());
					return;
				}
				*/
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
	
	/*
	 * 饮片拆包===================================================
	 */
	public String addOpenBagCode(){
		User user = (User) getSession().getAttribute("User");		
		
		if(form.getInOutStorList()!=null&&form.getInOutStorList().size()>0){				
			for(InOutStorBox stor:form.getInOutStorList()){
				//box信息、对应库存信息
				List<TabletStorage> sortList=tabletStorageDao.findBoxListByAll(stor.getCode(), user.getOrgid());
				
//				System.out.println("stor.getCode()=========="+stor.getCode());
//				System.out.println("sortList.size=========="+sortList.size());
//				for(TabletStorage storbox:sortList){
//					System.out.println("boxcode=========="+storbox.getBoxcode());
//				}
				
				if(sortList!=null&&sortList.size()>0){
					for(TabletStorage storbox:sortList){
						//更新箱码信息===============================
						Box b=new Box();
						b.setStortype(1);
						b.setBoxcode(storbox.getBoxcode());
						b.setStorid(storbox.getTabletstorid());
						b.setState(0);
						//要更改的字段
						b.setPackcode(Tools.dealNullInt(storbox.getBoxcode().substring(0, 1), 7)+"");						
						boxDao.updatePackcode(b);
						
						//更新对应库存信息===============================		
						TabletStorage tab =  new TabletStorage();
						tab.setTabletstorid(storbox.getTabletstorid());
						tab=tabletStorageDao.findById(tab);	
						
							
						tab.setPacktype(Tools.dealNullInt(storbox.getBoxcode().substring(0, 1), 7)+"");
						//库存已经没有的情况、新增当前箱.还原库存
						if(tab.getState()==1){
							tab.setState(0);
						}				
						tab.setTabletboxnum(tab.getTabletboxnum()+1);//箱数
						//更新库存当前饮片包数
						tab.setTabletnum(tab.getTabletnum()+storbox.getBoxitemnum());//饮片包数		
						tab.setTabletweight(Tools.addtr(tab.getTabletweight()+"",storbox.getBoxweight()+""));//当前总重量
						tabletStorageDao.update(tab);
						
					}
				}
				
				//销毁袋码
				Box box=new Box();
				box.setBoxcode(stor.getCode());
				box.setOrgid(user.getOrgid());
				box.setState(0);
				//要更改的字段
				box.setFlag(-1);//销毁状态
				boxDao.deleteByPackcode(box);
				
				
				String destroyxml="<msgbody msgtype=\"trash\">";
				destroyxml+="<trashcodes desc=\"拆包废码\">";
				destroyxml+="<sourcecode desc=\"溯源码\">"+stor.getCode()+"</sourcecode>";
				destroyxml+="</trashcodes>";
				destroyxml+="</msgbody>";
				
				ZyczsXml zyczsXml = new ZyczsXml();
				zyczsXml.setXmlcontent(destroyxml);
				zyczsXml.setLoginname(user.getLoginname());
				zyczsXml.setState(0);
				zyczsXml.setGuid(java.util.UUID.randomUUID().toString().replaceAll("-",""));
				zyczsXmlDao.saveOjbect(zyczsXml);
				
			}
			
			//返回袋码
//			form.setReturninfo(packCode);
		}else{
			form.setReturninfo("没有获取到要拆袋的数据");
		}
		
		
		return "addOpenBagFinish";
	}
	
	/*
	 * 单条溯源码出库查询
	 *  Ajax方式返回
	 */	
	@SuppressWarnings("unchecked")
	public void findOutCode() { 
		User user = (User) getSession().getAttribute("User");		
		
		HttpServletResponse response=this.getResponse();			
		try{
			JSONObject jsonObject = new JSONObject(); 	
			form.setBoxcodes(form.getBoxcodes().replaceAll("\r\n", ""));	
			
			Integer codeType=Tools.dealNullInt(form.getBoxcodes().substring(0,1), 6);
			Map boxmap =new HashMap();
			boxmap.put("boxcodes", "'"+form.getBoxcodes()+"'");
			boxmap.put("orgid", user.getOrgid());
			if(codeType==7){
				boxmap.put("flag", "0");//查询袋装溯源码
			}else{
				boxmap.put("flag", "1");
			}

			List<TabletStorage> tabletStorage=null;
			if(codeType==8){
				tabletStorage=tabletStorageDao.findByBox_8(boxmap);
			}else{
				tabletStorage = tabletStorageDao.findByBox(boxmap);
				//袋装--具体箱数列表
				if(codeType==7){
					Integer boxnum=0;
					Integer boxitemnum=0;
					List<TabletStorage> boxList=tabletStorageDao.findBoxListByAll(form.getBoxcodes(), user.getOrgid());
					for(TabletStorage storBox:boxList){
						boxitemnum+=storBox.getBoxitemnum();
						boxnum++;
					}
					if(tabletStorage!=null&&tabletStorage.size()>0){
						tabletStorage.get(0).setBoxitemnum(boxitemnum);
						tabletStorage.get(0).setTabletboxnum(boxnum);
					}
					
				}
			}
			
					
			if(tabletStorage!=null&&tabletStorage.size()>0){
				TabletStorage stoVO=tabletStorage.get(0);	

				//溯源码锁定状态查询
				List<Freeze> freezeList=boxDao.findByFreezeList("'"+stoVO.getBoxcode()+"','"+stoVO.getCpctablet()+"','"+stoVO.getProdcode()+"'");
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
	
	/*
	 * 饮片出库
	 */
	public String addOutCode(){
		User user = (User) getSession().getAttribute("User");	
		
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
		form.setType(1);//饮片
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
				//包-溯源码情况下就是1包
				if(storbox.getCodetype()==5){
					storbox.setBoxitemnum(1);//总包数
					storbox.setBoxnum(1);
				}else if(storbox.getCodetype()==8){
					storbox.setBoxnum(1);
				}else if(storbox.getCodetype()==7){
					storbox.setBoxnum(1);
				}else if(storbox.getCodetype()==6){
					storbox.setBoxitemnum(storbox.getBoxitemnum());//总包数
				}
				Integer inoutstorboxid = inOutStorBoxDao.save(storbox); 	
				//箱装溯源码
				if(storbox.getCodetype()==6){				
					//更新对应溯源码当前状态
					String[] groupInfo=storbox.getGroupInfo().split(";");//该字段保存 溯源码、库存ID、等附件信息 每个属性以逗号隔开、 每组以分号分隔
					for(String rows:groupInfo){
						String[] group=rows.split(",");
						Box box = new Box();										
						box.setBoxcode(group[0]);
						box.setState(1);
						box.setOutstorboxid(inoutstorboxid);
						box.setFlag(1);	//当flag为1时，更新操作state=0;
						boxDao.updateOjbect(box);//更新BOX明细
						
						//更新溯源码对应库存状态、当前包数
						TabletStorage tab =  new TabletStorage();
						tab.setTabletstorid(Integer.parseInt(group[1]));
						tab=tabletStorageDao.findById(tab);						
						//只剩下一箱、更新库存状态为无库存状态
						if(tab.getTabletboxnum()==1){
							tab.setState(1);
						}
						tab.setTabletboxnum(tab.getTabletboxnum()-1);//箱数
						tab.setTabletweight(tab.getTabletweight()-storbox.getBoxnumweight()*Integer.parseInt(group[2]));
						//更新库存当前饮片包数
						tab.setTabletnum(tab.getTabletnum()-Integer.parseInt(group[2]));//饮片包数						
						tabletStorageDao.update(tab);
					}
					
				}else if (storbox.getCodetype()==8){
					//袋装溯源码
					List<TabletStorage> boxList=tabletStorageDao.findBoxListByAll(storbox.getCode(), user.getOrgid());
					for(TabletStorage boxs:boxList){
						
						InOutStorBox storbox_b=new InOutStorBox();
						storbox_b.setBatchcpc(boxs.getCpctablet());
						storbox_b.setBoxnum(1);
						storbox_b.setBoxnumweight(boxs.getTabletnumweight());
						storbox_b.setTotalweight(Double.parseDouble(boxs.getBoxweight()));
						storbox_b.setRealtotalweight(Double.parseDouble(boxs.getBoxweight()));
						storbox_b.setProdname(boxs.getTabletname());
						storbox_b.setInoutstorid(inoutstorid);
						storbox_b.setProdcode(boxs.getProdcode());
//						storbox_b.setProdnumber(prodnumber)
						storbox_b.setBoxitemnum(boxs.getBoxitemnum()*1);//每箱包数*箱数						
						storbox_b.setCodetype(Tools.dealNullInt(boxs.getBoxcode().substring(0, 1), 7));//
						storbox_b.setPackstorboxid(inoutstorboxid);
						int inoutstorboxid_b =inOutStorBoxDao.save(storbox_b); 	
						//
						Box box = new Box();										
						box.setBoxcode(boxs.getBoxcode());
						box.setState(1);
						box.setOrgid(user.getOrgid());
						box.setOutstorboxid(inoutstorboxid_b);
						box.setFlag(1);	//当flag为1时，更新操作state=0;
						boxDao.updateOjbect(box);//更新BOX明细	
					}
					//更新袋装溯源码状态
					Box box = new Box();										
					box.setBoxcode(storbox.getCode());
					box.setState(1);
					box.setOutstorboxid(inoutstorboxid);
					box.setFlag(1);	//当flag为1时，更新操作state=0;
					boxDao.updateOjbect(box);//更新BOX明细
					
				}else if (storbox.getCodetype()==7){
					//袋装溯源码
					List<TabletStorage> boxList=tabletStorageDao.findBoxListByAll(storbox.getCode(), user.getOrgid());
					for(TabletStorage boxs:boxList){	
						Box box = new Box();										
						box.setBoxcode(boxs.getBoxcode());
						box.setState(1);
						box.setOutstorboxid(inoutstorboxid);
						box.setFlag(1);	//当flag为1时，更新操作state=0;
						boxDao.updateOjbect(box);//更新BOX明细								
					}
					//更新袋装溯源码状态
					Box box = new Box();										
					box.setBoxcode(storbox.getCode());
					box.setState(1);
					box.setOutstorboxid(inoutstorboxid);
					box.setFlag(1);	//当flag为1时，更新操作state=0;
					boxDao.updateOjbect(box);//更新BOX明细
					
				}else if (storbox.getCodetype()==5){
					//包装溯源码
					Box box = new Box();										
					box.setBoxcode(storbox.getCode());
					box.setState(1);
					box.setOutstorboxid(inoutstorboxid);
					box.setFlag(1);	//当flag为1时，更新操作state=0;
					boxDao.updateOjbect(box);//更新BOX明细	
						
					//更新溯源码对应库存状态、当前包数
					TabletStorage tab =  new TabletStorage();
					tab.setTabletstorid(storbox.getInoutstorboxid());//Inoutstorboxid 页面中绑定 Tabletstorid
					tab=tabletStorageDao.findById(tab);						
					//只剩下一包、更新库存状态为无库存状态
					if(tab.getTabletnum()==1){
						tab.setState(1);
					}
					//更新库存当前饮片包数
					tab.setTabletnum(tab.getTabletnum()-1);
					tab.setTabletboxnum(tab.getTabletboxnum()-1);
					tab.setTabletweight(tab.getTabletweight()-storbox.getBoxnumweight());
					tabletStorageDao.update(tab);
					
				}
	
			}
			
		}
		
		//出库xml生成
		zyczsXmlDao.saveOjbect(ToolsXml.create_Tablet_outstore2(form,form.getInOutStorList(),user));
		
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
		opLog.setSysid(sysid);
		opLog.setMethod("饮片出库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("出库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
			
		return "addOutStorageFinish";
	}
	
	
	
	
}
