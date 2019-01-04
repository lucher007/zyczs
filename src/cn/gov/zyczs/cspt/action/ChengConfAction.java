package cn.gov.zyczs.cspt.action;
import java.util.List;

import cn.gov.zyczs.cspt.action.BaseAction;
import cn.gov.zyczs.cspt.common.ToolSql;
import cn.gov.zyczs.cspt.dao.IChengConfDao;
import cn.gov.zyczs.cspt.dao.IChengKeyDao;
import cn.gov.zyczs.cspt.po.ChengConf;
import cn.gov.zyczs.cspt.po.ChengKey;
import com.opensymphony.xwork2.ModelDriven;
/**
 * 溯源秤信息
 * @author lucher
 *
 */
public class ChengConfAction extends BaseAction implements ModelDriven<ChengConf> {
	private static final long serialVersionUID = 1L;
	
	ChengConf form = new ChengConf();
	public ChengConf getModel() {
		return form;
	}
	private IChengConfDao chengConfDao;
	
	private IChengKeyDao chengKeyDao;
	
	public IChengKeyDao getChengKeyDao() {
		return chengKeyDao;
	}

	public void setChengKeyDao(IChengKeyDao chengKeyDao) {
		this.chengKeyDao = chengKeyDao;
	}

	public IChengConfDao getChengConfDao() {
		return chengConfDao;
	}

	public void setChengConfDao(IChengConfDao chengConfDao) {
		this.chengConfDao = chengConfDao;
	}

	/**
	 * 查询溯源秤配置信息
	 */
	public String findByList(){
		form.setPager_openset(10);
		form.setPager_count(chengConfDao.findByCount(form));
		List<ChengConf> chengConfList = chengConfDao.findByList(form);
		for (ChengConf chengConf : chengConfList) {
			//根据厂商数值从配置文件里直接取名称
			chengConf.setCompanyname(ToolSql.getCompanyNameByKey(chengConf.getCompanyname()));
		}
		form.setChengconflist(chengConfList);
		return "findByList";
	}
	
	/**
	 * 更新溯源秤信息初始化
	 */
	public String updateInit(){
		ChengConf conf = new ChengConf();
		conf = chengConfDao.findById(form);
		form.setChengconf(conf);
		ChengKey chengkey = new ChengKey();
		chengkey.setConfid(form.getConfid());
		List<ChengKey> keyList = chengKeyDao.queryByList(chengkey);
		form.setChengkeylist(keyList);
		return "updateInit";
	}
	
	/**
	 * 更新溯源秤配置信息
	 */
	public String update(){
		Integer confId = chengConfDao.update(form);
		if(confId != 0){
			List<String> strList = form.getStrList();
			ChengKey confkey = new ChengKey();
			confkey.setConfid(form.getConfid());
			//查询所有的快捷键，全部初始化
			
			
			
			//删除所有的键值
			chengKeyDao.deleteConfKeys(confkey);
			for (int i = 1; i < strList.size(); i++) {
				ChengKey key = new ChengKey();
				key.setRowsnum(Integer.parseInt(strList.get(i).split(",")[0]));
				key.setColumnnum(Integer.parseInt(strList.get(i).split(",")[1]));
				if(strList.get(i).split(",").length >= 3){
					key.setKeyvalue(strList.get(i).split(",")[2]);
				}else{
					key.setKeyvalue("");
				}
				key.setConfid(form.getConfid());
				chengKeyDao.save(key);
			}
		}else{
			form.setReturninfo("更新溯源秤失败!");
		}
		return "update";
	}
	
	/**
	 * 新增溯源秤信息
	 */
	public String save(){
		Integer confId = chengConfDao.save(form);
		
		if(confId != 0){
			List<String> strList = form.getStrList();
			for (int i = 1; i < strList.size(); i++) {
				ChengKey chengkey = new ChengKey();
				chengkey.setRowsnum(Integer.parseInt(strList.get(i).split(",")[0]));
				chengkey.setColumnnum(Integer.parseInt(strList.get(i).split(",")[1]));
				if(strList.get(i).split(",").length >= 3){
					chengkey.setKeyvalue(strList.get(i).split(",")[2]);
				}else{
					chengkey.setKeyvalue("");
				}
				chengkey.setConfid(confId);
				chengKeyDao.save(chengkey);
			}
		}else{
			form.setReturninfo("保存溯源秤失败!");
		}
		return "save";
	}
}
