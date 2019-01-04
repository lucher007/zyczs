package cn.gov.zyczs.cspt.action;

import java.util.List;

import cn.gov.zyczs.cspt.dao.IGovmentTabletStatDao;
import cn.gov.zyczs.cspt.po.GovmentTabletStat;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class GovmentTabletStatAction extends BaseAction implements ModelDriven<GovmentTabletStat>{
	
	GovmentTabletStat form = new GovmentTabletStat();

	@Override
	public GovmentTabletStat getModel() {
		return form;
	}
	
	IGovmentTabletStatDao govmentTabletStatDao;

	public void setGovmentTabletStatDao(IGovmentTabletStatDao govmentTabletStatDao) {
		this.govmentTabletStatDao = govmentTabletStatDao;
	}

	/**
	 * 饮片生产查询
	 * @return String
	 */
    public String findByTabletList(){
		User user = (User)getSession().getAttribute("User");	
		form.setPager_openset(10);     //一页显示10行
		
		form.setZyctype("00100000");
		 List<GovmentTabletStat> list=govmentTabletStatDao.findByTabletList(form);
		 for(GovmentTabletStat stat:list)
		 {
			 GovmentTabletStat cvo= govmentTabletStatDao.findByOutStor(stat);
			 if(cvo!=null)
			 {
				 stat.setOuttotalweight(cvo.getOuttotalweight());
				 stat.setAvgprice(cvo.getAvgprice());
				 stat.setOutorderCount(cvo.getOutorderCount());
			 }
		 }	 
		form.setPager_count(govmentTabletStatDao.findByTabletCount(form));
		form.setTabletList(list);
		
		return "findByTabletList";
	}
    
    /**
	 * 饮片经销查询
	 * @return String
	 */
    public String findByTabletSellList(){
		User user = (User)getSession().getAttribute("User");	
		form.setPager_openset(10);     //一页显示10行
		
		form.setZyctype("00010000");
		 List<GovmentTabletStat> list=govmentTabletStatDao.findByTabletList(form);
		 for(GovmentTabletStat stat:list)
		 {
			 GovmentTabletStat cvo= govmentTabletStatDao.findByOutStor(stat);
			 if(cvo!=null)
			 {
				 stat.setOuttotalweight(cvo.getOuttotalweight());
				 stat.setAvgprice(cvo.getAvgprice());
				 stat.setOutorderCount(cvo.getOutorderCount());
			 }
		 }	 
		form.setPager_count(govmentTabletStatDao.findByTabletCount(form));
		form.setTabletList(list);
		
		return "findByTabletSellList";
	}
    
    /**
	 * 饮片经销查询
	 * @return String
	 */
    public String findByTabletHospList(){
		User user = (User)getSession().getAttribute("User");	
		form.setPager_openset(10);     //一页显示10行
		
		form.setZyctype("00000100");
		 List<GovmentTabletStat> list=govmentTabletStatDao.findByTabletList(form);
		 for(GovmentTabletStat stat:list)
		 {
			 GovmentTabletStat cvo= govmentTabletStatDao.findByOutStor(stat);
			 if(cvo!=null)
			 {
				 stat.setOuttotalweight(cvo.getOuttotalweight());
				 stat.setAvgprice(cvo.getAvgprice());
				 stat.setOutorderCount(cvo.getOutorderCount());
			 }
		 }	 
		form.setPager_count(govmentTabletStatDao.findByTabletCount(form));
		form.setTabletList(list);
		
		return "findByTabletHospList";
	}
}
