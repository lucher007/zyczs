package cn.gov.zyczs.cspt.action;

import cn.gov.zyczs.cspt.dao.IInOutStorBoxDao;
import cn.gov.zyczs.cspt.dao.IInOutStorDao;
import cn.gov.zyczs.cspt.po.InOutStor;
import cn.gov.zyczs.cspt.po.InOutStorBox;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

/**
 * @Title InOutStorBoxAction.java
 * @Package 
 * @version 1.0
 * 出入库详细Action
 */
@SuppressWarnings("serial")
public class InOutStorBoxAction extends BaseAction implements ModelDriven<InOutStorBox>{
	InOutStorBox form = new InOutStorBox();
	@Override
	public InOutStorBox getModel() {
		return form;
	}
	
	private IInOutStorBoxDao inOutStorBoxDao;
	
	public void setInOutStorBoxDao(IInOutStorBoxDao inOutStorBoxDao) {
		this.inOutStorBoxDao = inOutStorBoxDao;
	}
	
	private IInOutStorDao inOutStorDao;
	public void setInOutStorDao(IInOutStorDao inOutStorDao) {
		this.inOutStorDao = inOutStorDao;
	}
    
	
	/**
	 * 种植平台-药材入库查询详情
	 * @return String
	 */
    public String findMedInStorBox_med(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedInStorBox_med";
	}

	/**
	 * 种植平台-药材出库查询详情
	 * @return String
	 */
    public String findMedOutStorBox_med(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedOutStorBox_med";
	}
    
    /**
	 * 种植平台-药材出库查询溯源码
	 * @return String
	 */
    public String findMedOutStorItem_med(){
    	form.setStortype(1); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedOutStorItem_med";
	}
    
    /**
	 * 生产平台-饮片出库查询详细
	 * @return String
	 */
    public String findTabletOutStorBox_tablet(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletOutStorBox_tablet";
	}
    
    /**
	 * 生产平台-饮片出库查询溯源码
	 * @return String
	 */
    public String findTabletOutStorItem_tablet(){
    	form.setStortype(1); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletOutStorItem_tablet";
	}
    
    /**
	 * 生产平台-饮片入库查询详细
	 * @return String
	 */
    public String findTabletInStorBox_tablet(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletInStorBox_tablet";
	}
    
    /**
	 * 生产平台-饮片入库查询溯源码
	 * @return String
	 */
    public String findTabletInStorItem_tablet(){
    	form.setStortype(0); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		return "findTabletInStorItem_tablet";
	}
    
    
    /**
	 * 生产平台-药材入库查询明细
	 * @return String
	 */
    public String findMedInStorBox_tablet(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		
		return "findMedInStorBox_tablet";
	}
    
    /**
	 * 生产平台-药材入库查询溯源码
	 * @return String
	 */
    public String findMedInStorItem_tablet(){
    	form.setStortype(0); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedInStorItem_tablet";
	}
    
    /**
	 * 生产平台-药材出库查询详细
	 * @return String
	 */
    public String findMedOutStorBox_tablet(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedOutStorBox_tablet";
	}
    
    /**
	 * 生产平台-药材出库查询溯源码
	 * @return String
	 */
    public String findMedOutStorItem_tablet(){
    	form.setStortype(1); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		return "findMedOutStorItem_tablet";
	}
    
    /**
	 * 药材经销平台-药材入库查询
	 * @return String
	 */
    public String findMedInStorBox_medSell(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedInStorBox_medSell";
	}
    
    /**
	 * 药材经销平台-查询药材入库溯源码
	 * @return String
	 */
    public String findMedInStorItem_medSell(){
    	form.setStortype(0); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedInStorItem_medSell";
	}
    
    /**
	 * 药材经销平台-查询药材销售详情
	 * @return String
	 */
    public String findMedOutStorBox_medSell(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedOutStorBox_medSell";
	}
    
    /**
	 * 药材经销平台-根据出药材销售明细ID查询出所包含的溯源码
	 * @return String
	 */
    public String findMedOutStorItem_medSell(){
    	form.setStortype(1); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedOutStorItem_medSell";
	}
    
    /**
	 * 药材市场平台-药材入库查询
	 * @return String
	 */
    public String findMedInStorBox_medMarket(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedInStorBox_medMarket";
	}
    
    /**
	 * 药材市场平台-查询药材入库溯源码
	 * @return String
	 */
    public String findMedInStorItem_medMarket(){
    	form.setStortype(0); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedInStorItem_medMarket";
	}
    
    /**
	 * 药材市场平台-查询药材销售详情
	 * @return String
	 */
    public String findMedOutStorBox_medMarket(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedOutStorBox_medMarket";
	}
    
    /**
	 * 药材市场平台-根据出药材销售明细ID查询出所包含的溯源码
	 * @return String
	 */
    public String findMedOutStorItem_medMarket(){
    	form.setStortype(1); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findMedOutStorItem_medMarket";
	}
    
    /**
	 * 饮片销售平台-饮片出库查询详细
	 * @return String
	 */
    public String findTabletOutStorBox_tabletSell(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletOutStorBox_tabletSell";
	}
    
    /**
	 * 饮片销售平台-饮片出库查询溯源码
	 * @return String
	 */
    public String findTabletOutStorItem_tabletSell(){
    	form.setStortype(1); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletOutStorItem_tabletSell";
	}
    
    /**
	 * 饮片销售平台-饮片入库查询详细
	 * @return String
	 */
    public String findTabletInStorBox_tabletSell(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletInStorBox_tabletSell";
	}
    
    /**
	 * 饮片销售平台-饮片入库查询溯源码
	 * @return String
	 */
    public String findTabletInStorItem_tabletSell(){
    	form.setStortype(0); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletInStorItem_tabletSell";
	}
    
    /**
	 * 医院平台-饮片入库查询详细
	 * @return String
	 */
    public String findTabletInStorBox_hospital(){
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findBoxCount(form));
		form.setInoutstorboxlist(inOutStorBoxDao.findBoxList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletInStorBox_hospital";
	}
    
    /**
	 * 医院平台-饮片入库查询溯源码
	 * @return String
	 */
    public String findTabletInStorItem_hospital(){
    	form.setStortype(0); //箱码类型:0入库 ;1出库
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(inOutStorBoxDao.findItemCount(form));
		form.setBoxitemlist(inOutStorBoxDao.findItemList(form));
		
		//页面上需要显示公司名字以及总重量
		InOutStor inOutStorage = new InOutStor();
		inOutStorage.setInoutstorid(form.getInoutstorid());
		inOutStorage = inOutStorDao.findById(inOutStorage);
		form.setInoutstorage(inOutStorDao.findById(inOutStorage));
		return "findTabletInStorItem_hospital";
	}

}
