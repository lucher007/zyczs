package cn.gov.zyczs.cspt.action;

import java.util.List;
import java.util.Map;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IBoxDao;
import cn.gov.zyczs.cspt.dao.ICompanyOtherDao;
import cn.gov.zyczs.cspt.dao.IInOutStorBoxDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IScalestatDao;
import cn.gov.zyczs.cspt.dao.ITabletStorageDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Box;
import cn.gov.zyczs.cspt.po.CompanyOther;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.TabletStorage;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title InOutStorageAction.java
 * @Package
 * @version 1.0 出入库Action
 */
@SuppressWarnings("serial")
public class InOutStorAction extends BaseAction implements ModelDriven<InOutStor> {
	InOutStor form = new InOutStor();
	@Override
	public InOutStor getModel() {
		return form;
	}
	private IInOutStorDao inOutStorDao;
	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}
	
	private IInOutStorBoxDao inOutStorBoxDao;
	public void setInOutStorBoxDao(IInOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}
	private IBoxDao boxDao;
	public void setBoxDao(IBoxDao boxDao) {
		this.boxDao = boxDao;
	}
	private ICompanyOtherDao companyOtherDao;
	public void setCompanyOtherDao(ICompanyOtherDao companyOtherDao) {
		this.companyOtherDao = companyOtherDao;
	}
	private IMedStorageDao medStorageDao;
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}

	private ITabletStorageDao tabletStorageDao;
	public void setTabletStorageDao(ITabletStorageDao tabletStorageDao) {
		this.tabletStorageDao = tabletStorageDao;
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
	
	/**
	 * 药材出库
	 * @return
	 */
	public String addOutStorageMed(){
		
		User user = (User) getSession().getAttribute("User");
		Map<String,List<MedStorage>> map = (Map<String,List<MedStorage>>)getSession().getAttribute("medOutStoragemap");
		if(form.getDatastr()==null||form.getDatastr().length()<1){
			form.setReturninfo("出库失败,获取明细数据出错!");
			return "saveoutstoragemed";
		}
		List<InOutStorBox> storboxlist = Tools.inOutStorageMedPack(form.getDatastr(),user.getOrgid());
		if(storboxlist==null||storboxlist.size()<1){
			form.setReturninfo("出库失败,解析明细数据出错!");
			return "saveoutstoragemed";
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
		
		//记录操作日志
		OpLog opLog=new OpLog();
		opLog.setSysid(1);
		opLog.setMethod("药材出库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("出库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
		
		getSession().removeAttribute("medOutStoragemap");
		//scalestatDao.updateByComsta(user.getCpccorp());
		
		return "saveoutstoragemed";
	}
	
	/**
	 * 饮片出库
	 * @return
	 */
	public String addOutStorageTablet(){
		
		User user = (User) getSession().getAttribute("User");                                             
		Map<String,List<TabletStorage>> map = (Map<String,List<TabletStorage>>)getSession().getAttribute("tabletOutStoragemap");
		if(form.getDatastr()==null||form.getDatastr().length()<1){
			form.setReturninfo("出库失败,获取明细数据出错!");
			return "saveoutstoragetablet";
		}
		List<InOutStorBox> storboxlist = Tools.inOutStorageTabletPack(form.getDatastr(),user.getOrgid());
		if(storboxlist==null||storboxlist.size()<1){
			form.setReturninfo("出库失败,解析明细数据出错!");
			return "saveoutstoragetablet";
		}
		form.setSellcorpname(user.getCompany().getCorpname());
		form.setUserid(user.getUserid());
		form.setOrgid(user.getOrgid());
		form.setCpccorp(form.getCpccorp());
		form.setTotalweight(form.getTotalweightval());
		form.setTotalmoney(form.getTotalmoneyval());
		form.setType(1);//饮片
		form.setStortype(1);//出库
		form.setOpertime(Tools.getCurrentTime());
		Integer inoutstorid = inOutStorDao.save(form); //插入出入库总单
		//插入非溯源企业信息
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
				//单个溯源码明细
				List<TabletStorage> tabletstoragelist = map.get(storbox.getKeyname());
				storbox.setProdcode(tabletstoragelist.get(0).getProdcode());
				storbox.setInoutstorid(inoutstorid);
				storbox.setBoxitemnum(storbox.getBoxitemnum());
				Integer inoutstorboxid = inOutStorBoxDao.save(storbox); //插入出入库子单
				
				if(tabletstoragelist!=null&&tabletstoragelist.size()>0){
					int tabletboxnum=0;
					int boxitemnum=0;
					for(TabletStorage ms : tabletstoragelist){
						Box box = new Box();										
						box.setBoxcode(ms.getBoxcode());
						box.setState(1);
						box.setOutstorboxid(inoutstorboxid);
						box.setFlag(1);	//当flag为1时，更新操作state=0;
						boxDao.updateOjbect(box);					//更新BOX明细
						tabletboxnum++;
						boxitemnum+=ms.getBoxitemnum();
					}
					//更新库存箱数
					TabletStorage tab =  tabletstoragelist.get(0);
					if(tabletboxnum==tab.getTabletboxnum()){
						tab.setState(1);
					}
					tab.setTabletnum(tab.getTabletnum()-boxitemnum);
					tab.setTabletboxnum(tab.getTabletboxnum()-tabletboxnum);
					tabletStorageDao.update(tab);
				}
				
				
			}
		}
		zyczsXmlDao.saveOjbect(ToolsXml.create_Tablet_outstore(form,storboxlist,map,user));
		
		//记录操作日志
		OpLog opLog=new OpLog();
		opLog.setSysid(4);
		opLog.setMethod("饮片出库");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("出库单编号:"+inoutstorid);
		opLogDao.saveOjbect(opLog);
		
		getSession().removeAttribute("tabletOutStoragemap");
		
		return "saveoutstoragetablet";
	}
    
	
	/**
	 * 种植平台-药材入库查询
	 * @return String
	 */
    public String findMedInStor_med(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(0);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedInStorage_med";
	}
	
	/**
	 * 种植平台-药材出库查询
	 * @return String
	 */
    public String findMedOutStor_med(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedOutStorage_med";
	}
    
    /**
	 * 生产平台-饮片入库查询
	 * @return String
	 */
    public String findTabletInStor_tablet(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(1);// 类型:药材0,饮片1
		form.setStortype(0);//出入库状态：0入库 1出库		
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findTabletInStorage_tablet";
	}
    
    /**
	 * 生产平台-饮片出库查询
	 * @return String
	 */
    public String findTabletOutStor_tablet(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(1);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库		
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findTabletOutStorage_tablet";
	}
    
    /**
	 * 生产平台-药材入库查询
	 * @return String
	 */
    public String findMedInStor_tablet(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(0);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedInStorage_tablet";
	}
    
    /**
	 * 生产平台-药材出库查询
	 * @return String
	 */
    public String findMedOutStor_tablet(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedOutStorage_tablet";
	}
    
    /**
	 * 药材经销平台-药材入库查询
	 * @return String
	 */
    public String findMedInStor_medSell(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(0);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedInStorage_medSell";
	}
    
    /**
	 * 药材经销平台-药材出库查询
	 * @return String
	 */
    public String findMedOutStor_medSell(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedOutStorage_medSell";
	}
    
    /**
	 * 药材市场平台-药材入库查询
	 * @return String
	 */
    public String findMedInStor_medMarket(){
		User user = (User)getSession().getAttribute("comuser");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(0);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedInStorage_medMarket";
	}
    
    /**
	 * 药材市场平台-药材出库查询
	 * @return String
	 */
    public String findMedOutStor_medMarket(){
		User user = (User)getSession().getAttribute("comuser");	
		form.setOrgid(user.getOrgid());
		form.setType(0);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findMedOutStorage_medMarket";
	}
    
    /**
	 * 饮片经销平台-饮片入库查询
	 * @return String
	 */
    public String findTabletInStor_tabletSell(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(1);// 类型:药材0,饮片1
		form.setStortype(0);//出入库状态：0入库 1出库		
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findTabletInStorage_tabletSell";
	}
    
    /**
	 * 饮片经销平台-饮片销售查询
	 * @return String
	 */
    public String findTabletOutStor_tabletSell(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(1);// 类型:药材0,饮片1
		form.setStortype(1);//出入库状态：0入库 1出库		
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findTabletOutStorage_tabletSell";
	}
    
    /**
	 * 医院平台-饮片入库查询
	 * @return String
	 */
    public String findTabletInStor_hospital(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid(user.getOrgid());
		form.setType(1);// 类型:药材0,饮片1
		form.setStortype(0);//出入库状态：0入库 1出库		
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorDao.findByCount(form));
		form.setInoutstoragelist(inOutStorDao.findByList(form));
		return "findTabletInStorage_hospital";
	}

}
