package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.ICheckDao;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.ICodeRegionDao;
import cn.gov.zyczs.cspt.dao.IGoodsCodeDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.IMedDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IRegionDao;
import cn.gov.zyczs.cspt.dao.ITabletAssistDao;
import cn.gov.zyczs.cspt.dao.ITabletDao;
import cn.gov.zyczs.cspt.dao.ITabletPackLogDao;
import cn.gov.zyczs.cspt.dao.impl.InOutStorBoxDao;
import cn.gov.zyczs.cspt.po.CodeArea;
import cn.gov.zyczs.cspt.po.GoodsCode;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Tablet;
import cn.gov.zyczs.cspt.po.TabletAssist;
import cn.gov.zyczs.cspt.po.TabletPackLog;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

import flex.messaging.util.URLEncoder;

/**
 * @Title TabletAction.java
 * @Package 
 * @version 1.0
 * 饮片生产Action
 */
@SuppressWarnings("serial")
public class TabletAction  extends BaseAction implements ModelDriven<Tablet>{
	
	Tablet form = new Tablet();
	public Tablet getModel() {
		return form;
	}
	
	private ITabletDao tabletDao;
	private ICheckDao checkDao;
	private IRegionDao regionDao;
	
	public void setRegionDao(IRegionDao regionDao) {
		this.regionDao = regionDao;
	}

	public ICheckDao getCheckDao() {
		return checkDao;
	}

	public void setCheckDao(ICheckDao checkDao) {
		this.checkDao = checkDao;
	}

	private IMedDao medDao;
	public IMedDao getMedDao() {
		return medDao;
	}

	public void setMedDao(IMedDao medDao) {
		this.medDao = medDao;
	}

	public void setTabletDao(ITabletDao tabletDao) {
		this.tabletDao = tabletDao;
	}
	private ITabletAssistDao tabletAssistDao;
	
	public void setTabletAssistDao(ITabletAssistDao tabletAssistDao) {
		this.tabletAssistDao = tabletAssistDao;
	}
	
	private IGoodsCodeDao goodsCodeDao;//商品编码dao实现类
	public void setGoodsCodeDao(IGoodsCodeDao goodsCodeDao) {
		this.goodsCodeDao = goodsCodeDao;
	}
	
	private IInOutStorDao inOutStorDao;//出入库dao实现类
	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}
	
	private InOutStorBoxDao inOutStorBoxDao;//出入库详情dao实现类
	public void setInOutStorBoxDao(InOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}
	
	private IMedStorageDao medStorageDao;
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	
	private ICodeRegionDao codeRegionDao;
	public void setCodeRegionDao(ICodeRegionDao codeRegionDao) {
		this.codeRegionDao = codeRegionDao;
	}
	
	private ITabletPackLogDao tabletPackLogDao;
	
	public void setTabletPackLogDao(ITabletPackLogDao tabletPackLogDao) {
		this.tabletPackLogDao = tabletPackLogDao;
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
	 * 获得生产批次、溯源码
	 * @return String
	 */
	@SuppressWarnings("unchecked")
	public void findByTabletcode() { 
		HttpServletResponse response=this.getResponse();	
       try{
    	    User _user = (User)getSession().getAttribute("User");
	   		//饮片批次码系统自动生成
	   		Map map = new HashMap();
	   		map.put("typeid","1");//批次号类型都为1
	   		map.put("companycodein",_user.getCpccorp());
	   		regionDao.findByCode(map);		
	   		String cpctablet = map.get("zycid").toString()+Tools.getCheckCode(map.get("zycid").toString());		
	   		String cpctabletimg=Tools.getTwoCode("*CPC*ZYCZS"+cpctablet);//二维码路径				
            String json ="{\"cpctablet\":\""+cpctablet+"\",\"cpctabletimg\":\""+cpctabletimg+"\" }";  
            Tools.printJson(response, json);
       }catch(Exception e){
    	   String json ="{\"cpctablet\":\"\",\"cpctabletimg\":\"\" }";  
           Tools.printJson(response, json);
    	   e.printStackTrace();
       }  
    } 
	
	/**
	 * 饮片生产
	 * @return String
	 */
	public String saveObject() throws DocumentException, IOException{
		User _user = (User)getSession().getAttribute("User");	
		form.setReturncode(1);
		form.setUserid(_user.getUserid());
		form.setOrgid(_user.getOrgid());
		form.setProvince(_user.getOrg().getProvince());
		form.setCity(_user.getOrg().getCity());
		form.setArea(_user.getOrg().getArea());
		//原药材总重量、使用重量入库转换
		form.setMeduseweight(Tools.multiply(String.valueOf(form.getMeduseweight()),10000+""));
		form.setMedweight(Tools.multiply(String.valueOf(form.getMedweight()),10000+""));
		
		//将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(_user.getOrg().getProvince());
		codeArea.setCity(_user.getOrg().getCity());
		codeArea.setArea(_user.getOrg().getArea());
		
		String areacode = codeAreaDao.findByName(codeArea);
		form.setAreacode(areacode);
		
		GoodsCode goodsCode = new GoodsCode();
		goodsCode.setBasecode(form.getTabletname());//通过饮片名称查询有无商品编码
		goodsCode.setType("1");//0药材 1饮片
		goodsCode.setCpccorp(_user.getOrg().getCpccorp());
		goodsCode = goodsCodeDao.findByList(goodsCode);
		String prodcpccode ="";
		if(goodsCode == null){
			String method = Tools.xmlCpcTablet(_user.getCpccorp(), form.getTabletname());		
			String xmlstr;
			try{			
				xmlstr = Tools.sendPost(method, "prodinfo");
			}catch(Exception ex){
				form.setReturninfo("获取饮片商品编码失败,请求中央接口超时!");
				return "save";
			}		
			if(xmlstr == null || xmlstr.equals("")){
				form.setReturninfo("获取饮片商品编码失败！");
				return "save";
			}
			
			String respcode ="";
				
			if(xmlstr != null && !xmlstr.equals("")){
				Document document = DocumentHelper.parseText(xmlstr); 
				respcode =document.selectSingleNode("cpc/respcode").getText();
				prodcpccode =document.selectSingleNode("cpc/operadata/prodcpccode").getText();
				if(respcode == null || prodcpccode == null || "".equals(prodcpccode) || prodcpccode.length() != 20){
					form.setReturninfo("解析饮片商品编码失败！");
					return "save";
				}	
				GoodsCode goodsCode1= new GoodsCode();
				goodsCode1.setType("1");
				goodsCode1.setBasecode(form.getTabletname());
				goodsCode1.setProdcode(prodcpccode);
				goodsCode1.setCpccorp(_user.getOrg().getCpccorp());
				goodsCodeDao.save(goodsCode1);
				form.setProdcode(prodcpccode);	
			}else{
				form.setReturninfo("获取饮片商品编码失败！");
				return "save";
			}
		}else{
			form.setProdcode(goodsCode.getProdcode());
		}
		
		//生产表入库
		Integer tabletid=tabletDao.saveOjbect(form);
		//辅料信息
		if(tabletid!=null&&tabletid>0){
			
			if(form.getAssList()!=null&&form.getAssList().size()>0)
			{
				tabletAssistDao.saveTabletAssistBatch(form.getAssList(),tabletid);
			}
			//更新药材库存总量
			MedStorage medStorage=new MedStorage();
			medStorage.setMedstorid(form.getMedid());
			medStorage.setOrgid(_user.getOrgid());	
			//查询原药材库存信息
			medStorage=medStorageDao.findMedStorage(medStorage);
			if(medStorage!=null)
			{
				
				Double weighttemp = Tools.subtr(medStorage.getMedweight().toString(),form.getMeduseweight().toString());
				if(weighttemp == 0 || weighttemp == 0.0 || weighttemp == 0.0f){
					medStorage.setState(1);
				}
				medStorage.setMedweight(weighttemp);
				
				medStorageDao.update(medStorage);
			}
			
			/***************3新增出入库记录*******************/
			InOutStor inOutStor = new InOutStor();
			inOutStor.setType(0);//类型:药材0,饮片1
			inOutStor.setStortype(1);//出入库状态：0入库 1出库
			inOutStor.setSellcorpname(_user.getCompany().getCorpname());
			inOutStor.setBuycorpname(_user.getCompany().getCorpname());
			inOutStor.setOpertime(form.getCreatetime());
			inOutStor.setUserid(_user.getUserid());
			inOutStor.setOrgid(_user.getOrgid());
			inOutStor.setTotalweight(form.getMeduseweight());
			inOutStor.setZstype(0);//销售去向类型:0表示溯源企业;表示1非溯源企业;
			inOutStor.setOperator(_user.getLoginname());
			inOutStor.setCpccorp(_user.getCpccorp());
			inOutStor.setMobile(_user.getCompany().getMobile());
			inOutStor.setAddress(_user.getCompany().getRegisteraddress());
			Integer inoutstorid = inOutStorDao.save(inOutStor);
			/***************4新增出入库详情记录*******************/
			InOutStorBox inOutStorBox = new InOutStorBox();
			
			inOutStorBox.setInoutstorid(inoutstorid);
			inOutStorBox.setBatchcpc(medStorage.getCpcmed());
//			inOutStorBox.setBoxnum(1);
			inOutStorBox.setProdname(medStorage.getMedname());
			inOutStorBox.setProdcode(medStorage.getProdcode());//编码
			inOutStorBox.setTotalweight(form.getMeduseweight());
			inOutStorBox.setRealtotalweight(form.getMeduseweight());
//			inOutStorBox.setProdnumber(form.getTabletnumber());//medStorage 没有内部批次号
			
			inOutStorBoxDao.save(inOutStorBox);
			
			//记录操作日志
			OpLog opLog=new OpLog();
			opLog.setSysid(4);
			opLog.setMethod("饮片生产");
			opLog.setLoginName(_user.getLoginname());
			opLog.setUserName(_user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLog.setContent("批次号:"+form.getCpctablet());
			opLogDao.saveOjbect(opLog);
			
			form.setTabletid(tabletid);
			form.setReturncode(0);
			form.setReturninfo("添加生产任务信息录入完成！");	
		}else{
			form.setReturninfo("添加生产任务失败！");
		}
		return "save";
	}
	
	
	/**
	 * 饮片生产任务查询
	 * @return String
	 */
    public String findByList(){
		User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());

		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(tabletDao.findByCount(form));
		form.setTabletlist(tabletDao.findByList(form));
		return "findByList";
	}
    
	/**
	 * 未检验饮片查询
	 * @return String
	 */
    public String findByList_unchecked(){
		User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setCheckstate(0);         //未检状态为0
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(tabletDao.findByCount(form));
		form.setTabletlist(tabletDao.findByList(form));
		return "findTabletUnchecked";
	}
    
    /**
	 * 已检饮片列表
	 * 
	 * @return String
	 */
	public String findCheckedList() {
		User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setCheckstate(1);         //已检状态为1
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(tabletDao.findByCount(form));
		form.setTabletlist(tabletDao.findByList(form));
		return "findTabletChecked";
	}
    
    
    
    /**
	 * 根据生产记录得到详情
	 * @return
	 */
	public String findDetails(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		form.setVo(tabletDao.findById(form.getTabletid()));
		form.setAssList(tabletAssistDao.findByTablet(form.getVo().getTabletid()));	
		
		
		form.setPager_openset(10);     //一页显示10行
		TabletPackLog packLog=new TabletPackLog();
		packLog.setPager_openset(form.getPager_openset());
		packLog.setTabletid(form.getTabletid());
		packLog.setOrgid(_user.getOrgid());
		
		List<TabletPackLog> packLogList=tabletPackLogDao.findByList(packLog);
		form.setPager_count(tabletPackLogDao.findByCount(packLog));
		form.setPackLogList(packLogList);
		
		return "findDetails";
	}
    
    /**
	 * 选择一条未检验饮片信息
	 * @return String
	 */
    public String findById_unchecked(){
    	form.setVo(tabletDao.findById(form.getTabletid()));
		return "tabletCheck";
	}
}
