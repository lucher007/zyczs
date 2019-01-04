package cn.gov.zyczs.cspt.action;

import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;

import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.IGoodsCodeDao;
import cn.gov.zyczs.cspt.dao.ITabletBaseDao;
import cn.gov.zyczs.cspt.po.GoodsCode;
import cn.gov.zyczs.cspt.po.TabletBase;
import cn.gov.zyczs.cspt.po.TabletBaseOrg;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;


public class TabletBaseAction  extends BaseAction implements ModelDriven<TabletBase> {
	
	TabletBase form = new TabletBase();
	public TabletBase getModel() {
		return form;
	}
	
	private ITabletBaseDao tabletBaseDao;
	public void setTabletBaseDao(ITabletBaseDao tabletBaseDao) {
		this.tabletBaseDao = tabletBaseDao;
	}
	
	private IGoodsCodeDao goodsCodeDao;//商品编码dao实现类
	public void setGoodsCodeDao(IGoodsCodeDao goodsCodeDao) {
		this.goodsCodeDao = goodsCodeDao;
	}
	
	public String saveObject(){
		User user = (User) getSession().getAttribute("User");
				
		if(form.getChkid()!=null&&!form.getChkid().equals(""))
		{
			String[] baseorg=form.getChkid().split(",");
			if(baseorg!=null&&baseorg.length>0)
			{
				if(tabletBaseDao.saveBaseOrgBatch(baseorg, user.getOrg().getOrgid())!=0){
					form.setReturnInfo("添加饮片品名成功!");
				}
				try{
					//获取饮片商品编码
					for (int i = 0 ;i<baseorg.length;i++) {
						if(Tools.dealNullInt(baseorg[i], -99)!=-99){
							TabletBase base=tabletBaseDao.findById(Integer.parseInt(baseorg[i]));
							if(base!=null){
								GoodsCode goodsCode = new GoodsCode();
								goodsCode.setBasecode(base.getName());//通过饮片名称查询有无商品编码
								goodsCode.setType("1");//0药材 1饮片
								goodsCode.setCpccorp(user.getOrg().getCpccorp());
								goodsCode = goodsCodeDao.findByList(goodsCode);
								//编码表不存在--请求中央接口
								if(goodsCode == null){
									String method = Tools.xmlCpcTablet(user.getCpccorp(), base.getName());		
									String xmlstr=null;
									try{			
										xmlstr = Tools.sendPost(method, "prodinfo");			
									}catch(Exception ex){
										ex.printStackTrace();
										System.out.println("网络异常>>"+ServletActionContext.getServletContext().getInitParameter("outstorage_url"));
									}		
									
									String respcode ="";
									String prodcpccode="";
									if(xmlstr != null && !xmlstr.equals("")){
										Document document = DocumentHelper.parseText(xmlstr); 
										respcode =document.selectSingleNode("cpc/respcode").getText();
										prodcpccode =document.selectSingleNode("cpc/operadata/prodcpccode").getText();
										if(respcode == null || prodcpccode == null || "".equals(prodcpccode) || prodcpccode.length() != 20){
				
											System.out.println("解析饮片商品编码失败>>"+base.getName());
										}	
										GoodsCode goodsCode1= new GoodsCode();
										goodsCode1.setType("1");
										goodsCode1.setBasecode(base.getName());
										goodsCode1.setProdcode(prodcpccode);
										goodsCode1.setCpccorp(user.getOrg().getCpccorp());
										goodsCodeDao.save(goodsCode1);
										System.out.println(base.getName()+"======"+prodcpccode);
									}else{
										System.out.println("请求中央接口失败>>"+base.getName());
									}
								}
							}
	                	}  
					}
				}catch(Exception e){
					e.printStackTrace();
				}
				
				
			}
		}else{
			form.setReturnInfo("未查找到要添加的饮片!");
		}
		
		return "addBaseOrgFinish";
	}
	
	public String deleteObject(){
		User user = (User) getSession().getAttribute("User");
		
		TabletBaseOrg vo=new TabletBaseOrg();
		vo.setBaseid(form.getId());
		vo.setOrgid(user.getOrg().getOrgid());
		
		if(tabletBaseDao.deleteByBaseOrg(vo)==0){
			form.setReturnInfo("删除饮片品名失败!");
		}
		findByList();
		return "findByList";
	}
	
	public String findById(){
		form.setVo(tabletBaseDao.findById(form.getId()));
		return "update";
	}
	
	
	
	public String tabletBaseChoice(){
		User user = (User)getSession().getAttribute("User");
		if(user.getOrg()!=null){
			form.setOrgid_in(user.getOrg().getOrgid());
		}		
		form.setPager_openset(5);//一页显示10行
		form.setPager_count(tabletBaseDao.findByCount(form));
		form.setList(tabletBaseDao.findByList(form));
		
		return "tabletBaseChoice";
	}
	
	/**
	 * 饮片库存查询
	 * @return String
	 */
    public String findByList_un(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid_un(user.getOrg().getOrgid());
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(tabletBaseDao.findByCount(form));
		form.setList(tabletBaseDao.findByList(form));
		
		return "findByList_un";
	}
	
	/**
	 * 饮片品名查询
	 * @return String
	 */
    public String findByList(){
		User user = (User)getSession().getAttribute("User");	
		form.setOrgid_in(user.getOrg().getOrgid());
		form.setEnabled(1);
		form.setPager_openset(10);     //一页显示10行
		form.setPager_count(tabletBaseDao.findByCount(form));
		form.setList(tabletBaseDao.findByList(form));
		
		return "findByList";
	}
    
}
