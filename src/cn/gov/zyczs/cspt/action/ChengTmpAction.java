package cn.gov.zyczs.cspt.action;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.dao.IChengConfDao;
import cn.gov.zyczs.cspt.dao.IChengFckTmpDao;
import cn.gov.zyczs.cspt.dao.IChengKeyDao;
import cn.gov.zyczs.cspt.dao.IChengTmpDao;
import cn.gov.zyczs.cspt.dao.IOpLogDao;
import cn.gov.zyczs.cspt.dao.IOrgDao;
import cn.gov.zyczs.cspt.po.ChengConf;
import cn.gov.zyczs.cspt.po.ChengFckTmp;
import cn.gov.zyczs.cspt.po.ChengKey;
import cn.gov.zyczs.cspt.po.ChengTmp;
import cn.gov.zyczs.cspt.po.DeviceConf;

import com.googlecode.jsonplugin.JSONException;
import com.googlecode.jsonplugin.JSONUtil;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤模板信息
 * @author lucher
 *
 */
@SuppressWarnings("serial")
public class ChengTmpAction extends BaseAction implements ModelDriven<ChengTmp> {
	
	ChengTmp form = new ChengTmp();
	public ChengTmp getModel() {
		return form;
	}
	private IChengTmpDao chengTmpDao;
	private IChengFckTmpDao chengFckTmpDao;
	private IChengConfDao chengConfDao;
	private IChengKeyDao chengKeyDao;
	private IOrgDao orgDao;
	private IOpLogDao opLogDao;
	
	/**
	 * 查询溯源秤模板信息
	 */
	public String findByList(){
		//构建溯源秤规格Map对象
		ChengConf chengconf = new ChengConf();
		List<ChengConf> list = chengConfDao.queryByList(chengconf);
		Map<Integer,String> map = new HashMap<Integer,String>();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			ChengConf chengConf = (ChengConf) iterator.next();
			map.put(chengConf.getConfid(),ToolSql.getCompanyNameByKey(chengConf.getCompanyname()) + "-" + chengConf.getNormname());
		}
		form.setChengconfmap(map);
        
		form.setPager_openset(10);
		form.setPager_count(chengTmpDao.findByCount(form));
		List<ChengTmp> tmpList = chengTmpDao.findByList(form);
		for (ChengTmp tmp : tmpList) {
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(tmp.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			if(chengConf != null){
				String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
				tmp.setNormname(companyName+"-"+chengConf.getNormname());
			}
		}
		form.setChengtmplist(tmpList);
		return "findByList";
	}
	
	/**
	 * 添加溯源秤模板信息初始化
	 */
	@SuppressWarnings("unchecked")
	public String addChengTmpInit(){
		//构建溯源秤模板规格Map对象
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
		return "addChengTmpInit";
	}
	
	
	@SuppressWarnings("unchecked")
	public void getChengConfKey() throws JSONException{
		try {
			this.getResponse().setContentType("text/html;charset=utf-8");
			PrintWriter out = this.getResponse().getWriter();
			
			Integer columnnum = 0;
            Integer rowsnum = 0;
			
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(form.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			ChengKey chengKey = new ChengKey();
			
			if(chengConf != null){
				chengKey.setConfid(chengConf.getConfid());
				columnnum = chengConf.getColumnnum();
				rowsnum = chengConf.getRowsnum();
			}
			//获取称键配置表中配置值不为空的数据
			List<ChengKey> keyConfList = chengKeyDao.queryListByValueNull(chengKey);
			String keyString = "";
			for (Iterator iterator = keyConfList.iterator(); iterator.hasNext();) {
				ChengKey keyConf = (ChengKey) iterator.next();
				keyString += "-" + keyConf.getRowsnum() + "," + keyConf.getColumnnum() + "," + keyConf.getKeyvalue();
			}
			
			Map<String, Object> jsonObject = new HashMap<String, Object>();
			
			 
			
			jsonObject.put("keyString", keyString);
			jsonObject.put("columnnum", columnnum);
			jsonObject.put("rowsnum", rowsnum);
			String jsonStr = JSONUtil.serialize(jsonObject);
			out.println(jsonStr);
			
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	@SuppressWarnings("unchecked")
	public void getChengFckTmp() throws JSONException{
		try {
			this.getResponse().setContentType("text/html;charset=utf-8");
			PrintWriter out = this.getResponse().getWriter();
			
			ChengTmp chengTmp = chengTmpDao.findById(form);
			
			Integer columnnum = 0;
            Integer rowsnum = 0;
			
			ChengConf chengConf = new ChengConf();
			chengConf.setConfid(chengTmp.getConfid());
			chengConf = chengConfDao.findById(chengConf);
			
			if(chengConf != null){
				columnnum = chengConf.getColumnnum();
				rowsnum = chengConf.getRowsnum();
			}
			
			ChengKey chengKey = new ChengKey();
			chengKey.setConfid(chengTmp.getConfid());
			//获取称键配置表中配置值不为空的数据
			List<ChengKey> keyConfList = chengKeyDao.queryListByValueNull(chengKey);
			String keyString = "";
			for (Iterator iterator = keyConfList.iterator(); iterator.hasNext();) {
				ChengKey keyConf = (ChengKey) iterator.next();
				keyString += "-" + keyConf.getRowsnum() + "," + keyConf.getColumnnum() + "," + keyConf.getKeyvalue();
			}
			
			//获取对应快捷键表中对应横纵坐标位置值
			ChengFckTmp chengfcktmp = new ChengFckTmp();
			chengfcktmp.setTmpid(form.getTmpid());
			List<ChengFckTmp> chengFckTmpList = new ArrayList<ChengFckTmp>();
			chengFckTmpList = chengFckTmpDao.quryListByTmpid(chengfcktmp); 
			
			
			Map<String, Object> jsonObject = new HashMap<String, Object>();
			jsonObject.put("keyString", keyString);
			jsonObject.put("columnnum", columnnum);
			jsonObject.put("rowsnum", rowsnum);
			
			JSONArray jsonArray = new JSONArray();
			for (Iterator iterator = chengFckTmpList.iterator(); iterator.hasNext();) {
				Map<String, Object> fcktmpmap = new HashMap<String, Object>();
				ChengFckTmp fckTmp = (ChengFckTmp) iterator.next();
				fcktmpmap.put("id", "newStrList"+fckTmp.getRowsnum()+"-"+fckTmp.getColumnnum());
				fcktmpmap.put("value", fckTmp.getKeyvalue()+"@"+fckTmp.getPlucodes()+"@"+fckTmp.getMedname());
				jsonArray.add(fcktmpmap);
			}
			jsonObject.put("chengfcktmplist", jsonArray);
			
			String jsonStr = JSONUtil.serialize(jsonObject);
			out.println(jsonStr);
			
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 保存溯源秤模板信息
	 */
	@SuppressWarnings("unchecked")
	public String saveChengTmp(){
		//保存模板
		Integer tmpid = chengTmpDao.save(form);
		//保存快捷键模板
		List<String> strList = form.getStrList();
		if(strList!=null && strList.size()>0){
			for (int i = 1; i < strList.size(); i++) {
				String tempStr = strList.get(i);
				if(tempStr != null){
					String[] str = strList.get(i).trim().split("@");
					if(str.length ==3 && !"".equals(str[1]) && !"undefined".equals(str[1]) && !"".equals(str[2]) && !"undefined".equals(str[2])){
						ChengFckTmp chengFckTmp = new ChengFckTmp();
						chengFckTmp.setTmpid(tmpid);
						chengFckTmp.setKeyvalue(str[0].trim());
						chengFckTmp.setPlucodes(str[1].trim());
						chengFckTmp.setMedname(str[2].trim());
						chengFckTmpDao.save(chengFckTmp);
					}
				}
			}
		}
		form.setReturninfo("模板保存成功");
		return addChengTmpInit();
	}
	
	/**
	 * 更新溯源秤模板快捷键初始化
	 */
	@SuppressWarnings("unchecked")
	public String updateChengTmpInit(){
		ChengTmp chengTmp = chengTmpDao.findById(form);
		
		ChengConf chengConf = new ChengConf();
		chengConf.setConfid(chengTmp.getConfid());
		chengConf = chengConfDao.findById(chengConf);
		ChengKey chengKey = new ChengKey();
		
		if(chengConf != null){
			chengKey.setConfid(chengConf.getConfid());
			String companyName = ToolSql.getCompanyNameByKey(chengConf.getCompanyname());
			chengTmp.setNormname(companyName+"-"+chengConf.getNormname());
		}
		//获取称键配置表中配置值不为空的数据
		List<ChengKey> keyConfList = chengKeyDao.queryListByValueNull(chengKey);
		String keyString = "";
		for (Iterator iterator = keyConfList.iterator(); iterator.hasNext();) {
			ChengKey keyConf = (ChengKey) iterator.next();
			keyString += "-" + keyConf.getRowsnum() + "," + keyConf.getColumnnum() + "," + keyConf.getKeyvalue();
		}
		
		ChengFckTmp chengfcktmp = new ChengFckTmp();
		chengfcktmp.setTmpid(chengTmp.getTmpid());
		chengfcktmp.setConfid(chengTmp.getConfid());
		//获取对应快捷键表中对应横纵坐标位置值
		List<ChengFckTmp> chengFckTmpList = new ArrayList<ChengFckTmp>();
		chengFckTmpList = chengFckTmpDao.quryListByTmpid(chengfcktmp); 
		
		form.setChengfcktmp(chengfcktmp);
		form.setChengtmp(chengTmp);
		form.setChengConf(chengConf);
		form.setChengfcktmplist(chengFckTmpList);
		form.setKeystring(keyString);
		return "updateChengTmpInit";
	}
	
	/**
	 * 保存溯源秤模板快捷键设置
	 */
	public String updateChengTmp(){
		chengTmpDao.update(form);
		
		List<String> strList = form.getStrList();
		if(strList!=null && strList.size()>0){
			for (int i = 1; i < strList.size(); i++) {
				String tempStr = strList.get(i);
				if(tempStr != null){
					String[] str = strList.get(i).trim().split("@");
					if(str.length ==3 && !"".equals(str[1]) && !"undefined".equals(str[1]) && !"".equals(str[2]) && !"undefined".equals(str[2])){
						ChengFckTmp chengFckTmp = new ChengFckTmp();
						chengFckTmp.setTmpid(form.getTmpid());
						chengFckTmp.setKeyvalue(str[0].trim());
						ChengFckTmp chengFckTmpOld = chengFckTmpDao.findById(chengFckTmp);//根据秤编号和键值去查询快捷键值
						if(chengFckTmpOld == null){//表示数据库中模板没有该快捷键，为新增加的快捷键
							chengFckTmp.setPlucodes(str[1].trim());
							chengFckTmp.setMedname(str[2].trim());
							chengFckTmpDao.save(chengFckTmp);
						}else if(chengFckTmpOld != null && !str[1].trim().equals(chengFckTmpOld.getPlucodes())){
							//表示该快捷键在数据库中存在，但是跟页面输入的不相等，为修改的快捷键
							//删除以前的PLU值
							chengFckTmpDao.delete(chengFckTmpOld); 
							//封装修改的PLU值
							chengFckTmpOld.setPlucodes(str[1].trim());
							chengFckTmpOld.setMedname(str[2].trim());
							chengFckTmpDao.save(chengFckTmpOld);
						}
					}else if(str.length == 2 && !"".equals(str[1]) && !"undefined".equals(str[1])){
						//表示页面上清空了此快捷键
						ChengFckTmp chengFckTmp = new ChengFckTmp();
						chengFckTmp.setTmpid(form.getTmpid());
						chengFckTmp.setKeyvalue(str[0].trim());
						ChengFckTmp chengFckTmpOld = chengFckTmpDao.findById(chengFckTmp);//根据秤编号和键值去查询快捷键值
						if(chengFckTmpOld != null && !str[1].trim().equals(chengFckTmpOld.getPlucodes())){
							//表示该快捷键在数据库中存在，但是跟页面把此快捷键设置为空,此时只管把数据库快捷键删除清空
							//删除以前的PLU值
							chengFckTmpDao.delete(chengFckTmp); 
						}
					}
				}
			}
		}
		form.setReturninfo("模板保存成功");
		return updateChengTmpInit();
	}
    
	/**
	 * 删除溯源秤模板信息
	 */
	public String deleteChengTmp(){
		//删除模板
		chengTmpDao.delete(form);
	    //删除模板快捷键
		ChengFckTmp chengfcktmp = new ChengFckTmp();
		chengfcktmp.setTmpid(form.getTmpid());
		chengFckTmpDao.delete(chengfcktmp);
		
		form.setReturninfo("模板删除成功");
		
		return findByList();
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

	public IOrgDao getOrgDao() {
		return orgDao;
	}

	public void setOrgDao(IOrgDao orgDao) {
		this.orgDao = orgDao;
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

	public void setOpLogDao(IOpLogDao opLogDao) {
		this.opLogDao = opLogDao;
	}
	
}
