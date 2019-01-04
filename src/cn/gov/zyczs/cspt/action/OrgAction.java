package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.ICodeRegionDao;
import cn.gov.zyczs.cspt.dao.ICompanyDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IOrgUploadDao;
import cn.gov.zyczs.cspt.dao.IRoleDao;
import cn.gov.zyczs.cspt.dao.IUserDao;
import cn.gov.zyczs.cspt.po.CodeArea;
import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.Role;
import cn.gov.zyczs.cspt.po.User;

import com.opensymphony.xwork2.ModelDriven;

public class OrgAction extends BaseAction implements ModelDriven<Org> {
	Org form =new Org();
	@Override
	public Org getModel() {
		return form;
	}
	private IOrgDao orgDao;
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	
	private ICodeRegionDao codeRegionDao;
	public void setCodeRegionDao(ICodeRegionDao codeRegionDao) {
		this.codeRegionDao = codeRegionDao;
	}
	
	private ICompanyDao companyDao;
	public void setCompanyDao(ICompanyDao companyDao) {
		this.companyDao = companyDao;
	}
	/**
	 * 行政区划dao
	 */
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}
	private IRoleDao roleDao;
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}
	private IOrgUploadDao orgUploadDao;//企业组织上传附件dao
	public void setOrgUploadDao(IOrgUploadDao orgUploadDao) {
		this.orgUploadDao = orgUploadDao;
	}
	
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
	private IUserDao userDao;
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	/**
	 * 组织查询
	 */
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(orgDao.findByCount(form));
		form.setOrglist(orgDao.findByList(form));
		return "success";
	}
	
	public String findByListChoice(){
		form.setPager_openset(5);
		form.setPager_count(orgDao.findByCount(form));
		form.setOrglist(orgDao.findByList(form));
		return "choice";
	}
	
	
	/**
	 * 组织添加初始化
	 */
	public String saveInit(){
		Company company = new Company();
		company.setCpccorp(form.getCpccorp());
		form.setCompany(companyDao.findByCpccorp(company));
		return "saveinit";
	}
	
	/**
	 * 组织添加
	 * @throws IOException 
	 * @throws DocumentException 
	 */
	public synchronized String save() throws IOException, DocumentException{
		/*****************后台判断该企业是否已经注册********************/
		Company tempCorp = new Company();
		tempCorp.setCorpname(form.getOrgname());
		List<Company> companys = companyDao.findByExist(tempCorp);
		if(companys != null && companys.size() > 0){
			form.setReturninfo("企业名称已经存在");
			return "save";
		}
		/******************后台判断该下属单位是否已经注册**************/
		List<Org> orgs = orgDao.findByExist(form.getOrgname());
		if(orgs != null && orgs.size() > 0 ){
			form.setReturninfo("组织名称已经存在");
			return "save";
		}
		
		User _user = (User) getSession().getAttribute("User");
		//将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());
		
		String areacode = codeAreaDao.findByName(codeArea);
		if(areacode==null||"".equals(areacode)){
			form.setReturninfo("添加下属单位失败!地址代码未找到!");
			return "save";
		}
		form.setAreacode(areacode);
		
		
		OrgUpload orgUpload = new OrgUpload();
		/*String uploadIds = form.getUploadids();
		if("".equals(uploadIds)){
			uploadIds = "0";
		}
		orgUpload.setUploadids(uploadIds);
		List<OrgUpload> orgUploads = orgUploadDao.findByUploadids(orgUpload);*/
		orgUpload.setType(1);
		orgUpload.setTokenid(form.getTokenid());
		List<OrgUpload> orgUploads = orgUploadDao.findByTokenIdAndType(orgUpload);
		String method = Tools.xmlRegister(form, "insert", areacode, 1,null,form.getCpccorp(),orgUploads);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			form.setReturninfo("审核失败!请求中央接口超时！");
			return "saveinit";
		}
		

		if(xmlstr == null|| xmlstr.equals("")){
			form.setReturninfo("审核失败!请重试！");
			return "saveinit";
		}
		
		String respcode ="";
		String cpccorp ="";	
		if(xmlstr != null && !xmlstr.equals("")){
			Document document = DocumentHelper.parseText(xmlstr); 
			respcode =document.selectSingleNode("cpc/respcode").getText();
			String cpcOrg =document.selectSingleNode("cpc/operadata/corpcpccode").getText();
			
			if(cpcOrg == null || "".equals(cpcOrg) || cpcOrg.length()!=14){
				if(respcode==null||!respcode.equals("0000")){
					String returninfo ="审核失败!";
					returninfo = Tools.getReturnInfo(respcode, returninfo);
					form.setReturninfo(returninfo);
					return "saveinit";
				}
			}else{
				
				/*****************根据返回的cpc查询company,org表是否已经存在********************/
				tempCorp.setCpccorp(cpcOrg);
				Company company = companyDao.findByCpccorp(tempCorp);
				if(company != null){
					form.setReturninfo("组织名称已经存在");
					return "save";
				}
				
				Org tempOrg = new Org();
				tempOrg.setCpccorp(cpcOrg);
				orgs = orgDao.findByCpccorp(tempOrg);
				if(orgs != null && orgs.size() > 0){
					form.setReturninfo("组织名称已经存在");
					return "save";
				}
				/**********************************************************/
				
				form.setSupercpccode(form.getCpccorp());//页面hidden传回的企业cpc
				form.setCpccorp(cpcOrg);//组织机构cpc
				Integer orgid = orgDao.save(form);
				if(orgid!=0){
					
					//种植  默认组和管理组
					String[] med_normal=ServletActionContext.getServletContext().getInitParameter("med_normal").split(",");
					String[] med_manage=ServletActionContext.getServletContext().getInitParameter("med_manage").split(",");
					//种植经销  默认组和管理组
					String[] medsell_normal=ServletActionContext.getServletContext().getInitParameter("medsell_normal").split(",");
					String[] medsell_manage=ServletActionContext.getServletContext().getInitParameter("medsell_manage").split(",");
					//生产  默认组和管理组
					String[] tablet_normal=ServletActionContext.getServletContext().getInitParameter("tablet_normal").split(",");
					String[] tablet_manage=ServletActionContext.getServletContext().getInitParameter("tablet_manage").split(",");
					//生产销售  默认组和管理组
					String[] tabletsell_normal=ServletActionContext.getServletContext().getInitParameter("tabletsell_normal").split(",");
					String[] tabletsell_manage=ServletActionContext.getServletContext().getInitParameter("tabletsell_manage").split(",");
					
					//市场  默认组和管理组
					String[] market_normal=ServletActionContext.getServletContext().getInitParameter("market_normal").split(",");
					String[] market_manage=ServletActionContext.getServletContext().getInitParameter("market_manage").split(",");
					//医院  默认组和管理组
					String[] hospital_normal=ServletActionContext.getServletContext().getInitParameter("hospital_normal").split(",");
					String[] hospital_manage=ServletActionContext.getServletContext().getInitParameter("hospital_manage").split(",");
					//监管管理组
					String[] govment_manage=ServletActionContext.getServletContext().getInitParameter("govment_manage").split(",");
					
					Role role = new Role();
					Integer oneid =0;
					if(!form.getZyctype().equals("00000010")){
						role.setRolename("默认组");
						role.setOrgid(orgid);
						oneid = roleDao.saveObject(role);	
					}
					role.setRolename("管理组");
					role.setOrgid(orgid);
					Integer towid = roleDao.saveObject(role);
					
					if(form.getZyctype().equals("10000000")){ //种植
						for(String mednormal:med_normal){
							Map map = new HashMap();
							map.put("roleid", oneid);
							map.put("menuid", mednormal);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
						for(String medmanage:med_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", medmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}else if(form.getZyctype().equals("01000000")){ //种植经销
						for(String medsellnormal:medsell_normal){
							Map map = new HashMap();
							map.put("roleid", oneid);
							map.put("menuid", medsellnormal);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
						for(String medsellmanage:medsell_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", medsellmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}else if(form.getZyctype().equals("00100000")){ //生产
						for(String tabletnormal:tablet_normal){
							Map map = new HashMap();
							map.put("roleid", oneid);
							map.put("menuid", tabletnormal);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
						for(String tabletmanage:tablet_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", tabletmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}else if(form.getZyctype().equals("00010000")){ //生产经销
						
						role.setRolename("药材经销组");
						role.setOrgid(orgid);
						Integer threeid = roleDao.saveObject(role);
						
						for(String tabletsellnormal:tabletsell_normal){
							Map map = new HashMap();
							map.put("roleid", oneid);
							map.put("menuid", tabletsellnormal);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
						for(String tabletsellmanage:tabletsell_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", tabletsellmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
						//如果是饮片经销,则还可以拥有药材经销的权限
						for(String medsellnormal:medsell_normal){
							Map map = new HashMap();
							map.put("roleid", threeid);
							map.put("menuid", medsellnormal);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
					}else if(form.getZyctype().equals("00001000")){ //市场
						for(String marketnormal:market_normal){
							Map map = new HashMap();
							map.put("roleid", oneid);
							map.put("menuid", marketnormal);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
						for(String marketmanage:market_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", marketmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}else if(form.getZyctype().equals("00000100")){ //医院
						for(String hospitalnormal:hospital_normal){
							Map map = new HashMap();
							map.put("roleid", oneid);
							map.put("menuid", hospitalnormal);
							roleDao.saveByIdRoleMenuOne(map);
						}
						
						for(String hospitalmanage:hospital_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", hospitalmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}else if(form.getZyctype().equals("00000010")){ //监管
						for(String govmentmanage:govment_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", govmentmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}
					
					//更新企业组织附件表中的组织id
					OrgUpload temp = new OrgUpload();
					temp.setId(orgid);
					temp.setType(1);
					/*temp.setUploadids(uploadIds);
					orgUploadDao.updateByIds(temp);*/
					temp.setTokenid(form.getTokenid());
					orgUploadDao.updateByTokenIdAndType(temp);
					
					
					// 记录操作日志
					OpLog opLog = new OpLog();
					opLog.setSysid(7);
					opLog.setMethod("企业审核");
					opLog.setLoginName(_user.getLoginname());
					opLog.setUserName(_user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLog.setContent("企业cpc:" + cpcOrg);
					opLogDao.saveOjbect(opLog);	
					
					form.setReturninfo("添加下属单位成功!");
				}else{
					form.setReturninfo("添加下属单位失败!");
				}
			}	
		}
		
		return "save";
	}
	
	/**
	 * 组织查询
	 */
	public String updateInit(){
		form.setOrg(orgDao.findById(form));
		return "update";
	}
	
	public String update() throws IOException, DocumentException{
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setType(1);//组织
		orgUpload.setId(form.getOrgid());
		List<OrgUpload> orgUploads = orgUploadDao.findUploadContent(orgUpload);
		
		String method = Tools.xmlRegister(form, "update", form.getAreacode(), 1,null,form.getSupercpccode(),orgUploads);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr  = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			form.setReturninfo("更新失败,请求中央接口超时!");
			updateInit();
			return "update";
		}
		

		System.out.println(method);
		if (xmlstr == null || xmlstr.equals("")) {
			form.setReturninfo("更新失败!");
			updateInit();
			return "update";
		}
		
		String respcode = "";
		String cpccorp = "";
		if (xmlstr != null && !xmlstr.equals("")) {
			Document document = DocumentHelper.parseText(xmlstr);
			respcode = document.selectSingleNode("cpc/respcode").getText();
			cpccorp = document.selectSingleNode("cpc/operadata/corpcpccode")
					.getText();
			if (respcode == null || !respcode.equals("0000") || cpccorp == null
					|| "".equals(cpccorp) || cpccorp.length() != 14) {
				form.setReturninfo("更新失败!");
				updateInit();
				return "update";
			}
			if(orgDao.updateById(form)!=0){
				form.setReturninfo("更新成功!");
			}else{
				form.setReturninfo("更新失败!");
			}
			updateInit();
			return "update";
		} else {
			form.setReturninfo("更新失败!");
			updateInit();
			return "update";
		}
	}
	
	//////////////市场统计////////////////////
	/**
	 * 市场的经营户统计
	 * @return
	 */
	public String findByMedmarketUserStat(){
		User user = (User) getSession().getAttribute("User");
		
		form.setOrgid(user.getOrgid());
		form.setPager_openset(10);

		form.setPager_count(orgDao.findByMedmarketUserStatCount(form));
		form.setOrglist(orgDao.findByMedmarketUserStatList(form));
		return "findByMedmarketUserStat";
	}
	
	
	/**
	 * 更新市场商户信息初始化页面
	 * @return
	 */
	public String UpdateMarketUserInit(){
		Org temp = new Org();
		temp.setCpccorp(form.getCpccorp());
		Org org = orgDao.findByCpccorp(temp).get(0);
		//查询经营户下的市场区域坐标
		User utemp = new User();
		utemp.setCpccorp(form.getCpccorp());
		User user = userDao.findByCpccorp(utemp);
		org.setPartion(user.getPartion());
		org.setCoordinate(user.getCoordinate());
		form.setOrg(org);
		
		Company c = new Company();
		c.setCpccorp(org.getSupercpccode());
		form.setCompany(companyDao.findByCpccorp(c));
		
		return "UpdateMarketUserInit";
	}
	/**
	 * 查询组织机构上拥有的称信息在地图上显示
	 * @return
	 */
	public String findOrgCheng(){
		//form.setOrglist(orgDao.findOrgCheng());
		
		List<Org> cheng = orgDao.findOrgCheng();
		List<Org> market = orgDao.findMarket();
		cheng.addAll(market);
		form.setOrglist(cheng);
		System.out.println(">>>>>"+cheng.size());
		return SUCCESS;
	}
	
	
	/**
	 * 出库选择查询所有企业
	 * @throws IOException 
	 * @throws DocumentException 
	 */
	public String chooseOrg() throws IOException, DocumentException{
		User user = (User) getSession().getAttribute("User");
		String zyczstype=user.getOrg().getZyctype();
		String type="";
		System.out.println(zyczstype);
		System.out.println(zyczstype.substring(0,1));
		if(zyczstype.substring(0,1).equals("1")){
			type="01100000";
		}else if(zyczstype.substring(1,2).equals("1")){
			type="01100000";
		}else if(zyczstype.substring(2,3).equals("1")){
			type="00010100";
		}else if(zyczstype.substring(3,4).equals("1")){
			type="00010100";
		}else if(zyczstype.substring(4,5).equals("1")){
			type="01100000";
		}
		String method="userName="+ServletActionContext.getServletContext().getInitParameter("operatename");
		method+="&password="+ServletActionContext.getServletContext().getInitParameter("operatepwd");
		method+="&zyctype="+type;
		//method+="&areacode="+user.getOrg().getAreacode();
		method+="&page="+Tools.addtract_Integer(String.valueOf(form.getPager_offset()/5), "1");
		System.out.println("form.getCorpname()===="+form.getCorpname());
		if(form.getCorpname()!=null&&form.getCorpname().length()>0){
		method+="&corpName="+form.getCorpname();
		}
		if(form.getCpccorp()!=null&&form.getCpccorp().length()>0){
		method+="&corpcpccode="+form.getCpccorp();
		}
		System.out.println("method==="+method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method, "chooseorg");
		}catch(Exception ex){
			form.setReturninfo("调用企业查询接口失败,请求中央接口超时!");
			return "chooseOrg";
		}
		
		if (xmlstr == null || xmlstr.equals("")) {
			form.setReturninfo("调用企业查询接口失败!");
			return "chooseOrg";
		}
		String respcode = "";
		String respmsg = "";
		String corplist = "";
		String currentpage = "";
		String listcount="";
		if (xmlstr != null && !xmlstr.equals("")) {
			Document document = DocumentHelper.parseText(xmlstr);
			respcode = document.selectSingleNode("cpc/respcode").getText();
			respmsg = document.selectSingleNode("cpc/respmsg").getText();
			corplist = document.selectSingleNode("cpc/data/corplist").getText();
			currentpage = document.selectSingleNode("cpc/data/currentpage").getText();
			listcount = document.selectSingleNode("cpc/data/listcount").getText();
			if (respcode == null||!respcode.equals("0000")||respmsg == null||"".equals(respmsg)||currentpage == null||"".equals(currentpage)||listcount == null||"".equals(listcount)) {
				form.setReturninfo("调用企业查询接口失败!");
				return "chooseOrg";
			}
			List<Org> orglist = new ArrayList<Org>();
			if(!"".equals(corplist)&&corplist.length()>0){
				String[] objtemp = corplist.split(";");
				for(String obj:objtemp){
					String[] str =obj.split(",");
					Org org =  new Org();
					org.setOrgname(str[0]);
					org.setCpccorp(str[1]);
					orglist.add(org);
				}
			}
			form.setOrglist(orglist);
			form.setPager_count(Integer.valueOf(listcount));
		}
		return "chooseOrg";
	}
	
	/**
	 * 查看下属组织是否存在
	 * @return
	 */
	public String findByExist() {
		Company c = new Company();
		c.setCorpname(form.getOrgname());
		List<Company> companylist = new ArrayList<Company>();
		companylist = companyDao.findByExist(c);
		if (companylist.size() > 0) {
			form.setReturncode(1);
			form.setReturninfo("组织名称已经存在");
			return SUCCESS;
		} 
		
		List<Org> orglist = new ArrayList<Org>();
		orglist = orgDao.findByExist(form.getOrgname());
		if (orglist.size() > 0) {
			form.setReturncode(1);
			form.setReturninfo("组织名称已经存在");
			return SUCCESS;
		}
		
		int returncode = Tools.findNameExist(form.getOrgname());
		if(returncode == 1){
			form.setReturninfo("组织名称已经存在");
		}else if(returncode == 2){
			form.setReturninfo("请求中央接口超时");
		}
		form.setReturncode(returncode);
		
		return SUCCESS;
	}
}
