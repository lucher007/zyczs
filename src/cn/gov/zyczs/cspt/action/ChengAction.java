package cn.gov.zyczs.cspt.action;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.common.Tools;
import cn.gov.zyczs.cspt.common.ToolsXml;
import cn.gov.zyczs.cspt.dao.IChengConfDao;
import cn.gov.zyczs.cspt.dao.IChengDao;
import cn.gov.zyczs.cspt.dao.IChengDataDao;
import cn.gov.zyczs.cspt.dao.IChengFckDao;
import cn.gov.zyczs.cspt.dao.IChengFckTmpDao;
import cn.gov.zyczs.cspt.dao.IChengKeyDao;
import cn.gov.zyczs.cspt.dao.IChengSqlDao;
import cn.gov.zyczs.cspt.dao.IChengTmpDao;
import cn.gov.zyczs.cspt.dao.ICompanyDao;
import cn.gov.zyczs.cspt.dao.IDeviceRecDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.dao.IZyczsXmlDao;
import cn.gov.zyczs.cspt.po.Cheng;
import cn.gov.zyczs.cspt.po.ChengConf;
import cn.gov.zyczs.cspt.po.ChengData;
import cn.gov.zyczs.cspt.po.ChengFck;
import cn.gov.zyczs.cspt.po.ChengFckTmp;
import cn.gov.zyczs.cspt.po.ChengKey;
import cn.gov.zyczs.cspt.po.ChengSql;
import cn.gov.zyczs.cspt.po.ChengTmp;
import cn.gov.zyczs.cspt.po.Company;
import cn.gov.zyczs.cspt.po.Device;
import cn.gov.zyczs.cspt.po.DeviceConf;
import cn.gov.zyczs.cspt.po.DeviceRec;
import cn.gov.zyczs.cspt.po.Mappdata;
import cn.gov.zyczs.cspt.po.OpLog;
import cn.gov.zyczs.cspt.po.Org;
import cn.gov.zyczs.cspt.po.OrgUpload;
import cn.gov.zyczs.cspt.po.User;

import com.googlecode.jsonplugin.JSONUtil;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤信息
 * @author lucher
 *
 */
@SuppressWarnings("serial")
public class ChengAction extends BaseAction implements ModelDriven<Cheng> {
	
	Cheng form = new Cheng();
	public Cheng getModel() {
		return form;
	}
	
	private String uploadcontent;
	public String getUploadcontent() {
		return uploadcontent;
	}
	public void setUploadcontent(String uploadcontent) {
		this.uploadcontent = uploadcontent;
	}
	
	private IChengDao chengDao;
	private IChengConfDao chengConfDao;
	private IChengKeyDao chengKeyDao;
	private IChengFckDao chengFckDao;
	private IChengSqlDao chengSqlDao;
	private IChengDataDao chengDataDao;
	private IOrgDao orgDao;
	private IDeviceRecDao deviceRecDao;
	private IOpLogDao opLogDao;
	private IChengTmpDao chengTmpDao;
	private IChengFckTmpDao chengFckTmpDao;
	
	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	private IZyczsXmlDao zyczsXmlDao;
	public void setZyczsXmlDao(IZyczsXmlDao zyczsXmlDao) {
		this.zyczsXmlDao = zyczsXmlDao;
	}
	/**
	 * 查询溯源秤信息
	 */
	public String findByList(){
		User user = (User) getSession().getAttribute("User");
		if(user.getOrg() != null ){
			if("00001000".equals(user.getOrg().getZyctype())){//判断此登录用户是不是市场用户
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		form.setPager_openset(10);
		form.setPager_count(chengDao.findByCount(form));
		List<Cheng> ChengList = chengDao.findByList(form);
		for (Cheng cheng : ChengList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(cheng.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
			cheng.setNormname(companyName+"-"+chengConf.getNormname());
		}
		form.setChengList(ChengList);
		return "findByList";
	}
	
	/**
	 * 添加溯源秤信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addChengInit(){
		//构建溯源秤规格Map对象
		List<ChengConf> list = chengConfDao.queryByList(new ChengConf());
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			ChengConf chengConf = (ChengConf) iterator.next();
			if(chengConf != null){
				map.put(chengConf.getConfid(),ToolSql.getCompanyNameByKey(chengConf.getCompanyname()) 
						+ "-" + chengConf.getNormname());
			}
		}
		form.setChengconfmap(map);
		return "addChengInit";
	}
	
	/**
	 * 检验溯源秤号是否存在
	 * @throws IOException 
	 */
	@SuppressWarnings("unchecked")
	public void checkChengCode(){
		try {
			this.getResponse().setContentType("text/html;charset=utf-8");
			PrintWriter out = this.getResponse().getWriter();
			
			String chengcode = form.getChengcode();
			//称号前补俩位省位编码，然后补22个0凑齐32位
			String cheng_code_area = ToolSql.getXmlValueFromKey("cheng_code");
			
			form.setChengcode("0000000000000000000000"+cheng_code_area+chengcode);
			
			Cheng cheng = chengDao.findByCode(form);
			if("".equals(cheng_code_area)){
				out.print("称号地区前缀未配置XML！");
			} else if (chengcode != null && !"".equals(chengcode) && chengcode.length() != 8){
				out.print("溯源秤编码必须手动输入8位！");
			} else if (cheng != null && !"".equals(form.getChengcode().trim())){
				out.print("溯源秤编码已经存在！");
			}else{
				out.print("");
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//选择企业列表
	public String companyChoice(){
		User user = (User) getSession().getAttribute("User");
		
		Org tepOrg = new Org();//查询所有单位的参数model
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号){
			if("00001000".equals(user.getOrg().getZyctype())){
				tepOrg.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		tepOrg.setState(1);//企业必须为审核企业
		tepOrg.setChengtype(form.getType());//溯源秤类型(1-案秤、2-台秤)
		tepOrg.setOrgname(form.getCorpname());
		tepOrg.setPager_openset(5);//一页显示5行
		tepOrg.setPager_offset(form.getPager_offset());
		form.setPager_count(orgDao.findByCount_companystate(tepOrg));
		List<Org> allOrgList = orgDao.findByList_companystate(tepOrg);
		if(allOrgList != null){
			for (Org orgTmp : allOrgList) {
				String marketcode = orgTmp.getMarketcode();
				if( marketcode!= null && !"".equals(marketcode)){
					Org orgPar = new Org();
					orgPar.setCpccorp(marketcode);
					List<Org> marketList = orgDao.findByCpccorp(orgPar);//查询此经商户的市场
					if(marketList != null && marketList.size() > 0){
						Org market = marketList.get(0);
						orgTmp.setMarketname(market.getOrgname());//将市场名称写入单位中
					}
				}
			}
		}
		
		form.setOrgList(allOrgList);
		
		
		return "companyChoice";
	}
	
	
	//根据当前操作员的CPCCORP来选择秤列表
	public String chengChoice(){
		User user = (User) getSession().getAttribute("User");
		
		if(form.getCpccorp()==null || "".equals(form.getCpccorp())){//表示页面上没有选择CPCCORP
			//判断此登录用户是不是市场用户
			if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
				if("00001000".equals(user.getOrg().getZyctype())){
					form.setMarketcode(user.getOrg().getCpccorp());
				}else{
					form.setCpccorp(user.getCpccorp());
				}
			}
		}
		
		form.setPager_openset(5);
		form.setPager_count(chengDao.findByCount(form));
		List<Cheng> chengList = chengDao.findByList(form);
		for (Cheng cheng : chengList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(cheng.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			if(chengConf != null){
				cheng.setNormname(ToolSql.getCompanyNameByKey(chengConf.getCompanyname())+"-"+chengConf.getNormname());
			}
		}
		form.setChengList(chengList);
		return "chengChoice";
	}
	
	/**
	 * 保存溯源秤信息
	 */
	@SuppressWarnings("unchecked")
	public String saveCheng(){
		User user = (User) getSession().getAttribute("User");
		
		String chengcode = form.getChengcode();
		//称号前补俩位省位编码，然后补22个0凑齐32位
		
		form.setChengcode("0000000000000000000000"+ToolSql.getXmlValueFromKey("cheng_code")+chengcode);
		
		
		if("".equals(chengcode)){
			form.setReturninfo("溯源秤编码不能为空！");
			return addChengInit();
		}else{
			Cheng OldCheng = chengDao.findByCode(form);
			if(OldCheng != null){
				form.setReturninfo("溯源秤编码已经存在！");
				return addChengInit();
			}
		}
		
		ChengConf conf = new ChengConf();
		conf.setConfid(form.getConfid());
		conf = chengConfDao.findById(conf);
		if(conf != null){
			form.setNormname(ToolSql.getCompanyNameByKey(conf.getCompanyname())+"-"+conf.getNormname());
		}
		form.setState(3);
		form.setLocked(0);
		form.setIp("");
		//秤的工作模式从web.xml中配置获取
		form.setChengmode(ToolSql.getChengModeFromXml());
		form.setOvertime(0);
		form.setChengbrand(conf.getCompanyname());
		form.setChengmodel(conf.getNormname());
		form.setWeightcount(0);
		//秤保存
		chengDao.save(form);
		//更新中间件SQL
		ChengSql outSql = new ChengSql();
		outSql.setSql(ToolSql.addChengSql(form));
		chengSqlDao.saveOutSql(outSql);
		
		//发放秤组织初始化XML发往北京平台
		zyczsXmlDao.saveOjbect(ToolsXml.provide_chengXml(form,user));
		//chengDao.saveChengStatXml(form);
		
		//判断页面是否需要回收溯源秤
		if(form.getRecoverCheck() != null && form.getRecoverCheck() == 1){
			//查询出要回收的溯源秤
			Cheng oldCheng = new Cheng();
			oldCheng.setChengid(form.getRecdeviceid());
			oldCheng = chengDao.findById(oldCheng);
			if(oldCheng != null){
				DeviceRec deviceRec = new DeviceRec();
				deviceRec.setConfid(oldCheng.getConfid());
				deviceRec.setDevicecode(oldCheng.getChengcode());
				deviceRec.setCpccorp(oldCheng.getCpccorp());
				deviceRec.setCorpname(oldCheng.getCorpname());
				//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描器；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
				deviceRec.setDevicetype(0);
				deviceRec.setChengtype(oldCheng.getType());
				deviceRec.setReason(form.getRecreason());//页面填写的回收原因
				deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
				//删除溯源秤发放信息
				chengDao.delete(oldCheng);
				//更新中间件SQL
				outSql.setSql(ToolSql.deleteChengSql(oldCheng));
				chengSqlDao.saveOutSql(outSql);
				
				//删除该溯源秤的所有快捷键信息
				ChengFck chengFck = new ChengFck();
				chengFck.setChengcode(oldCheng.getChengcode());
				chengFckDao.delete(chengFck);
				//更新中间件SQL
				outSql.setSql(ToolSql.deleteChengAllFckSql(chengFck));
				chengSqlDao.saveOutSql(outSql);
				
				//添加溯源秤回收信息
				deviceRecDao.save(deviceRec);
				
				//回收秤信息XML发往北京平台
				zyczsXmlDao.saveOjbect(ToolsXml.recover_chengXml(oldCheng,user));
			}
		}
		
		//记录操作日志
		OpLog opLog=new OpLog();		
		//监管平台
		if(user.getOrg()==null||user.getOrg().getZyctype().equals("00000010")){
			opLog.setSysid(7);
		//市场平台
		}else if(user.getOrg().getZyctype().equals("00001000")){
			opLog.setSysid(3);
		}
		opLog.setMethod("发放溯源称");
		opLog.setLoginName(user.getLoginname());
		opLog.setUserName(user.getUsername());
		opLog.setClientIp(Tools.getRealIp(this.getRequest()));
		opLog.setContent("溯源秤编号:"+form.getChengcode());
		opLogDao.saveOjbect(opLog);
		
		form.setReturninfo("添加溯源秤成功！");
		return addChengInit();
	}
	
	
	
	/**
	 * 回收溯源秤信息初始化
	 */
	public String recoverDeviceInit_cheng(){
		//查询出将要修改的溯源秤
		Cheng cheng = chengDao.findById(form);
		ChengConf chengconf = new ChengConf();
		chengconf.setConfid(cheng.getConfid());
		chengconf = chengConfDao.findById(chengconf);
		if(chengconf != null){
			cheng.setNormname(chengconf.getCompanyname() + "-" + chengconf.getNormname());
		}
		form.setCheng(cheng);
		return "recoverDeviceInit_cheng";
	}
	
	/**
	 * 保存溯源秤回收信息
	 */
	public String recoverDevice_cheng(){
		User user = (User) getSession().getAttribute("User");
		Cheng cheng = chengDao.findById(form);
		if(cheng!=null){
			DeviceRec deviceRec = new DeviceRec();
			deviceRec.setConfid(cheng.getConfid());
			deviceRec.setDevicecode(cheng.getChengcode());
			deviceRec.setCpccorp(cheng.getCpccorp());
			deviceRec.setCorpname(cheng.getCorpname());
			//设备类型(0-溯源秤；1-条码标签打印机；2-二维码扫描器；3-移动数据终端；4-卡类设备；5-查询机；6-耗材)
			deviceRec.setDevicetype(0);
			deviceRec.setChengtype(cheng.getType());
			deviceRec.setReason(form.getRecreason());//页面填写的回收原因
			deviceRec.setRemark(form.getRecremark());//页面填写的回收备注信息
			//删除溯源秤发放信息
			chengDao.delete(cheng);
			//更新中间件SQL
			ChengSql outSql = new ChengSql();
			outSql.setSql(ToolSql.deleteChengSql(cheng));
			chengSqlDao.saveOutSql(outSql);
			
			//删除该溯源秤的所有快捷键信息
			ChengFck chengFck = new ChengFck();
			chengFck.setChengcode(cheng.getChengcode());
			chengFckDao.delete(chengFck);
			//更新中间件SQL
			outSql.setSql(ToolSql.deleteChengAllFckSql(chengFck));
			chengSqlDao.saveOutSql(outSql);
			
			//添加溯源秤回收信息
			deviceRecDao.save(deviceRec);
			form.setReturninfo("回收成功！");
			
			//回收秤信息XML发往北京平台
			zyczsXmlDao.saveOjbect(ToolsXml.recover_chengXml(cheng,user));
			
			//记录操作日志
			OpLog opLog=new OpLog();		
			//监管平台
			if(user.getOrg()==null||user.getOrg().getZyctype().equals("00000010")){
				opLog.setSysid(7);
			//市场平台
			}else if(user.getOrg().getZyctype().equals("00001000")){
				opLog.setSysid(3);
			}
			opLog.setMethod("回收溯源称");
			opLog.setLoginName(user.getLoginname());
			opLog.setUserName(user.getUsername());
			opLog.setClientIp(Tools.getRealIp(this.getRequest()));
			opLog.setContent("溯源秤编号:"+form.getChengcode());
			opLogDao.saveOjbect(opLog);
			
		}else{
			form.setReturninfo("回收失败！");
		}
		
		//清空查询查询条件
		form.setChengcode("");
		form.setConfid(null);
		form.setCorpname("");
		form.setCpccorp("");
		return findByList();
	}
	
	
	
	
	
	
	/**
	 * 查询溯源秤快捷键信息
	 */
	public String findChengFckByList(){
		User user = (User) getSession().getAttribute("User");
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		form.setPager_openset(10);
		form.setPager_count(chengDao.findByCount(form));
		List<Cheng> ChengList = chengDao.findByList(form);
		for (Cheng cheng : ChengList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(cheng.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			if(chengConf != null){
				String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
				cheng.setNormname(companyName+"-"+chengConf.getNormname());
			}
		}
		form.setChengList(ChengList);
		return "findChengFckByList";
	}
	
	
	/**
	 * 更新溯源秤快捷键初始化
	 */
	@SuppressWarnings("unchecked")
	public String updateChengFckInit(){
		Cheng cheng = chengDao.findById(form);
		
		ChengConf chengConf = new ChengConf();
		chengConf.setConfid(cheng.getConfid());
		chengConf = chengConfDao.findById(chengConf);
		ChengKey chengKey = new ChengKey();
		
		if(chengConf != null){
			chengKey.setConfid(chengConf.getConfid());
			String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
			cheng.setNormname(companyName+"-"+chengConf.getNormname());
		}
		//获取称键配置表中配置值不为空的数据
		List<ChengKey> keyConfList = chengKeyDao.queryListByValueNull(chengKey);
		String keyString = "";
		for (Iterator iterator = keyConfList.iterator(); iterator.hasNext();) {
			ChengKey keyConf = (ChengKey) iterator.next();
			keyString += "-" + keyConf.getRowsnum() + "," + keyConf.getColumnnum() + "," + keyConf.getKeyvalue();
		}
		
		ChengFck chengfck = new ChengFck();
		chengfck.setChengcode(cheng.getChengcode());
		chengfck.setConfid(cheng.getConfid());
		//获取该秤所有的键值以及所配置的快捷键值
		List<ChengFck> chengFckList = new ArrayList<ChengFck>();
		chengFckList = chengFckDao.quryListByChengid(chengfck); 
		
		//根据溯源秤规格查询模板信息
		ChengTmp chengTmp = new ChengTmp();
		chengTmp.setConfid(cheng.getConfid());
		List<ChengTmp> tmplist = chengTmpDao.quryByList(chengTmp);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = tmplist.iterator(); iterator.hasNext();) {
			ChengTmp dmpChengTmp = (ChengTmp) iterator.next();
			if(dmpChengTmp != null){
				map.put(dmpChengTmp.getTmpid(), dmpChengTmp.getTmpname());
			}
		}
		form.setChengconfmap(map);
		
		form.setChengfck(chengfck);
		form.setCheng(cheng);
		form.setChengConf(chengConf);
		form.setChengfcklist(chengFckList);
		form.setKeystring(keyString);
		return "updateChengFckInit";
	}
	
	/**
	 * 保存溯源秤快捷键设置
	 */
	public String updateChengFck(){
		//首先删除该秤所有的快捷键
		ChengFck chengfck = new ChengFck();
		chengfck.setChengcode(form.getChengcode());
		chengFckDao.delete(chengfck);
		//更新中间件SQL
		ChengSql outSql = new ChengSql();
		outSql.setSql(ToolSql.deleteChengAllFckSql(chengfck));
		chengSqlDao.saveOutSql(outSql);
		
		List<String> strList = form.getStrList();
		if(strList!=null && strList.size()>0){
			for (int i = 1; i < strList.size(); i++) {
				String tempStr = strList.get(i);
				if(tempStr != null){
					String[] str = strList.get(i).trim().split("@");
					if(str.length ==3 && !"".equals(str[1]) && !"undefined".equals(str[1]) && !"".equals(str[2]) && !"undefined".equals(str[2])){
						ChengFck chengFck = new ChengFck();
						chengFck.setChengcode(form.getChengcode());
						chengFck.setKeyvalue(str[0].trim());
						
						chengFck.setPlucodes(str[1].trim());
						chengFck.setMedname(str[2].trim());
						chengFckDao.save(chengFck);
						//更新中间件SQL
						outSql.setSql(ToolSql.addChengFckSql(chengFck));
						chengSqlDao.saveOutSql(outSql);
					}
				}
			}
			//更新溯源秤快捷版本
			outSql.setSql(ToolSql.updateChengKeyVer(form));
			chengSqlDao.saveOutSql(outSql);
		}
		form.setReturninfo("快捷键保存成功");
		return updateChengFckInit();
	}
	
	/**
	 * 查询溯源秤锁定信息
	 */
	public String findChengLockedByList(){
		User user = (User) getSession().getAttribute("User");
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		form.setPager_openset(10);
		form.setPager_count(chengDao.findByCount(form));
		List<Cheng> ChengList = chengDao.findByList(form);
		for (Cheng cheng : ChengList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(cheng.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			if(chengConf != null){
				String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
				cheng.setNormname(companyName+"-"+chengConf.getNormname());
			}
		}
		
		form.setChengList(ChengList);
		return "findChengLockedByList";
	}
	
	/**
	 * 发送锁定指令
	 */
	public String updateChengLocked(){
		Cheng cheng = new Cheng();
		Cheng oldCheng = chengDao.findById(form);
		cheng.setChengid(form.getChengid());
		cheng.setChengcode(oldCheng.getChengcode());
		cheng.setLocked(form.getLocked()+1);//发送锁定指令1之后就变成锁定中2，发送解锁指令2之后就变成解锁中3。
		chengDao.update(cheng);
		///更新中间件SQL
		ChengSql outSql = new ChengSql();
		oldCheng.setLocked(form.getLocked());//锁定指令1；解锁指令2
		outSql.setSql(ToolSql.updateChengLocked(oldCheng));
		chengSqlDao.saveOutSql(outSql);
		return "updateChengLocked";
	}
	
	/**
	 * 查询溯源秤工作模式
	 */
	public String findChengModeByList(){
		User user = (User) getSession().getAttribute("User");
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		form.setPager_openset(10);
		form.setPager_count(chengDao.findByCount(form));
		List<Cheng> ChengList = chengDao.findByList(form);
		for (Cheng cheng : ChengList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(cheng.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			if(chengConf != null){
				String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
				cheng.setNormname(companyName+"-"+chengConf.getNormname());
			}
		}
		
		form.setChengList(ChengList);
		return "findChengModeByList";
	}
	
	
	/**
	 * 修改工作模式
	 */
	@SuppressWarnings("unchecked")
	public void updateChengMode(){
		try {
			this.getResponse().setContentType("text/html;charset=utf-8");
			PrintWriter out = this.getResponse().getWriter();
			
			Cheng cheng = new Cheng();
			Cheng oldCheng = chengDao.findById(form);
			cheng.setChengid(form.getChengid());
			cheng.setChengcode(oldCheng.getChengcode());
			cheng.setChengmode(form.getChengmode());
			chengDao.update(cheng);
			///更新中间件SQL
			ChengSql outSql = new ChengSql();
			outSql.setSql(ToolSql.updateChengMode(cheng));
			chengSqlDao.saveOutSql(outSql);
			
			out.print("修改成功！");
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询溯源秤发卡信息
	 */
	public String findChengCardByList(){
		User user = (User) getSession().getAttribute("User");
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		form.setPager_openset(10);
		form.setPager_count(chengDao.findByCount(form));
		List<Cheng> ChengList = chengDao.findByList(form);
		for (Cheng cheng : ChengList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(cheng.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			if(chengConf != null){
				String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
				cheng.setNormname(companyName+"-"+chengConf.getNormname());
			}
		}
		
		form.setChengList(ChengList);
		return "findChengCardByList";
	}
	
	
	/**
	 * 查询溯源秤交易信息
	 */
	public String findChengDataByList(){
		User user = (User) getSession().getAttribute("User");
		
		//判断此登录用户是不是市场用户
		if(user.getOrg() != null && !"00000010".equals(user.getOrg().getZyctype())){//等于空表示是admin账号,zyctype为00000010的为监管平台账号
			if("00001000".equals(user.getOrg().getZyctype())){
				form.setMarketcode(user.getOrg().getCpccorp());
			}
		}
		
		ChengData chengData = new ChengData();
		chengData.setPager_openset(10);
		chengData.setPager_offset(form.getPager_offset());
		chengData.setMarketcode(form.getMarketcode());
		if("1".equals(form.getQuerytype())){//市场下经商户查询
			User comuser = (User) getSession().getAttribute("comuser");
			chengData.setCpccorp(comuser.getOrg().getCpccorp());//市场下的经商户USER里的刷卡账号就是单位的cpc
		}
		
		chengData.setChengcode(form.getChengcode());
		chengData.setOperstarttime(form.getOperstarttime());
		chengData.setOperendtime(form.getOperendtime());
		form.setPager_count(chengDataDao.findByCount(chengData));
		List<ChengData> chengdatalist = chengDataDao.findByList(chengData);
		form.setChengdatalist(chengdatalist);
		return "findChengDataByList";
	}
	
	/**
	 * 查询溯源秤交易信息-单独查询
	 */
	public String findChengDataByList_chengCode(){
		ChengData chengData = new ChengData();
		chengData.setPager_openset(10);
		chengData.setPager_offset(form.getPager_offset());
		chengData.setChengcode(form.getChengcode());
		form.setPager_count(chengDataDao.findByCount(chengData));
		List<ChengData> chengdatalist = chengDataDao.findByList(chengData);
		form.setChengdatalist(chengdatalist);
		
		Cheng cheng = chengDao.findByCode(form);
		if(cheng==null){
			cheng = new Cheng();
		}
		
		ChengConf chengConf = new ChengConf();
		chengConf.setConfid(cheng.getConfid());
		chengConf = chengConfDao.findById(chengConf);
		String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
		cheng.setNormname(companyName+"-"+chengConf.getNormname());
		
		form.setCheng(cheng);
		
		return "findChengDataByList_chengCode";
	}
	
	/**
	 * 查询溯源秤交易信息-单独查询
	 */
	public String findChengStateLogByList_chengCode(){
		form.setPager_openset(10);
		form.setPager_offset(form.getPager_offset());
		form.setPager_count(chengDao.findByCount_statelog(form));
		List<Cheng> chenglist = chengDao.findByList_statelog(form);
		form.setChengList(chenglist);
		return "findChengStateLogByList_chengCode";
	}
	
	public void getChengFckDownFile() {
		try {
			HttpServletRequest request=this.getRequest();
			HttpServletResponse response=this.getResponse();
			
			ChengFck chengfck = new ChengFck();
			chengfck.setChengcode(form.getChengcode());
			
			List<ChengFck> chengfckList =  chengFckDao.quryByList(chengfck);
			
			String jsonStr = "";
			Map<String, Object> jsonObjectMp = new HashMap<String, Object>();
			if(chengfckList != null && chengfckList.size() >0){
				JSONArray jsonArray = new JSONArray();
				for (Iterator iterator = chengfckList.iterator(); iterator.hasNext();) {
					Map<String, Object> fckmap = new HashMap<String, Object>();
					ChengFck fck = (ChengFck) iterator.next();
					fckmap.put("key", fck.getKeyvalue());
					fckmap.put("fck", fck.getMedname());
					jsonArray.add(fckmap);
				}
				jsonObjectMp.put("cheng", jsonArray);
			}
					
			jsonStr = JSONUtil.serialize(jsonObjectMp);
			
			if(!"".equals(jsonStr)){
				response.reset();
				response.setContentType("application/octet-stream");
				response.addHeader("Content-Length", "" + jsonStr.getBytes().length); //设置返回的文件大小
				response.addHeader("Content-Disposition", "attachment;filename="+new String((form.getChengcode()+".txt").getBytes("gbk"), "iso-8859-1"));
				
		        InputStream fis = new ByteArrayInputStream(jsonStr.getBytes());  
				OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
				
				byte[] buffer = new byte[1024*1024];
				while(fis.read(buffer)>0){
					toClient.write(buffer); // 输出数据
				}
				
				fis.close();
				
				toClient.flush();
				toClient.close();
			
			}
			
		} catch (Exception ex) {
			ex.printStackTrace(); 
		}

	}
	
	
	
	public IChengDao getChengDao() {
		return chengDao;
	}

	public void setChengDao(IChengDao chengDao) {
		this.chengDao = chengDao;
	}

	public IChengConfDao getChengConfDao() {
		return chengConfDao;
	}

	public void setChengConfDao(IChengConfDao chengConfDao) {
		this.chengConfDao = chengConfDao;
	}

	public IChengKeyDao getChengKeyDao() {
		return chengKeyDao;
	}

	public void setChengKeyDao(IChengKeyDao chengKeyDao) {
		this.chengKeyDao = chengKeyDao;
	}

	public IChengFckDao getChengFckDao() {
		return chengFckDao;
	}

	public void setChengFckDao(IChengFckDao chengFckDao) {
		this.chengFckDao = chengFckDao;
	}

	public IChengSqlDao getChengSqlDao() {
		return chengSqlDao;
	}

	public void setChengSqlDao(IChengSqlDao chengSqlDao) {
		this.chengSqlDao = chengSqlDao;
	}

	public IChengDataDao getChengDataDao() {
		return chengDataDao;
	}

	public void setChengDataDao(IChengDataDao chengDataDao) {
		this.chengDataDao = chengDataDao;
	}

	public IOrgDao getOrgDao() {
		return orgDao;
	}

	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
	}

	public IDeviceRecDao getDeviceRecDao() {
		return deviceRecDao;
	}

	public void setDeviceRecDao(IDeviceRecDao deviceRecDao) {
		this.deviceRecDao = deviceRecDao;
	}

	public IChengTmpDao getChengTmpDao() {
		return chengTmpDao;
	}

	public void setChengTmpDao(IChengTmpDao chengTmpDao) {
		this.chengTmpDao = chengTmpDao;
	}

	public IChengFckTmpDao getChengFckTmpDao() {
		return chengFckTmpDao;
	}

	public void setChengFckTmpDao(IChengFckTmpDao chengFckTmpDao) {
		this.chengFckTmpDao = chengFckTmpDao;
	}

	public IOpLogDao getOpLogDao() {
		return opLogDao;
	}
	
}
