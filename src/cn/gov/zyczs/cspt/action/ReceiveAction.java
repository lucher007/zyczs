package cn.gov.zyczs.cspt.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.xpath.operations.Or;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import cn.gov.zyczs.cspt.common.ExceptionHandler;
import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IChengDao;
import cn.gov.zyczs.cspt.dao.IChengDataDao;
import cn.gov.zyczs.cspt.dao.ICodeAreaDao;
import cn.gov.zyczs.cspt.dao.ICodeRegionDao;
import cn.gov.zyczs.cspt.dao.ICompanyDao;
import cn.gov.zyczs.cspt.dao.IDailyCheckDao;
import cn.gov.zyczs.cspt.dao.IDeviceDao;
import cn.gov.zyczs.cspt.dao.IMedStorageDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IOrgUploadDao;
import cn.gov.zyczs.cspt.dao.IScanCompanyDao;
import cn.gov.zyczs.cspt.dao.IUserDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.ChengData;
import cn.gov.zyczs.cspt.po.CodeArea;
import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.DailyCheck;
import cn.gov.zyczs.cspt.po.Device;
import cn.gov.zyczs.cspt.po.DeviceRec;
import cn.gov.zyczs.cspt.po.MedStorage;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.OrgUpload_JiLin;
import cn.gov.zyczs.cspt.po.Org_JiLin;
import cn.gov.zyczs.cspt.po.ScanCompany;
import cn.gov.zyczs.cspt.po.User;
import cn.gov.zyczs.cspt.po.User_JiLin;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class ReceiveAction extends BaseAction implements ModelDriven<Org> {
	private static final long serialVersionUID = 1L;
	Org form = new Org();
	public Org getModel() {
		return form;
	}
	private IUserDao userDao;
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}
	private IOrgDao orgDao;
	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}
	private IDailyCheckDao dailyCheckDao;//日常检查
	public void setDailyCheckDao(IDailyCheckDao dailyCheckDao) {
		this.dailyCheckDao = dailyCheckDao;
	}
	private IScanCompanyDao scanCompanyDao;//扫描监管企业
	public void setScanCompanyDao(IScanCompanyDao scanCompanyDao) {
		this.scanCompanyDao = scanCompanyDao;
	}
	private IMedStorageDao medStorageDao;//药材超售
	public void setMedStorageDao(IMedStorageDao medStorageDao) {
		this.medStorageDao = medStorageDao;
	}
	private IChengDao chengDao;//溯源称查询
	public void setChengDao(IChengDao chengDao) {
		this.chengDao = chengDao;
	}
	private IChengDataDao chengDataDao;//溯源称详细
	public void setChengDataDao(IChengDataDao chengDataDao) {
		this.chengDataDao = chengDataDao;
	}
	private IDeviceDao deviceDao;//持卡信息
	public void setDeviceDao(IDeviceDao deviceDao) {
		this.deviceDao = deviceDao;
	}
	private IZyczsXmlDao zyczsXmlDao;//上传北京xml
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	
	private ICompanyDao companyDao;
	public void setCompanyDao(ICompanyDao companyDao) {
		this.companyDao = companyDao;
	}
	
	private IOpLogDao opLogDao;
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
	/**
	 * 行政区划dao
	 */
	private ICodeAreaDao codeAreaDao;
	public void setCodeAreaDao(ICodeAreaDao codeAreaDao) {
		this.codeAreaDao = codeAreaDao;
	}

	private IOrgUploadDao orgUploadDao;
	public void setOrgUploadDao(IOrgUploadDao orgUploadDao) {
		this.orgUploadDao = orgUploadDao;
	}
	
	private String key = "1234567812345678";
    private String iv = "fedcba9876543210";
    
	public void receiveCommands() throws DocumentException {
		HttpServletResponse response = (HttpServletResponse) ActionContext.getContext().get(org.apache.struts2.StrutsStatics.HTTP_RESPONSE);
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			JSONObject jsonObject = new JSONObject();
			String requeststr = form.getRequest();
			System.out.println("requeststr============"+requeststr);
			
//	         //加密
//	         System.out.println("加密前：" + requeststr);
//	         String c = Tools.encrypt(requeststr,key,iv);
//	         System.out.println("加密后：" + c);
	         
			if (requeststr != null && !"".equals(requeststr)) {
				if(requeststr.indexOf(":")==-1){
					//判断是否是16位数
					if(!Tools.cipherJudgement(requeststr)){
						jsonObject.put("returninfo", "0");
						out.write(jsonObject.toString());
						return;
					}
//					//解密
//					System.out.println("解密后：" + Tools.decrypt(requeststr,key.getBytes("UTF-8"),iv.getBytes("UTF-8")));
//					String requesttemp = Tools.decrypt(requeststr,key.getBytes("UTF-8"),iv.getBytes("UTF-8"));
					requeststr = Tools.decrypt(requeststr,key.getBytes("UTF-8"),iv.getBytes("UTF-8"));
					System.out.println(requeststr+"<------------");
					String result=Tools.cipherCutoff(requeststr);
					if(result.equals("false")){
						jsonObject.put("returninfo", "0");
						out.write(jsonObject.toString());
						return;
					}else{
						requeststr=result;
					}
				}
				
				JSONObject jsonobject = JSONObject.fromObject(requeststr);
				String commandid = jsonobject.optString("commandid");
				System.out.println("commandid============="+commandid);
				if (commandid != null && !"".equals(commandid)) {
					if("1".equals(commandid)) { //用户登录
						out.write(findByUser(jsonobject).toString());
					}else if("2".equals(commandid)){ //获取查询经销商信息，和经销商市场
						out.write(findByUserCpccorp(jsonobject).toString());
					}else if("3".equals(commandid)){ //查询日常检查
						out.write(findByDailyCheck(jsonobject).toString());
					}else if("4".equals(commandid)){ //添加日常检查
						out.write(saveByDailyCheck(jsonobject).toString());
					}else if("5".equals(commandid)){ //查询已监管过后的企业
						out.write(findByScanCompany(jsonobject).toString());
					}else if("6".equals(commandid)){ //查询超售信息
						out.write(findMedExceedListByCpccorp(jsonobject).toString());
					}else if("7".equals(commandid)){ //查询库存信息
						out.write(findMedListByCpccorp(jsonobject).toString());
					}else if("8".equals(commandid)){ //查询库存详细
						out.write(findMedListByProdcode(jsonobject).toString());
					}else if("9".equals(commandid)){ //查询溯源称信息
						out.write(findChengList(jsonobject).toString());
					}else if("10".equals(commandid)){ //查询溯源称详细交易信息
						out.write(findChengDetail(jsonobject).toString());
					}else if("11".equals(commandid)){ //查询持卡信息
						out.write(findCardList(jsonobject).toString());
					}else if("12".equals(commandid)){
						out.write(findByUser_jiLin(jsonobject).toString());//吉林手持机市场管理员登陆
					}else if("13".equals(commandid)){
						out.write(findMedSell_jiLin(jsonobject).toString());//吉林手持机商户列表查询
					}else if("14".equals(commandid)){
						out.write(saveMedSell_JiLin(jsonobject).toString());//吉林手持机商户新增
					}else if("15".equals(commandid)){
						out.write(findMedSellByCpc_JiLin(jsonobject).toString());//吉林手持机商户单条查询
					}else if("16".equals(commandid)){
						out.write(updateMobileByCpc_JiLin(jsonobject).toString());//吉林手持机商户单条查询
					}else if("17".equals(commandid)){
						out.write(saveCard_JiLin(jsonobject).toString());//吉林手持机发卡
					}
				}else{
					jsonObject.put("returninfo", "0");
					out.write(jsonObject.toString());
				}
			} else {
				jsonObject.put("returninfo", "0");
				out.write(jsonObject.toString());
			}
			out.flush();
			out.close();
		} catch (Exception e) {
			//e.printStackTrace();
			out.write("{\"returninfo\":\"0\"}");
			throw new ExceptionHandler("");
		}
	}

	
	
	public JSONObject findByUser(JSONObject jsonobjectstr) {
		JSONObject jsonObject = new JSONObject();
		//判断参数
		if(jsonobjectstr.optString("loginname")==null||"".equals(jsonobjectstr.optString("loginname"))
				||jsonobjectstr.optString("loginpass")==null||"".equals(jsonobjectstr.optString("loginpass"))){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		User user = new User();
		user.setLoginname(jsonobjectstr.optString("loginname"));
		user.setLoginpass(jsonobjectstr.optString("loginpass"));
		user = userDao.login(user);
		if(user!=null&&user.getCpccorp()!=null&&user.getCpccorp().length()==14){
			Org org = orgDao.findByCpccorpObject(user.getCpccorp());
			if(org!=null&&org.getZyctype()!=null&&org.getZyctype().length()==8&&(org.getZyctype().equals("00000010")||org.getZyctype().equals("00001000"))){
				user.setReturninfo("1");
				user.setOrg(org);
				jsonObject=JSONObject.fromObject(user);
			}else{
				jsonObject.put("returninfo", "0");
			}
		}else{
			jsonObject.put("returninfo", "0");
		}
		return jsonObject;
	}
	
	public JSONObject findByUserCpccorp(JSONObject jsonobjectstr) {
		JSONObject jsonObject = new JSONObject();
		//判断参数
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
				||jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))
				||jsonobjectstr.optString("type")==null||"".equals(jsonobjectstr.optString("type"))){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		//验证操作用户正不正确
		User user = new User();
		user.setUserid(jsonobjectstr.optInt("userid"));
		user = userDao.findById(user);
		if(user==null||user.getCpccorp()==null||user.getCpccorp().length()!=14||user.getLoginname()==null){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		Org org = orgDao.findByCpccorpObject(user.getCpccorp());
		if(org==null||org.getZyctype()==null||org.getZyctype().length()!=8||org.getCpccorp()==null||"".equals(org.getCpccorp())|| !(org.getZyctype().equals("00000010") || org.getZyctype().equals("00001000"))){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		//查询经销商
		user = new User();
		user.setCpccorp(jsonobjectstr.optString("cpccorp"));
		user = userDao.findByCpccorp(user);
		if(user==null||user.getCpccorp()==null||user.getCpccorp().length()!=14||user.getLoginname()==null||"".equals(user.getLoginname())){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		Org orgsell = orgDao.findByCpccorpObject(user.getCpccorp());
		if(orgsell==null||orgsell.getZyctype()==null||orgsell.getZyctype().length()!=8||!orgsell.getZyctype().equals("01000000")){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//查询经销商所属市场
		if(orgsell.getMarketcode()==null||orgsell.getMarketcode().length()!=14){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		Org orgmarket = orgDao.findByCpccorpObject(orgsell.getMarketcode());
		if(orgmarket==null||orgmarket.getOrgid()==null||orgmarket.getOrgname()==null||"".equals(orgmarket.getOrgname())||orgmarket.getZyctype()==null||!"00001000".equals(orgmarket.getZyctype())){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		if(org.getZyctype().equals("00001000")){
			if(!org.getOrgid().equals(orgmarket.getOrgid())){
				jsonObject.put("returninfo", "0");
				return jsonObject;
			}
		}
		
		//添加扫描企业记录 type=1为扫描 type=2为点击查看
		if(jsonobjectstr.optString("type").equals("1")){
			ScanCompany scanCompany = new ScanCompany();
			scanCompany.setUserid(Integer.valueOf(jsonobjectstr.optString("userid")));
			scanCompany.setCpccorp(jsonobjectstr.optString("cpccorp"));
			scanCompanyDao.save(scanCompany);
		}
		
		orgsell.setMarketname(orgmarket.getOrgname());
		user.setReturninfo("1");
		user.setOrg(orgsell);
		jsonObject=JSONObject.fromObject(user);
		return jsonObject;
	}
	
	public JSONArray findByDailyCheck(JSONObject jsonobjectstr) {
		JSONArray jsonArray = new JSONArray();
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))||jsonobjectstr.optString("cpccorp").length()!=14){
			JSONArray.fromObject("");
			return jsonArray;
		}
		DailyCheck dailycheck =new DailyCheck();
		dailycheck.setCpccorp(jsonobjectstr.optString("cpccorp"));
		jsonArray = JSONArray.fromObject(dailyCheckDao.findByMaxDate(dailycheck));
		return jsonArray;
	}
	
	public JSONObject saveByDailyCheck(JSONObject jsonobjectstr) throws UnsupportedEncodingException {
		JSONObject jsonObject = new JSONObject();
		//判断参数
		if(jsonobjectstr.optString("checkproject")==null||"".equals(jsonobjectstr.optString("checkproject"))
			||jsonobjectstr.optString("checkresult")==null||"".equals(jsonobjectstr.optString("checkresult"))
			||jsonobjectstr.optString("checkperson")==null||"".equals(jsonobjectstr.optString("checkperson"))
			//||jsonobjectstr.optString("checknote")==null
			//||jsonobjectstr.optString("cpcmeds")==null||"".equals(jsonobjectstr.optString("cpcmeds"))
			||jsonobjectstr.optString("deductscore")==null||"".equals(jsonobjectstr.optString("deductscore"))
			||jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))
			||jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
			||jsonobjectstr.optString("orgname")==null||"".equals(jsonobjectstr.optString("orgname"))
			||jsonobjectstr.optString("marketname")==null||"".equals(jsonobjectstr.optString("marketname"))
			||jsonobjectstr.optString("opername")==null||"".equals(jsonobjectstr.optString("opername"))
			||jsonobjectstr.optString("supercpccorp")==null||"".equals(jsonobjectstr.optString("supercpccorp"))
			||jsonobjectstr.optString("loginname")==null||"".equals(jsonobjectstr.optString("loginname"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//cpcmeds为手持机上传的溯源码,根据该溯源码查询出对应批次码,再次写入到cpcmeds存储
		StringBuffer sbCpcMeds = new StringBuffer("'");
		sbCpcMeds.append(jsonobjectstr.optString("cpcmeds").replaceAll(",", "','"));
		sbCpcMeds.append("'");
		
		String cpcMeds="";
		
		List<String> list = dailyCheckDao.findCpcMedsByBoxCode(sbCpcMeds.toString());
		for(String str:list){
			 str = str + ",";
			 cpcMeds += str;
		}
		
		DailyCheck dailyCheck = (DailyCheck)JSONObject.toBean(jsonobjectstr, DailyCheck.class);
		
		if(cpcMeds.length() > 0){
			dailyCheck.setCpcmeds(cpcMeds.substring(0,cpcMeds.length()-1));
		}
		/*else{
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}*/
		
		if(dailyCheckDao.save(dailyCheck)!=0){
			jsonobjectstr.put("checkdate", Tools.getCurrentTime());
			zyczsXmlDao.saveOjbect(ToolsXml.create_dailyCheck(dailyCheck));
			jsonObject.put("returninfo", "1");
		}else{
			jsonObject.put("returninfo", "0");
		}
		return jsonObject;
	}
	
	public JSONObject findByScanCompany(JSONObject jsonobjectstr){
		//判断参数
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))
				||jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
				||jsonobjectstr.optString("querytype")==null||"".equals(jsonobjectstr.optString("querytype"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		//当类型为4，判断自定义时间
		if(jsonobjectstr.optString("querytype").equals("4")){
			if(jsonobjectstr.optString("startscandate")==null||"".equals(jsonobjectstr.optString("startscandate"))||jsonobjectstr.optString("endscandate").length()!=10
					||jsonobjectstr.optString("endscandate")==null||"".equals(jsonobjectstr.optString("endscandate"))||jsonobjectstr.optString("endscandate").length()!=10
			){
				jsonObject.put("returninfo", "0");
				return jsonObject;
			}
		}
		jsonobjectstr.put("pager_openset", "10");
		Org org = new Org();
		org.setPager_count(scanCompanyDao.findByCount((ScanCompany)JSONObject.toBean(jsonobjectstr, ScanCompany.class)));
		org.setOrglist(scanCompanyDao.findByList((ScanCompany)JSONObject.toBean(jsonobjectstr, ScanCompany.class)));
		
		if(org.getPager_count()==0||org.getOrglist()==null||org.getOrglist().size()<1){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		org.setReturninfo("1");
		jsonObject=JSONObject.fromObject(org);
		return jsonObject;
	}
	
	public JSONObject findMedExceedListByCpccorp(JSONObject jsonobjectstr){
		//判断参数
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("orgid")==null||"".equals(jsonobjectstr.optString("orgid"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		jsonobjectstr.put("pager_openset", "10");
		MedStorage medStorage = new MedStorage();
		medStorage.setList(medStorageDao.findMedExceedListByCpccorp(Integer.valueOf(jsonobjectstr.optString("pager_offset")),
				Integer.valueOf(jsonobjectstr.optString("pager_openset")),
				Integer.valueOf(jsonobjectstr.optString("orgid")),
				Tools.getDateYear()+"-01-01 00:00:00",Tools.getDateYear()+"-12-31 23:59:59"));
		medStorage.setPager_count(medStorageDao.findMedExceedCountByCpccorp(Integer.valueOf(jsonobjectstr.optString("orgid")),
				Tools.getDateYear()+"-01-01 00:00:00",Tools.getDateYear()+"-12-31 23:59:59"));
		medStorage.setReturninfo("1");
		jsonObject=JSONObject.fromObject(medStorage);
		return jsonObject;
	}
	
	public JSONObject findMedListByCpccorp(JSONObject jsonobjectstr){
		//判断参数
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("orgid")==null||"".equals(jsonobjectstr.optString("orgid"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		jsonobjectstr.put("pager_openset", "10");
		MedStorage medStorage = new MedStorage();
		medStorage.setList(medStorageDao.findMedListByCpccorp(Integer.valueOf(jsonobjectstr.optString("pager_offset")),
				Integer.valueOf(jsonobjectstr.optString("pager_openset")),
				Integer.valueOf(jsonobjectstr.optString("orgid"))));
		medStorage.setPager_count(medStorageDao.findMedCountByCpccorp(Integer.valueOf(jsonobjectstr.optString("orgid"))));
		medStorage.setReturninfo("1");
		jsonObject=JSONObject.fromObject(medStorage);
		return jsonObject;
	}
	
	public JSONObject findMedListByProdcode(JSONObject jsonobjectstr){
		//判断参数
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("orgid")==null||"".equals(jsonobjectstr.optString("orgid"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
				||jsonobjectstr.optString("prodcode")==null||"".equals(jsonobjectstr.optString("prodcode"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		jsonobjectstr.put("pager_openset", "10");
		MedStorage medStorage = new MedStorage();
		medStorage.setList(medStorageDao.findMedListByProdcode(Integer.valueOf(jsonobjectstr.optString("pager_offset")),
				Integer.valueOf(jsonobjectstr.optString("pager_openset")),
				Integer.valueOf(jsonobjectstr.optString("orgid")),
				jsonobjectstr.optString("prodcode")));
		medStorage.setPager_count(medStorageDao.findMedCountByProdcode(Integer.valueOf(jsonobjectstr.optString("orgid")),jsonobjectstr.optString("prodcode")));
		medStorage.setReturninfo("1");
		jsonObject=JSONObject.fromObject(medStorage);
		return jsonObject;
	}
	
	
	public JSONObject findChengList(JSONObject jsonobjectstr){
		//判断参数
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		jsonobjectstr.put("pager_openset", "10");
		Cheng cheng = new Cheng();
		cheng.setCpccorp(jsonobjectstr.optString("cpccorp"));
		cheng.setPager_offset(Integer.valueOf(jsonobjectstr.optString("pager_offset")));
		cheng.setPager_openset(Integer.valueOf(jsonobjectstr.optString("pager_openset")));
		
		cheng.setChengList(chengDao.findByList_mobile(cheng));
		cheng.setPager_count(chengDao.findByCount_mobile(cheng));
		cheng.setReturninfo("1");
		jsonObject=JSONObject.fromObject(cheng);
		return jsonObject;
	}
	
	public JSONObject findChengDetail(JSONObject jsonobjectstr){
		//判断参数
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("chengcode")==null||"".equals(jsonobjectstr.optString("chengcode"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
				||jsonobjectstr.optString("querytype")==null||"".equals(jsonobjectstr.optString("querytype"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		jsonobjectstr.put("pager_openset", "10");
		ChengData chengData = new ChengData();
		chengData.setChengcode(jsonobjectstr.optString("chengcode"));
		chengData.setPager_offset(Integer.valueOf(jsonobjectstr.optString("pager_offset")));
		chengData.setPager_openset(Integer.valueOf(jsonobjectstr.optString("pager_openset")));
		
		//当类型为4，判断自定义时间
		if(jsonobjectstr.optString("querytype").equals("4")){
			if(jsonobjectstr.optString("startscandate")==null||"".equals(jsonobjectstr.optString("startscandate"))||jsonobjectstr.optString("endscandate").length()!=10
					||jsonobjectstr.optString("endscandate")==null||"".equals(jsonobjectstr.optString("endscandate"))||jsonobjectstr.optString("endscandate").length()!=10
			){
				jsonObject.put("returninfo", "0");
				return jsonObject;
			}
			
			chengData.setOperstarttime(jsonobjectstr.optString("startscandate"));
			chengData.setOperendtime(jsonobjectstr.optString("endscandate"));
		}
		chengData.setQuerytype(Integer.valueOf(jsonobjectstr.optString("querytype")));
		
		chengData.setChengdatalist(chengDataDao.findByList(chengData));
		chengData.setPager_count(chengDataDao.findByCount(chengData));
		chengData.setReturninfo("1");
		jsonObject=JSONObject.fromObject(chengData);
		return jsonObject;
	}
	
	public JSONObject findCardList(JSONObject jsonobjectstr){
		//判断参数
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
		){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		jsonobjectstr.put("pager_openset", "10");
		Device device= new Device();
		device.setPager_offset(Integer.valueOf(jsonobjectstr.optString("pager_offset")));
		device.setPager_openset(Integer.valueOf(jsonobjectstr.optString("pager_openset")));
		device.setCpccorp(jsonobjectstr.optString("cpccorp"));
		device.setDevicetype(4);//4表示身份卡
		
		device.setDeviceList(deviceDao.findByList(device));
		device.setPager_count(deviceDao.findByCount(device));
		device.setReturninfo("1");
		jsonObject=JSONObject.fromObject(device);
		return jsonObject;
	}
	
	
    /////////////////////////////////////吉林手持机接口区域/////////////////////////////////////////////////////////////
	public JSONObject findByUser_jiLin(JSONObject jsonobjectstr) {
		JSONObject jsonObject = new JSONObject();
		//判断参数
		if(jsonobjectstr.optString("loginname")==null||"".equals(jsonobjectstr.optString("loginname"))
				||jsonobjectstr.optString("loginpass")==null||"".equals(jsonobjectstr.optString("loginpass"))
				||jsonobjectstr.optString("pager_offset")==null||"".equals(jsonobjectstr.optString("pager_offset"))
				||jsonobjectstr.optString("pager_openset")==null||"".equals(jsonobjectstr.optString("pager_openset"))){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		User user = new User();
		user.setLoginname(jsonobjectstr.optString("loginname"));
		user.setLoginpass(jsonobjectstr.optString("loginpass"));
		//根据用户名和密码查询用户
		user = userDao.login(user);
		
		User_JiLin user_JiLin = new User_JiLin();
		Tools.setVOToVO(user, user_JiLin);
		
		if(user != null && user.getCpccorp() != null && user.getCpccorp().length() == 14){
			//根据用户cpc查询所在的组织机构
			Org org = orgDao.findByCpccorpObject(user.getCpccorp());
			//机构类型为药材市场
			if(org!=null&&org.getZyctype()!=null&&org.getZyctype().length()==8&&(org.getZyctype().equals("00001000"))){
				Org_JiLin obj = new Org_JiLin();
				Tools.setVOToVO(org, obj);
				user_JiLin.setOrg(obj);
				
				
				//根据marketcode为当前org的cpc,查询该市场下所有商户
				Org temp = new Org();
				temp.setMarketcode(org.getCpccorp());
				temp.setPager_offset(Integer.valueOf(jsonobjectstr.optString("pager_offset")));
				temp.setPager_openset(Integer.valueOf(jsonobjectstr.optString("pager_openset")));
				
				Org_JiLin org_JiLin = null;
				List<Org_JiLin> list_JiLin = new ArrayList<Org_JiLin>();
				List<Org> list = orgDao.findByList(temp);
				for(Org o:list){
					if(orgDao.findCardByCpc_JiLin(org.getCpccorp()) != 0){
						o.setSendcard("1");
					}else{
						o.setSendcard("0");
					}
					o.setUploadtype(5);
					
					List<OrgUpload> orgUploads = orgDao.findPic_JiLin(o);
					if(null != orgUploads && orgUploads.size() > 0){
						OrgUpload orgUpload = orgDao.findPic_JiLin(o).get(0);
						o.setUploadcontent(orgUpload.getUploadcontent());
						o.setUploadid(orgUpload.getUploadid());
					}
					org_JiLin = new Org_JiLin();
					Tools.setVOToVO(o,org_JiLin);
					list_JiLin.add(org_JiLin);
				}
				user_JiLin.setOrglist(list_JiLin);
				user_JiLin.setPager_count(orgDao.findByCount(temp));
				
				jsonObject=JSONObject.fromObject(user_JiLin);
				user.setReturninfo("1");
			}else{
				jsonObject.put("returninfo", "0");
			}
		}else{
			jsonObject.put("returninfo", "0");
		}
		return jsonObject;
	}
	
	
	public JSONObject findMedSell_jiLin(JSONObject jsonobjectstr) {
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
				||jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		//验证操作用户正不正确
		User user = new User();
		user.setUserid(jsonobjectstr.optInt("userid"));
		user = userDao.findById(user);
		if(user==null||user.getCpccorp()==null||user.getCpccorp().length()!=14||user.getLoginname()==null){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		User_JiLin user_JiLin = new User_JiLin();
		Tools.setVOToVO(user, user_JiLin);
		//根据用户cpc查询所在的组织机构
		Org org = orgDao.findByCpccorpObject(user.getCpccorp());
		//机构类型为药材市场
		if(org!=null&&org.getZyctype()!=null&&org.getZyctype().length()==8&&(org.getZyctype().equals("00001000"))){
			Org_JiLin obj = new Org_JiLin();
			Tools.setVOToVO(org, obj);
			user_JiLin.setOrg(obj);
			
			
			//根据marketcode为当前org的cpc,查询该市场下所有商户
			Org temp = new Org();
			temp.setMarketcode(org.getCpccorp());
			temp.setMcontent(jsonobjectstr.optString("mcontent"));
			temp.setPager_offset(Integer.valueOf(jsonobjectstr.optString("pager_offset")));
			temp.setPager_openset(Integer.valueOf(jsonobjectstr.optString("pager_openset")));
			
			Org_JiLin org_JiLin = null;
			List<Org_JiLin> list_JiLin = new ArrayList<Org_JiLin>();
			List<Org> list = orgDao.findByList(temp);
			for(Org o:list){
				if(orgDao.findCardByCpc_JiLin(org.getCpccorp()) != 0){
					o.setSendcard("1");
				}else{
					o.setSendcard("0");
				}
				
				o.setUploadtype(5);
				List<OrgUpload> orgUploads = orgDao.findPic_JiLin(o);
				if(null != orgUploads && orgUploads.size() > 0){
					OrgUpload orgUpload = orgDao.findPic_JiLin(o).get(0);
					o.setUploadcontent(orgUpload.getUploadcontent());
					o.setUploadid(orgUpload.getUploadid());
				}
				org_JiLin = new Org_JiLin();
				Tools.setVOToVO(o,org_JiLin);
				list_JiLin.add(org_JiLin);
				
				org_JiLin = new Org_JiLin();
				Tools.setVOToVO(o,org_JiLin);
				list_JiLin.add(org_JiLin);
			}
			user_JiLin.setOrglist(list_JiLin);
			user_JiLin.setPager_count(orgDao.findByCount(temp));
			
			jsonObject=JSONObject.fromObject(user_JiLin);
			user.setReturninfo("1");
		}else{
			jsonObject.put("returninfo", "0");
		}
		return jsonObject;
	}
	
	public JSONObject saveMedSell_JiLin(JSONObject jsonobjectstr) throws DocumentException, IOException {
		JSONObject jsonObject = new JSONObject();
		//判断参数
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
		   || jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))		
		   || jsonobjectstr.optString("orgname")==null||"".equals(jsonobjectstr.optString("orgname"))	
		   || jsonobjectstr.optString("identitycard")==null||"".equals(jsonobjectstr.optString("identitycard"))
		   || jsonobjectstr.optString("mobile")==null||"".equals(jsonobjectstr.optString("mobile"))){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//验证市场用户正不正确
		User user = new User();
		user.setUserid(jsonobjectstr.optInt("userid"));
		user = userDao.findById(user);
		if(user==null||user.getCpccorp()==null||user.getCpccorp().length()!=14||user.getLoginname()==null){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//根据市场用户cpc查询所在市场
		Org market = orgDao.findByCpccorpObject(user.getCpccorp());
		/*****************后台判断该企业是否已经注册********************/
		String orgname = jsonobjectstr.optString("orgname")+jsonobjectstr.optString("identitycard").substring(jsonobjectstr.optString("identitycard").length()-4);
		Company company = new Company();
		company.setCorpname(orgname);
		List<Company> companys = companyDao.findByExist(company);
		if(companys != null && companys.size() > 0){
			jsonObject.put("returninfo","经营户已注册!");
			return jsonObject;
		}
		/******************后台判断该下属单位是否已经注册**************/
		List<Org> orgs = orgDao.findByExist(company.getCorpname());
		if(orgs != null && orgs.size() > 0 ){
			jsonObject.put("returninfo","经营户已注册!");
			return jsonObject;
		}
		
		// 将省市区封装到codeArea进行查询返回区域码
		CodeArea codeArea = new CodeArea();
		codeArea.setProvince(market.getProvince());
		codeArea.setCity(market.getCity());
		codeArea.setArea(market.getArea());

		String areacode = codeAreaDao.findByName(codeArea);

		if (areacode == null || "".equals(areacode)) {
			jsonObject.put("returninfo","注册失败!地址代码未找到!");
			return jsonObject;
		}
		
		Tools.setVOToVO(market, company);
		company.setCorpname(orgname);
		company.setCorpshortname(orgname);
		company.setMasterman(jsonobjectstr.optString("orgname"));
		company.setLinkman(jsonobjectstr.optString("orgname"));
		company.setMobile(jsonobjectstr.optString("mobile"));
		company.setIdentitycard(jsonobjectstr.optString("identitycard"));
		company.setAreacode(areacode);
		company.setZyctype("01000000");//药材经销商
		company.setCpccorp("");
		String method = Tools.xmlRegister(company, "insert", areacode, 0,user.getCpccorp(),null,null);
		System.out.println(method);
		String xmlstr;
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			jsonObject.put("returninfo","注册失败!请求中央接口超时!");
			return jsonObject;
		}
	

		if (xmlstr == null || xmlstr.equals("")) {
			jsonObject.put("returninfo","注册失败!请稍后重试!");
			return jsonObject;
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
					jsonObject.put("returninfo",returninfo);
					return jsonObject;
				}
			}
			
			/*****************根据返回的cpc查询company,org表是否已经存在********************/
			Company tempCorp = new Company();
			tempCorp.setCpccorp(cpccorp);
			if(companyDao.findByCpccorp(tempCorp) != null){
				jsonObject.put("returninfo", "经营户已注册!");
				return jsonObject;
			}
			
			Org tempOrg = new Org();
			tempOrg.setCpccorp(cpccorp);
			orgs = orgDao.findByCpccorp(tempOrg);
			if(orgs != null && orgs.size() > 0){
				jsonObject.put("returninfo", "经营户已注册!");
				return jsonObject;
			}
			/**********************************************************/
			company.setCpccorp(cpccorp);
			company.setState(1);
			company.setOpertype(0);
			company.setCorp(1);//注册经营户 企业为非集团类型
			company.setOrgcode("");
			int companyId = companyDao.save(company);
			if (companyId != 0) {
				// 新增org
				Org org = new Org();
				Tools.setVOToVO(company, org);
				org.setOrgname(company.getCorpname());
				org.setOrgshortname(company.getCorpshortname());
				org.setMarketcode(user.getCpccorp());//当前登录用户的组织机构cpc
				org.setSupercpccode(cpccorp);
				Integer orgId = orgDao.save(org);
				if (orgId != null) {
					String str = "";
					//保存身份证,照片信息
					JSONArray jsonArr = jsonobjectstr.getJSONArray("orguploads");
					try{
						for(int i = 0 ,j = jsonArr.size(); i < j ; i++){
							JSONObject obj  = jsonArr.getJSONObject(i);
							str = saveObjectFile(orgId, obj);
						}
					}catch(Exception ex){
						jsonObject.put("returninfo",str);
						throw new RuntimeException();
					}
					
					
					// 新增user
					user = new User();
					user.setOrgid(orgId);
					user.setState(1);
					user.setUsertype(2);
					user.setCpccorp(cpccorp);
					user.setUsername(org.getLinkman());
					user.setLoginname(cpccorp);
					user.setLoginpass(cpccorp);
					//user.setPartion(form.getPartion());
					//user.setCoordinate(form.getCoordinate());
					userDao.save(user);
				} else {
					jsonObject.put("returninfo", "经营户注册失败!");
					return jsonObject;
				}
				jsonObject.put("returninfo", "经营户注册成功!");

				// 记录操作日志
				OpLog opLog = new OpLog();
				opLog.setSysid(3);
				opLog.setMethod("企业备案");
				opLog.setLoginName(user.getLoginname());
				opLog.setUserName(user.getUsername());
				opLog.setClientIp(Tools.getRealIp(this.getRequest()));
				opLog.setContent("企业cpc:" + cpccorp);
				opLogDao.saveOjbect(opLog);
			}else{
					jsonObject.put("returninfo", "经营户注册失败!");
					return jsonObject;
				}
			} else {
				jsonObject.put("returninfo", "经营户注册失败!");
				return jsonObject;
			}
		return jsonObject;
	}
	
	
	public JSONObject findMedSellByCpc_JiLin(JSONObject jsonobjectstr) {
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
			||jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//验证市场用户正不正确
		User user = new User();
		user.setUserid(jsonobjectstr.optInt("userid"));
		user = userDao.findById(user);
		if(user==null||user.getCpccorp()==null||user.getCpccorp().length()!=14||user.getLoginname()==null){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		//根据cpc查询当前农户
		Org org = orgDao.findByCpccorpObject(jsonobjectstr.optString("cpccorp"));
		if(orgDao.findCardByCpc_JiLin(org.getCpccorp()) != 0){
			org.setSendcard("1");
		}else{
			org.setSendcard("0");
		}
		
		List<OrgUpload> orgUploads = orgDao.findPic_JiLin(org);
		List<OrgUpload_JiLin> orgUploads_JiLin = new ArrayList<OrgUpload_JiLin>();
		OrgUpload_JiLin orgUpload_JiLin = null;
		for(OrgUpload orgUpload:orgUploads){
			orgUpload_JiLin = new OrgUpload_JiLin();
			Tools.setVOToVO(orgUpload, orgUpload_JiLin);
			orgUploads_JiLin.add(orgUpload_JiLin);
		}
	
		org.setOrguploads(orgUploads_JiLin);
		
		User_JiLin user_JiLin = new User_JiLin();
		Tools.setVOToVO(user, user_JiLin);
		
		Org_JiLin org_JiLin = new Org_JiLin();
		Tools.setVOToVO(org, org_JiLin);
		
		user_JiLin.setOrg(org_JiLin);
		
		jsonObject=JSONObject.fromObject(user_JiLin);
		return jsonObject;
	}
	
	public JSONObject updateMobileByCpc_JiLin(JSONObject jsonobjectstr) throws DocumentException, IOException {
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
			||jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))
			||jsonobjectstr.optString("mobile")==null||"".equals(jsonobjectstr.optString("mobile"))
			){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//验证市场用户正不正确
		User user = new User();
		user.setUserid(jsonobjectstr.optInt("userid"));
		user = userDao.findById(user);
		if(user==null||user.getCpccorp()==null||user.getCpccorp().length()!=14||user.getLoginname()==null){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//根据cpc查询company
		Company temp = new Company();
		temp.setCpccorp(jsonobjectstr.optString("cpccorp"));
		Company company = companyDao.findByCpccorp(temp);
		company.setMobile(jsonobjectstr.optString("mobile"));
		
		JSONArray jsonArr = jsonobjectstr.getJSONArray("orguploads");
		List<OrgUpload> list = new ArrayList<OrgUpload>();
		OrgUpload upload = null;
		for(int i = 0 ,j = jsonArr.size(); i < j ; i++){
			upload = new OrgUpload();
			JSONObject obj  = jsonArr.getJSONObject(i);
			File importFile = new File(obj.getString("uploadify"));
			if (importFile == null || "".equals(importFile)) {
				jsonObject.put("returninfo", "文件错误,文件名为空!");
				return jsonObject;
			}
			String file_org_path = ServletActionContext.getServletContext().getInitParameter("file_org_path");
			if (file_org_path == null || "".equals(file_org_path)) {
				jsonObject.put("returninfo", "文件错误,存储路径为空!");
				return jsonObject;
			}
			if (((float) (Math.round(importFile.length() / 1024 * 100)) / 100) > 2000) {
				jsonObject.put("returninfo", "文件错误,文件最大为2M!");
				return jsonObject;
			}
			String type = getStrend(obj.getString("uploadifyFileName"));
			StringBuffer filename = new StringBuffer(getNow());
			
			filename.append(".").append(type);
			
			upload.setUploadid(obj.getInt("uploadid"));
			upload.setUploadname(obj.getString("uploadifyFileName"));// .substring(0,form.getUploadifyFileName().indexOf(".")));
			upload.setUploadcontent(file_org_path + "/" + getDateMonthStr() + "/" + filename);
			upload.setUploadimage(Tools.getBytesFromFile(importFile));
			upload.setUploadtype(obj.getInt("uploadtype"));
			orgUploadDao.updateByUploadId(upload);
			
			list.add(upload);
		}
		
		String method = Tools.xmlRegister(company, "update", company.getAreacode(), 0,company.getMarketcode(),null,list);
		System.out.println(method);
		String xmlstr;
		
		try{
			xmlstr = Tools.sendPost(method,"corpinfo");
		}catch(Exception ex){
			jsonObject.put("returninfo", "更新失败,请求中央接口超时!");
			return jsonObject;
		}
		

		if (xmlstr == null || xmlstr.equals("")) {
			jsonObject.put("returninfo", "更新失败,请稍后重试!");
			return jsonObject;
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
				jsonObject.put("returninfo", "更新失败!");
				return jsonObject;
			}
		}
		
		temp.setCompanyid(company.getCompanyid());
		temp.setMobile(company.getMobile());
		temp.setCpccorp("");
		Integer count = companyDao.updateById(temp);
		if (count != 0) {
			// 同步更新org
			Org org = new Org();
			org.setSupercpccode(jsonobjectstr.optString("cpccorp"));
			org.setMobile(company.getMobile());
			Integer orgId = orgDao.updateBySuperCpC(org);
			if (orgId != 0) {
				// 新增user
				user = new User();
				user.setCpccorp(org.getSupercpccode());
				user = userDao.findByCpccorp(user);
				user.setLasttime(Tools.getCurrentTime());
				user.setUsername(form.getLinkman());
				userDao.updateById(user);
			}
			jsonObject.put("returninfo", "更新经营户完成!");
			
		}
		return jsonObject;
	}
	
	
	/**
	 * 保存IC卡信息
	 * @throws DocumentException 
	*/
	public JSONObject saveCard_JiLin(JSONObject jsonobjectstr) throws DocumentException{
		JSONObject jsonObject = new JSONObject();
		if(jsonobjectstr.optString("cpccorp")==null||"".equals(jsonobjectstr.optString("cpccorp"))
			||jsonobjectstr.optString("userid")==null||"".equals(jsonobjectstr.optString("userid"))
			||jsonobjectstr.optString("devicecode")==null||"".equals(jsonobjectstr.optString("devicecode"))
			||jsonobjectstr.optString("cardtype")==null||"".equals(jsonobjectstr.optString("cardtype"))
			||jsonobjectstr.optString("chengcode")==null||"".equals(jsonobjectstr.optString("chengcode"))
			||jsonobjectstr.optString("confid")==null||"".equals(jsonobjectstr.optString("confid"))
			||jsonobjectstr.optString("orgid")==null||"".equals(jsonobjectstr.optString("orgid"))
			){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//验证市场用户正不正确
		User user = new User();
		user.setUserid(jsonobjectstr.optInt("userid"));
		user = userDao.findById(user);
		if(user==null||user.getCpccorp()==null||user.getCpccorp().length()!=14||user.getLoginname()==null){
			jsonObject.put("returninfo", "0");
			return jsonObject;
		}
		
		//根据商户orgid查询当前商户
		Org org = new Org();
		org.setOrgid(jsonobjectstr.optInt("orgid"));
		org = orgDao.findById(org);
		
		//创建Device实例
		Device device = new Device();
		device.setDevicecode(jsonobjectstr.optString("devicecode"));
		device.setConfid(jsonobjectstr.optInt("confid"));
		device.setCpccorp(jsonobjectstr.optString("cpccorp"));
		device.setChengcode(jsonobjectstr.optString("chengcode"));
		device.setDevicetype(4);//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描设备；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
		device.setCardtype(jsonobjectstr.optString("cardtype"));
		device.setCorpname(org.getOrgname());
		
		//保存IC卡前先判断是否编码已经存在
		if(null != deviceDao.findByCode(device)){
			jsonObject.put("returninfo", "IC卡编码已经存在!");
			return jsonObject;
		}
		
		//扫描设备保存
		int deviceid = deviceDao.save(device);
		if(deviceid != 0){
		//将设备表中该企业下的所有IC卡编号查询出来组织XML发给中央平台
		device.setCpccorp(jsonobjectstr.optString("cpccorp"));
        List<Device> deviceList = deviceDao.queryByList(device);
	        
        String sendCard = "";
        for(int i =0; deviceList!=null && i<deviceList.size();i++){
        	if(i==0){//不是list的最后一个
        		sendCard = deviceList.get(i).getDevicecode();
        	}else{
        		sendCard = sendCard + "," + deviceList.get(i).getDevicecode();
        	}
        }
			
		
		if(org != null){
			org.setSendcard(sendCard);
			org.setCardtype(jsonobjectstr.optString("cardtype"));
			//组装发送IC卡XML
			String method = ToolSql.getSendCardXml(org);
			
			String xmlstr;
			try{
				xmlstr = Tools.sendPost(method,"corpinfo");
			}catch(Exception ex){
				jsonObject.put("returninfo", "发送IC卡XML文件失败,请求中央接口超时!");
				return jsonObject;
			}
			

			if(xmlstr==null||xmlstr.equals("")){
				jsonObject.put("returninfo", "发送IC卡XML文件失败!");
				return jsonObject;
			}
			String respcode ="";
			String cpccorptemp ="";	
			if(xmlstr!=null&&!xmlstr.equals("")){
				Document document = DocumentHelper.parseText(xmlstr); 
				respcode =document.selectSingleNode("cpc/respcode").getText();
				cpccorptemp =document.selectSingleNode("cpc/operadata/corpcpccode").getText();
				if(respcode==null||!respcode.equals("0000")||cpccorptemp==null||"".equals(cpccorptemp)||cpccorptemp.length()!=14){
					jsonObject.put("returninfo", "发送IC卡XML文件失败!");
					return jsonObject;
				}	
			}
			
		}
		jsonObject.put("returninfo", "发送IC卡成功！");
		//操作日志记录
		saveOpLog(user,"发送IC卡","IC卡编号:"+device.getDevicecode());
		}
		return jsonObject;
	} 
	
	public void saveOpLog(User user ,String method,String content){
		//记录操作日志
		OpLog opLog=new OpLog();
		if(user.getOrg()==null||user.getOrg().getZyctype().equals("00000010")){
			opLog.setSysid(7);
		}
		else if(user.getOrg().getZyctype().equals("10000000")){
			opLog.setSysid(1);
		}else if(user.getOrg().getZyctype().equals("01000000")){
			opLog.setSysid(2);
		}else if(user.getOrg().getZyctype().equals("00100000")){
			opLog.setSysid(4);
		}else if(user.getOrg().getZyctype().equals("00010000")){
			opLog.setSysid(5);
		}else if(user.getOrg().getZyctype().equals("00001000")){
			opLog.setSysid(3);
		}else if(user.getOrg().getZyctype().equals("00000100")){
			opLog.setSysid(6);
		}
		opLog.setMethod(method);
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent(content);
		opLogDao.saveOjbect(opLog);
	}
	
	
	/**
	 * 保存上传文件
	 * 
	 * @return
	 * @throws IOException 
	 */
	public String saveObjectFile(int orgId,JSONObject obj) throws IOException {
		File importFile = new File(obj.getString("uploadify"));
		String str="";
		if (importFile == null || "".equals(importFile)) {
			str="文件错误,文件名为空!";
		}
		String file_org_path = ServletActionContext.getServletContext().getInitParameter("file_org_path");
		if (file_org_path == null || "".equals(file_org_path)) {
			str="文件错误,存储路径为空!";
		}
		if (((float) (Math.round(importFile.length() / 1024 * 100)) / 100) > 2000) {
			str="文件错误,文件最大为2M!";
		}
		String type = getStrend(obj.getString("uploadifyFileName"));
		StringBuffer filename = new StringBuffer(getNow());
		
		filename.append(".").append(type);
		
		//新增企业组织上传附件信息
		OrgUpload orgUpload = new OrgUpload();
		orgUpload.setUploadname(obj.getString("uploadifyFileName"));// .substring(0,form.getUploadifyFileName().indexOf(".")));
		orgUpload.setUploadcontent(file_org_path + "/" + getDateMonthStr() + "/" + filename);
		orgUpload.setUploadtype(obj.getInt("uploadtype"));//1营业执照 2组织机构代证码 3其他证书
		orgUpload.setType(0);//0企业 1组织
		orgUpload.setUploadimage(Tools.getBytesFromFile(importFile));
		orgUpload.setId(orgId);
		orgUploadDao.save(orgUpload);
		return str;
	}
	
	
	public String upErrorStr(String filename, String errorInfo) {
		return "<div style=\"border:1px solid green;width:100px;float:left;margin:5px 0 0 5px;\"><div style=\"width:100px;height:20px;line-height:20px;vertical-align: middle;font-weight:bold;background:url('images/tabletitle.png') repeat-x;text-align:center;color:red;\">文件错误</div><div style=\"width:100px;height:80px;text-align:center;\">"
				+ filename + "<br style=\"clear:both;\" />" + errorInfo + "</div></div>";
	}

	public String upSuccessStr(String matname) {
		matname = matname.replaceAll(" ", "_");
		return "<div style=\"border:1px solid green;width:100px;float:left;margin:5px 0 0 5px;\"><div style=\"width:100px;height:20px;line-height:20px;vertical-align: middle;font-weight:bold;background:url('images/tabletitle.png') repeat-x;text-align:center;\">上传文件</div><div style=\"width:100px;height:80px;text-align:center;overflow:hidden;\">"
				+ matname + "</div></div>";
	}

	public static String getDateMonthStr() {
		return (new SimpleDateFormat("yyyy-MM")).format(new Date());
	}

	public static String getStrend(String str) {
		String[] strVale = str.split("[.]");
		int Maxs = (strVale.length) - 1;

		str = strVale[Maxs];

		return str;
	}
	
	public static String getNow() {
		return (new SimpleDateFormat("yyyyMMddHHmmssMS")).format(new Date());
	}
}
