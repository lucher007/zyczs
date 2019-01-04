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
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.InStorFailCode;
import cn.gov.zyczs.cspt.po.InStorSuccessCode;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title HospitalAction.java
 * @Package 
 * @version 1.0
 * 医院 Action
 */
public class HospitalInOutAction extends BaseAction implements ModelDriven<InOutStor>{
	
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
	 * 查询出用户输入的饮片入库溯源码
	 * @return String
	 * @throws IOException 
	 */
	public String findInStorage() throws IOException{
		User user = (User) getSession().getAttribute("User");	
		if(form.getBoxcodes()==null||form.getBoxcodes().length()<1){
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
					String cpc =ms.getBatchno()+ms.getWeight();			
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
			getSession().setAttribute("hospitalInStoragemap", resultMap);
		}else{
			form.setReturninfo("请输入正确的溯源码!");
			return "findInStorage";
		}
		

		return "addInStorage";
	}
	
	/**
	 * 饮片入库
	 * @return
	 */
	public String addInStorage(){
		User user = (User) getSession().getAttribute("User");		
		Map<String,Object> resultMap = (Map<String,Object>)getSession().getAttribute("hospitalInStoragemap");
	
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
				form.setType(1);//饮片
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
							Integer tabletnum=0;
							for(InStorSuccessCode ms : succTotal){
								tabletnum=tabletnum+Integer.parseInt(ms.getBoxitemnum());
							}
							//规格
							Double tabletnumweight=Tools.multiply(vo.getWeight(), String.valueOf(10));
							//总重量
							Double tabletweight=Tools.multiply(String.valueOf(tabletnumweight), tabletnum+"");
							
							//2--新增库存**************************************
							//地区编码
							//将省市区封装到codeArea进行查询返回区域码
							CodeArea codeArea = new CodeArea();
							codeArea.setProvince(user.getOrg().getProvince());
							codeArea.setCity(user.getOrg().getCity());
							codeArea.setArea(user.getOrg().getArea());
							
//							String areacode = codeAreaDao.findByName(codeArea);						
							//饮片批次码系统自动生成
//							Map map = new HashMap();
//							map.put("typeid","1");//批次号类型都为1
//							map.put("companycodein",user.getCpccorp());
//							regionDao.findByCode(map);		
//							String cpctablet = map.get("zycid").toString()+Tools.getCheckCode(map.get("zycid").toString());		
//							String cpctabletimg=Tools.getTwoCode("*CPC*ZYCZS"+cpctablet);//二维码路径		
							
							TabletStorage stor=new TabletStorage();
							stor.setUserid(user.getUserid());
							stor.setOrgid(user.getOrgid());
							stor.setTabletid(0);
							stor.setProvince(user.getOrg().getProvince());
							stor.setCity(user.getOrg().getCity());
							stor.setArea(user.getOrg().getArea());
//							stor.setAreacode(areacode);//地区编码
							stor.setCpctablet(vo.getBatchno());//批次
							stor.setTabletname(vo.getPname());//品名
							stor.setProdcode(vo.getPcode());//商品编码
							stor.setTabletweight(tabletweight);//总重量
							stor.setTabletnum(tabletnum);//包数
							stor.setTabletnumweight(tabletnumweight);//规格
							stor.setTabletboxnum(succTotal.size());//箱数
//							stor.setTabletboxitemnum(tabletboxitemnum);//每箱包数 ..库存里面的每箱包数 依照入库中的是不对的
							stor.setState(0);//有库存
							stor.setTablettype(1);//已分包
							stor.setPrintstate(3);//已打印
							stor.setDownstate(2);//已下载						
							Integer tabletstorid=tabletStorageDao.save(stor);
							
							//3--出入库单明细--名称、批次、规格 整合 **************************************
							InOutStorBox storbox=new InOutStorBox();
							storbox.setInoutstorid(inoutstorid);//出入库单ID
							storbox.setBatchcpc(vo.getBatchno());//批次号
							storbox.setBoxnum(succTotal.size());//箱数 + 累加
							storbox.setBoxitemnum(tabletnum);//包数
							storbox.setBoxnumweight(tabletnumweight);//规格
							storbox.setProdcode(vo.getPcode());	//产品编码	
							storbox.setProdname(vo.getPname()); //产品名称						
							storbox.setTotalweight(tabletweight);//根据规格，每箱数计算
							storbox.setRealtotalweight(tabletweight);//上面Totalweight的重量					
							Integer inoutstorboxid = inOutStorBoxDao.save(storbox); 	//插入出入库子单	
							
							//4--BOX箱码 **************************************
							for(InStorSuccessCode ms : succTotal){
								Box box = new Box();
								box.setStorid(tabletstorid);//库存ID
								box.setBoxcode(ms.getCode());//溯源码
								Double spec=Tools.multiply(ms.getWeight(), String.valueOf(10));
								box.setBoxweight(Tools.multiply(String.valueOf(spec),ms.getBoxitemnum()));//每箱重量=规格 x 每箱包数						
								box.setState(0);
								box.setInstorboxid(inoutstorboxid);//出库单ID
								box.setBoxitemnum(Integer.parseInt(ms.getBoxitemnum()));//每箱包数
								box.setStortype(1);//1饮片
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
					opLog.setSysid(6);
					opLog.setMethod("饮片入库");
					opLog.setLoginName(user.getLoginname());
					opLog.setUserName(user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLog.setContent("人库单编号:"+inoutstorid);
					opLogDao.saveOjbect(opLog);
					
					this.getSession().removeAttribute("hospitalInStoragemap");
				}
				
			}
		}else
		{
			form.setReturninfo("该批溯源码已入库、不能重复入库!");
		}
		
		
		return "addInStorageFinish";
	}

}
