package cn.gov.zyczs.cspt.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.dao.ITabletDao;
import cn.gov.zyczs.cspt.dao.ITabletPackLogDao;
import cn.gov.zyczs.cspt.dao.ITabletStorageDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.InStorFailCode;
import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.Tablet;
import cn.gov.zyczs.cspt.po.TabletPackLog;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title TabletStorageAction.java
 * @Package 
 * @version 1.0
 * 饮片库存Action
 */
@SuppressWarnings("serial")
public class TabletStorageAction  extends BaseAction implements ModelDriven<TabletStorage>{
	
	TabletStorage form = new TabletStorage();
	public TabletStorage getModel() {
		return form;
	}
	
	private ITabletStorageDao tabletStorageDao;
	private ITabletDao tabletDao;

	public ITabletDao getTabletDao() {
		return tabletDao;
	}

	public void setTabletDao(ITabletDao tabletDao) {
		this.tabletDao = tabletDao;
	}

	public void setTabletStorageDao(ITabletStorageDao tabletStorageDao) {
		this.tabletStorageDao = tabletStorageDao;
	}
	private IBoxDao boxDao;
	public void setBoxDao(IBoxDao boxDao) {
		this.boxDao = boxDao;
	}
	private ITabletPackLogDao tabletPackLogDao;
	
	public void setTabletPackLogDao(ITabletPackLogDao tabletPackLogDao) {
		this.tabletPackLogDao = tabletPackLogDao;
	}

	/*
	 * 查询代装下的箱列表
	 */
	public String showBoxList() {
		User _user = (User) getSession().getAttribute("User");
		form.setPager_openset(8);// 一页显示10行
		form.setOrgid(_user.getOrgid());
		
		form.setPager_count(tabletStorageDao.findBoxListByCount(form));
		form.setTabletStoragelist(tabletStorageDao.findBoxListByList(form));
		return "showBoxList";
	}
	
	
	/*
	 * 查询代装下的箱列表
	 */
	public String showInBoxList() {
		User _user = (User) getSession().getAttribute("User");
		try{
			List<String> liststr =new ArrayList<String>();
			liststr.add(form.getPackcode());
			
			//封装入库溯源码xml
			String inXml = ToolsXml.sendPost(ToolsXml.create_InStore(liststr,_user,1));
			System.out.println("resp==============="+inXml);
			if(inXml==null||inXml.equals("")){
				form.setReturninfo("入库接口异常,获取失败!");
				return "showInBoxList";
			}
			
			Map<String,Object> resultMap=Tools.createInStorResult(inXml,1);
			
			//成功溯源码
			List<InStorSuccessCode> succList=(List)resultMap.get("succList");
			JSONObject jsonObject = new JSONObject(); 		
			if(succList!=null&&succList.size()>0)
			{
	            form.setInStorSuccessCode(succList.get(0));
	            form.setReturninfo("");
			}else{
				form.setReturninfo("入库接口异常,获取失败!");
			}
		}catch(Exception e){
			e.printStackTrace();
		}				
		
		return "showInBoxList";
	}
	
	
	/**
	 * 饮片库存查询
	 * @return String
	 */
    public String findByList_instock(){
		User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setState(0);              //0表示有库存
		form.setPager_openset(10);     //一页显示10行
		
		if(form.getCodetype()==null){
			form.setCodetype(6);
		}
		if(form.getCodetype()==0){//未包装
			form.setTablettype(0);
		}else{
			form.setTablettype(1);//已包装
		}
		
		
		List<TabletStorage> list=tabletStorageDao.findByList_codeType(form);	
//		if(list!=null&&list.size()>0)
//		{
//			for(TabletStorage vo:list)
//			{
//				Tablet tablet=tabletDao.findById(vo.getTabletid());
//				vo.setTablet(tablet);
//			}
//		}
//		
		form.setPager_count(tabletStorageDao.findByCount_codeType(form));
		form.setTabletStoragelist(list);
		return "findTabletStorageStock";
	}
    
    /**
	 * 未包装饮片查询
	 * @return String
	 */
    public String findByListUnPack(){
    	User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setState(0);              //0表示有库存
		form.setTablettype(0);
		form.setPager_openset(10);     //一页显示10行
		
		List<TabletStorage> list=tabletStorageDao.findByList(form);	
		if(list!=null&&list.size()>0)
		{
			for(TabletStorage vo:list)
			{
				Tablet tablet=tabletDao.findById(vo.getTabletid());
				vo.setTablet(tablet);
			}
		}

		form.setPager_count(tabletStorageDao.findByCount(form));
		form.setTabletStoragelist(list);
		return "findTabletUnPack";
	}
    
    /**
	 * 未打印赋码饮片查询
	 * @return String
	 */
    public String findPrintUnCode(){
    	User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setState(0);     //0表示有库存		
		form.setTablettype(1);//已分包
		form.setFlag(1);
		form.setPrintstate(3);//未打印
		form.setDownstate(2);//
		form.setPager_openset(10);     //一页显示10行
		
		if(form.getCodetype()==null){
			form.setCodetype(6);
		}
		
		List<TabletStorage> list=tabletStorageDao.findByList_codeType(form);	
		if(list!=null&&list.size()>0)
		{
			for(TabletStorage vo:list)
			{
				//Tablet tablet=tabletDao.findById(vo.getTabletid());
				//vo.setTablet(tablet);
				Box box = new Box();
				box.setStorid(vo.getTabletstorid());
				box.setState(0);
				box.setStortype(1);
//				vo.setTabletboxnum(boxDao.findByCount(box));//为嘛要从box里面去取数量？
			}
		}

		form.setPager_count(tabletStorageDao.findByCount_codeType(form));
		form.setTabletStoragelist(list);
		return "findPrintUnCode";
	}
    
    /**
	 * 生产记录查询
	 * @return String
	 */
    public String findTabletRecord(){
    	User user = (User)getSession().getAttribute("User");	
		form.setPager_openset(10);     //一页显示10行
		
		
		Tablet tablet=new Tablet();
		tablet.setUserid(user.getUserid());
		tablet.setOrgid(user.getOrgid());
		tablet.setCheckstate(1);
		tablet.setPager_openset(form.getPager_openset());
		tablet.setTabletname(form.getTabletname());
		tablet.setPager_offset(form.getPager_offset());
		
		List<Tablet> tabletList=tabletDao.findByList(tablet);
		form.setPager_count(tabletDao.findByCount(tablet));
		form.setTabletList(tabletList);
		
		return "findTabletRecord";
	}
    
    /**
	 * 生产记录查询
	 * @return String
	 */
    public String findTabletPackLog(){
    	User user = (User)getSession().getAttribute("User");	
//		form.setUserid(user.getUserid());
//		form.setOrgid(user.getOrgid());
//		form.setState(0);              //0表示有库存
		form.setPager_openset(10);     //一页显示10行
		
		
		TabletPackLog packLog=new TabletPackLog();
		packLog.setPager_openset(form.getPager_openset());
		packLog.setTabletid(form.getTabletid());
		packLog.setOrgid(user.getOrgid());
		
		List<TabletPackLog> packLogList=tabletPackLogDao.findByList(packLog);
		form.setPager_count(tabletPackLogDao.findByCount(packLog));
		form.setPackLogList(packLogList);
		
		return "findTabletPackLog";
	}
    
    /**
	 * 未出库饮片查询
	 * @return String
	 */
    public String findByListUnOut(){
    	User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setState(0);     //0表示有库存
		form.setTablettype(1);//已包装
		form.setFlag(2);
		form.setPrintstate(3);//已打印
		form.setDownstate(2);//已下载
		form.setPager_openset(10);     //一页显示10行
		
		if(form.getCodetype()==null){//默认查箱码的记录
			form.setCodetype(6);  //5-包码 6-箱码 7-袋码
		}
		
		List<TabletStorage> list=tabletStorageDao.findByList_codeType(form);
		
		form.setPager_count(tabletStorageDao.findByCount_codeType(form));
		form.setTabletStoragelist(list);
		return "findTabletUnOut";
	}
    
    /**
	 * 未出库饮片查询
	 * @return String
	 */
    public String findByListUnOut_tabletSell(){
    	User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setState(0);              //0表示有库存
		form.setTablettype(1);//已包装
		form.setFlag(2);
		form.setPrintstate(3);//已打印
		form.setDownstate(2);//已下载
		form.setPager_openset(10);     //一页显示10行
		
		if(form.getCodetype()==null){//默认查箱码的记录
			form.setCodetype(6);  //5-包码 6-箱码 7-袋码
		}
		
		List<TabletStorage> list=tabletStorageDao.findByList_codeType(form);
		
		form.setPager_count(tabletStorageDao.findByCount_codeType(form));
		form.setTabletStoragelist(list);
		return "findTabletUnOut_tabletSell";
	}
    
    /**
	 * 跳转到分包页面
	 * @return String
	 */
    public String findById_pack(){  
    	
    	TabletStorage vo=tabletStorageDao.findById(form);
    	Tablet tablet=tabletDao.findById(vo.getTabletid());
    	vo.setTablet(tablet);
    	form.setTabletStorage(vo);
		return "pack";
	}
    
    /**
	 * 饮片分包
	 * @return String
	 */
    public String updateTabletPack(){
    	User _user = (User)getSession().getAttribute("User");
    	
    	TabletStorage tabletStorage=tabletStorageDao.findById(form); 
    	tabletStorage.setUserid(_user.getUserid());
    	tabletStorage.setOrgid(_user.getOrgid());
    	
    	Tablet tablet = tabletDao.findById(tabletStorage.getTabletid());
    	
    	/**************1判断传回的当前的使用重量是否大于库存量********************/
    	Double weighttemp = Tools.subtr(tabletStorage.getTabletweight().toString(),form.getUsetotal());
    	if(weighttemp == null){
			form.setReturninfo("当前分包使用量小于库存量！");
			findById_pack();
			return "pack";
		}else
		{
			//解析分包明细
			List<TabletStorage> list=Tools.createStoragePack(form.getPackStr(), tabletStorage);
	    	if(list!=null&&list.size()>0)
	    	{
	    		for(TabletStorage vo:list)
	    		{
	    			if(form.getFlag() == 1){
		    			vo.setPacktype("5");
	    			}else{
	    				vo.setPacktype("6");
	    			}
	    			
	    			Integer tabletstorid=tabletStorageDao.save(vo);
	    			if(tabletstorid==null){
						form.setReturninfo("添加库存出错!");
						findById_pack();		
						return "pack";
					}
	    			//flag 1代表包 2代表箱/包  
	    			/**********2写入溯源码**************************/
	    			System.out.println("规格:"+vo.getTabletnumweight()+" 箱数:"+vo.getTabletboxnum()+" 每箱包数:"+vo.getTabletboxitemnum()+" 总包数:"+vo.getTabletnum());
	    			Map boxMedMap = new HashMap();
	    			boxMedMap.put("storageid", tabletstorid);
	    			boxMedMap.put("weight", vo.getTabletnumweight());//规格
	    			boxMedMap.put("totalnum", vo.getTabletnum());//总包数
	    			boxMedMap.put("boxitemnum", vo.getTabletboxitemnum());//每箱包数
	    			boxMedMap.put("boxnum",  vo.getTabletboxnum());//箱数
	    			boxMedMap.put("cpccorp", _user.getCpccorp());
	    			boxMedMap.put("orgid", _user.getOrgid());
	    			
	    			boxMedMap.put("cpctablet", vo.getCpctablet());
	    			boxMedMap.put("loginname", _user.getLoginname());
	    			boxMedMap.put("tabletname", vo.getTabletname());
	    			boxMedMap.put("prodcode", vo.getProdcode());
	    			boxMedMap.put("areacode", vo.getAreacode());
	    			boxMedMap.put("spec", tablet.getTabletspec()==null?"":tablet.getTabletspec());
	    			
	    			
	    			
	    			if(form.getFlag() == 1){
		    			boxDao.saveBoxPackTablet(boxMedMap);
	    			}else{
	    				boxDao.saveBoxTablet(boxMedMap);	
	    			}
	    			//记录分包日志
	    			TabletPackLog packLog=new TabletPackLog();
	    			packLog.setTabletstorid(tabletstorid);
	    			packLog.setTabletid(vo.getTabletid());
	    			packLog.setTabletname(vo.getTabletname());
	    			packLog.setCpctablet(vo.getCpctablet());
	    			packLog.setProdcode(vo.getProdcode());
	    			packLog.setProvince(_user.getOrg().getProvince());
	    			packLog.setCity(_user.getOrg().getCity());
	    			packLog.setArea(_user.getOrg().getArea());
	    			packLog.setAreacode(vo.getAreacode());
	    			packLog.setOrgid(_user.getOrgid());
	    			packLog.setUserid(_user.getUserid());
	    			packLog.setTabletweight(vo.getTabletweight());
	    			packLog.setTabletnum(vo.getTabletnum());
	    			packLog.setTabletnumweight(vo.getTabletnumweight());
	    			packLog.setTabletboxnum(vo.getTabletboxnum());
	    			packLog.setTabletboxitemnum(vo.getTabletboxitemnum());
	    			tabletPackLogDao.save(packLog);
	    			   			
	    		}
	    		Integer state=0;
	    		if(weighttemp == 0 || weighttemp == 0.0 || weighttemp == 0.0f){
	    			state=1;//无库存
				}
	    		/********3更新未分包库存**********/
	    		//更新原库存现有库存量   
	    		tabletStorageDao.updateWeightById(weighttemp,state,tabletStorage.getTabletstorid());  			
	    		form.setReturninfo("饮片分包录入成功!");	    		
	    	}
		}
    	
		return "updateTabletPackFinish";
	}
    
    /**
	 * 饮片品名查询
	 * @return String
	 */
    public String findByDownCode(){
		User user = (User)getSession().getAttribute("User");	
		form.setPager_openset(10);     //一页显示10行
		form.setOrgid(user.getOrgid());
		form.setPager_count(tabletStorageDao.findDownCodeByCount(form));
		form.setTabletStoragelist(tabletStorageDao.findDownCodeByList(form));
		
		return "findByDownCode";
	}
   
    /**
	 * 查询出用户输入的饮片出库溯源码
	 * @return String
	 */
    /*
	public String findOutStorage(){
		User user = (User) getSession().getAttribute("User");
		if(form.getBoxcodes()==null||form.getBoxcodes().length()<3){
			form.setReturninfo("填写溯源码错误");
			return "findOutStorage";
		}
		Map<String,List<TabletStorage>> map = new HashMap<String,List<TabletStorage>>();
		// 记录失败溯源码
		List<InStorFailCode> failList = new ArrayList<InStorFailCode>();
		
		//溯源码锁定状态查询
		List<Freeze> freezeList=boxDao.findByFreezeList(form.getBoxcodes(), user.getOrgid(), 1);
		//设置锁定溯源码
		if(freezeList!=null&&freezeList.size()>0){
			for(Freeze freeze:freezeList){
				
				InStorFailCode instor = new InStorFailCode();				
				instor.setCode(freeze.getCpccode());
				instor.setReason(freeze.getCpclevel()+freeze.getReason());			
				failList.add(instor);
				//删除锁定溯源码
				if(form.getBoxcodes().indexOf(freeze.getCpccode()+"BR")!=-1){					
					form.setBoxcodes(form.getBoxcodes().replaceAll(freeze.getCpccode()+"BR", ""));				
				}		
			}
		}
		//去掉最后一个BR符号
		int index=form.getBoxcodes().lastIndexOf("BR");
		if(index!=-1&&index==form.getBoxcodes().length()-2){
			form.setBoxcodes(form.getBoxcodes().substring(0,form.getBoxcodes().length()-2));
		}

		if(!"".equals(form.getBoxcodes())){
			String[] boxcodesarray= form.getBoxcodes().split("BR");		
			List<String> liststr =Arrays.asList(boxcodesarray);		

			Map boxmap =new HashMap();
			boxmap.put("boxcodes", "'"+form.getBoxcodes().replaceAll("BR", "','")+"'");
			boxmap.put("orgid", user.getOrgid());
			List<TabletStorage> tabletStorage = tabletStorageDao.findByBox(boxmap);
			
			if(tabletStorage!=null&&tabletStorage.size()>0){
				for(String codes:liststr){
					int i = 0;
					for(TabletStorage ms :tabletStorage){
						if(codes.equals(ms.getBoxcode())){
							i=1;
							break;
						}
					}
					if(i==0){		
						InStorFailCode instor=new InStorFailCode();
						instor.setReason("0");//无效的溯源码
						instor.setCode(codes);
						failList.add(instor);
					}
				}
				for(TabletStorage ms :tabletStorage){
					String cpc = ms.getCpctablet()+ms.getTabletnumweight();
					List<TabletStorage> mslist =  map.get(cpc);
					if(mslist!=null&&mslist.size()>0){
						mslist.add(ms);
						map.put(cpc,mslist);
					}else{
						List<TabletStorage> mslistnew = new ArrayList<TabletStorage>();
						mslistnew.add(ms);
						map.put(cpc,mslistnew);
					}
				}				
			}else{
				//封装全部错误溯源码
				Tools.setFailCodes(liststr, failList);
			}
			
		}	
		getSession().setAttribute("tabletOutStoragemap", map);
		getRequest().setAttribute("failList", failList);

		return "addOutStorage";
	}
	*/
}
