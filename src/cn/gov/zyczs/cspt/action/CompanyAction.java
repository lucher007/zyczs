package cn.gov.zyczs.cspt.action;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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

public class CompanyAction extends BaseAction implements ModelDriven<Company> {
	private static final long serialVersionUID = 1L;

	Company form = new Company();
	@Override
	public Company getModel() {
		return form;
	}
	private ICompanyDao companyDao;
	public void setCompanyDao(ICompanyDao companyDao) {
		this.companyDao = companyDao;
	}
	private ICodeRegionDao codeRegionDao;
	public void setCodeRegionDao(ICodeRegionDao codeRegionDao) {
		this.codeRegionDao = codeRegionDao;
	}
	private IUserDao userDao;
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}
	private IOrgDao orgDao;
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	private IRoleDao roleDao;
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
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
	

	private IOrgUploadDao orgUploadDao;//企业组织上传附件dao
	public void setOrgUploadDao(IOrgUploadDao orgUploadDao) {
		this.orgUploadDao = orgUploadDao;
	}
	
	/**
	 * 根据企业编码查询企业
	 * 
	 * @return Boolean
	 */
	@SuppressWarnings("unchecked")
	public void findByCpccorp() {
		HttpServletResponse response = this.getResponse();
		try {
			User user = (User) getSession().getAttribute("User");

			form.setCorpname(URLDecoder.decode(form.getCorpname()));
			Integer state = Tools.findCompany(form.getCpccorp(), form
					.getCorpname(), user);

			String status = "";
			if (state == 1) {
				status = "cpc不正确";
			} else if (state == 2) {
				status = "企业名称不匹配";
			} else if (state == 3) {
				status = "销售去向不正确";
			} else if (state == 4) {
				status = "请求cpc接口异常";
			}

			String json = "{\"state\":\"" + status + "\"}";
			Tools.printJson(response, json);
		} catch (Exception e) {
			String json = "{\"state\":\"请求cpc接口异常\"}";
			Tools.printJson(response, json);
			e.printStackTrace();
		}
	}

	/**
	 * 企业查询
	 */
	public String findByList() {
		form.setPager_openset(10);
		form.setState(1);
		form.setPager_count(companyDao.findByCount(form));
		List<Company> companylist = companyDao.findByList(form);
		for (Company c : companylist) {
			Org org = new Org();
			org.setSupercpccode(c.getCpccorp());
			List<Org> orglist = orgDao.findByCpccorp(org);
			c.setOrgs(orglist);
		}
		form.setCompanylist(companylist);
		return "success";
	}

	/**
	 * 企业查询未审核
	 */
	public String findByListVerify() {
		form.setPager_openset(10);
		form.setState(0);
		form.setPager_count(companyDao.findByCount(form));
		form.setCompanylist(companyDao.findByList(form));
		return "successverify";
	}

	/**
	 * 添加企业
	 * 
	 * @throws IOException
	 * @throws DocumentException
	 */
	public String save_bak() throws IOException, DocumentException {
		User _user = (User)getSession().getAttribute("User");
		form.setOpertype(0);
		Integer companyId = companyDao.save(form);
		if (companyId != 0) {
			//更新企业组织附件表中的企业id
			OrgUpload orgUpload = new OrgUpload();
			orgUpload.setId(companyId);
			String uploadIds = form.getUploadids();
			if("".equals(uploadIds)){
				uploadIds = "0";
			}
			orgUpload.setUploadids(uploadIds);
			//更新企业上传附件
			orgUploadDao.updateByIds(orgUpload);
			
			// 记录操作日志
			OpLog opLog = new OpLog();
			opLog.setSysid(7);
			opLog.setMethod("企业备案");
			opLog.setLoginName(_user.getLoginname());
			opLog.setUserName(_user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLogDao.saveOjbect(opLog);	
			
			form.setReturninfo("主体备案成功!已进入备案审核!");
		} else {
			form.setReturninfo("主体备案失败!");
		}
		return "save";
	}

	/**
	 * 企业查询审核
	 */
	public String updateInitVerify() {
		form.setCpccorp(null);
		form.setCompany(companyDao.findById(form));
		return "updateverify";
	}

	/**
	 * 企业审核
	 */
	public String updateVerify_bak() throws DocumentException, IOException {
		User _user = (User) getSession().getAttribute("User");
		
		// 将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());

		String areacode = codeAreaDao.findByName(codeArea);
		if (areacode == null || "".equals(areacode)) {
			updateInitVerify();
			form.setReturninfo("审核失败!地址代码未找到!");
			return "updateverify";
		}
		
		
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setType(0);//企业
		orgUpload.setId(form.getCompanyid());
		List<OrgUpload> orgUploads = orgUploadDao.findUploadContent(orgUpload);
		
		String method = Tools.xmlRegister(form, "insert", areacode, 0,null,null,orgUploads);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method, "corpinfo");
		}catch(Exception ex){
			updateInitVerify();
			form.setReturninfo("审核失败,请求中央接口超时!");
			return "updateverify";
			
		}
		if (xmlstr == null || xmlstr.equals("")) {
			updateInitVerify();
			form.setReturninfo("审核失败!请重试！");
			return "updateverify";
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
				String returninfo = "审核失败!";
				returninfo = Tools.getReturnInfo(respcode, returninfo);
				updateInitVerify();
				form.setReturninfo(returninfo);
				return "updateverify";
			}

			form.setAreacode(areacode);
			form.setCpccorp(cpccorp);
			form.setState(1);
			if (companyDao.updateById(form) != 0) {
				if (form.getZyctype().equals("00001000")
						|| form.getZyctype().equals("00000100")
						|| form.getZyctype().equals("00000010")
						|| form.getZyctype().equals("00000001")) {
					String[] extendName = new String[] { "_市场", "_医院", "_管理机构",
							"_其他" };
					Org org = new Org();
					Tools.setVOToVO(form, org);
					if (form.getZyctype().equals("00001000")) {
						form.setCorpname(form.getCorpname() + extendName[0]);
					} else if (form.getZyctype().equals("00000100")) {
						form.setCorpname(form.getCorpname() + extendName[1]);
					} else if (form.getZyctype().equals("00000010")) {
						form.setCorpname(form.getCorpname() + extendName[2]);
					} else {
						form.setCorpname(form.getCorpname() + extendName[3]);
					}
					org.setOrgname(form.getCorpname());
					org.setOrgshortname(form.getCorpshortname());
					org.setSupercpccode(cpccorp);// 组织所在企业cpc

					method = Tools.xmlRegister(org, "insert", areacode, 1,null,cpccorp,orgUploads);
					System.out.println(method);
					try{
						xmlstr = Tools.sendPost(method, "corpinfo");
					}catch(Exception ex){
						updateInitVerify();
						form.setReturninfo("审核失败，请求中央接口超时!");
						return "updateverify";
					}
					if (xmlstr != null && !xmlstr.equals("")) {
						document = DocumentHelper.parseText(xmlstr);
						respcode = document.selectSingleNode("cpc/respcode")
								.getText();
						String cpcOrg = document.selectSingleNode(
								"cpc/operadata/corpcpccode").getText();
						org.setCpccorp(cpcOrg);// 组织结构cpc
						if (respcode == null || !respcode.equals("0000")
								|| cpcOrg == null || "".equals(cpcOrg)
								|| cpcOrg.length() != 14) {
							String returninfo = "审核失败!";
							returninfo = Tools.getReturnInfo(respcode, returninfo);
							updateInitVerify();
							form.setReturninfo(returninfo);
							return "updateverify";
						}
					} else {
						updateInitVerify();
						form.setReturninfo("审核失败!");
						return "updateverify";
					}
					Integer orgid = orgDao.save(org);
					if (orgid != 0) {
						
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
						
						/*********将企业的附件报告写入组织机构中*********/
						OrgUpload temp = new OrgUpload();
						temp.setId(form.getCompanyid());
						temp.setType(0);
						
						List<OrgUpload> orgUploadList = orgUploadDao.findByCondtion(temp);
						for(OrgUpload obj : orgUploadList){
							obj.setId(orgid);
							obj.setType(1);
							orgUploadDao.save(obj);
						}
						// 记录操作日志
						OpLog opLog = new OpLog();
						opLog.setSysid(7);
						opLog.setMethod("企业审核");
						opLog.setLoginName(_user.getLoginname());
						opLog.setUserName(_user.getUsername());
						opLog.setClientIp(Tools.getRealIp(this.getRequest()));
						opLog.setContent("企业cpc:" + cpccorp);
						opLogDao.saveOjbect(opLog);
						
						form.setReturninfo("审核成功!");
					} else {
						form.setReturninfo("审核失败!");
					}
				} else {
					form.setReturninfo("审核成功!");
				}
			} else {
				form.setReturninfo("审核失败!");
			}
		} else {
			updateInitVerify();
			form.setReturninfo("审核失败!");
			return "updateverify";
		}
		updateInitVerify();
		return "updateverify";
	}

	/**
	 * 企业查询
	 */
	public String updateInit() {
		form.setCompany(companyDao.findById(form));
		return "update";
	}

	/**
	 * 企业更新
	 */
	public String update() throws DocumentException, IOException {
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setType(0);//企业
		orgUpload.setId(form.getCompanyid());
		List<OrgUpload> orgUploads = orgUploadDao.findUploadContent(orgUpload);
		
		String method = Tools.xmlRegister(form, "update", form.getAreacode(), 0,null,null,orgUploads);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			form.setReturninfo("更新失败,请求中央接口超时!");
			form.setCpccorp(null);
			updateInit();
			return "update";
		}
		System.out.println(method);
		if (xmlstr == null || xmlstr.equals("")) {
			form.setReturninfo("更新失败!");
			form.setCpccorp(null);
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

			// form.setCorpshortname(form.getCorpname());
			// form.setAreacode(areacode);
			form.setCpccorp(null);

			if (companyDao.updateById(form) != 0) {
				//如果是非集团,则同步更新org信息,集团的话,则是到org中单独更新
				if(form.getCorp() == null || form.getCorp() == 1){
					Org org = new Org();
					Tools.setVOToVO(form, org);
					org.setSupercpccode(cpccorp);
					if(orgDao.updateBySuperCpC(org) != 0){
						form.setReturninfo("更新成功!");
					}else{
						form.setReturninfo("更新失败!");
					}
				}
				updateInit();
			} else {
				form.setReturninfo("更新失败!");
				updateInit();
			}
		} else {
			form.setReturninfo("更新失败!");
			updateInit();
			return "update";
		}

		return "update";
	}

	/**
	 * 新增市场下的经营户
	 * 
	 * @return
	 * @throws IOException
	 * @throws DocumentException
	 */
	public String addUserMarket_bak() throws IOException, DocumentException {
		User _user = (User) getSession().getAttribute("User");

		// 将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());

		String areacode = codeAreaDao.findByName(codeArea);

		if (areacode == null || "".equals(areacode)) {
			form.setReturninfo("注册失败!地址代码未找到!");
			return "addUserMarket";
		}
		
		String method = Tools.xmlRegister(form, "insert", areacode, 0,_user.getCpccorp(),null,null);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			updateInitVerify();
			form.setReturninfo("注册失败!请求中央接口超时!");
			return "addUserMarket";
		}
	

		if (xmlstr == null || xmlstr.equals("")) {
			updateInitVerify();
			form.setReturninfo("注册失败!请重试！");
			return "addUserMarket";
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
				String returninfo = "注册失败!";
				if (respcode.equals("0006")) {
					returninfo += " 该公司已注册!";
				}
				if(respcode.equals("0008")){
					returninfo+=" 公司类型不正确，只能是一种类型!";
				}
				form.setReturninfo(returninfo);
				return "addUserMarket";
			}
			form.setCpccorp(cpccorp);
			//form.setCorpshortname(form.getCorpname());
			form.setAreacode(areacode);
			form.setState(1);
			form.setOpertype(0);
			int companyId = companyDao.save(form);
			if (companyId != 0) {
				// 新增org
				Org org = new Org();
				Tools.setVOToVO(form, org);
				String oldCorpname = form.getCorpname();
				String oldShortname =  form.getCorpshortname();
				form.setCorpname(form.getCorpname()+"_药材经销");
				form.setCorpshortname(form.getCorpshortname()+"_药材经销");
				org.setOrgname(form.getCorpname());
				org.setOrgshortname(form.getCorpshortname());
				org.setMarketcode(_user.getCpccorp());//当前登录用户的组织机构cpc
				org.setSupercpccode(cpccorp);
				org.setBusinessnumber(form.getBusinessnumber());
				method = Tools.xmlRegister(org, "insert", areacode, 1,_user.getCpccorp(),cpccorp,null);
				System.out.println(method);
				try{
					xmlstr = Tools.sendPost(method,"corpinfo");
				}catch(Exception ex){
					updateInitVerify();
					form.setReturninfo("注册失败!请求中央接口超时!");
					return "addUserMarket";
				}
				if (xmlstr != null && !xmlstr.equals("")) {
					document = DocumentHelper.parseText(xmlstr);
					respcode = document.selectSingleNode("cpc/respcode").getText();
					String cpcOrg = document.selectSingleNode("cpc/operadata/corpcpccode")
							.getText();
					org.setCpccorp(cpcOrg);
					if (respcode == null || !respcode.equals("0000") || cpcOrg == null
							|| "".equals(cpcOrg) || cpcOrg.length() != 14) {
						String returninfo = "注册失败!";
						if (respcode.equals("0006")) {
							returninfo += " 该商户已注册!";
						}
						form.setReturninfo(returninfo);
						return "addUserMarket";
					}
					form.setCorpname(oldCorpname);
					form.setCorpshortname(oldShortname);
					Integer orgId = orgDao.save(org);
					form.setOrg(org);
					if (orgId != null) {
						// 新增user
						User user = new User();
						user.setOrgid(orgId);
						user.setState(1);
						user.setUsertype(2);
						
						user.setCpccorp(cpcOrg);
						user.setUsername(form.getLinkman());
						user.setLoginname(cpcOrg);
						user.setLoginpass(cpcOrg);
						user.setPartion(form.getPartion());
						user.setCoordinate(form.getCoordinate());
						userDao.save(user);
					} else {
						form.setReturninfo("注册失败!");
						return "addUserMarket";
					}
					form.setReturninfo("注册成功!");

					// 记录操作日志
					OpLog opLog = new OpLog();
					opLog.setSysid(3);
					opLog.setMethod("企业备案");
					opLog.setLoginName(_user.getLoginname());
					opLog.setUserName(_user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLog.setContent("企业cpc:" + cpccorp);
					opLogDao.saveOjbect(opLog);
				}else{
					form.setReturninfo("注册失败!");
					return "addUserMarket";
				}
			} else {
				form.setReturninfo("注册失败!");
			}
		} else {
			form.setReturninfo("注册失败!");
			return "addUserMarket";
		}
		form.setAddtime(Tools.getDateMonthDayStrTwo());
		return "addUserMarketFinish";
	}

	/**
	 * 更新市场用户
	 * @return
	 * @throws IOException
	 * @throws DocumentException
	 */
	public String updateUserMarket_bak() throws IOException, DocumentException {
		String method = Tools.xmlRegister(form, "update", form.getAreacode(), 0,form.getMarketcode(),null,null);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			form.setReturninfo("更新失败,请求中央接口超时!");
			return SUCCESS;
		}
		

		if (xmlstr == null || xmlstr.equals("")) {
			form.setReturninfo("更新失败!");
			return SUCCESS;
		}
		String respcode = "";
		String cpccorptemp = "";
		if (xmlstr != null && !xmlstr.equals("")) {
			Document document = DocumentHelper.parseText(xmlstr);
			respcode = document.selectSingleNode("cpc/respcode").getText();
			cpccorptemp = document
					.selectSingleNode("cpc/operadata/corpcpccode").getText();
			if (respcode == null || !respcode.equals("0000")
					|| cpccorptemp == null || "".equals(cpccorptemp)
					|| cpccorptemp.length() != 14) {
				form.setReturninfo("更新失败!");
				return SUCCESS;
			}
		}
		Integer count = companyDao.updateById(form);
		if (count != 0) {
			// 新增org
			Org temp = new Org();
			temp.setSupercpccode(form.getCpccorp());
			Org	org = orgDao.findByCpccorp(temp).get(0);
			String tempcpcOrg = org.getCpccorp(); 
			Tools.setVOToVO(form, org);
			org.setOrgname(form.getCorpname()+"_药材经销");
			org.setOrgshortname(form.getCorpshortname()+"_药材经销");
			org.setBusinessnumber(form.getBusinessnumber());
			org.setOrgid(form.getOrgid());
			org.setSupercpccode(form.getCpccorp());
			org.setCpccorp(tempcpcOrg);
			method = Tools.xmlRegister(org, "update", org.getAreacode(), 1,form.getMarketcode(),form.getCpccorp(),null);
			System.out.println(method);
			try{
				xmlstr =Tools.sendPost(method,"corpinfo");
			}catch(Exception ex){
				form.setReturninfo("更新失败,请求中央接口超时!");
				return SUCCESS;
			}
			if (xmlstr == null || xmlstr.equals("")) {
				form.setReturninfo("更新失败!");
				return SUCCESS;
			}
			if (xmlstr != null && !xmlstr.equals("")) {
				Document document = DocumentHelper.parseText(xmlstr);
				respcode = document.selectSingleNode("cpc/respcode").getText();
				cpccorptemp = document
						.selectSingleNode("cpc/operadata/corpcpccode").getText();
				if (respcode == null || !respcode.equals("0000")
						|| cpccorptemp == null || "".equals(cpccorptemp)
						|| cpccorptemp.length() != 14) {
					form.setReturninfo("更新失败!");
					return SUCCESS;
				}
			}
			Integer orgId = orgDao.updateById(org);
			form.setOrg(org);
			if (orgId != 0) {
				// 新增user
				User user = new User();
				user.setCpccorp(org.getCpccorp());
				user = userDao.findByCpccorp(user);
				user.setLasttime(Tools.getCurrentTime());
				user.setUsername(form.getLinkman());
				user.setPartion(form.getPartion());
				user.setCoordinate(form.getCoordinate());
				userDao.updateById(user);
			}
		}
		form.setReturninfo("更新经营户完成");
		return "updateUserMarketFinish";
	}

	public String findByExist() {
		List<Company> companylist = new ArrayList<Company>();
		companylist = companyDao.findByExist(form);
		if (companylist.size() > 0) {
			form.setReturncode(1);
			form.setReturninfo("企业名称已经存在");
			return SUCCESS;
		} 
		
		List<Org> orglist = new ArrayList<Org>();
		orglist = orgDao.findByExist(form.getCorpname());
		if (orglist.size() > 0) {
			form.setReturncode(1);
			form.setReturninfo("企业名称已经存在");
			return SUCCESS;
		}
		int returncode = Tools.findNameExist(form.getCorpname());
		if(returncode == 1){
			form.setReturninfo("企业名称已经存在");
		}else if(returncode == 2){
			form.setReturninfo("请求中央接口超时");
		}
		form.setReturncode(returncode);
		return SUCCESS;
	}

	/**
	 * 公司,组织,用户注册
	 * @return
	 */
	public String register_bak() {
		User _user = (User) getSession().getAttribute("User");
		String[] extendName = new String[] { "药材种植", "药材经销", "饮片生产", "饮片经销",
				"市场", "医院", "管理机构", "其他" };
		String[] extendEnName = new String[] { "yc", "ycs", "yp", "yps" };
		String[] zyctypeArr = new String[] { "10000000", "01000000",
				"00100000", "00010000", "00001000", "00000100", "00000010",
				"00000001" };

		/********************避免多个用户同时注册*********************/
		String loginName = form.getLoginname();
		StringBuffer sb = new StringBuffer(loginName).append("_yc,").append(
				loginName).append("_ycs,").append(loginName).append("_yp,")
				.append(loginName).append("_yps");

		User temp = new User();
		temp.setLoginname(sb.toString());
		List list = userDao.findByExist(temp);

		if (list.size() > 0) {
			form.setReturninfo("注册信息失败!");
			return "regsuc";
		}
		/*********************************************************/

		form.setOpertype(1);// 前台注册
		Integer companyId = companyDao.save(form);
		if (companyId != 0) {
			//更新企业组织附件表中的企业id
			OrgUpload orgUpload = new OrgUpload();
			orgUpload.setId(companyId);
			String uploadIds = form.getUploadids();
			if("".equals(uploadIds)){
				uploadIds = "0";
			}
			orgUpload.setUploadids(uploadIds);
			orgUploadDao.updateByIds(orgUpload);
			
			String zyctype = form.getZyctype();
			// 根据zyctype个数循环写入org,user
			for (int i = 0; i < 8; i++) {
				if (zyctype.charAt(i) == '1') {
					Org org = new Org();
					Tools.setVOToVO(form, org);
					org.setOrgname(form.getCorpname() + "_" + extendName[i]);
					org.setOrgshortname(form.getCorpshortname() + "_" + extendName[i]);
					if (i < 4) {
						org.setZyctype(zyctypeArr[i]);
					}
					org.setCpccorp(companyId.toString());
					org.setSupercpccode(companyId.toString());
					Integer orgId = orgDao.save(org);

					if (orgId != null) {
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
							role.setOrgid(orgId);
							oneid = roleDao.saveObject(role);	
						}
						role.setRolename("管理组");
						role.setOrgid(orgId);
						Integer towid = roleDao.saveObject(role);
						
						if(org.getZyctype().equals("10000000")){ //种植
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
						}else if(org.getZyctype().equals("01000000")){ //种植经销
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
						}else if(org.getZyctype().equals("00100000")){ //生产
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
						}else if(org.getZyctype().equals("00010000")){ //生产经销
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
						}else if(org.getZyctype().equals("00001000")){ //市场
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
						}else if(org.getZyctype().equals("00000100")){ //医院
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
						}else if(org.getZyctype().equals("00000010")){ //监管
							for(String govmentmanage:govment_manage){
								Map map = new HashMap();
								map.put("roleid", towid);
								map.put("menuid", govmentmanage);
								roleDao.saveByIdRoleMenuOne(map);
							}
						}
						/*********将企业的附件报告写入组织机构中*********/
						OrgUpload tempUpload = new OrgUpload();
						tempUpload.setId(companyId);
						tempUpload.setType(0);
						
						List<OrgUpload> orgUploadList = orgUploadDao.findByCondtion(tempUpload);
						for(OrgUpload obj : orgUploadList){
							obj.setId(orgId);
							obj.setType(1);
							orgUploadDao.save(obj);
						}
						// 新增user
						User user = new User();
						user.setOrgid(orgId);
						user.setState(0);// 前台注册,未审核前,不能登录
						user.setUsertype(2);
						user.setCpccorp(companyId.toString());
						user.setUsername(form.getUsername());
						if (i < 4) {
							user.setLoginname(form.getLoginname() + "_"
									+ extendEnName[i]);
						} else {
							user.setLoginname(form.getLoginname());
						}
						user.setLoginpass(form.getLoginpass());
						userDao.save(user);
						
						// 记录操作日志
						OpLog opLog = new OpLog();
						opLog.setSysid(7);
						opLog.setMethod("企业备案");
						opLog.setLoginName(form.getLoginname());
						opLog.setUserName(form.getLoginname());
						opLog.setClientIp(Tools.getRealIp(this.getRequest()));
						opLogDao.saveOjbect(opLog);	
						
						form.setReturninfo("注册信息成功,进入备案操作!");
					} else {
						form.setReturninfo("注册信息失败!");
					}
				}
			}
		}
		return "regsuc";
	}

	/**
	 * 企业查询审核
	 */
	public String updateInitRegVerify() {
		form.setCpccorp(null);
		form.setCompany(companyDao.findById(form));
		// 注册用户时,org,user表中的企业cpc暂时为companyId
		// User user = new User();
		// user.setCpccorp(form.getCompanyid().toString());
		// form.setUser(userDao.findByCpccorp(user));
		return "updateInitRegVerify";
	}

	/**
	 * 审核前台企业组织用户注册信息
	 */
	public String updateRegVerify_bak() throws DocumentException, IOException {
		User _user = (User) getSession().getAttribute("User");
		String[] extendName = new String[] { "_药材种植", "_药材经销", "_饮片生产",
				"_饮片经销", "_市场", "_医院", "_管理机构", "_其他" };

		// 将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());

		String areacode = codeAreaDao.findByName(codeArea);
		if (areacode == null || "".equals(areacode)) {
			updateInitRegVerify();
			form.setReturninfo("审核失败!地址代码未找到!");
			return "updateInitRegVerify";
		}
		
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setType(0);//企业
		orgUpload.setId(form.getCompanyid());
		List<OrgUpload> orgUploads = orgUploadDao.findUploadContent(orgUpload);
		
		String method = Tools.xmlRegister(form, "insert", areacode, 0,null,null,orgUploads);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr =Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			updateInitRegVerify();
			form.setReturninfo("审核失败,请求中央接口超时!");
			return "updateverify";
		}

		if (xmlstr == null || xmlstr.equals("")) {
			updateInitRegVerify();
			form.setReturninfo("审核失败!请重试！");
			return "updateverify";
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
				String returninfo = "审核失败!";
				if (respcode.equals("0005")) {
					returninfo += " 系统运行时异常!";
				}
				if (respcode.equals("0006")) {
					returninfo += " 该公司已注册!";
				}
				updateInitRegVerify();
				form.setReturninfo(returninfo);
				return "updateInitRegVerify";
			}
 
			form.setAreacode(areacode);
			form.setCpccorp(cpccorp);
			form.setState(1);
			int companyResult = companyDao.updateById(form);
			if (companyResult != 0) {
				// 根据企业cpc(这里是前台注册操作,对应企业ID)查询出对应的组织进行更新
				List<Org> orgs = orgDao.findByCompanyId(form.getCompanyid());
				// 更新组织
				for (Org org : orgs) {
					Integer orgId = org.getOrgid();
					String zyctype = org.getZyctype();
					Tools.setVOToVO(form, org);
					org.setOrgid(orgId);
					org.setZyctype(zyctype);
					//根据企业类型,将企业名称变为对应的组织名称,进行组织机构cpc码申请
					if (zyctype.equals("10000000")) {
						form.setCorpname(form.getCorpname() + extendName[0]);
					} else if (zyctype.equals("01000000")) {
						form.setCorpname(form.getCorpname() + extendName[1]);
					} else if (zyctype.equals("00100000")) {
						form.setCorpname(form.getCorpname() + extendName[2]);
					} else if (zyctype.equals("00010000")) {
						form.setCorpname(form.getCorpname() + extendName[3]);
					} else if (zyctype.equals("00001000")) {
						form.setCorpname(form.getCorpname() + extendName[4]);
					} else if (zyctype.equals("00000100")) {
						form.setCorpname(form.getCorpname() + extendName[5]);
					} else if (zyctype.equals("00000010")) {
						form.setCorpname(form.getCorpname() + extendName[6]);
					} else {
						form.setCorpname(form.getCorpname() + extendName[7]);
					}
					org.setSupercpccode(cpccorp);// 组织所在企业cpc
					method = Tools.xmlRegister(org, "insert", areacode, 1,null,cpccorp,orgUploads);
					System.out.println(method);
					try{
						xmlstr = Tools.sendPost(method, "corpinfo");
					}catch(Exception ex){
						updateInitRegVerify();
						form.setReturninfo("审核失败,请求中央接口超时!");
						return "updateInitRegVerify";
					}
					

					if (xmlstr != null && !xmlstr.equals("")) {
						document = DocumentHelper.parseText(xmlstr);
						respcode = document.selectSingleNode("cpc/respcode")
								.getText();
						String cpcOrg = document.selectSingleNode(
								"cpc/operadata/corpcpccode").getText();
						org.setCpccorp(cpcOrg);//组织机构cpc
						if (respcode == null || !respcode.equals("0000")
								|| cpcOrg == null || "".equals(cpcOrg)
								|| cpcOrg.length() != 14) {
							String returninfo = "审核失败!";
							if (respcode.equals("0006")) {
								returninfo += " 该组织机构已注册!";
							}
							updateInitRegVerify();
							form.setReturninfo(returninfo);
							return "updateInitRegVerify";
						} else {
							int orgResult = orgDao.updateById(org);
							if (orgResult != 0) {
								User user = userDao.findByOrgId(org.getOrgid());
								// 更新用户
								Integer userId = user.getUserid();
								Tools.setVOToVO(form, user);
								user.setState(1);
								user.setUserid(userId);
								user.setCpccorp(org.getCpccorp());
								userDao.updateById(user);
								form.setReturninfo("审核成功!");
							} else {
								form.setReturninfo("审核失败!");
							}

							// 记录操作日志
							OpLog opLog = new OpLog();
							opLog.setSysid(7);
							opLog.setMethod("企业审核");
							opLog.setLoginName(_user.getLoginname());
							opLog.setUserName(_user.getUsername());
							opLog.setClientIp(Tools.getRealIp(this.getRequest()));
							opLog.setContent("企业cpc:" + cpccorp);
							opLogDao.saveOjbect(opLog);	
						}
					} else {
						updateInitRegVerify();
						form.setReturninfo("审核失败!");
						return "updateInitRegVerify";
					}
				}
			}
		} else {
			updateInitRegVerify();
			form.setReturninfo("审核失败!");
			return "updateInitRegVerify";
		}
		updateInitRegVerify();
		return "updateInitRegVerify";
	}

	/**
	 * 后台添加的企业,只需要删除企业和上传的附件
	 * @return
	 */
	public String deleteCompany() {
		//根据id和类型删除
		OrgUpload obj = new OrgUpload();
		obj.setId(form.getCompanyid());
		obj.setType(0);
		orgUploadDao.deleteObj(obj);
		orgDao.deleteByCompanyId(form.getCompanyid());
		companyDao.deleteByCompanyId(form.getCompanyid());
		return findByListVerify();
	}

	/**
	 * 前台注册的企业,需要删除用户,组织,企业
	 * @return
	 */
	public String deleteComOrgUser() {
		//根据企业id删除附件
		OrgUpload obj = new OrgUpload();
		obj.setId(form.getCompanyid());
		obj.setType(0);
		orgUploadDao.deleteObj(obj);
		//根据orgid删除附件
		List<Org> orgs = orgDao.findByCompanyId(form.getCompanyid());
		for(Org org : orgs){
			obj.setId(org.getOrgid());
			obj.setType(1);
			orgUploadDao.deleteObj(obj);
		}
		userDao.deleteByCompanyId(form.getCompanyid());
		orgDao.deleteByCompanyId(form.getCompanyid());
		companyDao.deleteByCompanyId(form.getCompanyid());
		return findByListVerify();
	}
	
	public String mapBaseChoice() {
		return "mapBaseChoice";
	}
	
	
	
	//////////////////////////////////////////////////////////////////////////
	/////////////////////////////////新版前后台注册///////////////////////////
	//////////////////////////////////////////////////////////////////////////
	/**
	 * 公司,组织,用户前台注册
	 * @return
	 */
	public synchronized String register() {
		User _user = (User) getSession().getAttribute("User");
		/*********************************************************/
		form.setOpertype(1);// 前台注册
		
		/*****************后台判断该企业是否已经注册********************/
		List<Company> companys = companyDao.findByExist(form);
		if(companys != null && companys.size() > 0){
			form.setReturninfo("企业名称已经存在");
			return "regsuc";
		}
		/******************后台判断该下属单位是否已经注册**************/
		if(form.getCorp() == 0){
			//集团
			System.out.println("--------------------"+form.getOrgnames());
			List<Org> orgs = orgDao.findExistByOrgnames(form.getOrgnames());
			if(orgs != null && orgs.size() > 0 ){
				form.setReturninfo("组织名称已经存在");
				return "regsuc";
			}
		}else{
			//非集团
			List<Org> orgs = orgDao.findByExist(form.getCorpname());
			if(orgs != null && orgs.size() > 0 ){
				form.setReturninfo("组织名称已经存在");
				return "regsuc";
			}
		}
		
		Integer companyId = companyDao.save(form);
		if (companyId != 0) {
			
			//更新企业组织附件表中的企业id
			OrgUpload orgUpload = new OrgUpload();
			orgUpload.setId(companyId);
			/*String uploadIds = form.getUploadids();
			
			if("".equals(uploadIds)){
				uploadIds = "0";
			}
			orgUpload.setUploadids(uploadIds);
			orgUploadDao.updateByIds(orgUpload);*/
			orgUpload.setType(0);
			orgUpload.setTokenid(form.getTokenid());
			orgUploadDao.updateByTokenIdAndType(orgUpload);
			
			//判断是否是集团公司,如果是非集团则把company数据复制到org中,如果是非集团则从页面录入
			if(form.getCorp() == 0){
				
				for(Org org:form.getOrglist()){
					if(org == null || org.getOrgname() == null){
						continue;
					}
					
					org.setSupercpccode(companyId.toString());
					org.setCpccorp(companyId.toString());
					org.setIshospital(form.getIshospital());
					Integer orgId = orgDao.save(org);
					
					if (orgId != null) {
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
							role.setOrgid(orgId);
							oneid = roleDao.saveObject(role);	
						}
						role.setRolename("管理组");
						role.setOrgid(orgId);
						Integer towid = roleDao.saveObject(role);
						
						if(org.getZyctype().equals("10000000")){ //种植
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
						}else if(org.getZyctype().equals("01000000")){ //种植经销
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
						}else if(org.getZyctype().equals("00100000")){ //生产
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
						}else if(org.getZyctype().equals("00010000")){ //生产经销
							role.setRolename("药材经销组");
							role.setOrgid(orgId);
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
						}
						
						/*********更新附件报告中的组织机构id*********/
						OrgUpload tempUpload = new OrgUpload();
						/*tempUpload.setUploadids(org.getUploadids());
						tempUpload.setId(org.getOrgid());
						orgUploadDao.updateByIds(orgUpload);*/
						
						tempUpload.setId(orgId);
						tempUpload.setType(1);
						tempUpload.setTokenid(org.getTokenid());
						orgUploadDao.updateByTokenIdAndType(tempUpload);
						// 新增user
						/*User user = new User();
						user.setOrgid(orgId);
						user.setState(0);// 前台注册,未审核前,不能登录
						user.setUsertype(2);
						user.setCpccorp(companyId.toString());
						user.setUsername(form.getUsername());
						user.setLoginpass(form.getLoginpass());
						userDao.save(user);*/
						
						// 记录操作日志
						OpLog opLog = new OpLog();
						opLog.setSysid(7);
						opLog.setMethod("企业备案");
						opLog.setLoginName(form.getLoginname());
						opLog.setUserName(form.getLoginname());
						opLog.setClientIp(Tools.getRealIp(this.getRequest()));
						opLogDao.saveOjbect(opLog);	
						
						form.setReturninfo("注册信息成功,进入备案操作!");
				}else{
						form.setReturninfo("注册信息失败!");
				}
			}
			//非集团公司	
			}else{
				
				Org org = new Org();
				Tools.setVOToVO(form, org);
				org.setOrgname(form.getCorpname());
				org.setOrgshortname(form.getCorpshortname());
				org.setSupercpccode(companyId.toString());
				org.setCpccorp(companyId.toString());
				Integer orgId = orgDao.save(org);

				if (orgId != null) {
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
						role.setOrgid(orgId);
						oneid = roleDao.saveObject(role);	
					}
					role.setRolename("管理组");
					role.setOrgid(orgId);
					Integer towid = roleDao.saveObject(role);
					
					if(org.getZyctype().equals("10000000")){ //种植
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
					}else if(org.getZyctype().equals("01000000")){ //种植经销
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
					}else if(org.getZyctype().equals("00100000")){ //生产
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
					}else if(org.getZyctype().equals("00010000")){ //生产经销
						
						role.setRolename("药材经销组");
						role.setOrgid(orgId);
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
						
					}else if(org.getZyctype().equals("00001000")){ //市场
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
					}else if(org.getZyctype().equals("00000100")){ //医院
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
					}else if(org.getZyctype().equals("00000010")){ //监管
						for(String govmentmanage:govment_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", govmentmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}
					
					/*********将企业的附件报告写入组织机构中*********/
					OrgUpload tempUpload = new OrgUpload();
					tempUpload.setId(companyId);
					tempUpload.setType(0);
					
					List<OrgUpload> orgUploadList = orgUploadDao.findByCondtion(tempUpload);
					for(OrgUpload obj : orgUploadList){
						obj.setId(orgId);
						obj.setType(1);
						orgUploadDao.save(obj);
					}
					
					// 新增user
					/*User user = new User();
					user.setOrgid(orgId);
					user.setState(0);// 前台注册,未审核前,不能登录
					user.setUsertype(2);
					user.setCpccorp(companyId.toString());
					user.setUsername(form.getUsername());
					user.setLoginpass(form.getLoginpass());
					userDao.save(user);*/
					
					// 记录操作日志
					OpLog opLog = new OpLog();
					opLog.setSysid(7);
					opLog.setMethod("企业备案");
					opLog.setLoginName(form.getLoginname());
					opLog.setUserName(form.getLoginname());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLogDao.saveOjbect(opLog);	
					
					form.setReturninfo("注册信息成功,进入备案操作!");
			}else{
					form.setReturninfo("注册信息失败!");
			}
		}
	}
		return "regsuc";
  }
	
	/**
	 * 审核前台企业组织用户注册信息
	 */
	public String updateRegVerify() throws DocumentException, IOException {
		User _user = (User) getSession().getAttribute("User");

		// 将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());

		String areacode = codeAreaDao.findByName(codeArea);
		if (areacode == null || "".equals(areacode)) {
			updateInitRegVerify();
			form.setReturninfo("审核失败!地址代码未找到!");
			return "updateInitRegVerify";
		}
		
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setType(0);//企业
		orgUpload.setId(form.getCompanyid());
		List<OrgUpload> orgUploads = orgUploadDao.findUploadContent(orgUpload);
		
		String method = Tools.xmlRegister(form, "insert", areacode, 0,null,null,orgUploads);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr =Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			updateInitRegVerify();
			form.setReturninfo("审核失败,请求中央接口超时!");
			return "updateInitRegVerify";
		}

		if (xmlstr == null || xmlstr.equals("")) {
			updateInitRegVerify();
			form.setReturninfo("审核失败!请重试！");
			return "updateInitRegVerify";
		}

		String respcode = "";
		String cpccorp = "";
		if (xmlstr != null && !xmlstr.equals("")) {
			Document document = DocumentHelper.parseText(xmlstr);
			respcode = document.selectSingleNode("cpc/respcode").getText();
			cpccorp = document.selectSingleNode("cpc/operadata/corpcpccode")
					.getText();
			
			if(cpccorp == null|| "".equals(cpccorp) || cpccorp.length() != 14){
				if (respcode == null || !respcode.equals("0000") ) {
					String returninfo = "审核失败!";
					if (respcode.equals("0005")) {
						returninfo += " 系统运行时异常!";
					}
					if (respcode.equals("0006")) {
						returninfo += " 该公司已注册!";
					}
					updateInitRegVerify();
					form.setReturninfo(returninfo);
					return "updateInitRegVerify";
				}
		    }
		    	
			form.setAreacode(areacode);
			form.setCpccorp(cpccorp);
			form.setState(1);
			int companyResult = companyDao.updateById(form);
			if (companyResult != 0) {
				// 根据企业cpc(这里是前台注册操作,对应企业ID)查询出对应的组织进行更新
				List<Org> orgs = orgDao.findByCompanyId(form.getCompanyid());
				
				if(form.getCorp() == 0){
					
					// 更新组织
					for (Org org : orgs) {
						
						// 将省市区封装到codeArea进行查询返回区域码
						codeArea.setProvince(org.getProvince());
						codeArea.setCity(org.getCity());
						codeArea.setArea(org.getArea());

						areacode = codeAreaDao.findByName(codeArea);
						
						if (areacode == null || "".equals(areacode)) {
							updateInitRegVerify();
							form.setReturninfo("审核失败!地址代码未找到!");
							return "updateInitRegVerify";
						}
						
						org.setSupercpccode(cpccorp);// 组织所在企业cpc
						orgUpload.setType(1);//组织
						orgUpload.setId(org.getOrgid());
						orgUploads = orgUploadDao.findUploadContent(orgUpload);
						
						method = Tools.xmlRegister(org, "insert", areacode, 1,null,cpccorp,orgUploads);
						
						System.out.println(method);
						try{
							xmlstr = Tools.sendPost(method, "corpinfo");
						}catch(Exception ex){
							updateInitRegVerify();
							form.setReturninfo("审核失败,请求中央接口超时!");
							return "updateInitRegVerify";
						}
						

						if (xmlstr != null && !xmlstr.equals("")) {
							document = DocumentHelper.parseText(xmlstr);
							respcode = document.selectSingleNode("cpc/respcode")
									.getText();
							String cpcOrg = document.selectSingleNode(
									"cpc/operadata/corpcpccode").getText();
							org.setCpccorp(cpcOrg);//组织机构cpc
							org.setAreacode(areacode);
							
							if(cpcOrg == null || "".equals(cpcOrg) || cpcOrg.length() != 14){
								if (respcode == null || !respcode.equals("0000")){
									String returninfo = "审核失败!";
									if (respcode.equals("0006")) {
										returninfo += " 该组织机构已注册!";
									}
									updateInitRegVerify();
									form.setReturninfo(returninfo);
									return "updateInitRegVerify";
								}
							}
							else{
								int orgResult = orgDao.updateById(org);
								if (orgResult != 0) {
									// 记录操作日志
									OpLog opLog = new OpLog();
									opLog.setSysid(7);
									opLog.setMethod("企业审核");
									opLog.setLoginName(_user.getLoginname());
									opLog.setUserName(_user.getUsername());
									opLog.setClientIp(Tools.getRealIp(this.getRequest()));
									opLog.setContent("企业cpc:" + cpccorp);
									opLogDao.saveOjbect(opLog);	
									form.setReturninfo("审核成功!");
								} else {
									form.setReturninfo("审核失败!");
								}

							}
						} else {
							updateInitRegVerify();
							form.setReturninfo("审核失败!");
							return "updateInitRegVerify";
						}
					}
					
				}else{//非集团公司审核
					
					Org org = orgs.get(0);
					org.setCpccorp(cpccorp);
					org.setSupercpccode(cpccorp);
					org.setAreacode(areacode);
					int orgResult = orgDao.updateById(org);
					
				/*	if (orgResult != 0) {
						User user = userDao.findByOrgId(org.getOrgid());
						// 更新用户
						Integer userId = user.getUserid();
						user.setState(1);
						user.setUserid(userId);
						user.setCpccorp(org.getCpccorp());
						userDao.updateById(user);
						form.setReturninfo("审核成功!");
					} else {
						form.setReturninfo("审核失败!");
					}*/

					// 记录操作日志
					OpLog opLog = new OpLog();
					opLog.setSysid(7);
					opLog.setMethod("企业审核");
					opLog.setLoginName(_user.getLoginname());
					opLog.setUserName(_user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLog.setContent("企业cpc:" + cpccorp);
					opLogDao.saveOjbect(opLog);	
					form.setReturninfo("审核成功!");
				}
			}
		} 
		updateInitRegVerify();
		return "updateInitRegVerify";
	}
	
	/**
	 * 监管平台添加企业
	 * @throws IOException
	 * @throws DocumentException
	 */
	public synchronized String save() throws IOException, DocumentException {
		
		/*****************后台判断该企业是否已经注册********************/
		List<Company> companys = companyDao.findByExist(form);
		if(companys != null && companys.size() > 0){
			form.setReturninfo("企业名称已经存在");
			return "save";
		}
		/******************后台判断该下属单位是否已经注册**************/
		List<Org> orgs = orgDao.findByExist(form.getCorpname());
		if(orgs != null && orgs.size() > 0 ){
			form.setReturninfo("组织名称已经存在");
			return "save";
		}
		
		User _user = (User)getSession().getAttribute("User");
		form.setOpertype(0);
		Integer companyId = companyDao.save(form);
		if (companyId != 0) {
			//更新企业组织附件表中的企业id
			OrgUpload orgUpload = new OrgUpload();
			orgUpload.setId(companyId);
			/*String uploadIds = form.getUploadids();
			if("".equals(uploadIds)){
				uploadIds = "0";
			}
			orgUpload.setUploadids(uploadIds);
			//更新企业上传附件
			orgUploadDao.updateByIds(orgUpload);*/
			
			orgUpload.setType(0);
			orgUpload.setTokenid(form.getTokenid());
			orgUploadDao.updateByTokenIdAndType(orgUpload);
			
			//判断是否是集团公司,如果是非集团则把company数据复制到org中,如果是非集团则从页面录入
			if(form.getCorp() == 1){
				//添加下属单位
				Org org = new Org();
				Tools.setVOToVO(form, org);
				org.setOrgname(form.getCorpname());
				org.setOrgshortname(form.getCorpshortname());
				org.setSupercpccode(companyId.toString());
				org.setCpccorp(companyId.toString());
				Integer orgId = orgDao.save(org);
	
				if (orgId != null) {
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
						role.setOrgid(orgId);
						oneid = roleDao.saveObject(role);	
					}
					role.setRolename("管理组");
					role.setOrgid(orgId);
					Integer towid = roleDao.saveObject(role);
					
					if(org.getZyctype().equals("10000000")){ //种植
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
					}else if(org.getZyctype().equals("01000000")){ //种植经销
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
					}else if(org.getZyctype().equals("00100000")){ //生产
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
					}else if(org.getZyctype().equals("00010000")){ //生产经销
						
						role.setRolename("药材经销组");
						role.setOrgid(orgId);
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
						
					}else if(org.getZyctype().equals("00001000")){ //市场
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
					}else if(org.getZyctype().equals("00000100")){ //医院
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
					}else if(org.getZyctype().equals("00000010")){ //监管
						for(String govmentmanage:govment_manage){
							Map map = new HashMap();
							map.put("roleid", towid);
							map.put("menuid", govmentmanage);
							roleDao.saveByIdRoleMenuOne(map);
						}
					}
					
					/*********将企业的附件报告写入组织机构中*********/
					OrgUpload tempUpload = new OrgUpload();
					tempUpload.setId(companyId);
					tempUpload.setType(0);
					
					List<OrgUpload> orgUploadList = orgUploadDao.findByCondtion(tempUpload);
					for(OrgUpload obj : orgUploadList){
						obj.setId(orgId);
						obj.setType(1);
						orgUploadDao.save(obj);
					}
				}
			} 
					// 记录操作日志
					OpLog opLog = new OpLog();
					opLog.setSysid(7);
					opLog.setMethod("企业备案");
					opLog.setLoginName(_user.getLoginname());
					opLog.setUserName(_user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					Integer result = opLogDao.saveOjbect(opLog);	
					
					if(result != 0){
						form.setReturninfo("主体备案成功!已进入备案审核!");
					}else{
						form.setReturninfo("主体备案失败!");
					}
		}
		return "save";
	}
	
	
	/**
	 * 监管平台企业审核
	 */
	public String updateVerify() throws DocumentException, IOException {
		User _user = (User) getSession().getAttribute("User");
		
		// 将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());

		String areacode = codeAreaDao.findByName(codeArea);
		if (areacode == null || "".equals(areacode)) {
			updateInitVerify();
			form.setReturninfo("审核失败!地址代码未找到!");
			return "updateverify";
		}
		
		
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setType(0);//企业
		orgUpload.setId(form.getCompanyid());
		List<OrgUpload> orgUploads = orgUploadDao.findUploadContent(orgUpload);
		
		String method = Tools.xmlRegister(form, "insert", areacode, 0,null,null,orgUploads);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method, "corpinfo");
		}catch(Exception ex){
			updateInitVerify();
			form.setReturninfo("审核失败,请求中央接口超时!");
			return "updateverify";
			
		}
		if (xmlstr == null || xmlstr.equals("")) {
			updateInitVerify();
			form.setReturninfo("审核失败!请重试！");
			return "updateverify";
		}

		String respcode = "";
		String cpccorp = "";
		if (xmlstr != null && !xmlstr.equals("")) {
			Document document = DocumentHelper.parseText(xmlstr);
			respcode = document.selectSingleNode("cpc/respcode").getText();
			cpccorp = document.selectSingleNode("cpc/operadata/corpcpccode")
					.getText();
			
			if(cpccorp == null || "".equals(cpccorp) || cpccorp.length() != 14){
				if (respcode == null || !respcode.equals("0000")) {
					String returninfo = "审核失败!";
					returninfo = Tools.getReturnInfo(respcode, returninfo);
					updateInitVerify();
					form.setReturninfo(returninfo);
					return "updateverify";
				}
			}
			form.setAreacode(areacode);
			form.setCpccorp(cpccorp);
			form.setState(1);
			if (companyDao.updateById(form) != 0) {
				// 根据企业cpc(这里是前台注册操作,对应企业ID)查询出对应的组织进行更新
				List<Org> orgs = orgDao.findByCompanyId(form.getCompanyid());
				//非集团
				if (form.getCorp() == 1) {
					Org org = orgs.get(0);
					org.setCpccorp(cpccorp);
					org.setSupercpccode(cpccorp);
					org.setAreacode(form.getAreacode());
					int orgResult = orgDao.updateById(org);
					// 记录操作日志
					OpLog opLog = new OpLog();
					opLog.setSysid(7);
					opLog.setMethod("企业审核");
					opLog.setLoginName(_user.getLoginname());
					opLog.setUserName(_user.getUsername());
					opLog.setClientIp(Tools.getRealIp(this.getRequest()));
					opLog.setContent("企业cpc:" + cpccorp);
					opLogDao.saveOjbect(opLog);	
					form.setReturninfo("审核成功!");
				}
			} else {
				form.setReturninfo("审核失败!");
			}
		} else {
			updateInitVerify();
			form.setReturninfo("审核失败!");
			return "updateverify";
		}
		form.setReturninfo("审核成功!");
		updateInitVerify();
		return "updateverify";
	}
	
	
	/**
	 * 新增市场下的经营户
	 * @return
	 * @throws IOException
	 * @throws DocumentException
	 */
	public synchronized String addUserMarket() throws IOException, DocumentException {
		
		/*****************后台判断该企业是否已经注册********************/
		List<Company> companys = companyDao.findByExist(form);
		if(companys != null && companys.size() > 0){
			form.setReturninfo("经营户已注册");
			return "addUserMarket";
		}
		/******************后台判断该下属单位是否已经注册**************/
		List<Org> orgs = orgDao.findByExist(form.getCorpname());
		if(orgs != null && orgs.size() > 0 ){
			form.setReturninfo("经营户已注册");
			return "addUserMarket";
		}
		
		User _user = (User) getSession().getAttribute("User");

		// 将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(form.getProvince());
		codeArea.setCity(form.getCity());
		codeArea.setArea(form.getArea());

		String areacode = codeAreaDao.findByName(codeArea);

		if (areacode == null || "".equals(areacode)) {
			form.setReturninfo("注册失败!地址代码未找到!");
			return "addUserMarket";
		}
		
		String method = Tools.xmlRegister(form, "insert", areacode, 0,_user.getCpccorp(),null,null);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			//updateInitVerify();
			form.setReturninfo("注册失败!请求中央接口超时!");
			return "addUserMarket";
		}
	

		if (xmlstr == null || xmlstr.equals("")) {
			//updateInitVerify();
			form.setReturninfo("注册失败!请重试！");
			return "addUserMarket";
		}

		String respcode = "";
		String cpccorp = "";
		if (xmlstr != null && !xmlstr.equals("")) {
			Document document = DocumentHelper.parseText(xmlstr);
			respcode = document.selectSingleNode("cpc/respcode").getText();
			cpccorp = document.selectSingleNode("cpc/operadata/corpcpccode")
					.getText();
			
			if(cpccorp == null || "".equals(cpccorp) || cpccorp.length() != 14){
				if (respcode == null || !respcode.equals("0000")) {
					String returninfo = "注册失败!";
					if (respcode.equals("0006")) {
						returninfo += " 该经营户已注册!";
					}
					if(respcode.equals("0008")){
						returninfo+=" 公司类型不正确，只能是一种类型!";
					}
					form.setReturninfo(returninfo);
					return "addUserMarket";
				}
			}
			
			/*****************根据返回的cpc查询company,org表是否已经存在********************/
			Company tempCorp = new Company();
			tempCorp.setCpccorp(cpccorp);
			Company company = companyDao.findByCpccorp(tempCorp);
			if(company != null){
				form.setReturninfo("经营户已注册");
				return "addUserMarket";
			}
			
			Org tempOrg = new Org();
			tempOrg.setCpccorp(cpccorp);
			orgs = orgDao.findByCpccorp(tempOrg);
			if(orgs != null && orgs.size() > 0){
				form.setReturninfo("经营户已注册");
				return "addUserMarket";
			}
			/**********************************************************/
			
			form.setCpccorp(cpccorp);
			form.setAreacode(areacode);
			form.setState(1);
			form.setOpertype(0);
			form.setCorp(1);//注册经营户 企业为非集团类型
			int companyId = companyDao.save(form);
			if (companyId != 0) {
				// 新增org
				Org org = new Org();
				Tools.setVOToVO(form, org);
				org.setOrgname(form.getCorpname());
				org.setOrgshortname(form.getCorpshortname());
				org.setMarketcode(_user.getCpccorp());//当前登录用户的组织机构cpc
				org.setSupercpccode(cpccorp);
				Integer orgId = orgDao.save(org);
				form.setOrg(org);
				if (orgId != null) {
					// 新增user
					User user = new User();
					user.setOrgid(orgId);
					user.setState(1);
					user.setUsertype(2);
					user.setCpccorp(cpccorp);
					user.setUsername(form.getLinkman());
					user.setLoginname(cpccorp);
					user.setLoginpass(cpccorp);
					user.setPartion(form.getPartion());
					user.setCoordinate(form.getCoordinate());
					userDao.save(user);
				} else {
					form.setReturninfo("经营户注册失败!");
					return "addUserMarket";
				}
				form.setReturninfo("经营户注册成功!");

				// 记录操作日志
				OpLog opLog = new OpLog();
				opLog.setSysid(3);
				opLog.setMethod("企业备案");
				opLog.setLoginName(_user.getLoginname());
				opLog.setUserName(_user.getUsername());
				opLog.setClientIp(Tools.getRealIp(this.getRequest()));
				opLog.setContent("企业cpc:" + cpccorp);
				opLogDao.saveOjbect(opLog);
			}else{
					form.setReturninfo("经营户注册失败!");
					return "addUserMarket";
				}
			} else {
				form.setReturninfo("经营户注册失败!");
				return "addUserMarket";
			}
		form.setAddtime(Tools.getDateMonthDayStrTwo());
		return "addUserMarketFinish";
	}
	
	/**
	 * 更新市场经营户
	 * @return
	 * @throws IOException
	 * @throws DocumentException
	 */
	public String updateUserMarket() throws IOException, DocumentException {
		String method = Tools.xmlRegister(form, "update", form.getAreacode(), 0,form.getMarketcode(),null,null);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			form.setReturninfo("更新失败,请求中央接口超时!");
			return UpdateMarketUserInit(form);
		}
		

		if (xmlstr == null || xmlstr.equals("")) {
			form.setReturninfo("更新失败!");
			return UpdateMarketUserInit(form);
		}
		String respcode = "";
		String cpccorptemp = "";
		if (xmlstr != null && !xmlstr.equals("")) {
			Document document = DocumentHelper.parseText(xmlstr);
			respcode = document.selectSingleNode("cpc/respcode").getText();
			cpccorptemp = document
					.selectSingleNode("cpc/operadata/corpcpccode").getText();
			if (respcode == null || !respcode.equals("0000")
					|| cpccorptemp == null || "".equals(cpccorptemp)
					|| cpccorptemp.length() != 14) {
				form.setReturninfo("更新失败!");
				return UpdateMarketUserInit(form);
			}
		}
		
		Integer count = companyDao.updateById(form);
		if (count != 0) {
			// 同步更新org
			Org temp = new Org();
			temp.setSupercpccode(form.getCpccorp());
			Org	org = orgDao.findByCpccorp(temp).get(0);
			Tools.setVOToVO(form, org);
			org.setOrgid(form.getOrgid());
			Integer orgId = orgDao.updateById(org);
			form.setOrg(org);
			if (orgId != 0) {
				// 新增user
				User user = new User();
				user.setCpccorp(org.getCpccorp());
				user = userDao.findByCpccorp(user);
				user.setLasttime(Tools.getCurrentTime());
				user.setUsername(form.getLinkman());
				user.setPartion(form.getPartion());
				user.setCoordinate(form.getCoordinate());
				userDao.updateById(user);
			}
		}
		form.setReturninfo("更新经营户完成");
		return "updateUserMarketFinish";
	}
	
	/**
	 * 更新市场商户信息初始化页面
	 * @return
	 */
	public String UpdateMarketUserInit(Company form){
		Org temp = new Org();
		Tools.setVOToVO(form, temp);
		form.setOrg(temp);
		
		form.setCompany(form);
		
		return "UpdateMarketUserInit";
	}
}
