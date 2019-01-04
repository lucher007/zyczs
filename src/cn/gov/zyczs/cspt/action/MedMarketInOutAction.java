package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IBoxDao;
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

/*
 * 药材市场出入库 Action
 */
public class MedMarketInOutAction extends BaseAction implements ModelDriven<InOutStor>{
	
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
	 * 药材入库查询
	 * @return
	 * @throws IOException 
	 */
	public String findInStorage() throws IOException{
		User user = (User) getSession().getAttribute("comuser");	
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
			getSession().setAttribute("medMarketInStoragemap", resultMap);
		}else{
			form.setReturninfo("请输入正确的溯源码!");
			return "findInStorage";
		}
		

		return "addInStorage";
	}
	
	/**
	 * 药材入库
	 * @return
	 */
	public String addInStorage(){
		User user = (User) getSession().getAttribute("comuser");		
		Map<String,Object> resultMap = (Map<String,Object>)getSession().getAttribute("medMarketInStoragemap");
	
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
				form.setType(0);//饮片
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
							stor.setAreacode(areacode);//地区编码
							stor.setCpcmed(vo.getBatchno());//批次
							stor.setMedname(vo.getPname());//品名
							stor.setProdcode(vo.getPcode());//商品编码
							stor.setMedweight(medweight);//总重量
							stor.setMednum(mednum);//包数
							stor.setMednumweight(mednumweight);//规格
							stor.setOrimedweight(medweight);
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
					//scalestatDao.updateByComsta(user.getCpccorp());
					
					//记录操作日志
					OpLog opLog=new OpLog();
					opLog.setSysid(3);
					opLog.setMethod("药材入库");
					opLog.setLoginName(user.getLoginname());
					opLog.setUserName(user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLog.setContent("入库单编号:"+inoutstorid);
					opLogDao.saveOjbect(opLog);
					
					this.getSession().removeAttribute("medMarketInStoragemap");
				}
				
			}
		}else
		{
			form.setReturninfo("该批溯源码已入库、不能重复入库!");
		}
		
		
		return "addInStorageFinish";
	}
	
	
	/**
	 * 药材出库查询
	 * @return
	 */
	/*
	public String findOutStorage(){
		User user = (User) getSession().getAttribute("comuser");
		
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
				}
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
		
		getSession().setAttribute("medMarketOutStoragemap", map);
		getRequest().setAttribute("failList", failList);
		
		return "addOutStorage";
	}
	*/
	/**
	 * 药材出库
	 * @return
	 */
	public String addOutStorage(){
		User user = (User) getSession().getAttribute("comuser");
		Map<String,List<MedStorage>> map = (Map<String,List<MedStorage>>)getSession().getAttribute("medMarketOutStoragemap");
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
		this.getSession().removeAttribute("medMarketOutStoragemap");
		//scalestatDao.updateByComsta(user.getCpccorp());
		//记录操作日志
		OpLog opLog=new OpLog();
		opLog.setSysid(3);
		opLog.setMethod("药材出库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("出库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
		
		return "addOutStorageFinish";
	}

}
