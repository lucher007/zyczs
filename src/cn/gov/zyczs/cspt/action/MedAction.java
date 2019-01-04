package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IChengSqlDao;
import cn.gov.zyczs.cspt.dao.IGoodsCodeDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.IMedBaseDao;
import cn.gov.zyczs.cspt.dao.IMedDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IPlantDao;
import cn.gov.zyczs.cspt.dao.IRegionDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.dao.impl.CheckDao;
import cn.gov.zyczs.cspt.dao.impl.InOutStorBoxDao;
import cn.gov.zyczs.cspt.po.Check;
import cn.gov.zyczs.cspt.po.ChengSql;
import cn.gov.zyczs.cspt.po.GoodsCode;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.Med;
import cn.gov.zyczs.cspt.po.MedBase;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Plant;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title MedAction.java
 * @Package com.action
 * @version 1.0 
 * 药材action
 */
public class MedAction extends BaseAction implements ModelDriven<Med> {
		
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Med form = new Med();
	@Override
	public Med getModel() {
		return form;
	}
	
	private IMedDao medDao;//药材dao实现类
	public void setMedDao(IMedDao medDao) {
		this.medDao = medDao;
	
	}
	
	private IMedBaseDao medBaseDao;//药材基础dao实现类
	public void setMedBaseDao(IMedBaseDao medBaseDao) {
		this.medBaseDao = medBaseDao;
	}
	
	private IGoodsCodeDao goodsCodeDao;//商品编码dao实现类
	public void setGoodsCodeDao(IGoodsCodeDao goodsCodeDao) {
		this.goodsCodeDao = goodsCodeDao;
	}
	
	private IMedStorageDao medStorageDao;//药材库存dao实现类
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	
	private IPlantDao plantDao;//植物dao实现类
	public void setPlantDao(IPlantDao plantDao) {
		this.plantDao = plantDao;
	}
	
	private IRegionDao regionDao;
	public void setRegionDao(IRegionDao regionDao) {
		this.regionDao = regionDao;
	}

	private IInOutStorDao inOutStorDao;//出入库dao实现类
	
	private InOutStorBoxDao inOutStorBoxDao;//出入库详情dao实现类
	public void setInOutStorBoxDao(InOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}
    
	private CheckDao checkDao;
	public void setCheckDao(CheckDao checkDao) {
		this.checkDao = checkDao;
	}
	
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}

	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}

	private IChengSqlDao chengSqlDao;
	/**
	 * 根据植物cpc查询收获药材信息
	 * @return
	 */
	public String findByCpcPlant(){
		Plant plant = new Plant();
		plant.setCpcplant(form.getCpcplant());
		plant = plantDao.findById(plant);
		//循环遍历药材
		List<Plant> plantlist = new ArrayList<Plant>();
		Plant temp = null;
		String harvestmedwei = plant.getHarvestmedwei();
		String [] groupMeds = harvestmedwei.split("~");
		for(int i = 0 ; i < groupMeds.length ; i++){
			temp = new Plant();
			String [] groupMed = groupMeds[i].split("@");
			temp.setHarvestmed(groupMed[0]);
			temp.setHarvestwei(groupMed[1]);
			plantlist.add(temp);
		}
		form.setPlant(plant);
		form.setPlantlist(plantlist);
		//获取植物批次号
		form.setMedlist(medDao.findByCpcPlant(form));
		return "findByCpcPlant";
	}
	
	/**
	 * 保存产出的药材信息,然后药材入库
	 * @return
	 * @throws IOException 
	 * @throws DocumentException 
	 */
	@SuppressWarnings("unchecked")
	public String save() throws IOException, DocumentException{
		User _user = (User)getSession().getAttribute("User");
		Map map = new HashMap();
		map.put("typeid","1");//批次号类型都为1
		map.put("companycodein",_user.getCpccorp());
		regionDao.findByCode(map);
		String cpcmed = map.get("zycid").toString()+Tools.getCheckCode(map.get("zycid").toString());
		//药材批次码系统自动生成
		form.setCpcmed(cpcmed);
		//药材类型栽培
		form.setSource("栽培");
		//预计产量和实际产量进入数据库*10000保留到g以下一位
		form.setPredictweight(form.getPredictweight() * 10000);
		form.setMedweight(form.getMedweight() * 10000);
		form.setMedtype(0);//溯源
		
		
		/**********1:获取商品编码***************/
		MedBase medBase = new MedBase();
		medBase.setName(form.getMedname());
		MedBase mb = medBaseDao.findByName(medBase);
		String basecode = mb.getSourceid();
		if(basecode == null || "".equals(basecode)){
			form.setReturninfo("新建收获任务失败！");
			return findByCpcPlant();
		}
		
		/******************2:请求商品编码,如果存在则直接用,不存在则请求接口将数据写入本地数据库后再用***********************/
		GoodsCode goodsCode = new GoodsCode();
		goodsCode.setBasecode(basecode);//药材基础表的合并编码
		goodsCode.setType("0");//0药材 1饮片
		goodsCode.setCpccorp(_user.getOrg().getCpccorp());
		goodsCode = goodsCodeDao.findByList(goodsCode);
		if(goodsCode == null){
//			String method = Tools.xmlCpcMed(_user.getCpccorp(), basecode);
//			String xmlstr = Tools.sendPost(method, "prodinfo");
//			if(xmlstr == null || xmlstr.equals("")){
//				form.setReturninfo("新建收获任务并入库失败！");
//				return findByCpcPlant();
//			}
//			
//			String respcode ="";
//			String prodcpccode ="";	
//			if(xmlstr != null && !xmlstr.equals("")){
//				Document document = DocumentHelper.parseText(xmlstr); 
//				respcode =document.selectSingleNode("cpc/respcode").getText();
//				prodcpccode =document.selectSingleNode("cpc/operadata/prodcpccode").getText();
//				if(respcode == null || prodcpccode == null || "".equals(prodcpccode) || prodcpccode.length() != 20){
//					form.setReturninfo("新建收获任务并入库失败！");
//					return findByCpcPlant();
//				}	
//				GoodsCode goodsCode1= new GoodsCode();
//				goodsCode1.setType("0");
//				goodsCode1.setBasecode(basecode);
//				goodsCode1.setProdcode(prodcpccode);
//				goodsCode1.setCpccorp(_user.getOrg().getCpccorp());
//				goodsCodeDao.save(goodsCode1);
//				form.setProdcode(prodcpccode);	
//			}else{
//				form.setReturninfo("新建收获任务并入库失败！");
//				return findByCpcPlant();
//			}
			String prodcpccode=Tools.xmlCpcMed_local(_user.getCpccorp(), basecode);
			if(prodcpccode != null && !prodcpccode.equals("") && prodcpccode.length()==20){
				GoodsCode goodsCode1= new GoodsCode();
				goodsCode1.setType("0");
				goodsCode1.setBasecode(basecode);
				goodsCode1.setProdcode(prodcpccode);
				goodsCode1.setCpccorp(_user.getOrg().getCpccorp());
				goodsCodeDao.save(goodsCode1);
				form.setProdcode(prodcpccode);	
			}else{
				form.setReturninfo("新建收获任务并入库失败！");
				return findByCpcPlant();
			}
		}else{
			form.setProdcode(goodsCode.getProdcode());
		}
		
		
		int medId = medDao.save(form);
		if(medId !=0){
			MedStorage storage =new MedStorage();
			storage.setMedname(form.getMedname());
			storage.setProdcode(form.getProdcode());
			storage.setCpcmed(form.getCpcmed());
			storage.setMedweight(form.getMedweight());
			storage.setProvince(_user.getCompany().getProvince());
			storage.setCity(_user.getOrg().getCity());
			storage.setArea(_user.getOrg().getArea());
			storage.setAreacode(_user.getOrg().getAreacode());
			storage.setState(0);  //药材库存状态:0有库存,1无库存	
			storage.setMedtype(0); //药材是否分包:0药材未分包,1药材已分包
			storage.setPrintstate(0);//打印状态:0未打印,1已打印
			storage.setOrgid(_user.getOrgid());
			storage.setCheckstate(0);
			storage.setUserid(_user.getUserid());
			storage.setCpccorp(_user.getOrg().getCpccorp());
			storage.setOrimedweight(storage.getMedweight());
			//storage.setChangemedweight(storage.getMedweight());
			storage.setAddtime(Tools.getCurrentTime());
			medStorageDao.save(storage);
			
			/***************3新增出入库记录*******************/
			InOutStor inOutStor = new InOutStor();
			inOutStor.setType(0);//类型:药材0,饮片1
			inOutStor.setStortype(0);//类型:药材0,饮片1
			inOutStor.setSellcorpname(_user.getCompany().getCorpname());
			inOutStor.setBuycorpname(_user.getCompany().getCorpname());
			inOutStor.setOpertime(form.getPlantaddtime());
			inOutStor.setUserid(_user.getUserid());
			inOutStor.setTotalmoney(0d);
			inOutStor.setTotalweight(form.getMedweight());
			inOutStor.setZstype(0);//溯源企业
			inOutStor.setOperator(_user.getLoginname());
			inOutStor.setCpccorp(_user.getCpccorp());
			inOutStor.setMobile(_user.getCompany().getMobile());
			inOutStor.setAddress(_user.getCompany().getRegisteraddress());
			inOutStor.setOrgid(_user.getOrgid());
			inOutStor.setOpertime(Tools.getCurrentTime());
			Integer inoutstorid = inOutStorDao.save(inOutStor);
			/***************4新增出入库详情记录*******************/
			InOutStorBox inOutStorBox = new InOutStorBox();
			inOutStorBox.setBatchcpc(form.getCpcmed());
			inOutStorBox.setBoxnum(0);
			inOutStorBox.setBoxnumweight(0d);
			inOutStorBox.setTotalweight(form.getMedweight());
			inOutStorBox.setRealtotalweight(form.getMedweight());
			inOutStorBox.setPrice(0d);
			inOutStorBox.setTotalmoney(0d);
			inOutStorBox.setProdname(form.getMedname());
			inOutStorBox.setInoutstorid(inoutstorid);
			inOutStorBox.setProdcode(form.getProdcode());
			inOutStorBox.setProdnumber(form.getMednumber());
			inOutStorBox.setBoxitemnum(0);
			inOutStorBoxDao.save(inOutStorBox);
			form.setReturninfo("新建收获任务并入库完成！");
			
			zyczsXmlDao.saveOjbect(ToolsXml.create_Med_codeinfo(form, _user,storage.getAreacode(),1));
			
			try{
				//根据组织id,商品编码,药材批次号查询当前最新库存
				MedStorage medStorage = medStorageDao.findCurrentMedWeight(storage);
				medStorage.setCpccorp(_user.getCpccorp());
				
				//更新中间件SQL
				ChengSql outSql = new ChengSql();
				outSql.setSql(ToolSql.updateMedStroage(medStorage));
				chengSqlDao.saveOutSql(outSql);
			}catch(Exception ex){
				ex.printStackTrace();
			}
			
			//记录操作日志
			OpLog opLog=new OpLog();
			opLog.setSysid(1);
			opLog.setMethod("药材收获");
			opLog.setLoginName(_user.getLoginname());
			opLog.setUserName(_user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLog.setContent("批次号:"+cpcmed);
			opLogDao.saveOjbect(opLog);
		
		}else{
			form.setReturninfo("新建收获任务并入库失败！");			
		}		
		form.setMedname("");
		return findByCpcPlant();
	}
	
	/**
	 * 入库查询
	 * @return String
	 */
    public String findByList_inStore(){
		User user = (User)getSession().getAttribute("User");	
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(medDao.findByCount(form));
		form.setMedlist(medDao.findByList(form));
		return "findByListInStore";
	}
	
    /**
	 * 药材入库查询详情
	 * @return
	 */
	public String findMedInstoreDetail(){
		User _user = (User)getSession().getAttribute("User");
		form.setOrgid(_user.getOrgid());
		
		//药材信息
		form.setMed(medDao.findByCpc(form));
		
		//药材检验信息
		Check check = new Check();
		check.setOrgid(_user.getOrgid());
		
		form.setCheck(checkDao.findCheckDetail(check));
		
		//种子信息
		Plant plant = new Plant();
		plant.setCpcplant(form.getCpcplant());
		form.setPlant(plantDao.findById(plant));
		
		return "findMedInstoreDetail";
	}

	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}

	public void setChengSqlDao(IChengSqlDao chengSqlDao) {
		this.chengSqlDao = chengSqlDao;
	}
    
}

